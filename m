From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] git-send-email: kill $prompting variable
Date: Fri, 16 Aug 2013 17:34:04 +0000
Message-ID: <1376674444-29599-1-git-send-email-rv@rasmusvillemoes.dk>
Cc: git@vger.kernel.org, Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 16 19:34:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VANuw-0001dy-31
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 19:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab3HPReZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 13:34:25 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:60830 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab3HPReY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 13:34:24 -0400
Received: by mail-ee0-f50.google.com with SMTP id d51so1025610eek.23
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 10:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n+mduZfC1TYLeirvD6kvKQbe0A73kYYufJOWWD+TozU=;
        b=jdYs/dnYlNEXUGMgNPa7a0db7SQMP3YxfWAmRwrA+fGPMACx52YLJW/SFJnb+0p6uM
         fcIBlIbVU9ZUmuQdJY2xkrun3nDlS16nJAY7mRMfob6zTLgWEOb4fHjrPxTO9W9vtZW+
         tvsdF1pSk3+2IuYyMrebdQT3AHydEIZFq/Kqp/oC2z+qmOkYNkK/Vo+iAe/v4hf2sYl4
         Wq0Z4r5pugZtUAs46lYrQmMJ13gy/WxeEzNq4BWCYkgRKWMI/sjupP5DQUpPPk97ia0H
         tqPT0pj00dLUvOibk4/weILaXxfN8YnWRijPuYCYhIETdgsUCyyQXVHUbGNwYMk8DW9z
         eI6w==
X-Gm-Message-State: ALoCoQk4I1LpuzD2nEURbxQJk1h7ADZp7Q0cdK2Qmjo4uNvtXJg2VBnnPZbpFMlAbCR6A9xB1o84
X-Received: by 10.15.41.205 with SMTP id s53mr16439eev.63.1376674462999;
        Fri, 16 Aug 2013 10:34:22 -0700 (PDT)
Received: from villemoes-sl500.decode.is (wildmoose.dk. [83.169.18.19])
        by mx.google.com with ESMTPSA id a4sm4176670eez.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 10:34:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.1.g30eccb6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232436>

The variable $prompting is weird. It is only read in one place (when
deciding whether to prompt for a Message-ID to use in In-Reply-To),
and it will be false unless we've taken the completely unrelated
branch filling in @initial_to.

Prompting should be done if the info is needed, not if some unrelated
item had to be prompted for. So kill $prompting.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 git-send-email.perl | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2162478..f608d9b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -755,13 +755,11 @@ if (!defined $sender) {
 # But it's a no-op to run sanitize_address on an already sanitized address.
 $sender = sanitize_address($sender);
 
-my $prompting = 0;
 if (!@initial_to && !defined $to_cmd) {
 	my $to = ask("Who should the emails be sent to (if any)? ",
 		     default => "",
 		     valid_re => qr/\@.*\./, confirm_only => 1);
 	push @initial_to, parse_address_line($to) if defined $to; # sanitized/validated later
-	$prompting++;
 }
 
 sub expand_aliases {
@@ -785,7 +783,7 @@ sub expand_one_alias {
 @bcclist = expand_aliases(@bcclist);
 @bcclist = validate_address_list(sanitize_address_list(@bcclist));
 
-if ($thread && !defined $initial_reply_to && $prompting) {
+if ($thread && !defined $initial_reply_to) {
 	$initial_reply_to = ask(
 		"Message-ID to be used as In-Reply-To for the first email (if any)? ",
 		default => "",
-- 
1.8.4.rc3.1.g30eccb6
