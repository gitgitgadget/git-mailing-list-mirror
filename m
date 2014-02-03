From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH v5 4/5] setup: Add 'abspath_part_inside_repo' function
Date: Tue, 4 Feb 2014 00:16:59 +0100
Message-ID: <20140203231659.GC15607@mule>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-5-git-send-email-martinerikwerner@gmail.com>
 <xmqq1tzjewsf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, richih@debian.org, tboegi@web.de,
	pclouds@gmail.com, dak@gnu.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 00:17:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASlM-0006a1-1g
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 00:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbaBCXRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 18:17:07 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:59621 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbaBCXRF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 18:17:05 -0500
Received: by mail-lb0-f180.google.com with SMTP id n15so5699117lbi.25
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 15:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ogem9FfIf9vns6cMn0Gcon1YgFrk7tCGZULC8eCux/g=;
        b=ratHC514dAjgRJtacrEIIBMRGfMS3Hywa8Zjy0DcHZnkYpRlGZxMfIRR2ytjhjmZc7
         U03lJF5wzCc8eqmgiQ88ifMlJ9VaCTm+WTJvaYMMjPhavH0PYUhPVgFUxlbCf1cjw282
         6rxjl0wSkT6MG7qcAX2ajnqybWsBtmzLTlsvDjr/FRaTfW1CfANn/gEosbGjZlkjfXCQ
         vz43i3JT6kXv8lpDfUEmFaz4xKBW4dqF6WyW9RHoHC0LmeUHL4nW/vrq8mMUi1BEoB33
         itJP2OcqnEOvzuUyY3r9wasn6xbrTs1/s+xCVk/fkmx97AziGh9+VNlIWD0auoICZVtx
         XWOw==
X-Received: by 10.112.114.228 with SMTP id jj4mr7786735lbb.13.1391469423423;
        Mon, 03 Feb 2014 15:17:03 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id jf8sm3354802lbc.8.2014.02.03.15.17.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 15:17:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq1tzjewsf.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241492>

On Mon, Feb 03, 2014 at 11:52:33AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Can we have that "git foo $path" to the testsuite as well?  That is
> > the breakage we do not want to repeat in the future by regressing.
> 
> Something like this, perhaps?
> 
>  t/t3004-ls-files-basic.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
> index 8d9bc3c..d93089d 100755
> --- a/t/t3004-ls-files-basic.sh
> +++ b/t/t3004-ls-files-basic.sh
> @@ -36,4 +36,21 @@ test_expect_success 'ls-files -h in corrupt repository' '
>  	test_i18ngrep "[Uu]sage: git ls-files " broken/usage
>  '
>  
> +test_expect_success SYMLINKS 'ls-files with symlinks' '
> +	mkdir subs &&
> +	ln -s nosuch link &&
> +	ln -s ../nosuch subs/link &&
> +	git add link subs/link &&
> +	git ls-files -s link subs/link >expect &&
> +	git ls-files -s "$(pwd)/link" "$(pwd)/subs/link" >actual &&
> +	test_cmp expect actual &&
> +
> +	(
> +		cd subs &&
> +		git ls-files -s link >../expect &&
> +		git ls-files -s "$(pwd)/link" >../actual
> +	) &&
> +	test_cmp expect actual
> +'
> +
>  test_done

Your test looks preferrable to the simple git-add one that I proposed,
since it covers some more ground than the simple:

test_expect_success SYMLINKS 'add with abs path to link...' '
	ln -s target link &&
	git add link
'

Will you add that test or should I place it in the series with you as
author?

On Mon, Feb 03, 2014 at 01:00:48PM -0800, Junio C Hamano wrote:
> Martin Erik Werner <martinerikwerner@gmail.com> writes:
> 
> > The path being exactly equal to the work tree is handled separately,
> > since then there is no directory separator between the work tree and
> > in-repo part.
> 
> What is an "in-repo part"?  Whatever it is, I am not sure if I
> follow that logic.  After the while (*path) loop checks each level,
> you check the whole path---wouldn't that code handle that special
> case already?

Given "/dir1/repo/dir2/file" I've used 'in-repo' to refer to
"dir2/file", sometimes interchangably with "part inside the work tree"
which might be better terminology, and should replace it?

I was trying to convey that if path is simply "/dir/repo", then the while
loop method of replacing a '/' and checking from the beginning won't
work for the last level, since it has no terminating '/' to replace, so
hence it's a special case, mentioning the "part inside the work tree"
is arguably confusing in that case, since there isn't really one, maybe
it should be left out completely, since the "check each level"
explanation covers it already?

