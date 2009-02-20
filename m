From: Jay Soffian <jaysoffian@gmail.com>
Subject: git push usage
Date: Fri, 20 Feb 2009 04:16:26 -0500
Message-ID: <76718490902200116n73e00b62sbe7bb774bcc058c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 10:18:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaRWA-0002DO-8m
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 10:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbZBTJQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 04:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbZBTJQ3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 04:16:29 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:13211 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbZBTJQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 04:16:27 -0500
Received: by rv-out-0506.google.com with SMTP id g37so854894rvb.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 01:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=hY6y30CD2jPViUCyn9sajObavRF7W0RjksJWhbE5e0s=;
        b=Ao5AjLWaO7nIw+Nse9ztTmS9ok9q9D/AVToAQNtgg9C3L72GkZ6UAUZFe+jdZ22SI0
         0uISo4SbWMa9W6TVXSq1SEMPF/wTMgvbJRljcRnHPIB7cgeewfsUXglIHfwPUaiP7wro
         psz3tS81KX9fMmiarpnB2KhEdbRBYVI/NZ1BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=oQikRAjAnlBd+8qmG/LE6UcRy8+8Xp/cffelZhNsRJR2w7/EtJMZ2pWYrZx8a56xo2
         AQCD38s1lJ94ytkKBqbISatimkK6ESLeGo02wAhRNge3yjVOuoQgXUWwgIy2UE18367g
         Kdjat1CZatLJBnKYwkA+ZS26VlgnAQEW7ymaM=
Received: by 10.141.151.18 with SMTP id d18mr319127rvo.134.1235121386900; Fri, 
	20 Feb 2009 01:16:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110827>

The man page for git push claims:

 --repo=<repository>
     This option is only relevant if no <repository> argument is passed
     in the invocation. In this case, git-push derives the remote name
     from the current branch: If it tracks a remote branch, then that
     remote repository is pushed to. Otherwise, the name "origin" is
     used. For this latter case, this option can be used to override the
     name "origin". In other words, the difference between these two
     commands

         git push public         #1
         git push --repo=public  #2

     is that #1 always pushes to "public" whereas #2 pushes to "public"
     only if the current branch does not track a remote branch. This is
     useful if you write an alias or script around git-push.

However, I'm sitting here looking at the code and I don't see how this
is possible. I've also done some testing. So I think the man page lies
and that forms (1) and (2) are equivalent as shown.

cmd_push() is:

  const char *repo = NULL; /* default repository */
  struct option options[] = {
    ...
    OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
    ...
  }

  argc = parse_options(argc, argv, options, push_usage, 0);

  if (argc > 0) {
    repo = argv[0];
    set_refspecs(argv + 1, argc - 1);
  }

  rc = do_push(repo, flags);

So if the user specifies --repo, then its value is assigned to *repo by
parse_options. If the user otherwise specifies a repository w/o --repo, that
will be argv[0] after parse_options, so it will get assigned to *repo. Assuming
no other arguments, set_refspecs gets called with argc = 0 and returns w/o doing
anything.

So the only difference I can see is that form #1 allows the user to specify a
refspec on the command line. Form #2 does not since the first
non-dashed argument gets assigned to *repo, so:

$ git push --repo src:dst

would assign src:dst to *repo, which would choke.

So, what's the point of the --repo dashed-option then?

j.
