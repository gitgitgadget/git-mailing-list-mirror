From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] send-email: enable SSL level 1 debug output
Date: Thu,  3 Dec 2015 21:47:18 +0000
Message-ID: <26c6006ad88146e0abfdfcaf99be686a4fb050c4.1449179138.git.john@keeping.me.uk>
References: <a56a8d728ffeb6a6c2b0f7decd0485a1906b8f25.1448409432.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 03 22:47:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4bj0-00084u-O5
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 22:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbbLCVre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 16:47:34 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:41308 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbLCVrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 16:47:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C59C9CDA548;
	Thu,  3 Dec 2015 21:47:32 +0000 (GMT)
X-Quarantine-ID: <BujqwBBwNE+5>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BujqwBBwNE+5; Thu,  3 Dec 2015 21:47:32 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id D093FCDA586;
	Thu,  3 Dec 2015 21:47:26 +0000 (GMT)
X-Mailer: git-send-email 2.6.3.462.gbe2c914
In-Reply-To: <a56a8d728ffeb6a6c2b0f7decd0485a1906b8f25.1448409432.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281975>

If a server's certificate isn't accepted by send-email, the output is:

	Unable to initialize SMTP properly. Check config and use --smtp-debug.

but adding --smtp-debug=1 just produces the same output since we don't
get as far as talking SMTP.

Turning on SSL debug at level 1 gives:

	DEBUG: .../IO/Socket/SSL.pm:1796: SSL connect attempt failed error:14090086:SSL routines:ssl3_get_server_certificate:certificate verify failed
	DEBUG: .../IO/Socket/SSL.pm:673: fatal SSL error: SSL connect attempt failed error:14090086:SSL routines:ssl3_get_server_certificate:certificate verify failed
	DEBUG: .../IO/Socket/SSL.pm:1780: IO::Socket::IP configuration failed

IO::Socket::SSL defines level 1 debug as "print out errors from
IO::Socket::SSL and ciphers from Net::SSLeay".  In fact, it aliases
Net::SSLeay::trace which is defined to guarantee silence at level 0 and
only emit error messages at level 1, so let's enable it by default.

The modification of warnings is needed to avoid a warning about:

	Name "IO::Socket::SSL::DEBUG" used only once: possible typo

Signed-off-by: John Keeping <john@keeping.me.uk>
---
Sorry about the delay following up with this.

I don't particularly like the need for brackets and modifying the
warnings here, but AFAIK there is no other way to avoid a warning that
is likely to upset users (although I am far from a Perl expert).

 git-send-email.perl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index e907e0e..72508be 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1318,6 +1318,13 @@ Message-Id: $message_id
 			require Net::SMTP::SSL;
 			$smtp_domain ||= maildomain();
 			require IO::Socket::SSL;
+
+			# Suppress "variable accessed once" warning.
+			{
+				no warnings 'once';
+				$IO::Socket::SSL::DEBUG = 1;
+			}
+
 			# Net::SMTP::SSL->new() does not forward any SSL options
 			IO::Socket::SSL::set_client_defaults(
 				ssl_verify_params());
-- 
2.6.3.462.gbe2c914
