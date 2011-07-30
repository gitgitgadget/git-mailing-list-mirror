From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 7/6] gitweb: Use esc_html_match_hl in 'grep' search
Date: Sat, 30 Jul 2011 16:57:47 +0200
Message-ID: <201107301657.48678.jnareb@gmail.com>
References: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 16:58:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnAzP-0000w4-1q
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 16:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661Ab1G3O6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 10:58:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62104 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab1G3O56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 10:57:58 -0400
Received: by fxh19 with SMTP id 19so3144727fxh.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=W0ARgBxd4lGl2ZaK6N0WM0ydXAt2gJ8iy50f+b4wO44=;
        b=jDS2P6JwbE6zY9wcgnrMJ+Pe6ZtDNb1MAj/0lVvO7x2ii7jKNMj1LaAl6uovmnQXeg
         Uw+iuwWm973YV1F1T1/srgw8gyEaxUsJpLL64zXVNBmwf7pFbLuk2syinBbk0dTb8zt6
         EZR3k2DN1+KrGuqdS1mDOuaLM5Kno+L2vMzvs=
Received: by 10.223.63.20 with SMTP id z20mr1763717fah.97.1312037877125;
        Sat, 30 Jul 2011 07:57:57 -0700 (PDT)
Received: from [192.168.1.13] (abvz37.neoplus.adsl.tpnet.pl [83.8.223.37])
        by mx.google.com with ESMTPS id n27sm1731253faa.28.2011.07.30.07.57.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 07:57:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178204>

Use newly introduced esc_html_match_hl() subroutine in
git_search_files() ('grep' search), instead of handcrafted code using
captures, which highlighted only first match in line.

This required to enhance esc_html_match_hl() to be able to pass-thru
options for esc_html like -nbsp=>1.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Note: because untabify() is run before match, some regexp might not
show match; this is not regression, because earlier versions had the
same behavior.

Code is shorter, and behavior is improved.

 gitweb/gitweb.perl |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6bc68c5..d489640 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1692,24 +1692,24 @@ sub chop_and_escape_str {
 
 # highlight match (if any), and escape HTML
 sub esc_html_match_hl {
-	my ($str, $regexp) = @_;
-	return esc_html($str) unless defined $regexp;
+	my ($str, $regexp, @opts) = @_;
+	return esc_html($str, @opts) unless defined $regexp;
 
 	my @matches;
 	while ($str =~ /$regexp/g) {
 		push @matches, [$-[0], $+[0]];
 	}
-	return esc_html($str) unless @matches;
+	return esc_html($str, @opts) unless @matches;
 
 	my $out = '';
 	my $pos = 0;
 	for my $m (@matches) {
-		$out .= esc_html(substr $str, $pos, $m->[0] - $pos);
+		$out .= esc_html(substr($str, $pos, $m->[0] - $pos), @opts);
 		$out .= $cgi->span({-class => 'match'},
-		                   esc_html(substr $str, $m->[0], $m->[1] - 
$m->[0]));
+		                   esc_html(substr($str, $m->[0], $m->[1] - $m->[0]), 
@opts));
 		$pos = $m->[1];
 	}
-	$out .= esc_html(substr $str, $pos);
+	$out .= esc_html(substr($str, $pos), @opts);
 
 	return $out;
 }
@@ -5796,15 +5796,7 @@ sub git_search_files {
 			print "<div class=\"binary\">Binary file</div>\n";
 		} else {
 			$ltext = untabify($ltext);
-			if ($ltext =~ m/^(.*)($search_regexp)(.*)$/i) {
-				$ltext = esc_html($1, -nbsp=>1);
-				$ltext .= '<span class="match">';
-				$ltext .= esc_html($2, -nbsp=>1);
-				$ltext .= '</span>';
-				$ltext .= esc_html($3, -nbsp=>1);
-			} else {
-				$ltext = esc_html($ltext, -nbsp=>1);
-			}
+			esc_html_match_hl($ltext, $search_regexp, -nbsp => 1);
 			print "<div class=\"pre\">" .
 				$cgi->a({-href => href(action=>"blob", hash=>$co{'hash'},
 						       file_name=>"$file").'#l'.$lno,
-- 
1.7.5
