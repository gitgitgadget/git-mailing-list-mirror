From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: t5505-remote fails on Windows
Date: Thu, 19 Mar 2009 08:20:18 +0100
Message-ID: <49C1F232.2090009@viscovery.net>
References: <49C0DE23.8020809@viscovery.net> <20090319041837.GA32642@coredump.intra.peff.net> <20090319044313.GA341@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 08:22:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkCZn-0003E8-Tq
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 08:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbZCSHUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 03:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbZCSHUe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 03:20:34 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30293 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbZCSHUe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 03:20:34 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LkCY7-00062O-H8; Thu, 19 Mar 2009 08:20:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3D8ED543; Thu, 19 Mar 2009 08:20:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090319044313.GA341@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113725>

Jeff King schrieb:
> I didn't look closely enough at your issue, which is one
> ref pushing to two different places. For that, the sort needs to take
> into account the util field, which holds the destination.
> 
> The patch below probably fixes it, but as I can't actually reproduce
> here, it is largely untested.

Your patch fixes it. The following change to the test case would be a good
addition; it protects later tests from failures in earlier tests.

-- Hannes

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5ec668d..13f32b8 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -160,7 +160,7 @@ cat > test/expect << EOF
     master pushes to another (up to date)
 EOF

-test_expect_success 'show' '
+test_expect_success 'more setup for show' '
 	(cd test &&
 	 git config --add remote.origin.fetch refs/heads/master:refs/heads/upstream &&
 	 git fetch &&
@@ -183,12 +183,20 @@ test_expect_success 'show' '
 	 git config --add remote.origin.push refs/heads/master:refs/heads/upstream &&
 	 git config --add remote.origin.push +refs/tags/lastbackup &&
 	 git config --add remote.two.push +refs/heads/ahead:refs/heads/master &&
-	 git config --add remote.two.push refs/heads/master:refs/heads/another &&
+	 git config --add remote.two.push refs/heads/master:refs/heads/another)
+'
+
+test_expect_success 'show' '
+	(cd test &&
 	 git remote show origin two > output &&
-	 git branch -d rebase octopus &&
 	 test_cmp expect output)
 '

+test_expect_success 'more setup for show -n' '
+	(cd test &&
+	 git branch -d rebase octopus)
+'
+
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
