From: "Guillaume Seguin" <guillaume@segu.in>
Subject: [PATCH] gitweb : disambiguate heads and tags withs the same name
Date: Sun, 28 Oct 2007 14:12:53 +0100
Message-ID: <e877c31c0710280612l5d783ab0o50ce00c70b3311db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sun Oct 28 14:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im7xF-0004A1-5L
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 14:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbXJ1NMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 09:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbXJ1NMz
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 09:12:55 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:61872 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbXJ1NMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 09:12:54 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1285802rvb
        for <git@vger.kernel.org>; Sun, 28 Oct 2007 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=IBmSCsRcXCm5Pwsq0rbKGdrWPhnw8NUsUMvgEEMS9I4=;
        b=Z2KWzYggkyAEOMWov21P7GcfeMMNwu8wigs3ofSZpzjVwInzp+gOPzxhkdl1VVcw+ruzARtY2a5xbt0J1LWv1ooZjX/ih3O9NE3ZrZ5ErQ+wZ08WogsUBOuxRPgT8hWjabPukMy4Yw/FK/Eg/iwTEOuc1G8z9V/58YLKRm8vsWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=YgSToM23nirrrUFHiy47/M02nPzHDjmbsIsEW8+Xz4sdj44QzV4zErBRbGFnXky1Kttxsb3hDJKdxuuNYKnfktizup5WWTPcN+pAVByhOsdL4SinGU5mqOHJ7zzRhip2W3AxK1bj7A3XdRBVEbd6hUel+tP2KkY6FGhMixdw1us=
Received: by 10.142.126.17 with SMTP id y17mr1132670wfc.1193577173714;
        Sun, 28 Oct 2007 06:12:53 -0700 (PDT)
Received: by 10.143.30.21 with HTTP; Sun, 28 Oct 2007 06:12:53 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: c8e117e024f4ddad
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62560>

Avoid wrong disambiguation that would link logs/trees of tags and heads which
share the same name to the same page, leading to a disambiguation that would
prefer the tag, thus making it impossible to access the corresponding
head log and
tree without hacking the url by hand.

---
 gitweb/gitweb.perl |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 48e21da..f918c00 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3534,6 +3534,7 @@ sub git_tags_body {
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $taglist->[$i];
 		my %tag = %$entry;
+		my $name = "refs/tags/$tag{'name'}";
 		my $comment = $tag{'subject'};
 		my $comment_short;
 		if (defined $comment) {
@@ -3570,8 +3571,8 @@ sub git_tags_body {
 		      "<td class=\"link\">" . " | " .
 		      $cgi->a({-href => href(action=>$tag{'reftype'},
hash=>$tag{'refid'})}, $tag{'reftype'});
 		if ($tag{'reftype'} eq "commit") {
-			print " | " . $cgi->a({-href => href(action=>"shortlog",
hash=>$tag{'name'})}, "shortlog") .
-			      " | " . $cgi->a({-href => href(action=>"log",
hash=>$tag{'name'})}, "log");
+			print " | " . $cgi->a({-href => href(action=>"shortlog",
hash=>$name)}, "shortlog") .
+			      " | " . $cgi->a({-href => href(action=>"log", hash=>$name)}, "log");
 		} elsif ($tag{'reftype'} eq "blob") {
 			print " | " . $cgi->a({-href => href(action=>"blob_plain",
hash=>$tag{'refid'})}, "raw");
 		}
@@ -3597,6 +3598,7 @@ sub git_heads_body {
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $headlist->[$i];
 		my %ref = %$entry;
+		my $name = "refs/heads/$ref{'name'}";
 		my $curr = $ref{'id'} eq $head;
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
@@ -3606,13 +3608,13 @@ sub git_heads_body {
 		$alternate ^= 1;
 		print "<td><i>$ref{'age'}</i></td>\n" .
 		      ($curr ? "<td class=\"current_head\">" : "<td>") .
-		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'name'}),
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$name),
 		               -class => "list name"},esc_html($ref{'name'})) .
 		      "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"shortlog",
hash=>$ref{'name'})}, "shortlog") . " | " .
-		      $cgi->a({-href => href(action=>"log", hash=>$ref{'name'})},
"log") . " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'name'},
hash_base=>$ref{'name'})}, "tree") .
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$name)},
"shortlog") . " | " .
+		      $cgi->a({-href => href(action=>"log", hash=>$name)}, "log") . " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$name,
hash_base=>$name)}, "tree") .
 		      "</td>\n" .
 		      "</tr>";
 	}
-- 
1.5.3.4.395.g85b0
