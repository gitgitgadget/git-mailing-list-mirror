From: iler.ml@gmail.com
Subject: [PATCH] fix obscure perl message when encryption=tls and smtp cannot connect.
Date: Sat, 26 Sep 2009 00:30:13 +0300
Message-ID: <1253914213-22274-1-git-send-email-iler.ml@gmail.com>
Cc: iler.ml@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 25 23:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrIMu-000549-TY
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 23:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbZIYVaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 17:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbZIYVaK
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 17:30:10 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:46788 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbZIYVaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 17:30:09 -0400
Received: by ewy7 with SMTP id 7so2936187ewy.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fOxnJhHnTFKxA7tZ/ArZOjvrUc4uSWtg6wXdj8aINJ0=;
        b=rHE/Y3J1YFJGbb2xfi0ToznpLXnJrFn07FY4H1SiBjkuyAQER8AaWH6wWOUjP4Y0vE
         mMgKJwx1RYxFUTMhj0tDNL+yb0JC7IaqZCbcIomx0yLkA9IuYfqdZfq+dHTEVac/b8/k
         ZDEJX6fueM+e8onECp544zdv5gt5pEM1hzqGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jmC8WmT5ZPZLyFSC7nqa4Nak0jBhibEIuJmHvt5GgbPFpp2zjMYG+zllOUiWT6jlZu
         ZkGLDbtIdIjovpD/PnHAPkD8lsruhHIR/ZqkV278nMOJREo4Wz+JV9IOJclkICt0RskE
         MH/7jdATwHNiMYYlntMR2vZBGGvApIbyxaAEA=
Received: by 10.216.85.65 with SMTP id t43mr158269wee.92.1253914211304;
        Fri, 25 Sep 2009 14:30:11 -0700 (PDT)
Received: from localhost.localdomain ([94.159.132.74])
        by mx.google.com with ESMTPS id 7sm1251514eyg.0.2009.09.25.14.30.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Sep 2009 14:30:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129118>

When encryption=tls and smtp cannot connect, git-send-email prints following perl error:

Can't call method "command" on an undefined value at /usr/local/libexec/git-core/git-send-email line 927.

(ithis is when smtp host orport is misspelled, or network is down, and encryption is tls).
We expect some familiar "Cannot connect to SERVER:PORT" message.
Fix it to print normal "smtp can't connect" diagnostics.

--- /usr/local/libexec/git-core/git-send-email.000	2009-09-26 00:10:01.000000000 +0300
+++ /usr/local/libexec/git-core/git-send-email	2009-09-26 00:11:39.000000000 +0300
@@ -922,7 +922,7 @@
 			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
 						 ? "$smtp_server:$smtp_server_port"
 						 : $smtp_server);
-			if ($smtp_encryption eq 'tls') {
+			if ($smtp_encryption eq 'tls' && $smtp) {
 				require Net::SMTP::SSL;
 				$smtp->command('STARTTLS');
 				$smtp->response();
