From: Linus Torvalds <torvalds@osdl.org>
Subject: bogus "fatal: Not a git repository"
Date: Thu, 25 May 2006 08:22:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605250804390.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu May 25 17:23:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjHg0-0000do-DP
	for gcvg-git@gmane.org; Thu, 25 May 2006 17:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWEYPXA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 11:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWEYPXA
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 11:23:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964862AbWEYPXA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 11:23:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4PFMo2g021038
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 May 2006 08:22:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4PFMhLG028265;
	Thu, 25 May 2006 08:22:46 -0700
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20741>


I was just testing that "git ls-remote" change by Junio, and when you're 
not in a git repository, it gives this totally bogus warning. The _target_ 
obviously has to be a git repository, but there's no reason why you'd have 
to be in a local git repo when doing an ls-remote.

The reason is commit 73136b2e8a8ee024320c5ac6a0f14f912432bf03 by Dscho: it 
adds calls to git-repo-config in git-parse-remote.sh to get the remote 
shorthands etc.

Now, either we should just hide and ignore the error from git-repo-config 
(probably bad, because some errors _are_ valid - like git-repo-config 
failing due to bad syntax in the config file), or we should just make 
git-repo-config quietly handle the case of not being in a git repository.

This does the latter: just quietly accepting (and doing nothing - trying 
to set a value will result in the lock-file failing) our lot in life 
sounds better than dying with a bogus error message.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/repo-config.c b/repo-config.c
index 127afd7..08fc4cc 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -108,7 +108,8 @@ static int get_value(const char* key_, c
 
 int main(int argc, const char **argv)
 {
-	setup_git_directory();
+	int nongit = 0;
+	setup_git_directory_gently(&nongit);
 
 	while (1 < argc) {
 		if (!strcmp(argv[1], "--int"))
