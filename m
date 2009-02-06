From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2] gitweb: Better regexp for SHA-1 committag match
Date: Fri, 6 Feb 2009 11:49:14 +0100
Message-ID: <200902061149.16210.jnareb@gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de> <200902061126.18418.jnareb@gmail.com> <b77c1dce0902060231u358587d5o940eb322fde52a68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster@gmx.de>
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 11:50:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOIL-0005Tb-4X
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 11:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbZBFKt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 05:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbZBFKtY
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 05:49:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:45605 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbZBFKtX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 05:49:23 -0500
Received: by fg-out-1718.google.com with SMTP id 16so450631fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 02:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tuROhVuxuSwHj6/aERPuadQh/STNZoICl+gO1wtLWx8=;
        b=u7lMBNFJS9GxHjphjIYwVYdBTnwHFjhGo8FWBuBo8D1PkV8zE0+Cn9xmRuCIFCvSKo
         IQaWoM1W8TQJA4JQfnFXwysJqtlplCnzJpnz54R6PvOg4QsKah7hd7upLZIMwEbGjYPx
         2nwWZxcNtCvPIE/NaxHa8Tt7yLmBHwmKwq5oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ca+Inp0JxWYyqU/PslJ4aEFUzwlE4s3BrKMNOIYgBV6ZDhmFJutlF0Jsvct8rDfxdG
         9Zt61OTgPt2s+9nXAONsG1Awl+Z4rb2gtkhfCWMZIpSYgZnSLYZKqchLbohLQLSZW9B6
         v8rN8ufsafgjl5Am3BuHhssVtQvhxrAoyitGs=
Received: by 10.86.29.8 with SMTP id c8mr875789fgc.19.1233917361454;
        Fri, 06 Feb 2009 02:49:21 -0800 (PST)
Received: from ?192.168.1.13? (abuz248.neoplus.adsl.tpnet.pl [83.8.197.248])
        by mx.google.com with ESMTPS id 4sm1564342fge.54.2009.02.06.02.49.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 02:49:20 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <b77c1dce0902060231u358587d5o940eb322fde52a68@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108676>

Make SHA-1 regexp to be turned into hyperlink (SHA-1 committag)
to match word boundary at beginning and end.  This way we limit
false matches, for example 0x74a5cd01 which is hex decimal (for
example memory address) but not SHA-1.

Also make sure that it is not Message-ID, which fragment just
looks like SHA-1 (e.g. "Message-ID: <46A0F335@example.com>"),
by using zero-width negative look-ahead assertion to _not_
match '@' after.

Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Suggested-by: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
v2: Added protection against matching Message-IDs fragments.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f27dbb6..5dcc108 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1364,7 +1364,7 @@ sub format_log_line_html {
 	my $line = shift;
 
 	$line = esc_html($line, -nbsp=>1);
-	if ($line =~ m/([0-9a-fA-F]{8,40})/) {
+	if ($line =~ m/\b([0-9a-fA-F]{8,40})\b(!?\@)/) {
 		my $hash_text = $1;
 		my $link =
 			$cgi->a({-href => href(action=>"object", hash=>$hash_text),
-- 
1.6.1
