From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv1 2/2] gitweb: Serve */*+xml 'blob_plain' as text/plain with $prevent_xss
Date: Thu, 30 Jun 2011 11:39:21 +0200
Message-ID: <1309426761-819-3-git-send-email-jnareb@gmail.com>
References: <1309426761-819-1-git-send-email-jnareb@gmail.com>
Cc: Matt McCutchen <matt@mattmccutchen.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 11:43:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcDmw-0007by-54
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 11:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076Ab1F3Jny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 05:43:54 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:41259 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab1F3Jnx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 05:43:53 -0400
Received: by fxd18 with SMTP id 18so2071382fxd.11
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ACR2UTPu2bezHGMFwevOnb014LtnnOLv80Lwc5evEHk=;
        b=E21YP3VnDpLUOpf2s3NcLKB8L0zHU9BD56vl/aAYQ0W/dmPmN3R7M8ga3B7yPkASgp
         f4dBjGRtqIJDxDy0UcXAwEboECBO2g+6NWrxnVVa44+yUEqIHsNDl3uxrTVr7O5crB68
         w7/GmM95FHD5RvNRpWwGE1teHhw6T1w2OOl6A=
Received: by 10.223.99.153 with SMTP id u25mr2697502fan.112.1309426871809;
        Thu, 30 Jun 2011 02:41:11 -0700 (PDT)
Received: from localhost.localdomain (abwr29.neoplus.adsl.tpnet.pl [83.8.241.29])
        by mx.google.com with ESMTPS id 21sm1349341fay.45.2011.06.30.02.41.10
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 02:41:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1309426761-819-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176484>

Enhance usability of 'blob_plain' view protection against XSS attacks
(enabled by setting $prevent_xss to true) by serving contents inline
as safe 'text/plain' mimetype where possible, instead of serving with
"Content-Disposition: attachment" to make sure they don't run in
gitweb's security domain.

This patch broadens downgrading to 'text/plain' further, to any
*/*+xml mimetype.  This includes:

  application/xhtml+xml    (*.xhtml, *.xht)
  application/atom+xml     (*.atom)
  application/rss+xml      (*.rss)
  application/mathml+xm    (*.mathml)
  application/docbook+xml  (*.docbook)
  image/svg+xml            (*.svg, *.svgz)

Probably most useful is serving XHTML files as text/plain in
'blob_plain' view, directly viewable.

Because file with 'image/svg+xml' mimetype can be compressed SVGZ
file, we have to check if */*+xml really is text file, via '-T $fd'.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is new.

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cb2e7bc..ae6244c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6143,7 +6143,8 @@ sub git_blob_plain {
 
 	# serve text/* as text/plain
 	if ($prevent_xss &&
-	    $type =~ m!^text/[a-z]+\b(.*)$!) {
+	    ($type =~ m!^text/[a-z]+\b(.*)$! ||
+	     ($type =~ m!^[a-z]+/[a-z]\+xml\b(.*)$! && -T $fd))) {
 		my $rest = $1;
 		$rest = defined $rest ? $rest : '';
 		$type = "text/plain$rest";
-- 
1.7.5
