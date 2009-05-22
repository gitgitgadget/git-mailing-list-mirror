From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH (do not use)] gitweb: Introduce and use esc_attr to escape values of tag attributes
Date: Fri, 22 May 2009 17:55:39 +0200
Message-ID: <200905221755.40239.jnareb@gmail.com>
References: <200905221735.48310.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 17:56:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7X6P-0007rU-NB
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 17:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896AbZEVPzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 11:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755233AbZEVPzt
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 11:55:49 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:61086 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbZEVPzs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 11:55:48 -0400
Received: by bwz22 with SMTP id 22so1713691bwz.37
        for <git@vger.kernel.org>; Fri, 22 May 2009 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DRg9QErKHAHT8/ztYsFLy/Ui1hHGSgpaCSI+pqCdRWw=;
        b=AYVppBzdpTKJ7rC2WOKrBrhWh1OZmU4xDvkH4xkwYReql5zJS3hLsKr/4yJIrsESCl
         dJJEWwYamxEUxOw5+2xHFuYyjK6sHW+CS52S8V4R7PGuwBNhGhlWzSLuPCm5IywOjW77
         emzcHXK6lFLkS53kr/h1/i1iWIqY0irqWfgAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=MLKSxx2QSVUgcQ5snJSWjexK6J2Bo89SU1Mw2o7nyeCQjxr5kmZt3zwmnh8IDFPqIW
         mE7JS+rCUNi73XQo60Bb18rgoaS3R7RmstbHboq8DlgHbCMOyVBaCar6c9dT+9LWJhP+
         ZYxyLjIIeJTp/jV+HXvVWKKJb/otA376ObWr8=
Received: by 10.204.69.133 with SMTP id z5mr3715402bki.163.1243007747681;
        Fri, 22 May 2009 08:55:47 -0700 (PDT)
Received: from ?192.168.1.13? (abwq183.neoplus.adsl.tpnet.pl [83.8.240.183])
        by mx.google.com with ESMTPS id 28sm5839044fkx.28.2009.05.22.08.55.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 May 2009 08:55:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905221735.48310.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119738>

CGI.pm does by default slight escaping (simple_escape from CGI::Util)
of all _attribute_ values (depending on the value of autoEscape(), by
default on).

This escaping, at least in CGI.pm version 3.10 (most current version
at CPAN is 3.43), is minimal: only '"', '&', '<' and '>' are escaped
using named HTML entity references (&quot;, &amp;, &lt; and &gt;
respectively).  simple_escape does not do escaping of control
characters such as ^X which are invalid in XHTML (in strict mode).
Note that IIRC escaping '<' and '>' in attributes is not strictly
necessary.


New 'esc_attr' subroutine can be used to do more complete escaping of
attribute values, including dealing with control characters (forbidden
in XHTML in strict validating mode); currently it replaces all control
characters by '?' question mark.  For esc_attr() to work correctly you
have to turn off CGI.pm autoescaping to avoid double escaping.

While at it chop_and_esc_str now uses esc_attr instead of simply
replacing control characters with '?' by itself.


The problem is that when autoescaping is turned off we would have to
esc_attr all attributes containing user input (this includes result of
href() subroutine), or risk either double escaping, or not escaping
some fragment.


Alternate solution include:
* stripping of control characters before input is passed as attribute
  value, as it was done in chop_and_esc_str; this would include at
  minimum format_subject_html
* replacing either make_attributes from CGI.pm, or simple_escape
  subrotuine it uses, making it escape characters better


Noticed-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>

http://thread.gmane.org/gmane.comp.version-control.git/116755/focus=117539
---
This is abandoned version. Still... perhaps esc_attr would be of use
to somebody... Also as negative example in archives.

 gitweb/gitweb.perl |   39 +++++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 05702e4..e505f2f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1027,7 +1027,7 @@ sub esc_param {
 	return $str;
 }
 
-# quote unsafe chars in whole URL, so some charactrs cannot be quoted
+# quote unsafe chars in whole URL, so some characters cannot be quoted
 sub esc_url {
 	my $str = shift;
 	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&=])/sprintf("%%%02X", ord($1))/eg;
@@ -1036,6 +1036,26 @@ sub esc_url {
 	return $str;
 }
 
+# quote and escape tag attribute values; autoEscape has to be turned off
+# otherwise you would get double escaping for '&' ("escape" character)
+sub esc_attr {
+	my $str = shift;
+	return $str unless defined $str;
+
+	my %ent = ( # named HTML entities
+		'"' => '&quot;',
+		'&' => '&amp;',
+		# those are not strictly necessary
+		'<' => '&lt;',
+		'>' => '&gt;',
+	);
+	$str = to_utf8($str);
+	$str =~ s|([\"&<>])|$ent{$1}|eg;
+	$str =~ s|([[:cntrl:]])|?|eg; # alternative would be use quot_xxx($1)
+
+	return $str;
+}
+
 # replace invalid utf8 character with SUBSTITUTION sequence
 sub esc_html {
 	my $str = shift;
@@ -1236,8 +1256,10 @@ sub chop_and_escape_str {
 	if ($chopped eq $str) {
 		return esc_html($chopped);
 	} else {
-		$str =~ s/([[:cntrl:]])/?/g;
-		return $cgi->span({-title=>$str}, esc_html($chopped));
+		my $autoescape = $cgi->autoEscape(undef);
+		my $result = $cgi->span({-title=>esc_attr($str)}, esc_html($chopped));
+		$cgi->autoEscape($autoescape); # restore original value
+		return $result;
 	}
 }
 
@@ -1458,14 +1480,19 @@ sub format_subject_html {
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
-- 
1.6.3.1
