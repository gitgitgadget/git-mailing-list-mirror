From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Add local time and timezone to git_print_authorship
Date: Mon, 28 Aug 2006 17:16:36 -0700
Message-ID: <7vveocpfa3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0608281016380.27779@g5.osdl.org>
	<11567998513000-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 02:16:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHrH7-0005bh-Mc
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 02:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWH2AP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 20:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWH2AP7
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 20:15:59 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:53228 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964929AbWH2AP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 20:15:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060829001555.SOVX29796.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Mon, 28 Aug 2006 20:15:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id FcFs1V00m4Noztg0000000
	Mon, 28 Aug 2006 20:15:53 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <11567998513000-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Mon, 28 Aug 2006 23:17:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26187>

Jakub Narebski <jnareb@gmail.com> writes:

> Add local time (hours and minutes) and local timezone to the output of
> git_print_authorship command, used by git_commitdiff.

Looks nice, thanks.

Now I got envious seeing people are having SO MUCH FUN with
gitweb, so here is mine...

Likes, dislikes, "your color selection sucks ;-)",... ?

-- >8 --
gitweb: show age and author in blame output

This does two things.

 - The commit object name link on each link uses "title", which
   shows the author and age of the particular line when hovered
   over.

 - The background of these links are painted on darker color as
   they become older and the links on younger lines are shown on
   lighter background.

---
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index eb9fc38..008ee70 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -215,6 +215,12 @@ td.sha1 {
 	font-family: monospace;
 }
 
+td.age-week   { color: #00f; background-color: #fff; }
+td.age-month  { color: #00f; background-color: #eef; }
+td.age-season { color: #00f; background-color: #ddf; }
+td.age-year   { color: #00f; background-color: #ccf; }
+td.age-old    { color: #00f; background-color: #bbf; }
+
 td.error {
 	color: red;
 	background-color: yellow;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9324d71..7dbd40f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2190,7 +2190,7 @@ sub git_blame2 {
 	if ($ftype !~ "blob") {
 		die_error("400 Bad Request", "Object is not a blob");
 	}
-	open ($fd, "-|", git_cmd(), "blame", '-l', $file_name, $hash_base)
+	open ($fd, "-|", git_cmd(), "blame", '-l', '-t', $file_name, $hash_base)
 		or die_error(undef, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
@@ -2211,12 +2211,21 @@ sub git_blame2 {
 <table class="blame">
 <tr><th>Commit</th><th>Line</th><th>Data</th></tr>
 HTML
+	my $now = time();
 	while (<$fd>) {
-		/^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
-		my $full_rev = $1;
+		my ($full_rev, $author, $timestamp, $zone, $lineno, $data) =
+		    /^([0-9a-fA-F]{40})\s\((.*?)\s+(\d+)\s
+		    ([-+\d]{5})\s+(\d+)\)\s{1}(\s*.*)/x;
 		my $rev = substr($full_rev, 0, 8);
-		my $lineno = $2;
-		my $data = $3;
+
+		my $age = $now - $timestamp;
+		my $ago = age_string($age);
+		my $pop = "$author, $ago";
+		my $agegroup =
+		    (($age < 60*60*24*7) ? "age-week" :
+		     ($age < 60*60*24*30) ? "age-month" :
+		     ($age < 60*60*24*120) ? "age-season" :
+		     ($age < 60*60*24*360) ? "age-year" : "age-old");
 
 		if (!defined $last_rev) {
 			$last_rev = $full_rev;
@@ -2225,7 +2234,8 @@ HTML
 			$current_color = ++$current_color % $num_colors;
 		}
 		print "<tr class=\"$rev_color[$current_color]\">\n";
-		print "<td class=\"sha1\">" .
+		print "<td class=\"sha1 $agegroup\" title=\"" .
+			esc_html($pop) ."\">" .
 			$cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
 			        esc_html($rev)) . "</td>\n";
 		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
