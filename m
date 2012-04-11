From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v4 3/8] gitweb: Pass esc_html_hl_regions() options to esc_html()
Date: Wed, 11 Apr 2012 23:18:39 +0200
Message-ID: <1334179124-14258-4-git-send-email-michal.kiedrowicz@gmail.com>
References: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, michal.kiedrowicz@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 11 23:19:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4wW-00053U-2x
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933371Ab2DKVTB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 17:19:01 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63166 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351Ab2DKVTA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:19:00 -0400
Received: by wgbdr13 with SMTP id dr13so1311420wgb.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gsQVPkKfCWLKJkbcEmFtjYqconbL539y/h4d3qP/xFI=;
        b=EajRk4sgsNdBf5fpGxWPuNkPygqPC2iVgH5+KsbsnuMahDfPXSuWaGPccjkTLyYEOj
         sSZj2PE1J08FUDOeWNOBeXfT2Sr5axZwOnbkFjgrbV2iiJhC4aNSddSXnvxWvpBsuJJ8
         8ULmyhJhhveqALgkNp0fVpP505/mBXhMshhZDyqFni5eFZoxqDDKPNDsZx2YPr6MyajV
         5l+vrzwTq9Y5Jpy9PzRVA2mc4Bt7uKZ5ekWs6v1AlTx0qbXLHTmnpkQEuar+WXrdE7OG
         /LcWFyepgaWJbTN2xANK0MHpe042uQ6wphzeWpELY9osNjKzi9RxByFRENByYh5szazY
         Jxiw==
Received: by 10.216.138.38 with SMTP id z38mr9521008wei.63.1334179139000;
        Wed, 11 Apr 2012 14:18:59 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id o2sm13727421wiv.11.2012.04.11.14.18.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:18:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195259>

=46rom: Jakub Nar=C4=99bski <jnareb@gmail.com>

With this change, esc_html_hl_regions() accepts options and passes them
down to esc_html().  This may be needed if a caller wants to pass
-nbsp=3D>1 to esc_html().

The idea and implementation example of this change was described in
337da8d2 (gitweb: Introduce esc_html_match_hl and esc_html_hl_regions,
2012-02-27).  While other suggestions may be more useful in some cases,
there is no need to implement them at the moment.  The
esc_html_hl_regions() interface may be changed later if it's needed.

[mk: extracted from larger patch and wrote commit message]

Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 588b87d..db1f698 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1732,7 +1732,9 @@ sub chop_and_escape_str {
 # '<span class=3D"mark">foo</span>bar'
 sub esc_html_hl_regions {
 	my ($str, $css_class, @sel) =3D @_;
-	return esc_html($str) unless @sel;
+	my %opts =3D grep { ref($_) ne 'ARRAY' } @sel;
+	@sel     =3D grep { ref($_) eq 'ARRAY' } @sel;
+	return esc_html($str, %opts) unless @sel;
=20
 	my $out =3D '';
 	my $pos =3D 0;
@@ -1743,15 +1745,16 @@ sub esc_html_hl_regions {
 		# Don't create empty <span> elements.
 		next if $end <=3D $begin;
=20
-		my $escaped =3D esc_html(substr($str, $begin, $end - $begin));
+		my $escaped =3D esc_html(substr($str, $begin, $end - $begin),
+		                       %opts);
=20
-		$out .=3D esc_html(substr($str, $pos, $begin - $pos))
+		$out .=3D esc_html(substr($str, $pos, $begin - $pos), %opts)
 			if ($begin - $pos > 0);
 		$out .=3D $cgi->span({-class =3D> $css_class}, $escaped);
=20
 		$pos =3D $end;
 	}
-	$out .=3D esc_html(substr($str, $pos))
+	$out .=3D esc_html(substr($str, $pos), %opts)
 		if ($pos < length($str));
=20
 	return $out;
--=20
1.7.8.4
