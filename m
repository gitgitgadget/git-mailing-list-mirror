From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] send-email: use the three-arg form of open in
 recipients_cmd
Date: Sun, 31 Mar 2013 18:40:42 -0700
Message-ID: <1364780442-6015-3-git-send-email-gitster@pobox.com>
References: <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
 <1364780442-6015-1-git-send-email-gitster@pobox.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 03:41:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMTkN-0000nz-O5
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 03:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870Ab3DABkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 21:40:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56544 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890Ab3DABkt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 21:40:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39EC1ED6C;
	Mon,  1 Apr 2013 01:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/oJr
	8unBS6sNh7MylPhlvcChRzY=; b=ax+C3rwn0OEb8qLAhiDRTsOblIJcX8uOu0IC
	9qny3R5r2737dDTCmSl1zSeogk+QPjKwWaNTEBdlpvyWvZSQrsPCaGeKLCpORQQs
	dAubjCYPog0ueaPsOdDNCOSRkpD5BeVBngjNwFVRFHRfwst6CwIsNVQUFRGO8QOo
	59dB+iE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	HR8AQkBqTVt1l+wHfXii/xzxMUrA3NNJzjk4R+5uGq+zQpm8+RlG97kcXy2mPGbv
	2G65PGOfL251p0h8mH8SgKxghRSdvgb9W+e8WAWRWyScP/68mynHWxU43Rybec0Z
	lbpMxN4JG4tsqUbHr8xrJYE1eymPwGKyyZTxlbHw9vY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 327CFED6B;
	Mon,  1 Apr 2013 01:40:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81EA8ED6A; Mon,  1 Apr 2013
 01:40:48 +0000 (UTC)
X-Mailer: git-send-email 1.8.2-441-g6e6f07b
In-Reply-To: <1364780442-6015-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2DD22B52-9A6D-11E2-92B1-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219653>

From: Ramkumar Ramachandra <artagnon@gmail.com>

Perlcritic does not want to see the trailing pipe in the two-args
form of open(), i.e.

	open my $fh, "$cmd \Q$file\E |";

If $cmd were a single-token command name, it would make a lot more
sense to use four-or-more-args form "open FILEHANDLE,MODE,CMD,ARGS"
to avoid shell from expanding metacharacters in $file, but we do
expect multi-word string in $to_cmd and $cc_cmd to be expanded by
the shell, so we cannot rewrite it to

	open my $fh, "-|", $cmd, $file;

for extra safety.  At least, by using this in the three-arg form:

	open my $fh, "-|", "$cmd \Q$file\E";

we can silence Perlcritique, even though we do not gain much safety
by doing so.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 86dd593..fb92227 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1438,7 +1438,7 @@ sub recipients_cmd {
 
 	my $sanitized_sender = sanitize_address($sender);
 	my @addresses = ();
-	open my $fh, "$cmd \Q$file\E |"
+	open my $fh, "-|", "$cmd \Q$file\E"
 	    or die "($prefix) Could not execute '$cmd'";
 	while (my $address = <$fh>) {
 		$address =~ s/^\s*//g;
-- 
1.8.2-441-g6e6f07b
