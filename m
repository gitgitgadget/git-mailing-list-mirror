X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Use character or octal escape codes (and add span.cntrl) in esc_path
Date: Wed, 8 Nov 2006 11:50:07 +0100
Message-ID: <200611081150.07469.jnareb@gmail.com>
References: <200611081147.52952.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 10:49:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j6Kc7qFkMGfFtfWz6FvOvFm/h57IdHXEwfbIO5pJbC+bL+EBkpLeJQvVFjbfSF3m3JI5cNCDr7Dwxp6xUQySOb8KfRjB3cIvJLE6l7ujUlMZTLZtVU7HbiQy2UpkB5WophjXe1fitRFgV9MDMfw0uxTr+EekiQk11W+Rxkie1YM=
User-Agent: KMail/1.9.3
In-Reply-To: <200611081147.52952.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31136>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghkzz-0001gj-NR for gcvg-git@gmane.org; Wed, 08 Nov
 2006 11:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754507AbWKHKte (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 05:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754509AbWKHKte
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 05:49:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:31694 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1754507AbWKHKtd
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 05:49:33 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1476063ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 02:49:32 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr10641068ugh.1162982971884; Wed,
 08 Nov 2006 02:49:31 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id m1sm7626498uge.2006.11.08.02.49.31; Wed, 08 Nov
 2006 02:49:31 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Instead of simply hiding control characters in esc_path by replacing
them with '?', use Character Escape Codes (CEC) i.e. alphabetic
backslash sequences like those found in C programming language and
many other languages influenced by it, such as Java and Perl.  If
control characted doesn't have corresponding character escape code,
use octal char sequence to escape it.

Additionally use 'span' element with 'cntrl' attribute to mark escaped
control characters. Add style for span.cntrl in the CSS.

Below there is alternative quoting using Unicode Printable
Representation (PR), i.e. replace control characters with appropriate
Unicode Control Pictures U+2400 - U+243F (9216 - 9279), the Unicode
characters reserved for representing control characters when it is
necessary to print or display them:

sub esc_path {
	my $str = shift;
	$str = esc_html($str);
	$str =~ s!([[:cntrl:]])!sprintf('<span class="cntrl">&#%04d;</span>', 0x2400+ord($1))!eg;
	return $str;
}

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The styling (span.cntrl style) isn't best, I agree.

 gitweb/gitweb.css  |    7 +++++++
 gitweb/gitweb.perl |   25 ++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 0eda982..e19e6bc 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -16,6 +16,13 @@ a:hover, a:visited, a:active {
 	color: #880000;
 }
 
+span.cntrl {
+	border: dashed #aaaaaa;
+	border-width: 1px;
+	padding: 0px 2px 0px 2px;
+	margin:  0px 2px 0px 2px;
+}
+
 img.logo {
 	float: right;
 	border-width: 0px;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 32926f9..c9b16b5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -587,8 +587,31 @@ sub esc_html ($;%) {
 # quote control characters and escape filename to HTML
 sub esc_path {
 	my $str = shift;
+
+	sub quot {
+		my $seq = shift;
+		my %es = ( # character escape codes, aka escape sequences
+			"\t" => '\t',   # tab            (HT, TAB)
+			"\n" => '\n',   # newline        (NL)
+			"\r" => '\r',   # return         (CR)
+			"\f" => '\f',   # form feed      (FF)
+			"\b" => '\b',   # backspace      (BS)
+			"\a" => '\a',   # alarm (bell)   (BEL)
+			"\e" => '\e',   # escape         (ESC)
+			"\013" => '\v', # vertical tab   (VT)
+			"\000" => '\0', # null character (NUL)
+		);
+
+		if (exists $es{$seq}) {
+			# C escape sequence, aka character escape code
+			return $es{$seq};
+		}
+		# octal char sequence
+		return sprintf('\%03o', ord($seq));
+	}
+
 	$str = esc_html($str);
-	$str =~ s/[[:cntrl:]]/?/g; # like --hide-control-chars in ls
+	$str =~ s!([[:cntrl:]])!'<span class="cntrl">' . quot($1) . '</span>'!eg;
 	return $str;
 }
 
-- 
1.4.3.4
