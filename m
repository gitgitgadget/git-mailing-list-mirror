From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] git-fetch: resolve remote symrefs for HTTP transport
Date: Wed, 26 Apr 2006 09:10:01 -0700
Message-ID: <20060426161001.GH32744@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 26 18:10:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYmaw-0006Wj-Li
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 18:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWDZQKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 12:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWDZQKF
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 12:10:05 -0400
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:27486 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932468AbWDZQKC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 12:10:02 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k3QGA2FR014827
	for <git@vger.kernel.org>; Wed, 26 Apr 2006 09:10:02 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k3QGA1x5014824
	for git@vger.kernel.org; Wed, 26 Apr 2006 09:10:01 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19211>

git-fetch validates that a remote ref resolves to a SHA1 prior to calling
git-http-fetch.  This adds support for resolving a few levels of symrefs
to get to the SHA1.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

Maybe this isn't the right way to handle this - since we're already
calling perl we could use LWP to do the transfers (using keepalive
even?) or we could let git-http-fetch take care of it and deal with
remote names that don't resolve.  It may also make sense to modify
git-http-fetch so it can fetch more than one head at a time.

 git-fetch.sh |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

aa50f9012834993d8bd080050bc13b23465f9185
diff --git a/git-fetch.sh b/git-fetch.sh
index 83143f8..280f62e 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -270,14 +270,22 @@ fetch_main () {
 	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 	      curl_extra_args="-k"
 	  fi
-	  remote_name_quoted=$(perl -e '
+	  max_depth=5
+	  depth=0
+	  head="ref: $remote_name"
+	  while (expr "z$head" : "zref:" && expr $depth \< $max_depth) >/dev/null
+	  do
+	    remote_name_quoted=$(perl -e '
 	      my $u = $ARGV[0];
+              $u =~ s/^ref:\s*//;
 	      $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
 	      print "$u";
-	  ' "$remote_name")
-	  head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted") &&
+	  ' "$head")
+	    head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted")
+	    depth=$( expr \( $depth + 1 \) )
+	  done
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
-		  die "Failed to fetch $remote_name from $remote"
+	      die "Failed to fetch $remote_name from $remote"
 	  echo >&2 Fetching "$remote_name from $remote" using http
 	  git-http-fetch -v -a "$head" "$remote/" || exit
 	  ;;
-- 
1.3.0.g368f0-dirty
