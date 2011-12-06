From: Seth Robertson <in-gitvger@baka.org>
Subject: BUG: Confusing submodule error message
Date: Tue, 06 Dec 2011 14:30:56 -0500
Message-ID: <201112061930.pB6JUuDx004171@no.baka.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 20:38:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY0qQ-0000rV-Gk
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 20:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab1LFTiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 14:38:21 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:45834 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187Ab1LFTiU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 14:38:20 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Dec 2011 14:38:20 EST
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id pB6JUuPj008058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 6 Dec 2011 14:30:57 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id pB6JUuDx004171
	for <git@vger.kernel.org>; Tue, 6 Dec 2011 14:30:56 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186375>


Someone on #git just encountered a problem where `git init && git add . &&
git status` was failing with a message about a corrupted index.

    error: bad index file sha1 signature
    fatal: index file corrupt
    fatal: git status --porcelain failed

This confused everyone for a while, until he provided access to the
directory to play with.  I eventually tracked it down to a directory
in the tree which already had a .git directory in it.  Unfortunately,
that .git repo was corrupted and was the one returning the message
about a corrupted index.  The problem is that the error message we
were seeing did not provide any direct hints that submodules were
involved or that the problem was not at the top level (`git status
--porcelain` is admittedly an indirect hint to both).  Here is a
recipe to reproduce a similar problem:

(mkdir -p z/foo; cd z/foo; git init; echo A>A; git add A; git commit -m A; cd ..; echo B>B; rm -f foo/.git/objects/*/*; git init; git add .; git status)

Providing an expanded error message which clarifies that this is
failing in a submodule directory makes everything clear.

----------------------------------------------------------------------
--- submodule.c~	2011-12-02 14:25:08.000000000 -0500
+++ submodule.c	2011-12-06 14:13:00.554413432 -0500
@@ -714,7 +714,7 @@
 	close(cp.out);
 
 	if (finish_command(&cp))
-		die("git status --porcelain failed");
+		die("git status --porcelain failed in submodule directory %s", path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
----------------------------------------------------------------------

Do more error messages in submodule.c need adjusting?  It seems likely.

					-Seth Robertson
