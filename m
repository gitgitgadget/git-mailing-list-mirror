From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Let git-clone/git-fetch follow HTTP redirections
Date: Thu, 10 Nov 2005 14:12:19 +0100
Message-ID: <200511101412.20069.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 14:14:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaCE7-0006DR-27
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 14:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVKJNMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 08:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVKJNMW
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 08:12:22 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:56307 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750822AbVKJNMW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 08:12:22 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 00E52283D;
	Thu, 10 Nov 2005 14:12:21 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11483>

Let git-clone/git-fetch follow HTTP redirections

Otherwise, git-clone silently failed to clone a remote
repository where redirections (ie. a response with a
"Location" header line) are used.

This includes the fixes from Nick Hengeveld.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

 git-clone.sh |    2 +-
 git-fetch.sh |    2 +-
 http-fetch.c |    2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

applies-to: f4d9606c4e4ca69203ea9211547083009b34196e
f6bf6aee48c028a4166d4c5d54c8e3c136721e3c
diff --git a/git-clone.sh b/git-clone.sh
index 4fdd652..aafcc18 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -23,7 +23,7 @@ fi
 
 http_fetch () {
 	# $1 = Remote, $2 = Local
-	curl -nsf $curl_extra_args "$1" >"$2"
+	curl -nsfL $curl_extra_args "$1" >"$2"
 }
 
 clone_dumb_http () {
diff --git a/git-fetch.sh b/git-fetch.sh
index 31e5f4c..8564cbf 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -230,7 +230,7 @@ do
 	    $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
 	    print "$u";
 	' "$remote_name")
-	head=$(curl -nsf $curl_extra_args "$remote/$remote_name_quoted") &&
+	head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted") &&
 	expr "$head" : "$_x40\$" >/dev/null ||
 		die "Failed to fetch $remote_name from $remote"
 	echo >&2 Fetching "$remote_name from $remote" using http
diff --git a/http-fetch.c b/http-fetch.c
index ea8af1b..28d225c 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -269,6 +269,8 @@ static CURL* get_curl_handle(void)
 				 curl_low_speed_time);
 	}
 
+	curl_easy_setopt(result, CURLOPT_FOLLOWLOCATION, 1);
+
 	return result;
 }
 
---
0.99.9.GIT
