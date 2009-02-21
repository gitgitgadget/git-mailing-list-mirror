From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git push usage
Date: Sat, 21 Feb 2009 04:32:35 -0500
Message-ID: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com>
References: <76718490902200116n73e00b62sbe7bb774bcc058c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 10:34:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaoFJ-0007t0-Cq
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 10:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbZBUJch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 04:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbZBUJcg
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 04:32:36 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:55808 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbZBUJcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 04:32:35 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1280890rvb.1
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 01:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=tajtBVuRz5CHJ7xonQhAXutBoqB/RHWAdWBsYMnv3JU=;
        b=hHu0nUarIanrbcivdqpyYVyIa6INOs4i/t/j46wCEW8AmSxDHDovl2u4aU9GbVLcAX
         rXEWq4fj1/e0QJXbGhvJP1TiUQqpv3ixwWsmXscSnx4aJQzknEJb2WyDgTwv7PEE16jm
         5nANIBpV+sO/nmjD7mVSQJ2pSPt6hzsJT++kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=gPJ7y2u+hExMD0WDDnIv0QO7l2QkdCEs2C6pbqQkWyULBOUvDOIcdJdczG6iUqV2QW
         5KiSZ/DTIgqKyxlUqgo1QF051NZv4Qu/qstwDd8ia2WCpHzwBrB9Zw9gW0mhdBHNnCCt
         dmbDYurhWxG4IFQ2ukyLhfaA485S/C+QIPyT4=
Received: by 10.141.146.4 with SMTP id y4mr898951rvn.88.1235208755158; Sat, 21 
	Feb 2009 01:32:35 -0800 (PST)
In-Reply-To: <76718490902200116n73e00b62sbe7bb774bcc058c5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110935>

Tap...tap...tap... is this thing on? :-)

On Fri, Feb 20, 2009 at 4:16 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> The man page for git push claims:
>
>  --repo=<repository>
>     This option is only relevant if no <repository> argument is passed
>     in the invocation. In this case, git-push derives the remote name
>     from the current branch: If it tracks a remote branch, then that
>     remote repository is pushed to. Otherwise, the name "origin" is
>     used. For this latter case, this option can be used to override the
>     name "origin". In other words, the difference between these two
>     commands
>
>         git push public         #1
>         git push --repo=public  #2
>
>     is that #1 always pushes to "public" whereas #2 pushes to "public"
>     only if the current branch does not track a remote branch. This is
>     useful if you write an alias or script around git-push.
>
> However, I'm sitting here looking at the code and I don't see how this
> is possible. I've also done some testing. So I think the man page lies
> and that forms (1) and (2) are equivalent as shown.
>
> cmd_push() is:
>
>  const char *repo = NULL; /* default repository */
>  struct option options[] = {
>    ...
>    OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
>    ...
>  }
>
>  argc = parse_options(argc, argv, options, push_usage, 0);
>
>  if (argc > 0) {
>    repo = argv[0];
>    set_refspecs(argv + 1, argc - 1);
>  }
>
>  rc = do_push(repo, flags);
>
> So if the user specifies --repo, then its value is assigned to *repo by
> parse_options. If the user otherwise specifies a repository w/o --repo, that
> will be argv[0] after parse_options, so it will get assigned to *repo. Assuming
> no other arguments, set_refspecs gets called with argc = 0 and returns w/o doing
> anything.
>
> So the only difference I can see is that form #1 allows the user to specify a
> refspec on the command line. Form #2 does not since the first
> non-dashed argument gets assigned to *repo, so:
>
> $ git push --repo src:dst
>
> would assign src:dst to *repo, which would choke.
>
> So, what's the point of the --repo dashed-option then?
>
> j.
>
