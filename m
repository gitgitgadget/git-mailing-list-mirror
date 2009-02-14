From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/3] send-email: correct logic error with --suppress-cc=cc
Date: Fri, 13 Feb 2009 22:51:29 -0500
Message-ID: <1234583491-61260-2-git-send-email-jaysoffian@gmail.com>
References: <1234583491-61260-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, gitster@pobox.com,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 04:59:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYBgZ-0000O5-Ob
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 04:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbZBND55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 22:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbZBND54
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 22:57:56 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:5147 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbZBND54 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 22:57:56 -0500
Received: by yx-out-2324.google.com with SMTP id 8so735379yxm.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 19:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vs3V8e7DdTfdmK91OdbCAwvpjcP1yJPtvwJTz0gkVLk=;
        b=YwW4UB1R0eCsZI5rgTjoZBMus+qWD2pJeqwVXb+zEfb+dwb5beueIXArO7B3bvtqFJ
         dxgNwWhDNg9gfttWtzJcoebbjzd3TC4D/o+7d07wePjIUQUPBk0JdvL+8AAo3u2WjMw3
         rk0Ky7OPi3ueONcOtm+Ipxw59jrmX9Qb9zfqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UQh++s2bhcf4wiP1Qa7KRWCmwmLdCWt8HX6EU2FEsXyjMXrT0kxikIQo+WUrMK/bRH
         MBb7+/dBJp2KfrdSQZ9IWmZS7fR7x5/iZjjTa0C0hAwTwjvSjAiQbTbnG+OJWSVjMCfw
         F6Mx4PR1wekR4NSPRtm3M3sUKSTUQx6dhLWY4=
Received: by 10.151.113.5 with SMTP id q5mr1113446ybm.62.1234583496378;
        Fri, 13 Feb 2009 19:51:36 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id s30sm5060867elf.11.2009.02.13.19.51.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 19:51:35 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.238.g0c1fe
In-Reply-To: <1234583491-61260-1-git-send-email-jaysoffian@gmail.com>
In-Reply-To: <200902140032.19922.trast@student.ethz.ch>
References: <200902140032.19922.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109817>

From: Jay Soffian <jaysoffian@gmail.com>

--suppress-cc=cc is supposed to suppress harvesting addresses from any
Cc: lines. However, in the case where the Cc: line contained the sender,
it would only suppress if --suppress-cc=self.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-send-email.perl |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cde294c..a2e0b94 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -965,12 +965,10 @@ foreach my $t (@files) {
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
-- 
1.6.2.rc0.235.g1319
