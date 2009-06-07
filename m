From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/2] git-send-email.perl: improve detection of MIME encoded-words
Date: Sat,  6 Jun 2009 20:12:30 -0500
Message-ID: <1244337151-6506-1-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 03:10:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD6u0-0008H4-JY
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 03:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbZFGBKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 21:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbZFGBKD
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 21:10:03 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:46256 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbZFGBKC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 21:10:02 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1506448ywb.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 18:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cdAYQllHZa49xoS0yD6YFJqbxWl63FFLux32ooXCRms=;
        b=hnKr66B2+3QyEdwSVtaxtgss/681cqF+PJh0mSfS0+0GTeWuyj5nekrxH9KYfwuwwv
         xyjEp2io5Jy9Q+MwkHVUotwfM+sXdMCSk/Br+zrZ5xet62HlPRUlJv2Gd0K3uqsH4/G5
         WVT2jOCeME61FlmtvYM1Av9YDfjSwFFetAxjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ipeSOH9edzzLerK8Q2ES+hUbeG+XzSSxp2Rt7oNyhvzQr4Yhud+J6cI4PhMCdOCbVo
         t5QrMSwG7TpWCx8JyOcP04GKds3qRF1r2iba3Wa1sJGzihjkJQyNEdWCeq0zP4g/o8rF
         y7upehdnyc6Oe0RMlN5tN+EADYBVHeV6QTItw=
Received: by 10.90.88.16 with SMTP id l16mr4345375agb.112.1244337003987;
        Sat, 06 Jun 2009 18:10:03 -0700 (PDT)
Received: from localhost.localdomain ([96.19.141.3])
        by mx.google.com with ESMTPS id 1sm3927720agb.8.2009.06.06.18.10.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 18:10:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.9.g95405b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120948>

According to rfc2047, an encoded word has the following form:

   encoded-word = "=?" charset "?" encoding "?" encoded-text "?="

   charset = token

   encoding = token

   token = <Any CHAR except SPACE, CTLs, and especials>

   especials = "(" / ")" / "<" / ">" / "@" / "," / ";" / ":" / "
               <"> / "/" / "[" / "]" / "?" / "." / "="

   encoded-text = <Any printable ASCII character other than "?"
                     or SPACE>

And rfc822 defines CTLs as:

    CTL = <any ASCII control;  (  0- 37,  0.- 31.)
           character and DEL>; (    177,     127.)

The original code only detected rfc2047 encoded strings when the charset
was UTF-8.  This patch generalizes the matching expression and breaks the
check for an rfc2047 encoded string into its own function.  There's no real
functional change, since any properly rfc2047 encoded string (the ones that
weren't UTF-8) would have fallen through the remaining 'if' statements and
been returned unchanged.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 git-send-email.perl |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3d6a982..e735815 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -772,6 +772,14 @@ sub quote_rfc2047 {
 	return $_;
 }
 
+sub is_rfc2047_quoted {
+	my $s = shift;
+	my $token = '[^][()<>@,;:"\/?.= \000-\037\177]+';
+	my $encoded_text = '[!->@-~]+';
+	length($s) <= 75 &&
+	$s =~ m/^(?:"[[:ascii:]]*"|=\?$token\?$token\?$encoded_text\?=)$/o;
+}
+
 # use the simplest quoting being able to handle the recipient
 sub sanitize_address
 {
@@ -783,7 +791,7 @@ sub sanitize_address
 	}
 
 	# if recipient_name is already quoted, do nothing
-	if ($recipient_name =~ /^("[[:ascii:]]*"|=\?utf-8\?q\?.*\?=)$/) {
+	if (is_rfc2047_quoted($recipient_name)) {
 		return $recipient;
 	}
 
-- 
1.6.3.1.9.g95405b
