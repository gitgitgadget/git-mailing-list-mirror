From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-pull: warn if only fetching tags with the -t switch
Date: Thu, 27 Dec 2007 14:46:18 +0000
Message-ID: <20071227144618.32373.qmail@5b51609f839e87.315fe32.mid.smarden.org>
References: <20071221124400.20725.qmail@db93e79e204cd8.315fe32.mid.smarden.org> <7v8x3oatvi.fsf@gitster.siamese.dyndns.org> <20071227093016.18337.qmail@e6d9fb481b7087.315fe32.mid.smarden.org> <7vwsr0ifqi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 15:46:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7u0Q-0001kx-Ix
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 15:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbXL0OqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 09:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbXL0OqE
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 09:46:04 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:51152 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751858AbXL0OqC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 09:46:02 -0500
Received: (qmail 32374 invoked by uid 1000); 27 Dec 2007 14:46:18 -0000
Content-Disposition: inline
In-Reply-To: <7vwsr0ifqi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69262>

Subject: [PATCH] git-pull: warn if only fetching tags with the -t switch

git-pull -t|--tags isn't supposed to be run, remove that option from
fetch-options.txt, and explicitely add it to git-fetch.txt.  Have git pull
still fetch tags with the -t switch, but warn afterwards to better use
git fetch --tags, and error out.
---

How about this?

 Documentation/fetch-options.txt |    8 --------
 Documentation/git-fetch.txt     |    8 ++++++++
 git-pull.sh                     |    9 +++++++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index da03422..debdc87 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -29,14 +29,6 @@
 	and stores them locally.  This option disables this
 	automatic tag following.
 
--t, \--tags::
-	Most of the tags are fetched automatically as branch
-	heads are downloaded, but tags that do not point at
-	objects reachable from the branch heads that are being
-	tracked will not be fetched by this mechanism.  This
-	flag lets all tags and their associated objects be
-	downloaded.
-
 -k, \--keep::
 	Keep downloaded pack.
 
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 9003473..3cdac7f 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -33,6 +33,14 @@ OPTIONS
 -------
 include::fetch-options.txt[]
 
+-t, \--tags::
+        Most of the tags are fetched automatically as branch
+        heads are downloaded, but tags that do not point at
+        objects reachable from the branch heads that are being
+        tracked will not be fetched by this mechanism.  This
+        flag lets all tags and their associated objects be
+        downloaded.
+
 include::pull-fetch-param.txt[]
 
 include::urls-remotes.txt[]
diff --git a/git-pull.sh b/git-pull.sh
index 698e82b..ab15eda 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -112,6 +112,15 @@ case "$merge_head" in
 	     exit 1;;
 	  *) exit $?;;
 	esac
+	# warn if only tags have been fetched
+	not_for_merge=$(sed -e '/	not-for-merge	tag/d' \
+			"$GIT_DIR"/FETCH_HEAD)
+	if test "$not_for_merge" = ''; then
+		echo >&2 "Fetching tags only, you probably meant:"
+		echo >&2 "  git fetch --tags"
+		exit 1;
+	fi
+
 	curr_branch=${curr_branch#refs/heads/}
 
 	echo >&2 "You asked me to pull without telling me which branch you"
-- 
1.5.3.7
