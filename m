From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Reintegrate script
Date: Mon, 26 Jan 2009 01:03:16 -0800
Message-ID: <7vd4ea8mnf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 10:06:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRNQ6-0005nW-H5
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 10:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbZAZJD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 04:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbZAZJDZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 04:03:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbZAZJDY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 04:03:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A7EA934EF;
	Mon, 26 Jan 2009 04:03:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 48E86934ED; Mon,
 26 Jan 2009 04:03:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E204A0A-EB88-11DD-9A3D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107178>

In a workflow that uses topic branches heavily, you would need to keep
updating test integration branch(es) all the time.  If they are managed
like my 'next' by merging the tips of topics that have grown since the
last integration, it is not so difficult.  You only need to review output
from "git branch --no-merged next" to see if there are topics that can and
needs to be merged to 'next'.

But sometimes it is easier to rebuild a test integration branch from
scratch all the time, especially if you do not publish it for others to
build on.

I've been using this script for some time to rebuild jch and pu branches
in my workflow.  jch's tip is supposed to always match 'next', but it is
rebuilt from scratch on top of 'master' by merging the same topics that
are in 'next'.  You can use the same script in your work.

To use it, you give a commit range base..tip to the script, and you will
see a shell script that uses a series of 'git-merge'.  "base" is the more
stable branch that you rebuild your test integration branch on top (in my
case, 'master'), and "tip" is where the tip of the test integration branch
is from the last round (in my case, 'jch' or 'pu').

Then you can run the resulting script, fix conflicted merge and use
'git-commit', and then repeat until all the branches are re-integrated on
top of the base branch.

    $ Meta/Reintegrate master..jch >/var/tmp/redo-jch.sh
    $ cat /var/tmp/redo-jch.sh
    #!/bin/sh
    while read branch eh
    do
	    case "$eh" in
	    "") git merge "$branch" || break ;;
	    ?*) echo >&2 "Eh? $branch $eh"; break ;;
	    esac
    done <<EOF
    jc/blame
    js/notes
    ks/maint-mailinfo-folded~3
    tr/previous-branch
    EOF
    $ git checkout jch
    $ git reset --hard master
    $ /var/tmp/redo-jch.sh
    ... if there is conflict, resolve, "git commit" here ...
    $ /var/tmp/redo-jch.sh
    ... repeat until everything is applied.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is taken from my 'todo' branch, which I keep a checkout in Meta/
   directory.

 Reintegrate |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100755 Reintegrate

diff --git a/Reintegrate b/Reintegrate
new file mode 100755
index 0000000..dfdb73e
--- /dev/null
+++ b/Reintegrate
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+merge_msg="Merge branch '\(.*\)'"
+x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+x40="$x40$x40$x40$x40$x40$x40$x40$x40"
+LF='
+'
+
+echo '#!/bin/sh
+while read branch eh
+do
+	case "$eh" in
+	"") git merge "$branch" || break ;;
+	?*) echo >&2 "Eh? $branch $eh"; break ;;
+	esac
+done <<EOF'
+
+git log --pretty=oneline --first-parent "$1" |
+{
+	series=
+	while read commit msg
+	do
+		other=$(git rev-parse --verify "$commit^2") &&
+		branch=$(expr "$msg" : "$merge_msg") &&
+		tip=$(git rev-parse --verify "refs/heads/$branch" 2>/dev/null) &&
+		merged=$(git name-rev --refs="refs/heads/$branch" "$other" 2>/dev/null) &&
+		merged=$(expr "$merged" : "$x40 \(.*\)") &&
+		test "$merged" != undefined || {
+			other=$(git log -1 --pretty='format:%s' $other) &&
+			merged="$branch :rebased? $other"
+		}
+		if test -z "$series"
+		then
+			series="$merged"
+		else
+			series="$merged$LF$series"
+		fi
+	done
+	echo "$series"
+}
+
+echo 'EOF'
-- 
1.6.1.1.248.g7f6d2
