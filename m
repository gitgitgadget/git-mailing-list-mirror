From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/4] Allow Git repositories to be shared using POSIX ACLs
Date: Fri, 19 Feb 2010 17:33:23 +0100
Message-ID: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 17:34:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiVo4-0004Z2-NF
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 17:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621Ab0BSQeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 11:34:15 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37868 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879Ab0BSQeO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 11:34:14 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o1JGVRX7005303
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 19 Feb 2010 17:31:27 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NiVnO-0006F2-FR; Fri, 19 Feb 2010 17:33:38 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NiVnO-0008LZ-DO; Fri, 19 Feb 2010 17:33:38 +0100
X-Mailer: git-send-email 1.7.0.rc2.4.gc602c4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 19 Feb 2010 17:31:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o1JGVRX7005303
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1267201888.38297@Z5Ma2kKrwZF394qv3pbMIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140459>

I talked about the problem earlier:

http://thread.gmane.org/gmane.comp.version-control.git/136720

In short: if a user wants to share a git repository using POSIX
filesystem ACLs, it seems everything works except pack file creation.
The problem is that we create the file with a mode 0600, i.e. no
permission for group, but the semantics of ACL is that this group
permission is used as ACL umask when the file has ACLs (don't ask me
why, I never understood the rational, but that's how it works).

Instead, if we let the umask do its job at the time of file creation,
then the pack file is created with the correct permission bits and
ACLs, and we don't need to chmod it after the fact. This is what this
patch serie does.

The test-case is really weak: ideally, we should have a real test with
several users interacting. But that's hardly scriptable in a portable
way, so the only testcase I added relies on getfacl and "ls -l" to find
out if the result is correct. However, I did some manual testing, and
as far as I can say, Git works very well with ACLs with this patch.
