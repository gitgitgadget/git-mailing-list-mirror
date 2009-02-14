From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/3 v2] send-email: correct logic error with --suppress-cc=cc
Date: Sat, 14 Feb 2009 01:21:59 -0500
Message-ID: <1234592519-71980-1-git-send-email-jaysoffian@gmail.com>
References: <1234583491-61260-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, gitster@pobox.com,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 07:23:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYDw4-0001yt-Mx
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 07:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbZBNGWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 01:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbZBNGWF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 01:22:05 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:53266 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbZBNGWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 01:22:04 -0500
Received: by gxk22 with SMTP id 22so1516120gxk.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 22:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=GUELtpNiav0WgIZH82MelN5B2ADHLKZGaRxwsZJSrIo=;
        b=MXFwec8AxuphX/EzvmKQ15R8buucnrFGyZNr4w4I8BPnrnh7aXqMLWXuJGOq6wi9/+
         nNr2Tu5V3YxMShkqbILTsCNKEh+bjwb6hV2fZbLIgdkrOA9KHpDbx5Qqa4WVy6pGglWI
         elcJajIxhg7+gLS8VxVSL0Rcg/mtT9Me+xWFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YRA7cGvVo/k/R4sCw6sYATfjB02/nqoqd3wMnIwQl3JNZgjDaKLXUOZR/mbMQz82L9
         uuyuyGI+GiiVQfvFroqRJU+suL1e/tWh1vrAw7sIN/EzSMW8s7apEuomsAxEV54GdVYR
         vJ3Gv4n8srh9domca16X2ySLTjLrihTW4PGj0=
Received: by 10.151.156.1 with SMTP id i1mr1753393ybo.247.1234592521887;
        Fri, 13 Feb 2009 22:22:01 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id q26sm5268027ele.5.2009.02.13.22.22.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 22:22:01 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.238.ge8815
In-Reply-To: <1234583491-61260-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109828>

--suppress-cc=cc is supposed to suppress harvesting addresses from any
Cc: lines. However, in the case where the Cc: line contained the sender,
it would only suppress if --suppress-cc=self.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
And here's a re-roll of this one. Sheesh, that logic was too subtle for
my brain. I think it's a lot more obvious what is going on after this
patch.

I apologize that this thread is getting so dense. Here it is on gmane
which may help:

  http://thread.gmane.org/gmane.comp.version-control.git/109783

j.

 git-send-email.perl |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cde294c..cef32da 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -959,18 +959,17 @@ foreach my $t (@files) {
 			}
 			elsif (/^From:\s+(.*)$/) {
 				($author, $author_encoding) = unquote_rfc2047($1);
-				next if ($suppress_cc{'author'});
+				next if $suppress_cc{'author'};
+				next if $suppress_cc{'self'} and $author eq $sender;
 				printf("(mbox) Adding cc: %s from line '%s'\n",
 					$1, $_) unless $quiet;
 				push @cc, $1;
 			}
 			elsif (/^Cc:\s+(.*)$/) {
+				next if $suppress_cc{'cc'};
 				foreach my $addr (parse_address_line($1)) {
-					if (unquote_rfc2047($addr) eq $sender) {
-						next if ($suppress_cc{'self'});
-					} else {
-						next if ($suppress_cc{'cc'});
-					}
+					next if $suppress_cc{'self'} and
+						unquote_rfc2047($addr) eq $sender;
 					printf("(mbox) Adding cc: %s from line '%s'\n",
 						$addr, $_) unless $quiet;
 					push @cc, $addr;
@@ -1038,7 +1037,7 @@ foreach my $t (@files) {
 			or die "(cc-cmd) failed to close pipe to '$cc_cmd'";
 	}
 
-	if (defined $author) {
+	if (defined $author and $author ne $sender) {
 		$message = "From: $author\n\n$message";
 		if (defined $author_encoding) {
 			if ($has_content_type) {
-- 
1.6.2.rc0.238.g0c1fe
