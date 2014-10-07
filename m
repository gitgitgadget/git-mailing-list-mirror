From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 09/16] prune: factor out loose-object directory traversal
Date: Tue, 07 Oct 2014 16:07:52 +0200
Message-ID: <5433F3B8.2080505@alum.mit.edu>
References: <20141003202045.GA15205@peff.net> <20141003202943.GI16293@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 16:08:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbVQn-0002XI-GU
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 16:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbaJGOH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 10:07:57 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:63884 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752462AbaJGOH4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2014 10:07:56 -0400
X-AuditID: 12074411-f79d86d000006a97-76-5433f3ba9943
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 84.33.27287.AB3F3345; Tue,  7 Oct 2014 10:07:54 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C4D.dip0.t-ipconnect.de [93.219.28.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s97E7qKg012583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 7 Oct 2014 10:07:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20141003202943.GI16293@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqLvrs3GIwe01mhZdV7qZLH609DA7
	MHk8693D6PF5k1wAUxS3TVJiSVlwZnqevl0Cd8b2/ltMBVstK77cfMfUwPhBu4uRk0NCwERi
	4uoZrBC2mMSFe+vZuhi5OIQELjNK9PRuZIZwzjJJbHy7GayKV0BbouX2CXYQm0VAVeLDjN/M
	IDabgK7Eop5mJhBbVCBA4kPnA0aIekGJkzOfsIDYIgJGEjc+fGMDsYUFfCX2v/4NFGcHWuAv
	8c8JJMopoCcxfeUDsCnMAuoSf+ZdYoaw5SWat85mnsDIPwvJ0FlIymYhKVvAyLyKUS4xpzRX
	NzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTIyQcBXcwzjgpd4hRgINRiYeXQdc4RIg1say4
	MvcQoyQHk5Io7/YLQCG+pPyUyozE4oz4otKc1OJDjBIczEoivFPeA+V4UxIrq1KL8mFS0hws
	SuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8Bz8BNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfm
	paQWJZaWZMSD4jG+GBiRICkeoL2sn0H2Fhck5gJFIVpPMSpKifP6gswVAElklObBjYUlmVeM
	4kBfCvM+A6niASYouO5XQIOZgAav6gcbXJKIkJJqYGy3md2gZvrhWbjr65N/LX7defwiW3LW
	8RyZOxX1rGILfPouBTDqrvQIEz+z+ueN/l+7c94u/RkXueXyVk3vhNepCcbRW6dtnx3qw+Tu
	yHt///IjnuUTeNQurAjT+SLvz5JXflN0ddXttr5sprvvbun6/7765MUe/mz2Zb4F 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257927>

On 10/03/2014 10:29 PM, Jeff King wrote:
> Prune has to walk $GIT_DIR/objects/?? in order to find the
> set of loose objects to prune. Other parts of the code
> (e.g., count-objects) want to do the same. Let's factor it
> out into a reusable for_each-style function.
> 
> Note that this is not quite a straight code movement. There
> are two differences:
> 
>   1. The original code iterated from 0 to 256, trying to
>      opendir("$GIT_DIR/%02x"). The new code just does a
>      readdir() on the object directory, and descends into
>      any matching directories. This is faster on
>      already-pruned repositories, and should not ever be
>      slower (nobody ever creates other files in the object
>      directory).

This would change the order that the objects are processed. I doubt that
matters to anybody, but it's probably worth mentioning in the commit
message.

>   2. The original code had strange behavior when it found a
>      file of the form "[0-9a-f]{2}/.{38}" that did _not_
>      contain all hex digits. It executed a "break" from the
>      loop, meaning that we stopped pruning in that directory
>      (but still pruned other directories!). This was
>      probably a bug; we do not want to process the file as
>      an object, but we should keep going otherwise.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I admit the speedup in (1) almost certainly doesn't matter. It is real,
> and I found out about it while writing a different program that was
> basically "count-objects" across a large number of repositories. However
> for a single repo it's probably not big enough to matter (calling
> count-objects in a loop while get dominated by the startup costs). The
> end result is a little more obvious IMHO, but that's subjective.
> 
>  builtin/prune.c | 87 ++++++++++++++++------------------------------------
>  cache.h         | 31 +++++++++++++++++++
>  sha1_file.c     | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 152 insertions(+), 61 deletions(-)
> 
> [...]
> diff --git a/cache.h b/cache.h
> index cd16e25..7abe7f6 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1239,6 +1239,37 @@ extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsig
>  extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
>  extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
>  
> +/*
> + * Iterate over the files in the loose-object parts of the object
> + * directory "path", triggering the following callbacks:
> + *
> + *  - loose_object is called for each loose object we find.
> + *
> + *  - loose_cruft is called for any files that do not appear to be
> + *    loose objects.
> + *
> + *  - loose_subdir is called for each top-level hashed subdirectory
> + *    of the object directory (e.g., "$OBJDIR/f0"). It is called
> + *    after the objects in the directory are processed.
> + *
> + * Any callback that is NULL will be ignored. Callbacks returning non-zero
> + * will end the iteration.
> + */
> +typedef int each_loose_object_fn(const unsigned char *sha1,
> +				 const char *path,
> +				 void *data);
> +typedef int each_loose_cruft_fn(const char *basename,
> +				const char *path,
> +				void *data);
> +typedef int each_loose_subdir_fn(const char *basename,
> +				 const char *path,
> +				 void *data);
> +int for_each_loose_file_in_objdir(const char *path,
> +				  each_loose_object_fn obj_cb,
> +				  each_loose_cruft_fn cruft_cb,
> +				  each_loose_subdir_fn subdir_cb,
> +				  void *data);
> +
>  struct object_info {
>  	/* Request */
>  	enum object_type *typep;
> diff --git a/sha1_file.c b/sha1_file.c
> index bae1c15..9fdad47 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3218,3 +3218,98 @@ void assert_sha1_type(const unsigned char *sha1, enum object_type expect)
>  		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
>  		    typename(expect));
>  }
> +
> +static int opendir_error(const char *path)
> +{
> +	if (errno == ENOENT)
> +		return 0;
> +	return error("unable to open %s: %s", path, strerror(errno));
> +}
> +
> +static int for_each_file_in_obj_subdir(struct strbuf *path,
> +				       const char *prefix,
> +				       each_loose_object_fn obj_cb,
> +				       each_loose_cruft_fn cruft_cb,
> +				       each_loose_subdir_fn subdir_cb,
> +				       void *data)
> +{
> +	size_t baselen = path->len;
> +	DIR *dir = opendir(path->buf);
> +	struct dirent *de;
> +	int r = 0;
> +
> +	if (!dir)
> +		return opendir_error(path->buf);

OK, so if there is a non-directory named $GIT_DIR/objects/33, then we
emit an "unable to open" error rather than treating it as cruft. I think
this is reasonable.

> +
> +	while ((de = readdir(dir))) {
> +		if (is_dot_or_dotdot(de->d_name))
> +			continue;
> +
> +		strbuf_setlen(path, baselen);
> +		strbuf_addf(path, "/%s", de->d_name);
> +
> +		if (strlen(de->d_name) == 38)  {
> +			char hex[41];
> +			unsigned char sha1[20];
> +
> +			memcpy(hex, prefix, 2);
> +			memcpy(hex + 2, de->d_name, 38);
> +			hex[40] = 0;
> +			if (!get_sha1_hex(hex, sha1)) {
> +				if (obj_cb) {
> +					r = obj_cb(sha1, path->buf, data);
> +					if (r)
> +						break;
> +				}
> +				continue;
> +			}
> +		}
> +
> +		if (cruft_cb) {
> +			r = cruft_cb(de->d_name, path->buf, data);

So, files *and* directories at the $GIT_DIR/objects/XX/ level are
reported as cruft (as opposed to, say, descending into the directories
and reporting any files found deeper in the hierarchy). This seems fine,
too.

> +			if (r)
> +				break;
> +		}
> +	}
> +	if (!r && subdir_cb)
> +		r = subdir_cb(de->d_name, path->buf, data);

By my reading, path->buf still contains the name of the last file in the
directory at this point. I assume you want to pass it the original
"baselen"-length path here.

> +	closedir(dir);
> +	return r;

...and anyway, it would be more polite to restore the path strbuf to its
original length before returning.

> +}
> +
> +int for_each_loose_file_in_objdir(const char *path,
> +			    each_loose_object_fn obj_cb,
> +			    each_loose_cruft_fn cruft_cb,
> +			    each_loose_subdir_fn subdir_cb,
> +			    void *data)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t baselen;
> +	DIR *dir = opendir(path);
> +	struct dirent *de;
> +	int r = 0;
> +
> +	if (!dir)
> +		return opendir_error(path);
> +
> +	strbuf_addstr(&buf, path);
> +	baselen = buf.len;
> +
> +	while ((de = readdir(dir))) {
> +		if (!isxdigit(de->d_name[0]) ||
> +		    !isxdigit(de->d_name[1]) ||
> +		    de->d_name[2])
> +			continue;

So other files or directories at the $GIT_DIR/objects/ level are just
ignored; they are not considered cruft. This is worth clarifying in the
docstring.

> +
> +		strbuf_addf(&buf, "/%s", de->d_name);
> +		r = for_each_file_in_obj_subdir(&buf, de->d_name, obj_cb,
> +						cruft_cb, subdir_cb, data);
> +		strbuf_setlen(&buf, baselen);
> +		if (r)
> +			break;
> +	}
> +
> +	closedir(dir);
> +	strbuf_release(&buf);
> +	return r;
> +}
> 

Other than my comments above, it looks good to me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
