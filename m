From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] send-email: enable SSL level 1 debug output
Date: Wed, 25 Nov 2015 00:02:23 +0000
Message-ID: <a56a8d728ffeb6a6c2b0f7decd0485a1906b8f25.1448409432.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 01:02:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1NXy-00007R-Iw
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 01:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbbKYACw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 19:02:52 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:58757 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbbKYACu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 19:02:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id CFBD6CDA52C;
	Wed, 25 Nov 2015 00:02:49 +0000 (GMT)
X-Quarantine-ID: <bqn6els2942H>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bqn6els2942H; Wed, 25 Nov 2015 00:02:49 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 668F1CDA57C;
	Wed, 25 Nov 2015 00:02:40 +0000 (GMT)
X-Mailer: git-send-email 2.6.3.462.gbe2c914
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281655>

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

Signed-off-by: John Keeping <john@keeping.me.uk>
---
This is the result of a previous discussion [0] but I decided to drop
the switch on --smtp-debug since level 1 only gives output on errors.

[0] http://marc.info/?l=git&m=144840344331208&w=2

 git-send-email.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index e907e0e..918aafa 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1318,6 +1318,7 @@ Message-Id: $message_id
 			require Net::SMTP::SSL;
 			$smtp_domain ||= maildomain();
 			require IO::Socket::SSL;
+			$IO::Socket::SSL::DEBUG = 1;
 			# Net::SMTP::SSL->new() does not forward any SSL options
 			IO::Socket::SSL::set_client_defaults(
 				ssl_verify_params());
-- 
2.6.3.462.gbe2c914
