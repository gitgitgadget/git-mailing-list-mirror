From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: avoid symlinks when reusing worktree files
Date: Fri, 30 Oct 2015 00:28:57 -0700
Message-ID: <20151030072857.GA15031@gmail.com>
References: <1445981088-6285-1-git-send-email-davvid@gmail.com>
 <xmqq1tcgne4u.fsf@gitster.mtv.corp.google.com>
 <20151029015539.GA12513@gmail.com>
 <xmqq8u6lsggx.fsf@gitster.mtv.corp.google.com>
 <xmqq4mh9sfl6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ismail Badawi <ismail@badawi.io>,
	John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 08:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zs47Y-0006zY-Oy
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 08:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758886AbbJ3H3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 03:29:03 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32976 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758340AbbJ3H3B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 03:29:01 -0400
Received: by padhy1 with SMTP id hy1so60301686pad.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 00:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C4G8uzUNmuHvcDSBcsByWXmWj4fBu6FfA12lJqwx+cc=;
        b=cBnKIFcnoe6Xu7Vm8brvZz5WBDQEfNBq9QDFH9Uko7Hqn4zjqeXqaELTKUb7JLzvgx
         WychbCq/58i/zbRwckKoBWhnzYcVs+IKBfkG4JhKHAz+y3Q/nJDCBmeYngEQMVIuKTl0
         DSlPzWUnirw71XnIwdCY85+ZYSK1DtEv9Y1pBuOGkoPyANnWZsT18EHxXLlYMKH55LGv
         oNga3fc2JH6i5MlfsL+zXFiLIlGzFgzsXl/E2jN4Jp7p9/REjXfdqYh+795zOniAlI1D
         3+O8SQcCDJq1VhckEezOK50yP5j6Y0rdJXW4jYqrZbsSRcudc2xcseQZXnA9L3zmIV2h
         hatg==
X-Received: by 10.68.226.161 with SMTP id rt1mr7039210pbc.98.1446190140623;
        Fri, 30 Oct 2015 00:29:00 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id qv5sm6260515pbc.71.2015.10.30.00.28.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2015 00:28:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq4mh9sfl6.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280480>

On Thu, Oct 29, 2015 at 11:19:01AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > So I think it is fine to return $use=0 for any symbolic link from
> > use_wt_file.  Anything you do there will be replaced by the loop
> > over %symlink that appears later in the caller.  The caller discards
> > $wt_sha1 when $use=0 is returned, so the second return value does
> > not matter.
> 
> So let me try to update your patch with the result of the study of
> the codeflow.
> 
> -- >8 --
> From: David Aguilar <davvid@gmail.com>
> Subject: difftool: ignore symbolic links in use_wt_file
> 
> The caller is preparing a narrowed-down copy of the working tree and
> this function is asked if the path should be included in that copy.
> If we say yes, the path from the working tree will be either symlinked
> or copied into the narrowed-down copy.
> 
> For any path that is a symbolic link, the caller later fixes up the
> narrowed-down copy by unlinking the path and replacing it with a
> regular file it writes out that mimics the way how "git diff"
> compares symbolic links.
> 
> Let's answer "no, you do not want to copy/symlink the working tree
> file" for all symbolic links from this function, as we know the
> result will not be used because it will be overwritten anyway.
> 
> Incidentally, this also stops the function from feeding a symbolic
> link in the working tree to hash-object, which is a wrong thing to
> do to begin with. The link may be pointing at a directory, or worse
> may be dangling (both would be noticed as an error).  Even if the
> link points at a regular file, hashing the contents of a file that
> is pointed at by the link is not correct (Git hashes the contents of
> the link itself, not the pointee).
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

This is a very nicely worded commit message.  Thanks for the
thorough explanation.


>  git-difftool.perl   |  4 +---
>  t/t7800-difftool.sh | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 7df7c8a..488d14b 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -70,9 +70,7 @@ sub use_wt_file
>  	my ($repo, $workdir, $file, $sha1) = @_;
>  	my $null_sha1 = '0' x 40;
>  
> -	if (! -e "$workdir/$file") {
> -		# If the file doesn't exist in the working tree, we cannot
> -		# use it.
> +	if (-l "$workdir/$file" || ! -e _) {
>  		return (0, $null_sha1);
>  	}

The "-e _" shorthand caught my eye ~ I didn't know perl could do that!
Nice.

Underline is barely mentioned in perlvar, but it's obvious what
(I think) it means, and since Perl is DWIM, it must be right. ;-)
-- 
David
