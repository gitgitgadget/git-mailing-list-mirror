From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2] git-send-email.perl: improve detection of MIME encoded-words
Date: Sun,  7 Jun 2009 19:25:58 -0500
Message-ID: <1244420758-5604-1-git-send-email-drafnel@gmail.com>
References: <ee63ef30906070945g62e94313r8b2a7128bde16f9d@mail.gmail.com>
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 02:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDSdl-0002MT-Qg
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 02:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbZFHAWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 20:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbZFHAWy
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 20:22:54 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:62040 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbZFHAWx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 20:22:53 -0400
Received: by gxk10 with SMTP id 10so1148974gxk.13
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 17:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XyJ1ecz3af0lZIbel0qNER2bs/4T38h0HXJ10Of75Dw=;
        b=YsPK9WHRuiPUltRM6YnApFBex7z/woqCqA3/+ZLhs7zqYtkEJd+8LDlUvDkFnYmVrV
         il9ZdhffkawcXUga4ElGGmQRbyoor2KUp7eGHlM4UJfnxdRhqVIwOP21OqSMqegETOd5
         5B9e9yCl3ucR0+1OfCNbAKtJSmYW7V/GATrQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SU740tOMG9+5hHLXAzqFso0vQ1MAjqiXrUDShyS4kRh/OUSFzsBWdEc/xweCIquM89
         udxzJSlHFro7XX99ohnnFBpgrOPkGjIdEHLrp1OA4pgz+LvQQhVOzjv/tPLLeRr3xIt/
         ALZ/H7Qu34M7UzWWRBbtlUSFui+aS0ygwvxHY=
Received: by 10.90.101.17 with SMTP id y17mr1990373agb.97.1244420575548;
        Sun, 07 Jun 2009 17:22:55 -0700 (PDT)
Received: from localhost.localdomain ([96.19.141.3])
        by mx.google.com with ESMTPS id 10sm6521169agb.76.2009.06.07.17.22.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Jun 2009 17:22:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.9.g95405b
In-Reply-To: <ee63ef30906070945g62e94313r8b2a7128bde16f9d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121023>

According to rfc2047, an encoded word has the following form:

   encoded-word = "=?" charset "?" encoding "?" encoded-text "?="

   charset = token

   encoding = token

   token = <Any CHAR except SPACE, CTLs, and especials>

   especials = "(" / ")" / "<" / ">" / "@" / "," / ";" / ":" / "
               <"> / "/" / "[" / "]" / "?" / "." / "="

   encoded-text = <Any printable ASCII character other than "?"
                     or SPACE>

And rfc822 defines CHARs and CTLs as:

    CHAR = <any ASCII character> ; (  0-177,  0.-127.)

    CTL = <any ASCII control     ; (  0- 37,  0.- 31.)
           character and DEL>    ; (    177,     127.)

The original code only detected rfc2047 encoded strings when the charset
was UTF-8.  This patch generalizes the matching expression and breaks the
check for an rfc2047 encoded string into its own function.  There's no real
functional change, since any properly rfc2047 encoded string would have
fallen through the remaining 'if' statements and been returned unchanged.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


Here's a replacement patch which increases the range of excluded characters
allowed as tokens so only ASCII characters are allowed (minus the other
exclusions).

-brandon


 git-send-email.perl |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3d6a982..8a1a40d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -772,6 +772,14 @@ sub quote_rfc2047 {
 	return $_;
 }
 
+sub is_rfc2047_quoted {
+	my $s = shift;
+	my $token = '[^][()<>@,;:"\/?.= \000-\037\177-\377]+';
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
