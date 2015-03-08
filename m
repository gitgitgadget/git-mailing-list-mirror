From: Sundararajan R <dyoucme@gmail.com>
Subject: Re: [PATCH] [GSoC Microproject]Adding "-" shorthand for =?utf-8?b?IkB7LTF9Ig==?= in RESET command
Date: Sun, 8 Mar 2015 11:09:45 +0000 (UTC)
Message-ID: <loom.20150308T120618-983@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 12:10:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUZ5s-0004r8-NI
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 12:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbbCHLJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 07:09:56 -0400
Received: from plane.gmane.org ([80.91.229.3]:42180 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbbCHLJz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 07:09:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YUZ5k-0004mB-QY
	for git@vger.kernel.org; Sun, 08 Mar 2015 12:09:53 +0100
Received: from 202.3.77.220 ([202.3.77.220])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 12:09:52 +0100
Received: from dyoucme by 202.3.77.220 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 12:09:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 202.3.77.220 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265087>

On Sun, Mar 8, 2015 at 1:04 PM Junio C Hamano <gitster@pobox.com> wrote:
Sundararajan R <dyoucme@gmail.com> writes:

> diff --git a/builtin/reset.c b/builtin/reset.c
> index 4c08ddc..62764d4 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -203,8 +203,16 @@ static void parse_args(struct pathspec *pathspec,
>        *
>        * At this point, argv points immediately after [-opts].
>        */
> -
> +     int flag=0; /*
> +                  *  "-" may refer to filename in which case we should be 
giving more precedence
> +                  *  to filename than equating argv[0] to "@{-1}"
> +                  */

Comment on a separate line.  More importantly, think if you can give
the variable a more meaningful name so that you do not have to
explain.

You are missing SPs requested by the coding guideline everywhere in
your patch.


>       if (argv[0]) {
> +             if (!strcmp(argv[0], "-") && !argv[1])  /* "-" is the only 
argument */
> +             {
> +                     argv[0]="@{-1}";
> +                     flag=1;
> +             }
>               if (!strcmp(argv[0], "--")) {
>                       argv++; /* reset to HEAD, possibly with paths */
>               } else if (argv[1] && !strcmp(argv[1], "--")) {
> @@ -226,6 +234,8 @@ static void parse_args(struct pathspec *pathspec,

Around here not shown by this patch there are a few uses of argv[0],
and the most important one is

                        verify_non_filename(prefix, argv[0]);

just before the line below (see below).

>                       rev = *argv++;
>               } else {
>                       /* Otherwise we treat this as a filename */
> +                     if(flag)
> +                             argv[0]="-";
>                       verify_filename(prefix, argv[0], 1);
>               }
>       }

By the way, do you understand the intent of the existing checks in
this codepath that uses verify_filename() and verify_non_filename()?

The idea is to allow users to write "git reset X" and "git reset Y
Z" safely in an unambiguous way.

 * X could be a commit (e.g. "git reset master"), to update the
   current branch to point at the same commit as 'master' and update
   the index to match.

 * X could be a pathspec (e.g. "git reset hello.c"), to grab the
   blob object for X out of the HEAD and put it in the index.

 * Y could be a tree-ish and Z a pathspec (e.g. "git reset HEAD^
   hello.c"), to grab the blob object for Z out of tree-ish Y and
   put it to the index.

 * Both Y and Z could be pathspecs (e.g. "git reset hello.c
   goodbye.c"), to revert the index entries for these two paths to
   what the HEAD records.

If you happen to have a file whose name is 'master', and if you are
working on your 'topic' branch, what would this do?

    $ git reset master

Is this a request to revert the index entry for path 'master' from
the HEAD?  Or is it a request to update the current branch to be the
same as the 'master' branch and repopulate the index from there?

What does the existing code try to do, and how does it do it?  It
detects the ambiguity and refuses to do either, to make sure it
causes no harm.

Now, with your change, does the result still honor this "when
ambiguous, stop without causing harm to the user" principle?  What
happens when your user has a file whose name is "-" in the working
tree?  What happens when your user has a file whose name is "@{-1}"
in the working tree?

--------------------------------------------------------------------------
Hi all,

I am sorry for the mistakes in the code formatting. It was because I was in 
a hurry that day and I wanted to submit a working patch. In the new patch I 
am making, I am using check_filename() to see if there are files named "-" 
and "@{-1}" in the working tree . Is this an appropriate way to check or is 
there something else suggested? 

Thanks a lot.
R Sundararajan.
