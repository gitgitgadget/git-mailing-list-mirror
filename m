From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: disambiguate heads and tags withs the same name
Date: Sat, 1 Dec 2007 02:45:27 +0100
Message-ID: <200712010245.29204.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Guillaume Seguin <guillaume@segu.in>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 02:48:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyHT6-0002EZ-DC
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 02:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759319AbXLABrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 20:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759529AbXLABrq
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 20:47:46 -0500
Received: from mu-out-0910.google.com ([209.85.134.189]:3106 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085AbXLABro (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 20:47:44 -0500
Received: by mu-out-0910.google.com with SMTP id i10so385177mue
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 17:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=LfxRh0BN0HGTLphXcNTSgWV9mtVfYbXSAk4ZFcK3pZw=;
        b=X8ZJzywZv2bgO9kfRoJG+qOhqYqbhy0diUQJevfnIuR6UZWEXis3N26/kLHWVtJPI/rl0ZcQkl5ji+ZVG17gdFRGWYuoRAXO1curwh1d6/ujxG1Zm+2E8GMyVBgAJggvUWJayIfSeeJ+iD161H58tJhL1BwppGE1P7rDhyHSVVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LzfSeLpeD+ZWuHv8D/fp0sHUew+E+mzfEa5pgsG9JirscRl50yWX8yS+NSs92GPK4ytqfCgkrJCPWquQv70e7m6JJ1DqJ/ablQVGZC1nYNyd94j4Y+pvIKwFUlvyniTS6bpB4TMi1hyRF936EP5EKbVqauN0Of1pm3nKFDbN4FI=
Received: by 10.86.100.7 with SMTP id x7mr7832725fgb.1196473662356;
        Fri, 30 Nov 2007 17:47:42 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.252.40])
        by mx.google.com with ESMTPS id b17sm393284fka.2007.11.30.17.47.40
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Nov 2007 17:47:41 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66672>

Avoid wrong disambiguation that would link logs/trees of tags and heads which
share the same name to the same page, leading to a disambiguation that would
prefer the tag, thus making it impossible to access the corresponding
head log and tree without hacking the url by hand.

It does it by using full refname (with 'refs/heads/' or 'refs/tags/' prefix)
instead of shortened one in the URLs in 'heads' and 'tags' tables.

Signed-off-by: Guillaume Seguin <guillaume@segu.in>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This does exactly the same as patch send by Guillaume Seguin earlier
  Message-ID: <1194126032.15420.4.camel@ed3n-m>
  http://permalink.gmane.org/gmane.comp.version-control.git/63317

Original patch added 'refs/heads/' and 'refs/tags/' in git_heads_body
and git_tags_body respectively; this one uses 'fullname' field, which
contain refname before stripping 'refs/heads/' or 'refs/tags/'. The
change is in git_get_heads_list and git_get_tags_list, respectively.

Original patch was either badly whitespace damaged, or GMane has
broken 'raw' display.

Note that this patch does not help handcrafted URLs, and saved URLs from
older version of gitweb.

 gitweb/gitweb.perl |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 491a3f4..6ff4221 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2234,6 +2234,7 @@ sub git_get_heads_list {
 		my ($hash, $name, $title) = split(' ', $refinfo, 3);
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
+		$ref_item{'fullname'}  = $name;
 		$name =~ s!^refs/heads/!!;
 
 		$ref_item{'name'}  = $name;
@@ -2271,6 +2272,7 @@ sub git_get_tags_list {
 		my ($id, $type, $name, $refid, $reftype, $title) = split(' ', $refinfo, 6);
 		my ($creator, $epoch, $tz) =
 			($creatorinfo =~ /^(.*) ([0-9]+) (.*)$/);
+		$ref_item{'fullname'} = $name;
 		$name =~ s!^refs/tags/!!;
 
 		$ref_item{'type'} = $type;
@@ -3691,8 +3693,8 @@ sub git_tags_body {
 		      "<td class=\"link\">" . " | " .
 		      $cgi->a({-href => href(action=>$tag{'reftype'}, hash=>$tag{'refid'})}, $tag{'reftype'});
 		if ($tag{'reftype'} eq "commit") {
-			print " | " . $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'})}, "shortlog") .
-			      " | " . $cgi->a({-href => href(action=>"log", hash=>$tag{'name'})}, "log");
+			print " | " . $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'fullname'})}, "shortlog") .
+			      " | " . $cgi->a({-href => href(action=>"log", hash=>$tag{'fullname'})}, "log");
 		} elsif ($tag{'reftype'} eq "blob") {
 			print " | " . $cgi->a({-href => href(action=>"blob_plain", hash=>$tag{'refid'})}, "raw");
 		}
@@ -3727,13 +3729,13 @@ sub git_heads_body {
 		$alternate ^= 1;
 		print "<td><i>$ref{'age'}</i></td>\n" .
 		      ($curr ? "<td class=\"current_head\">" : "<td>") .
-		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'name'}),
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'}),
 		               -class => "list name"},esc_html($ref{'name'})) .
 		      "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'name'})}, "shortlog") . " | " .
-		      $cgi->a({-href => href(action=>"log", hash=>$ref{'name'})}, "log") . " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'name'}, hash_base=>$ref{'name'})}, "tree") .
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'})}, "shortlog") . " | " .
+		      $cgi->a({-href => href(action=>"log", hash=>$ref{'fullname'})}, "log") . " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'name'})}, "tree") .
 		      "</td>\n" .
 		      "</tr>";
 	}
-- 
1.5.3.6
