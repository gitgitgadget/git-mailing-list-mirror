From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: filter escapes from longer commit titles that break firefox
Date: Sat, 25 Apr 2009 11:04:42 +0200
Message-ID: <200904251104.45236.jnareb@gmail.com>
References: <1239985473-666-1-git-send-email-paul.gortmaker@windriver.com> <20090424194822.GA15846@windriver.com> <200904250010.46299.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 11:07:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxdqa-00008q-HN
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 11:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbZDYJEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 05:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbZDYJEy
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 05:04:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:34319 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbZDYJEx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 05:04:53 -0400
Received: by fg-out-1718.google.com with SMTP id 16so301048fgg.17
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ARc6wJ3agneTm720O1gqA48MJBorUNImRx7M+B+lUcc=;
        b=GifNEtY09lhsezSUKCfdsJ53NLZyiQMEFs1CNVG2onRSSY/CkUB4De0pfR+DjVhJbW
         dtZqXvdbZl9YmJ5g0wTbIAcC6M+eYqPmGEgGiTKUCNxGBGDKdFYL0E3CZIDSNmMGnfpB
         KU1sECG0boHGSiK6khPqL8HnF8M2rn6ka7t+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YpZgQRdWSejYi3t6PWspAv5bmUCqfyM6TPcxO5/lO80QekeQE2Gh4fshYBkn6bnO4o
         qp9ygmrWhIxtIuqix1WcaCzva7DoI72QGa/YrkHjps9NAYm5ACvGRcifWOAcCwdzfZ1E
         3LKU8reTt0vZ9okuJSI/Qvgsv2JrdEwaDRb/M=
Received: by 10.86.36.17 with SMTP id j17mr1496079fgj.40.1240650291609;
        Sat, 25 Apr 2009 02:04:51 -0700 (PDT)
Received: from ?192.168.1.13? (abrz154.neoplus.adsl.tpnet.pl [83.8.119.154])
        by mx.google.com with ESMTPS id d6sm2458225fga.2.2009.04.25.02.04.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Apr 2009 02:04:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200904250010.46299.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117539>

On Sat, 25 April 2009, Jakub Narebski wrote:

> So it is not that simple...

That said, here is simple patch which should fix the bug you found.
It always creates sensible short and long values, contrary to your patch
(take a look at gitweb output after your patch, including tooltips on
mouseover).

But it is NOT TESTED if it works correctly, and if it covers all
occurrences.  And it might be not necessary in all its complication:
we could simply replace control characters by '?' like in
chop_and_escape_str subroutine (which would also make gitweb more
consistent).  It also lacks commit message.

Nevertheless it might be good bandaid for your problem:

-- >8 --
diff --git c/gitweb/gitweb.perl w/gitweb/gitweb.perl
index 3f99361..8575d5f 100755
--- c/gitweb/gitweb.perl
+++ w/gitweb/gitweb.perl
@@ -1035,6 +1035,24 @@ sub esc_url {
 	return $str;
 }
 
+# quote and escape tag attribute values; autoEscape has to be turned off
+sub esc_attr {
+	my $str = shift;
+	return $str unless defined $str;
+
+	my %ent = ( # named HTML entities
+		'"' => '&quot;',
+		'&' => '&amp;',
+		'<' => '&lt;',
+		'>' => '&gt;',
+	);
+	$str = to_utf8($str);
+	$str =~ s|([\"&<>])|$ent{$1}|eg;
+	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_upr($1) : $1)|eg;
+
+	return $str;
+}
+
 # replace invalid utf8 character with SUBSTITUTION sequence
 sub esc_html ($;%) {
 	my $str = shift;
@@ -1457,14 +1475,19 @@ sub format_subject_html {
 	my ($long, $short, $href, $extra) = @_;
 	$extra = '' unless defined($extra);
 
+	my $ret = '';
 	if (length($short) < length($long)) {
-		return $cgi->a({-href => $href, -class => "list subject",
-		                -title => to_utf8($long)},
+		my $autoescape = $cgi->autoEscape(undef);
+		# or just replace s/([[:cntrl:]])/?/g in -title
+		$ret = $cgi->a({-href => $href, -class => "list subject",
+		                -title => esc_attr($long)},
 		       esc_html($short) . $extra);
+		$cgi->autoEscape($autoescape); # restore original value
 	} else {
-		return $cgi->a({-href => $href, -class => "list subject"},
+		$ret = $cgi->a({-href => $href, -class => "list subject"},
 		       esc_html($long)  . $extra);
 	}
+	return $ret;
 }
 
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
