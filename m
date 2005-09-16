From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use objects/info/alternates in rsync transport.
Date: Fri, 16 Sep 2005 00:42:43 -0700
Message-ID: <7vslw5qwzw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 16 09:44:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGArw-000431-3Q
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 09:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbVIPHmp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 03:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbVIPHmp
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 03:42:45 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:33725 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1161113AbVIPHmp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 03:42:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916074243.DOZU24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 03:42:43 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8669>

For local operations and downloading and uploading via git aware protocols,
use of $GIT_OBJECT_DIRECTORY/info/alternates is recommended on the server
side for big projects that are derived from another one (like Linux kernel).
However, dumb protocols and rsync transport needs to resolve this on the
client end, which we did not bother doing until this week.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Hopefully this will be in 0.99.7 to allow downloaders deal
   with kernel.org subsystem maintainer trees that borrow from
   the Linus tree.

 * I noticed that "rsync" used -z, but most of the stuff we ship
   are already compressed -- I wonder if this was done for a
   reason or just inertia from somebody's finger?

 git-fetch.sh        |   23 +++++++++++++++++++++--
 git-parse-remote.sh |   22 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

85dccff8f47f76a739f0263b0d03ab5b1b5bf127
diff --git a/git-fetch.sh b/git-fetch.sh
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -183,12 +183,31 @@ do
 	;;
     rsync://*)
 	TMP_HEAD="$GIT_DIR/TMP_HEAD"
-	rsync -L "$remote/$remote_name" "$TMP_HEAD" || exit 1
+	rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
 	head=$(git-rev-parse TMP_HEAD)
 	rm -f "$TMP_HEAD"
 	test "$rsync_slurped_objects" || {
-	    rsync -avz --ignore-existing "$remote/objects/" \
+	    rsync -a --ignore-existing --progress \
+		--exclude info "$remote/objects/" \
 		"$GIT_OBJECT_DIRECTORY/" || exit
+
+	    # Look at objects/info/alternates for rsync -- http will
+	    # support it natively and git native ones will do it on the remote
+	    # end.  Not having that file is not a crime.
+	    rsync -q "$remote/objects/info/alternates" "$GIT_DIR/TMP_ALT" ||
+		    rm -f "$GIT_DIR/TMP_ALT"
+	    if test -f "$GIT_DIR/TMP_ALT"
+	    then
+		resolve_alternates "$remote" <"$GIT_DIR/TMP_ALT" |
+		while read alt
+		do
+		    case "$alt" in 'bad alternate: '*) die "$alt";; esac
+		    rsync -a --ignore-existing \
+			--exclude info "$alt" \
+			"$GIT_OBJECT_DIRECTORY/" || exit
+		done
+		rm -f "$GIT_DIR/TMP_ALT"
+	    fi
 	    rsync_slurped_objects=t
 	}
 	;;
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -153,3 +153,25 @@ get_remote_refs_for_fetch () {
 	    ;;
 	esac
 }
+
+resolve_alternates () {
+	# original URL (xxx.git)
+	top_=`expr "$1" : '\([^:]*:/*[^/]*\)/'`
+	while read path
+	do
+		case "$path" in
+		#* | '')
+			continue ;;
+		/*)
+			echo "$top_$path/" ;;
+		../*)
+			# relative -- ugly but seems to work.
+			echo "$1/objects/$path/" ;;
+			;;
+		*)
+			# exit code may not be caught by the reader.
+			echo "bad alternate: $path"
+			exit 1 ;;
+		esac
+	done
+}
