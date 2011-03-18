From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH v3 1/3] gitweb: fix #patchNN anchors when path_info is enabled
Date: Fri, 18 Mar 2011 13:59:44 +0100
Message-ID: <201103181359.46600.jnareb@gmail.com>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 14:00:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0ZHn-00058m-Ui
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 14:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756327Ab1CRNAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 09:00:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37488 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357Ab1CRNAF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 09:00:05 -0400
Received: by bwz15 with SMTP id 15so3311658bwz.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=U9tdwcdrKxRprpsB/HsuDfNZ8WxSYNly8a7NlKajdtA=;
        b=lK01mch5BeNiv8K5l9TayF0NC1QPNfQRsnmSM1ocI/C/x6FdONG6oksGN/nDFe4Xzf
         JSRrlHCDrfj4n+gmXnIKXU/5Pzbt+wpDIvdwryzGT72GjYW1wfsbcUTFcMXG3tjWz126
         aY4jP2P+bfzqnU0gD3SkpkI2jecvEt+YGlSMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=whu18GWZuQG4Np9sSQkjVYY18m/ijYlE5Z8PMIcm2/esw5GF0rFnyxyHGM5yT2PdpY
         HCHLFV+eY9BA3JgFDqOb8rNzmRYsLQrNAM2yRSQfdBzxqnvJdiG7l851TgrU1Itz/4iA
         C9krLqILnkENCpdbLl2Q+VwgCKiHQfUgliEb8=
Received: by 10.204.81.203 with SMTP id y11mr943521bkk.124.1300453202940;
        Fri, 18 Mar 2011 06:00:02 -0700 (PDT)
Received: from [192.168.1.13] (abuz4.neoplus.adsl.tpnet.pl [83.8.197.4])
        by mx.google.com with ESMTPS id t1sm2127418bkx.7.2011.03.18.05.59.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 06:00:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <c8621826e0576e3e31240b0205e7e3d0@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169314>

From: Kevin Cernekee <cernekee@gmail.com>

When $feature{'pathinfo'} is used, gitweb script sets the base URL to
itself, so that relative links to static files work correctly.  It
does it by adding something like below to HTML head:

  <base href="http://HOST/gitweb.cgi">

This breaks the "patch" anchor links seen on the commitdiff pages,
because these links, being relative (<a href="#patch1">), are resolved
(computed) relative to the base URL and not relative to current URL,
i.e. as:

  http://HOST/gitweb.cgi#patch1

Instead, they should look like this:

  http://HOST/gitweb.cgi/myproject.git/commitdiff/35a9811ef9d68eae9afd76bede121da4f89b448c#patch1

Add an "-anchor" parameter to href(), and use href(-anchor=>"patch1")
to generate "patch" anchor links, so that the full path is included in
the patch link.


While at it, convert

  print "foo";
  print "bar";

to

  print "foo" .
        "bar";

in the neighborhood of changes.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I like v2 version, and had only small corrections.  For you to not have
to resend this patch once again, I have added those corrections and sent
them as a patch myself.

Changes from original v2 version from Kevin Cernekee:

* Fix (re-add) accidentally lost in v2 '"<td class=\"link\">"' in first
  chunk using href(-anchor => ...)

* Reword commit message (hopefully make it better, and not only longer)

* Move code that sets implicit -replay when -anchor is the only parameter
  lower, and change order of subexpression, for better possible future
  extendability, if there would be other cases when we would want to 
  automatically turn on -replay.

* Change indenting of code (whitespace-only change).

* Add 'while at it' fixup.

 gitweb/gitweb.perl |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b04ab8c..3960d34 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1199,6 +1199,7 @@ if (defined caller) {
 # -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
 # -replay => 1      - start from a current view (replay with modifications)
 # -path_info => 0|1 - don't use/use path_info URL (if possible)
+# -anchor => ANCHOR - add #ANCHOR to end of URL, implies -replay if used alone
 sub href {
 	my %params = @_;
 	# default is to use -absolute url() i.e. $my_uri
@@ -1206,6 +1207,9 @@ sub href {
 
 	$params{'project'} = $project unless exists $params{'project'};
 
+	# implicit -replay
+	$params{-replay} = 1 if (keys %params == 1 && $params{-anchor});
+
 	if ($params{-replay}) {
 		while (my ($name, $symbol) = each %cgi_param_mapping) {
 			if (!exists $params{$name}) {
@@ -1314,6 +1318,10 @@ sub href {
 	# final transformation: trailing spaces must be escaped (URI-encoded)
 	$href =~ s/(\s+)$/CGI::escape($1)/e;
 
+	if ($params{-anchor}) {
+		$href .= "#".esc_param($params{-anchor});
+	}
+
 	return $href;
 }
 
@@ -4335,7 +4343,8 @@ sub git_difftree_body {
 				# link to patch
 				$patchno++;
 				print "<td class=\"link\">" .
-				      $cgi->a({-href => "#patch$patchno"}, "patch") .
+				      $cgi->a({-href => href(-anchor=>"patch$patchno")},
+				              "patch") .
 				      " | " .
 				      "</td>\n";
 			}
@@ -4432,8 +4441,9 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch");
-				print " | ";
+				print $cgi->a({-href => href(-anchor=>"patch$patchno")},
+				              "patch") .
+				      " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff->{'file'})},
@@ -4452,8 +4462,9 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch");
-				print " | ";
+				print $cgi->a({-href => href(-anchor=>"patch$patchno")},
+				              "patch") .
+				      " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'from_id'},
 			                             hash_base=>$parent, file_name=>$diff->{'file'})},
@@ -4494,7 +4505,8 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch") .
+				print $cgi->a({-href => href(-anchor=>"patch$patchno")},
+				              "patch") .
 				      " | ";
 			} elsif ($diff->{'to_id'} ne $diff->{'from_id'}) {
 				# "commit" view and modified file (not onlu mode changed)
@@ -4539,7 +4551,8 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch") .
+				print $cgi->a({-href => href(-anchor=>"patch$patchno")},
+				              "patch") .
 				      " | ";
 			} elsif ($diff->{'to_id'} ne $diff->{'from_id'}) {
 				# "commit" view and modified file (not only pure rename or copy)
-- 
1.7.3
