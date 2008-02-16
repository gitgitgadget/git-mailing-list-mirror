From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] Don't open a XML tag while another one is already open
Date: Sat, 16 Feb 2008 20:16:28 +0100
Message-ID: <20080216191628.GK30676@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 20:17:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQSX8-00082I-93
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 20:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbYBPTQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 14:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756265AbYBPTQe
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 14:16:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:47755 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229AbYBPTQd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 14:16:33 -0500
Received: by fg-out-1718.google.com with SMTP id e21so884405fga.17
        for <git@vger.kernel.org>; Sat, 16 Feb 2008 11:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        bh=vYdNbwXHDpc9LwhYHCSZIJyZv9r/oJz5Ej7bsYFuzpg=;
        b=VkHP/SkjsU2YTYdmALIvKJpnwD8uCygWvKhA6FY/EhpHKw4DImuvZjQyajIrYLcxRVV6UPN17QjSyxPMjgbx7eBrc0P700BYNy0xNyr1VIbBTeNa5ed0i7BP5zD4WZ0xcRGn0PC5cMLL02eiGEOjxpY1Tm3KpZQIJZ5fuHY7/4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=gX6YlFR53kj90g6XRXXDFvcprRqO76SVmNj4NCI6wIWRGfZHYyOccfIs9tAvr8T7iuAMmFtBmjpe3rArkPI0whYqa5gTREdMne9ppscR9wnYgK5Dlfyc0IrLPSzqvoDtbML2PNi52EBMCMnB7jokAJtR0rlY45QPu9vc/nEIEYQ=
Received: by 10.86.99.9 with SMTP id w9mr3957942fgb.44.1203189392426;
        Sat, 16 Feb 2008 11:16:32 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [91.18.105.53])
        by mx.google.com with ESMTPS id d6sm7599881fga.9.2008.02.16.11.16.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Feb 2008 11:16:31 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 6CACB2A8D5; Sat, 16 Feb 2008 20:16:28 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74063>

chop_and_escape_str calls esc_html within a XML tag.  Since esc_html
itself does escape control characters with quot_cec it could potentially
open another tag which leads to incorrect XML.

This patch adds an option "intag" to esc_html and quot_cec to indicate
that we are currently within a tag and thus suppresses opening another
one.  It also makes use of this option in chop_and_escape_str.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
This patch should fix the bug Martin Koegler reported in his mail "Invalid
html output repo.or.cz (alt-git.git)".

 gitweb/gitweb.perl |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5e88637..a010c7a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -732,7 +732,7 @@ sub esc_html ($;%) {
 	if ($opts{'-nbsp'}) {
 		$str =~ s/ /&nbsp;/g;
 	}
-	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
+	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1, -intag=>$opts{'-intag'}) : $1)|eg;
 	return $str;
 }
 
@@ -753,6 +753,7 @@ sub esc_path {
 # Make control characters "printable", using character escape codes (CEC)
 sub quot_cec {
 	my $cntrl = shift;
+	my %opts = @_;
 	my %es = ( # character escape codes, aka escape sequences
 		   "\t" => '\t',   # tab            (HT)
 		   "\n" => '\n',   # line feed      (LF)
@@ -767,7 +768,11 @@ sub quot_cec {
 	my $chr = ( (exists $es{$cntrl})
 		    ? $es{$cntrl}
 		    : sprintf('\%03o', ord($cntrl)) );
-	return "<span class=\"cntrl\">$chr</span>";
+	if ($opts{'-intag'}) {
+		return "$chr";
+	} else {
+		return "<span class=\"cntrl\">$chr</span>";
+	}
 }
 
 # Alternatively use unicode control pictures codepoints,
@@ -866,7 +871,7 @@ sub chop_and_escape_str {
 	if ($chopped eq $str) {
 		return esc_html($chopped);
 	} else {
-		return qq{<span title="} . esc_html($str) . qq{">} .
+		return qq{<span title="} . esc_html($str, -intag=>1) . qq{">} .
 			esc_html($chopped) . qq{</span>};
 	}
 }
-- 
1.5.2.4
