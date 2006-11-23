X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] git-fetch: fix dumb protocol transport to fetch from pack-pruned ref
Date: Wed, 22 Nov 2006 23:24:05 -0800
Message-ID: <7v64d6lj6y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 07:24:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32117>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn8wV-0002LW-6y for gcvg-git@gmane.org; Thu, 23 Nov
 2006 08:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932934AbWKWHYI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 02:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWKWHYI
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 02:24:08 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48848 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1757286AbWKWHYG
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 02:24:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061123072405.YHYU7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 02:24:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id q7QD1V0061kojtg0000000; Thu, 23 Nov 2006
 02:24:13 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Earlier, commit walkers downloaded loose refs from refs/ hierarchy
of the remote side to find where to start walking; this would
not work for a repository whose refs are packed and then pruned.

With the previous change, we have ls-remote output from the
remote in-core; we can use the value from there without
requiring loose refs anymore.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-fetch.sh |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 170c2cb..06b66b9 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -307,22 +307,20 @@ fetch_main () {
 		"`git-repo-config --bool http.noEPSV`" = true ]; then
 	      noepsv_opt="--disable-epsv"
 	  fi
-	  max_depth=5
-	  depth=0
-	  head="ref: $remote_name"
-	  while (expr "z$head" : "zref:" && expr $depth \< $max_depth) >/dev/null
-	  do
-	    remote_name_quoted=$(@@PERL@@ -e '
-	      my $u = $ARGV[0];
-              $u =~ s/^ref:\s*//;
-	      $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
-	      print "$u";
-	  ' "$head")
-	    head=$(curl -nsfL $curl_extra_args $noepsv_opt "$remote/$remote_name_quoted")
-	    depth=$( expr \( $depth + 1 \) )
-	  done
+
+	  # Find $remote_name from ls-remote output.
+	  head=$(
+		IFS='	'
+		echo "$ls_remote_result" |
+		while read sha1 name
+		do
+			test "z$name" = "z$remote_name" || continue
+			echo "$sha1"
+			break
+		done
+	  )
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
-	      die "Failed to fetch $remote_name from $remote"
+		die "No such ref $remote_name at $remote"
 	  echo >&2 "Fetching $remote_name from $remote using $proto"
 	  git-http-fetch -v -a "$head" "$remote/" || exit
 	  ;;
-- 
1.4.4.1.g77614

