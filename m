From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Separate search regexp from search text
Date: Wed, 16 May 2007 01:56:10 +0200
Message-ID: <200705160156.10866.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 01:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho6sN-0007eA-On
	for gcvg-git@gmane.org; Wed, 16 May 2007 01:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462AbXEOX4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 19:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757694AbXEOX4O
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 19:56:14 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:51935 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462AbXEOX4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 19:56:13 -0400
Received: by py-out-1112.google.com with SMTP id a29so311821pyi
        for <git@vger.kernel.org>; Tue, 15 May 2007 16:56:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tez8w+T8en7PebV++rnRtAN24pT8MvAM4f3pFBAnAkHJwceg4hvjOiBKKyaNY+RHlzDvX/uSJv6olXijljv4rwHgRcgJlJQTgBzr7C6Jyj5wgL+hi0p5CTkt/zuTvWmP9UXjzdvhDyQ7fhC3wtpL+ExVW02l/4uYjLPwVrPsWh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=o50fCsZNhrbjlAkDtDX8EokCh9d37Si10dBacYg5XFeu6ReFfJveVPqbc8GFQPAAcQwfPJ+8tj7AhoEkPNqhiGx+Dk8RktgrLVFS9olHU5/VNKxXUw/GYnwyNZ52JPdDjm0UX8qMKI3Ee+8HZYLfTxj7li7Pukqo3Lx7qjuk538=
Received: by 10.65.84.5 with SMTP id m5mr1885896qbl.1179273372383;
        Tue, 15 May 2007 16:56:12 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e19sm1271702qbe.2007.05.15.16.56.10;
        Tue, 15 May 2007 16:56:11 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47393>

Separate search text, which is saved in $searchtext global variable,
and is used in links, as default value for the textfield in search
form, and for pickaxe search, from search regexp, which is saved in
$search_regexp global variable, and is used as parameter to --grep,
--committer or --author options to git-rev-list, and for searching
commit body in gitweb.  For now $search_regexp is unconditionallt
equal to quotemeta($searchtext), meaning that we always search for
fixed string.

This fixes bug where 'next page' links for 'search' view didn't work
for searchtext containing quotable characters, like `@'.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
There was similar patch; bit of bandaid (without commit message IIRC),
but I cannot find it to add Originally-by:/Suggested-by: acknowledgement
header, not Noticed-by: header...

 gitweb/gitweb.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a13043d..549e027 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -365,6 +365,7 @@ if (defined $page) {
 }
 
 our $searchtext = $cgi->param('s');
+our $search_regexp;
 if (defined $searchtext) {
 	if ($searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
 		die_error(undef, "Invalid search parameter");
@@ -372,7 +373,7 @@ if (defined $searchtext) {
 	if (length($searchtext) < 2) {
 		die_error(undef, "At least two characters are required for search parameter");
 	}
-	$searchtext = quotemeta $searchtext;
+	$search_regexp = quotemeta $searchtext;
 }
 
 our $searchtype = $cgi->param('st');
@@ -3244,7 +3245,7 @@ sub git_search_grep_body {
 			       esc_html(chop_str($co{'title'}, 50)) . "<br/>");
 		my $comment = $co{'comment'};
 		foreach my $line (@$comment) {
-			if ($line =~ m/^(.*)($searchtext)(.*)$/i) {
+			if ($line =~ m/^(.*)($search_regexp)(.*)$/i) {
 				my $lead = esc_html($1) || "";
 				$lead = chop_str($lead, 30, 10);
 				my $match = esc_html($2) || "";
@@ -4626,7 +4627,7 @@ sub git_search {
 		} elsif ($searchtype eq 'committer') {
 			$greptype = "--committer=";
 		}
-		$greptype .= $searchtext;
+		$greptype .= $search_regexp;
 		my @commitlist = parse_commits($hash, 101, (100 * $page), $greptype);
 
 		my $paging_nav = '';
-- 
1.5.1.4
