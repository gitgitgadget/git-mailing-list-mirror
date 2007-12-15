From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: disambiguate heads and tags withs the same name
Date: Sat, 15 Dec 2007 15:40:28 +0100
Message-ID: <200712151540.29187.jnareb@gmail.com>
References: <200712151534.50951.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <gitster@pobox.com>,
	Guillaume Seguin <guillaume@segu.in>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 15:42:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3YDs-0004XE-T5
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 15:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333AbXLOOmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 09:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757323AbXLOOmP
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 09:42:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:18419 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbXLOOmI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 09:42:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1336403ugc.16
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 06:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=jbkIuwK0xFEqgjkHp4loO7tIKEwNk6jfDJsaGHP6Ia4=;
        b=Pq0n6nQMClly7gnBe6QJz1089/EvCwwGLA8MCP+T+dEYUmF5BsgSuiAwteJmZwFQd2gN/fWtXmKJfolw77gSZE+M4tF9iLhxwK/BCgJbm5hPOxYx06QRQLGglgSbfEt4GRZrFkQ64b045QL41TRwKdrqk/z8adaQLaxTsxirIic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LPV5EDh39OhgKnzk4ZNDCQovti2w9htnOeXSRHXtFRoGGX6ylq9bs9WwOr+VF77gxZ8B6kq5Pw9JBcodD/wQyzP5McFs8j8Rc6wWPhw6l5M6ZnZ9FENBddgUDkshz6z/oz5suFBkRjp4Qxii6Fep3VQzoWjmePrYBiK5VYkniI4=
Received: by 10.66.251.20 with SMTP id y20mr1299292ugh.69.1197729726748;
        Sat, 15 Dec 2007 06:42:06 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.240.142])
        by mx.google.com with ESMTPS id b17sm14288867fka.2007.12.15.06.42.04
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Dec 2007 06:42:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200712151534.50951.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68387>

Avoid wrong disambiguation that would link logs/trees of tags and
heads which share the same name to the same page, leading to
a disambiguation that would prefer the tag, thus making it impossible
to access the corresponding head log and tree without hacking the url
by hand.

It does it by using full refname (with 'refs/heads/' or 'refs/tags/'
prefix) instead of shortened one in the URLs in 'heads' and 'tags'
tables.  This makes URLs (and refs) provided by gitweb unambiguous.

Signed-off-by: Guillaume Seguin <guillaume@segu.in>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Based on the patch by Guillaume Seguin, which solved the same problem
in slightly different way, by re-adding 'refs/heads/' or 'refs/tags/'.
I think this way is slightly better.

Note that there is companion RFC patch (which is not a part of this
mini-series) which added check if the refname is ambiguous in git_tag:
  "gitweb: Try harder in parse_tag; perhaps it was given ambiguous name"

 gitweb/gitweb.perl |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a746a85..448dca7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2233,6 +2233,7 @@ sub git_get_heads_list {
 		my ($hash, $name, $title) = split(' ', $refinfo, 3);
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
+		$ref_item{'fullname'}  = $name;
 		$name =~ s!^refs/heads/!!;
 
 		$ref_item{'name'}  = $name;
@@ -2270,6 +2271,7 @@ sub git_get_tags_list {
 		my ($id, $type, $name, $refid, $reftype, $title) = split(' ', $refinfo, 6);
 		my ($creator, $epoch, $tz) =
 			($creatorinfo =~ /^(.*) ([0-9]+) (.*)$/);
+		$ref_item{'fullname'} = $name;
 		$name =~ s!^refs/tags/!!;
 
 		$ref_item{'type'} = $type;
@@ -3690,8 +3692,8 @@ sub git_tags_body {
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
@@ -3726,13 +3728,13 @@ sub git_heads_body {
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
1.5.3.7