> 
> Because it is probably the normal case not to have any symbolic link
> in the leading part (hence not having to dereference them), I think
> checking "is work_tree[] a prefix of path[]" early is justified from
> performance point of view, though.
> 
> >  /*
> > + * No checking if the path is in fact an absolute path is done, and it must
> > + * already be normalized.
> 
> This is not quite parsable to me.
Hmm, what about
	The input parameter must contain an absolute path, and it must
	already be normalized.
?

> > + * Find the part of an absolute path that lies inside the work tree by
> > + * dereferencing symlinks outside the work tree, for example:
> > + * /dir1/repo/dir2/file   (work tree is /dir1/repo)      -> dir2/file
> > + * /dir/file              (work tree is /)               -> dir/file
> > + * /dir/symlink1/symlink2 (symlink1 points to work tree) -> symlink2
> > + * /dir/repolink/file     (repolink points to /dir/repo) -> file
> > + * /dir/repo              (exactly equal to work tree)   -> (empty string)
> > + */
> > +static inline int abspath_part_inside_repo(char *path)
> 
> It looks a bit too big to be marked "inline"; better leave it to the
> compiler to notice that there is only a single callsite and decide
> to (or not to) inline it.

Ok, will do.

> > +{
> > +	size_t len;
> > +	size_t wtlen;
> > +	char *path0;
> > +	int off;
> > +
> > +	const char* work_tree = get_git_work_tree();
> > +	if (!work_tree)
> > +		return -1;
> > +	wtlen = strlen(work_tree);
> > +	len = strlen(path);
> 
> I expect that this is called from a callsite that _knows_ how long
> path[] is.  Shouldn't len be a parameter to this function instead?

Currently, it actually doesn't, since 'normalize_path_copy_len' is
called on it prior, which can mess with the string length. Do you think
the 'strlen' call should still be moved up a step into
'prefix_path_gently'?

> > +	off = 0;
> > +
> > +	/* check if work tree is already the prefix */
> > +	if (strncmp(path, work_tree, wtlen) == 0) {
> 
> I wonder if we want to be explicit and compare wtlen and len before
> even attempting strncmp().  If work_tree is longer than path, it
> cannot be a prefix of path, right?
> 
> In other words, also with a style-fix to prefer !XXcmp() over
> XXcmp() == 0:
> 
> 	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
> 
> perhaps?  That would make it clear why referring to path[wtlen] on
> the next line is permissible (it is obvious that it won't access
> past the end of path[]):

Definitely sounds like a good idea.

> > +		if (path[wtlen] == '/') {
> > +			memmove(path, path + wtlen + 1, len - wtlen);
> > +			return 0;
> > +		} else if (path[wtlen - 1] == '/' || path[wtlen] == '\0') {
> > +			/* work tree is the root, or the whole path */
> > +			memmove(path, path + wtlen, len - wtlen + 1);
> 
> If work_tree[] == "/", path[] == "/a", then len == 2, wtlen == 1,
> path[wtlen - 1] == '/' and this shifts path[] to the left by one,
> leaving path[] = "a", which is what we want.  OK.
> 
> If work_tree[] == path[] == "/a", then len == wtlen == 2,
> path[wtlen] == '\0', and this becomes equivalent to path[0] = '\0'.
> Hmph....  How do our callers treat an empty path?  In other words,
> should these three be equivalent?
> 
> 	cd /a && git ls-files /a
> 	cd /a && git ls-files ""
> 	cd /a && git ls-files .

Here I have only gone by the assumption that previous code did the right
thing, whether or not it *did*, I'm not sure I'm able to figure out at
the moment.

> > +			return 0;
> > +		}
> > +		/* work tree might match beginning of a symlink to work tree */
> > +		off = wtlen;
> > +	}
> > +	path0 = path;
> > +	path += offset_1st_component(path) + off;
> > +
> > +	/* check each level */
> > +	while (*path) {
> > +		path++;
> > +		if (*path == '/') {
> > +			*path = '\0';
> > +			if (strcmp(real_path(path0), work_tree) == 0) {
> > +				memmove(path0, path + 1, len - (path - path0));
> > +				return 0;
> > +			}
> > +			*path = '/';
> > +		}
> > +	}
> > +
> > +	/* check whole path */
> > +	if (strcmp(real_path(path0), work_tree) == 0) {
> > +		*path0 = '\0';
> > +		return 0;
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> > +/*
> >   * Normalize "path", prepending the "prefix" for relative paths. If
> >   * remaining_prefix is not NULL, return the actual prefix still
> >   * remains in the path. For example, prefix = sub1/sub2/ and path is
