From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/4] worktree: refactor find_linked_symref function
Date: Tue, 22 Sep 2015 10:44:22 -0700
Message-ID: <xmqqmvwe4adl.fsf@gitster.mtv.corp.google.com>
References: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
	<1442583027-47653-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, dturner@twopensource.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 19:44:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeRcE-0005wz-21
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 19:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757961AbbIVRoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 13:44:25 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36564 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbbIVRoY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 13:44:24 -0400
Received: by pacgz1 with SMTP id gz1so12440264pac.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rBL3MMhiQ9XRRv7meuWYpIhddM9YpYoZ1xJvQ+saNFw=;
        b=lMzgfh+GgVHbS6E5rkx8EvKXq3fboWA3G46fedUu+9Q5vQza1tvnREOExcp8DL/uSD
         cJbdGpqrYi5E3P8pvXy9Pzgejs9X3611CpHWsrKRULsr6TNsQbmVfhm13sc07HrHNlOm
         faquTs/wl0T7ySeT9HaAEU54Z6ps8UHgm5YlIdjjAK5v16fQk11lbK+VMMse4kT3Ht6k
         Blj10C7Dx1/O8GHGyJBpN2J9IBp/GqYx3EOOTj+uMolpw1CsQQe9YUdpVD6AzsUTeKZC
         7F9NY3I8wR7te+bxwcdqwsDjHb9OAbR4pmtCeKlmjIrGPMp0QBpBt6zfblOswLKxTepa
         hknw==
X-Received: by 10.68.242.42 with SMTP id wn10mr32818331pbc.77.1442943863716;
        Tue, 22 Sep 2015 10:44:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id un2sm3452848pac.28.2015.09.22.10.44.22
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 10:44:23 -0700 (PDT)
In-Reply-To: <1442583027-47653-3-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Fri, 18 Sep 2015 09:30:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278405>

Michael Rappazzo <rappazzo@gmail.com> writes:

> Refactoring will help transition this code to provide additional useful
> worktree functions.
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  worktree.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 64 insertions(+), 22 deletions(-)
>
> diff --git a/worktree.c b/worktree.c
> index 10e1496..5c75875 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -3,6 +3,60 @@
>  #include "strbuf.h"
>  #include "worktree.h"
>  
> +/*
> + * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
> + * set is_detached to 1 if the ref is detatched.

set is_detached to 1 (0) if the ref is detatched (is not detached).

> + *
> + * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR so
> + * for linked worktrees, `resolve_ref_unsafe()` won't work (it uses
> + * git_path). Parse the ref ourselves.
> + *
> + * return -1 if the ref is not a proper ref, 0 otherwise (success)
> + */
> +static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
> +{
> +	if (is_detached)
> +		*is_detached = 0;
> +	if (!strbuf_readlink(ref, path_to_ref, 0)) {
> +		if (!starts_with(ref->buf, "refs/")
> +				|| check_refname_format(ref->buf, 0))

Don't try to be creative with the format and stick to the original.

	if (!starts_with(ref->buf, "refs/") ||
	    check_refname_format(ref->buf, 0))

> +			return -1;
> +

This blank makes a strange code by making the "return -1" have no
blank above and one blank below.

> +	} else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
> +		if (starts_with(ref->buf, "ref:")) {
> +			strbuf_remove(ref, 0, strlen("ref:"));
> +			strbuf_trim(ref);
> +			if (check_refname_format(ref->buf, 0))
> +				return -1;
> +		} else if (is_detached)
> +			*is_detached = 1;

Minor: I have a suspicion that this would be easier to follow:

		if (!starts_with(...)) {
			if (is_detached)
				*is_detached = 1;
		} else {
                	strbuf_remove(...);
                        strbuf_trim(...);
                        if (check_refname_format(...))
				return -1;
		}

> +	}

What should happen when strbuf_read_file() above fails?  Would it be
a bug (i.e. the caller shouldn't have called us in the first place
with such a broken ref), would it be a repository inconsistency
(i.e. it is worth warning and stop the caller from doing further
damage), or is it OK to silently succeed?

> +	return 0;
> +}
> +
> +static char *find_main_symref(const char *symref, const char *branch)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf gitdir = STRBUF_INIT;
> +	char *existing = NULL;
> +
> +	strbuf_addf(&path, "%s/%s", get_git_common_dir(), symref);
> +	if (parse_ref(path.buf, &sb, NULL) == -1)
> +		goto done;

I know you described it to "return -1 on an error", but as a general
style, for a function that signals a success by returning 0 and
negative on error (or on various kinds of errors), it is easier to
follow if you followed a more common pattern:

	if (parse_ref(...) < 0)
        	goto done;

> +	if (strcmp(sb.buf, branch))
> +		goto done;
> +	strbuf_addstr(&gitdir, get_git_common_dir());
> +	strbuf_strip_suffix(&gitdir, ".git");
> +	existing = strbuf_detach(&gitdir, NULL);
> +done:
> +	strbuf_release(&path);
> +	strbuf_release(&sb);
> +	strbuf_release(&gitdir);
> +
> +	return existing;
> +}
> +
>  static char *find_linked_symref(const char *symref, const char *branch,
>  				const char *id)
>  {
> @@ -11,36 +65,24 @@ static char *find_linked_symref(const char *symref, const char *branch,
>  	struct strbuf gitdir = STRBUF_INIT;
>  	char *existing = NULL;
>  
> +	if (!id)
> +		goto done;

A caller that calls this function with id==NULL would always get a
no-op.  Is that what the caller intended, or should it have called
the new find_main_symref() instead?  I'd imagine it is the latter,
in which case

	if (!id)
        	die("BUG");

is more appropriate.  On the other hand, if you are trying to keep
the old interface to allow id==NULL to mean "get the information for
the primary one", I'd expect this to call find_main_symref() for the
(old-style) callers.

In either case, this "no id? no-op" looks funny.

>  	/*
>  	 * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside
>  	 * $GIT_DIR so resolve_ref_unsafe() won't work (it uses
>  	 * git_path). Parse the ref ourselves.
>  	 */

You moved this comment to parse_ref(), which is a more appropriate
home for it.  Perhaps you want to remove this copy from here?

> -	if (id)
> -		strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
> -	else
> -		strbuf_addf(&path, "%s/%s", get_git_common_dir(), symref);
> +	strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
>  
> -	if (!strbuf_readlink(&sb, path.buf, 0)) {
> -		if (!starts_with(sb.buf, "refs/") ||
> -		    check_refname_format(sb.buf, 0))
> -			goto done;
> -	} else if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
> -	    starts_with(sb.buf, "ref:")) {
> -		strbuf_remove(&sb, 0, strlen("ref:"));
> -		strbuf_trim(&sb);
> -	} else
> +	if (parse_ref(path.buf, &sb, NULL) == -1)
>  		goto done;

Same comment as in find_main_symref() applies here.

I can see the value of splitting out parse_ref() into a separate
function, but it is not immediately obvious how it would be an
overall win to duplicate major parts of the logic that used to be
shared for "primary" and "linked" cases in a single function into
two separate, simpler and similar functions at this point in the
series (note that I did not say "it clearly made it worse").
Perhaps reviews on the callers will help us answer that.

Thanks.
