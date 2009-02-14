From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/3] send-email: don't call unquote_rfc2047 unnecessarily
Date: Fri, 13 Feb 2009 22:51:30 -0500
Message-ID: <1234583491-61260-3-git-send-email-jaysoffian@gmail.com>
References: <1234583491-61260-1-git-send-email-jaysoffian@gmail.com>
 <1234583491-61260-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, gitster@pobox.com,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 04:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYBfv-0000Fb-Vt
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 04:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbZBND5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 22:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbZBND5Q
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 22:57:16 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:38744 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZBND5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 22:57:15 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Feb 2009 22:57:15 EST
Received: by gxk22 with SMTP id 22so1460181gxk.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 19:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xL1LXK6N/3K1Rm9SHu1SNoVVXF2j62lfVCuwPGEuSF0=;
        b=pYd6wSIFozWFK17ZGhTNRwIHStnG8OhFJcDgubpgtSKwAuCiiGd5wvkqIeEeoNjXMg
         E3xZThEZrnQZpODx1E6xAW65+A6BFFHyYFvRlsVFx2zW6pt5cNOB7SIM5hW0eSq4Hg2f
         1p1fU1cQfBt/SgzaSbeVuIKsvhg78T/Nd27Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AkDRwz3gR3xCWfN6ARiT6ojylvTqXBitdnaHn9s1ZswiVa2G3fJWv8dgXC8dqGUQf4
         +IMv2GWD+DWgZ2+mFJ5NXB4SIu0mwAlyKbYOijRJOdj7luApcXGgH5/xdLJhJ4/nmVfF
         XTPEf76BMxjEMYZ6odPhJpj6QCidy/Gc5TaaY=
Received: by 10.151.156.7 with SMTP id i7mr1045802ybo.154.1234583498625;
        Fri, 13 Feb 2009 19:51:38 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id t26sm5072329ele.15.2009.02.13.19.51.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 19:51:38 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.238.g0c1fe
In-Reply-To: <1234583491-61260-2-git-send-email-jaysoffian@gmail.com>
In-Reply-To: <200902140032.19922.trast@student.ethz.ch>
References: <200902140032.19922.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109816>

From: Jay Soffian <jaysoffian@gmail.com>

If --suppress-cc=author then there is no need to unquote the From:
address.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a2e0b94..2a3e3e8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -958,8 +958,8 @@ foreach my $t (@files) {
 				$subject = $1;
 			}
 			elsif (/^From:\s+(.*)$/) {
+				next if $suppress_cc{'author'};
 				($author, $author_encoding) = unquote_rfc2047($1);
-				next if ($suppress_cc{'author'});
 				printf("(mbox) Adding cc: %s from line '%s'\n",
 					$1, $_) unless $quiet;
 				push @cc, $1;
-- 
1.6.2.rc0.235.g1319
