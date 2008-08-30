From: David Greaves <david@dgreaves.com>
Subject: setlocalversion wasn't producing git labels for bisect
Date: Sat, 30 Aug 2008 20:43:03 +0100
Message-ID: <48B9A2C7.3080001@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 21:44:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZWMw-0005PA-FO
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 21:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbYH3TnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 15:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbYH3TnJ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 15:43:09 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:43357 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbYH3TnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 15:43:07 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id F1D8FDEF7C;
	Sat, 30 Aug 2008 20:43:08 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id KmNRh8KHDMSH; Sat, 30 Aug 2008 19:01:07 +0100 (BST)
Received: from elm.dgreaves.com (78-32-229-233.no-dns-yet.enta.net [78.32.229.233])
	by mail.ukfsn.org (Postfix) with ESMTP id C2E75DEF6D;
	Sat, 30 Aug 2008 20:43:08 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by elm.dgreaves.com with esmtp (Exim 4.62)
	(envelope-from <david@dgreaves.com>)
	id 1KZWLg-0004n8-4A; Sat, 30 Aug 2008 20:43:04 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94410>

Trying to do a bisect with git version 1.5.6.3 didn't work with the setlocalversion script

Running
  git name-rev --tags HEAD
gives the output
  HEAD tags/v2.6.27-rc4~44^2

This isn't matched by setlocalversion regexp so it makes it harder to make deb-pkg/install/grub/reboot/remove

Of course if this patch is accepted it is going to make life complicated when bisecting around it.
Maybe git should behave as the man page suggests and have the ^X before the ~nnn? (maybe it has been fixed already)
  http://www.kernel.org/pub/software/scm/git/docs/v1.5.6.5/git-name-rev.html
shows an example:
  33db5f4d9027a10e477ccf054b2c1ab94f74c85a tags/v0.99^0~940

David

commit 511c5f04eb2df03dbbae97ede82913da1f141f86
Author: David Greaves <david@dgreaves.com>
Date:   Sat Aug 30 14:53:35 2008 +0100

    setlocalversion wasn't producing git labels for bisect

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 83b7512..89f126d 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -11,7 +11,7 @@ cd "${1:-.}" || usage
 # Check for git and a git repo.
 if head=`git rev-parse --verify HEAD 2>/dev/null`; then
 	# Do we have an untagged version?
-	if git name-rev --tags HEAD | grep -E '^HEAD[[:space:]]+(.*~[0-9]*|undefined)$' > /dev/null; then
+	if git name-rev --tags HEAD | grep -E '^HEAD[[:space:]]+(.*~[0-9^]*|undefined)$' > /dev/null; then
 		if tag=`git describe 2>/dev/null`; then
 			echo $tag | awk -F- '{printf("-%05d-%s", $(NF-1),$(NF))}'
 		fi
