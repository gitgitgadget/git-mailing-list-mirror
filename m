From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Sanitize title attribute in format_subject_html
Date: Fri, 22 May 2009 17:35:46 +0200
Message-ID: <200905221735.48310.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 17:36:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Wmx-0006V3-4o
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 17:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251AbZEVPf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 11:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756969AbZEVPfz
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 11:35:55 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:60101 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbZEVPfy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 11:35:54 -0400
Received: by fxm2 with SMTP id 2so1733962fxm.37
        for <git@vger.kernel.org>; Fri, 22 May 2009 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=BVv/Xk0uxn52huFQQRELH0xl/yP+uLhEVNqAfJX8a1Q=;
        b=Zf0HyZjDrAGrDsc8sQ7Ht755NDjr22p3K+xygxOyiTqgntcICbv960WUxyWtyjKsdJ
         oQtkd3HY+Lj2hRfI3dkJFAmS/7ag7bgB+/msIVEv6+pPzLiKPUjvY2sYFhGimjkr0/JZ
         0D9Goh+fnSCr6Iql0w9tbhXJf/VQsjqXW1gSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=Ue9BdcXtTQZxoxdrJ74Di5GUMgprKL9t1H+m4Bcux5m7VboVloMRGQ9sHSRdiqf1oR
         KzXld4HGxhZfsCOcQpQNl3a8Yh8sbSkDoaouAvGJsExY1/g60d14ex1O5cdoJ3b0rpaC
         dERw2Gw80FfiEpZH2Rjy61Iwlcbwtl9WK8mjM=
Received: by 10.86.51.10 with SMTP id y10mr3219138fgy.51.1243006554389;
        Fri, 22 May 2009 08:35:54 -0700 (PDT)
Received: from ?192.168.1.13? (abwq183.neoplus.adsl.tpnet.pl [83.8.240.183])
        by mx.google.com with ESMTPS id 4sm5730423fgg.28.2009.05.22.08.35.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 May 2009 08:35:53 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119736>

Replace control characters with question mark '?' (like in
chop_and_esc_str).


A little background: some web browsers turn on strict (and
unforgiving) XML validating mode for XHTML documents served using
application/xhtml+xml content type.  This means among others that
control characters are forbidden to appear in gitweb output.

CGI.pm does by default slight escaping (using simple_escape subroutine
from CGI::Util) of all _attribute_ values (depending on the value of
autoEscape, by default on).  This escaping, at least in CGI.pm version
3.10 (most current version at CPAN is 3.43), is minimal: only '"',
'&', '<' and '>' are escaped using named HTML entity references
(&quot;, &amp;, &lt; and &gt; respectively).  But simple_escape does
not do escaping of control characters such as ^X which are invalid in
XHTML (in strict mode).

If by some accident commit message do contain some control character
in first 50 characters (more or less) of first line of commit message,
and this line is longer than 50 characters (so gitweb shortens it for
display), then gitweb would put this control character in title
attribute (and CGI.pm would not remove them).  The tag _contents_ is
safe because it is escaped using esc_html() explicitly, and it
replaces control characters by their printable representation.


While at it: chop_and_escape_str doesn't need capturing group.

Noticed-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This issue first appeared (with a wrong solution) month ago in
http://thread.gmane.org/gmane.comp.version-control.git/116755

I'm sorry Paul that it took so long to fix it.


This patch will be followed by 'lite' version, with minimal commit
message (this one is a bit long), and with failed attempt using
esc_attr.

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 05702e4..1e7e2d8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1236,7 +1236,7 @@ sub chop_and_escape_str {
 	if ($chopped eq $str) {
 		return esc_html($chopped);
 	} else {
-		$str =~ s/([[:cntrl:]])/?/g;
+		$str =~ s/[[:cntrl:]]/?/g;
 		return $cgi->span({-title=>$str}, esc_html($chopped));
 	}
 }
@@ -1459,6 +1459,7 @@ sub format_subject_html {
 	$extra = '' unless defined($extra);
 
 	if (length($short) < length($long)) {
+		$long =~ s/[[:cntrl:]]/?/g;
 		return $cgi->a({-href => $href, -class => "list subject",
 		                -title => to_utf8($long)},
 		       esc_html($short) . $extra);
-- 
1.6.3.1
