From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: What's cooking in git.git (Dec 2013, #03; Thu, 12)
Date: Mon, 16 Dec 2013 13:30:40 +0100
Message-ID: <20131216123040.GZ11745@mars-attacks.org>
References: <xmqqwqj9r2ig.fsf@gitster.dls.corp.google.com>
 <xmqqa9g1qrzj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 13:40:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsXTk-0002LQ-Cz
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 13:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab3LPMkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 07:40:51 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:49334 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab3LPMku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 07:40:50 -0500
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2013 07:40:50 EST
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 096B14E66;
	Mon, 16 Dec 2013 13:31:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6Ib_mAEsl6XD; Mon, 16 Dec 2013 13:31:02 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 956863ECC;
	Mon, 16 Dec 2013 13:31:02 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id EA58D438C5; Mon, 16 Dec 2013 13:30:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqa9g1qrzj.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239334>

On Sun, 15 Dec 2013, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > [Stalled]
> >
> > * nv/commit-gpgsign-config (2013-11-06) 1 commit
> >  - Add the commit.gpgsign option to sign all commits
> >
> >  Introduce commit.gpgsign configuration variable to force every
> >  commit to be GPG signed.
> >
> >  Needs tests, perhaps?

Ok, I'll add some tests.

> 
> Besides, we would need at least something like this to make sure
> that people have a way to selectively disable configured default
> when necessary, perhaps like this.

This looks like a good idea.

> 
> -- >8 --
> Subject: [PATCH] commit-tree: add and document --no-gpg-sign
> 
> Document how to override commit.gpgsign configuration that is set to
> true per "git commit" invocation (parse-options machinery lets us
> say "--no-gpg-sign" to do so).
> 
> "git commit-tree" does not use parse-options, so manually add the
> corresponding option for now.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-commit-tree.txt | 5 +++++
>  Documentation/git-commit.txt      | 4 ++++
>  builtin/commit-tree.c             | 5 +++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
> index cafdc96..a469eab 100644
> --- a/Documentation/git-commit-tree.txt
> +++ b/Documentation/git-commit-tree.txt
> @@ -55,8 +55,13 @@ OPTIONS
>  	from the standard input.
>  
>  -S[<keyid>]::
> +--gpg-sign[=<keyid>]::
>  	GPG-sign commit.

Looking at the code, commit-tree does not currently support the
"--gpg-sign=" option, only the short one -S.

If we want to add it for consistency with the --no-gpg-sign option, it
can be added with this change :

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 1646d5b25e4f..b380d486c89a 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -71,6 +71,11 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (!memcmp(arg, "--gpg-sign=", 11)) {
+			sign_commit = arg + 11;
+			continue;
+		}
+
 		if (!strcmp(arg, "-m")) {
 			if (argc <= ++i)
 				usage(commit_tree_usage);
