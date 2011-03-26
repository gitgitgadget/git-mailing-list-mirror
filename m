From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: GIT_WORK_TREE and GIT_DIR with git clone
Date: Sun, 27 Mar 2011 00:37:28 +0100
Message-ID: <20110326233728.GA9445@camk.edu.pl>
References: <20110326125818.GA2621@camk.edu.pl>
 <7vtyep3c1h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 00:37:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3d3I-0002gw-Fl
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 00:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab1CZXhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 19:37:36 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:38543 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab1CZXhf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 19:37:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id C25985F0047;
	Sun, 27 Mar 2011 00:37:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7apWy44lfUmb; Sun, 27 Mar 2011 00:37:28 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id B9D125F0046;
	Sun, 27 Mar 2011 00:37:28 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 85B1780F32; Sun, 27 Mar 2011 00:37:28 +0100 (CET)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vtyep3c1h.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170073>

On Sat, Mar 26, 2011 at 12:40:58PM -0700, Junio C Hamano wrote:
> Kacper Kornet <kornet@camk.edu.pl> writes:

> > Is there a reason why git clone does not respect GIT_DIR
> > variable.

> Are you sure it does "not respect GIT_DIR"?  When you are running clone
> locally, like that:

> > GIT_WORK_TREE=repo GIT_DIR=repo/.git git clone <path>/repo.git

> you have _two_ repositories that the command operates on on your system,
> the one that you are cloning _from_, and the new one that you are
> creating.

> Which repository does your GIT_DIR talk about?

I would expect that GIT_DIR always talks the new one. For example after:

GIT_WORK_TREE=dir GIT_DIR=dir/.git git clone git://git.kernel.org/pub/scm/gitk/gitk

I would expect to have repo in dir/.git. What happens is that in dir
there is a working tree and in local directory gitk there is a bare
repo. The following patch should fix the issue:

diff --git a/builtin/clone.c b/builtin/clone.c
index c6e10bb..082ee53 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -442,11 +442,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			die("working tree '%s' already exists.", work_tree);
 	}
 
-	if (option_bare || work_tree)
-		git_dir = xstrdup(dir);
-	else {
+	git_dir = getenv("GIT_DIR");
+	if (option_bare || work_tree) {
+		if (!git_dir)
+			git_dir = xstrdup(dir);
+	} else {
 		work_tree = dir;
-		git_dir = xstrdup(mkpath("%s/.git", dir));
+		if (!git_dir)
+			git_dir = xstrdup(mkpath("%s/.git", dir));
 	}
 
 	if (!option_bare) {





-- 
  Kacper 
