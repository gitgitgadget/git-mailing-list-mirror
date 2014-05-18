From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/4] git-ack: record an ack
Date: Mon, 19 May 2014 00:17:54 +0300
Message-ID: <1400447743-18513-5-git-send-email-mst@redhat.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 23:19:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm8UC-0006OI-UI
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 23:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbaERVTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 17:19:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50997 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195AbaERVTA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 17:19:00 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4ILJ0JY017220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 18 May 2014 17:19:00 -0400
Received: from redhat.com (ovpn-116-32.ams2.redhat.com [10.36.116.32])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s4ILIwRJ008697
	for <git@vger.kernel.org>; Sun, 18 May 2014 17:18:59 -0400
Content-Disposition: inline
In-Reply-To: <1400447743-18513-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249514>

This is a simple script that I use by piping
incoming mail with an ack to it.
It produces an empty ack commit suitable for
squshing with git rebase -i -autosquash.

Works best if people ack individual commits: you simply
pipe each ack to git ack, before pushing your branch,
rebase.

Some people ack series by responding to cover letter
or to commit 1.
To address this usecase, there are two additional
flags: -s saves the ack signature in a file (you can
save several in a row), -r creates an ack for
a given patch using the saved signature.
Thus: pipe ack(s) to git ack -s, then select and pipe
each individual patch to git ack -r.
I don't use these flags much so they likely work
less well.

If it's found useful, this script can either
become a first-class command (with documentation
and tests) or be integrated as a flag into git am.

Limitations: requires that index is clean, this is
so we can create an empty commit recording the ack.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/git-ack | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 contrib/git-ack

diff --git a/contrib/git-ack b/contrib/git-ack
new file mode 100755
index 0000000..4aeb16a
--- /dev/null
+++ b/contrib/git-ack
@@ -0,0 +1,84 @@
+msg=`mktemp`
+patch=`mktemp`
+info=`git mailinfo $msg $patch`
+subj=`echo "$info"|sed -n 's/^Subject: //p'`
+author=`echo "$info"|sed -n 's/^Author: //p'`
+email=`echo "$info"|sed -n 's/^Email: //p'`
+auth="$author <$email>"
+date=`echo "$info"|sed -n 's/^Date: //p'`
+sign=`mktemp`
+echo "ack! $subj" > $sign
+echo "" >> $sign
+if
+    git diff --cached HEAD
+then
+    nop < /dev/null
+else
+    echo "DIFF in cache. Not acked, reset or commit!"
+    exit 1
+fi
+GIT_DIR=`pwd`/${GIT_DIR}
+
+usage () {
+	echo "Usage: git ack " \
+            "[-s|--save|-a|--append|-r|--restore |-c|--clear]\n" >& 2;
+        exit 1;
+}
+
+append=
+save=
+clear=
+
+while test $# != 0
+do
+	case "$1" in
+	-a|--append)
+		append="y"
+		;;
+	-s|--s)
+		save="y"
+		;;
+	-r|--restore)
+		restore="y"
+		;;
+	-c|--clear)
+		clear="y"
+                ;;
+	*)
+		usage ;;
+	esac
+	shift
+done
+
+if
+    test "$clear"
+then
+    rm -f "${GIT_DIR}/ACKS"
+fi
+
+if
+    test "$save"
+then
+    if
+        test "$append"
+    then
+        cat $msg >> "${GIT_DIR}/ACKS"
+    else
+        cat $msg > "${GIT_DIR}/ACKS"
+    fi
+fi
+
+if
+    test "$restore"
+then
+    msg = ${GIT_DIR}/ACKS
+fi
+
+if
+    grep '^[A-Z][A-Za-z-]*-by:' $msg >> $sign
+then
+    git commit --allow-empty -F $sign --author="$auth" --date="$date"
+else
+    echo "No signature found!"
+    exit 2
+fi
-- 
MST
