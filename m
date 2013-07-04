From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] send-email: provide port separately from hostname
Date: Thu,  4 Jul 2013 22:04:52 +0000
Message-ID: <1372975492-981035-1-git-send-email-sandals@crustytoothpaste.net>
Cc: gitster@pobox.com, artagnon@gmail.com, krzysiek@podlesie.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 00:05:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UureG-0008Nd-Ss
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 00:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174Ab3GDWFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 18:05:03 -0400
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:34301 "EHLO
	qmta10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756935Ab3GDWFC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 18:05:02 -0400
Received: from omta23.emeryville.ca.mail.comcast.net ([76.96.30.90])
	by qmta10.emeryville.ca.mail.comcast.net with comcast
	id wMr21l0051wfjNsAAN51HW; Thu, 04 Jul 2013 22:05:01 +0000
Received: from castro.crustytoothpaste.net ([IPv6:2001:470:1f04:79::2])
	by omta23.emeryville.ca.mail.comcast.net with comcast
	id wN4z1l00L25wmie8jN50Yn; Thu, 04 Jul 2013 22:05:01 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CE66828057;
	Thu,  4 Jul 2013 22:04:58 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2.923.g2a18ff8.dirty
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372975501;
	bh=bBE8ua7B4ZrY/5A81/37ySCmQvxXpcqaACC+86dwgqM=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=T9o87w27jWKH5Hz8wDGmLZukfo02KitOiPUU6iO7vhpXG5nHOUEE5/fInW2H2G3co
	 p1dVS/nY7RvI45lCpaQrPsmunLiGQkqNubvaXr92kzYPAafp+naL5ioeHeG+Qgbkfb
	 yHAPTHrSNwk8UEfBJWelcmSXXx3wj8l17DekSOxFfH1un1C2kiWhLdImuzOAuPa23V
	 bC4MUhPfLslq6MpNRwINBL5F1eEhkjNLm/dJmd2sBI4cncnZXsJnsK9iR1JS3gOJyL
	 SjG5NxzPqv5z1f28czptdY0uZJ0lWxB4BzFi0B5Kll0orDgogPR/NdfOUoLkJiV6jg
	 WlYNHpO0xIiuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229621>

From: "brian m. carlson" <sandals@crustytoothpaste.net>

If the SMTP port is provided as part of the hostname to Net::SMTP, it passes
the combined string to the SASL provider; this causes GSSAPI authentication to
fail since Kerberos does not want the port information.  Instead, pass the port
as a separate argument as is done for SSL connections.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-send-email.perl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bd13cc8..ca86a13 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1199,9 +1199,11 @@ X-Mailer: git-send-email $gitversion
 		else {
 			require Net::SMTP;
 			$smtp_domain ||= maildomain();
-			$smtp ||= Net::SMTP->new(smtp_host_string(),
+			$smtp_server_port ||= 25;
+			$smtp ||= Net::SMTP->new($smtp_server,
 						 Hello => $smtp_domain,
-						 Debug => $debug_net_smtp);
+						 Debug => $debug_net_smtp,
+						 Port => $smtp_server_port);
 			if ($smtp_encryption eq 'tls' && $smtp) {
 				require Net::SMTP::SSL;
 				$smtp->command('STARTTLS');
-- 
1.8.3.2.923.g2a18ff8.dirty
