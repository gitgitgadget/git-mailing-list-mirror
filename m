From: Junio C Hamano <gitster@pobox.com>
Subject: Re: warning: no common commits - slow pull
Date: Tue, 26 Feb 2008 22:29:20 -0800
Message-ID: <7voda2yksf.fsf@gitster.siamese.dyndns.org>
References: <200802102007.38838.lenb@kernel.org>
 <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org>
 <200802261438.17014.lenb@kernel.org>
 <7vir0byoc2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Len Brown <lenb@kernel.org>, Theodore Tso <tytso@mit.edu>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 07:30:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUFoC-0005Zh-9l
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 07:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbYB0G3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 01:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbYB0G3l
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 01:29:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbYB0G3k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 01:29:40 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 81C9426F3;
	Wed, 27 Feb 2008 01:29:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DFD0226F2; Wed, 27 Feb 2008 01:29:27 -0500 (EST)
In-Reply-To: <7vir0byoc2.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 26 Feb 2008 21:12:45 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75203>

Updates.

I seem to have a reliable reproduction script, for this issue.

After rebuilding your git with the following patch, running
the test script ./t000.sh would exhibit that "no common refs"
while following the tag.

Then rebuild your git with "#if 0" part enabled, and run the
test again, to see the problem fixed.

This adds --autofollow option which is _purely_ for debugging
this issue.  The command named by the option is executed after
the command finishes the main transfer but before it starts the
second transfer to auto follow the tags.

The test prepares two repositories (src0.git and src1.git) to
simulate DNS round robin server side.  src0.git grows, src1.git
mirrors it with a bit of lag.  src.git is a symlink that is used
to simulate DNS round robin.  Initially it points at src0.git
(more up-to-date one) and a clone to Len (dst.git) is made.
After src0.git grows history while src1.git mirrors it with a
lag, Len fetches again, first from src0.git but autofollowing
connection goes to src1.git.

While I was futzing with the test script, I also observed
another error message "fatal: not our ref", but that was before
I fixed the commit traversal order by giving them the test_tick
timestamps.  It won't reproduce with the attached test script,
but the patch also seemed to fix it.

---

 builtin-fetch.c |   12 +++++++
 t000.sh         |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index ac335f2..79359ac 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -28,6 +28,7 @@ static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *transport;
+static char *autofollow;
 
 static struct option builtin_fetch_options[] = {
 	OPT__QUIET(&quiet),
@@ -45,6 +46,8 @@ static struct option builtin_fetch_options[] = {
 		    "allow updating of HEAD ref"),
 	OPT_STRING(0, "depth", &depth, "DEPTH",
 		   "deepen history of shallow clone"),
+	OPT_STRING(0, "autofollow", &autofollow, "COMMAND",
+		   "call the command just before autofollowing"),
 	OPT_END()
 };
 
@@ -547,6 +550,15 @@ static int do_fetch(struct transport *transport,
 	/* if neither --no-tags nor --tags was specified, do automated tag
 	 * following ... */
 	if (tags == TAGS_DEFAULT && autotags) {
+		if (autofollow)
+			system(autofollow);
+#if 0
+		if (transport->remote_refs) {
+			struct ref *stale = (struct ref *)transport->remote_refs;
+			free_refs(stale);
+			transport->remote_refs = NULL;
+		}
+#endif
 		ref_map = find_non_local_tags(transport, fetch_map);
 		if (ref_map) {
 			transport_set_option(transport, TRANS_OPT_DEPTH, "0");
diff --git a/t000.sh b/t000.sh
new file mode 100644
index 0000000..e2c35d1
--- /dev/null
+++ b/t000.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+GIT_EXEC_PATH=`pwd`
+PATH=`pwd`:/usr/bin:/bin
+GITPERLLIB=`pwd`/perl/blib/lib
+export GIT_EXEC_PATH PATH GITPERLLIB
+
+testdir=/var/tmp/fetch-test
+mkdir -p "$testdir"
+
+cd "$testdir" || exit
+test_tick=1112911993
+
+grow () {
+	j_bottom="$1" j_top="$2" i_top="$3" tagit="$4"
+	j="$j_bottom"
+	while test "$j" -le "$j_top"
+	do
+		i=1
+		while test "$i" -le "$i_top"
+		do
+			echo "$j.$i" >f
+			git add f
+			test_tick=$(($test_tick + 60))
+			GIT_COMMITTER_DATE="$test_tick -0700" \
+			git commit -q -m "$j.$i"
+			i=$(($i + 1))
+		done
+		if test -n "$tagit"
+		then
+			git tag -a -m "Tag $j" v$j
+		fi
+		j=$(($j + 1))
+	done
+}
+
+rm -fr src0.git src1.git dst.git
+
+# Prepare the very original.  Pretend this is Linus
+mkdir src0.git
+cd src0.git
+git init
+grow 1 5 4 1
+cd ..
+
+# Prepare a "mirror" that slightly lags behind.
+mkdir src1.git
+cd src1.git
+GIT_DIR=. git init
+git remote add -f --mirror origin ../src0.git/
+cd ..
+
+# Prepare canonical symlink
+rm -f src.git && ln -s src0.git src.git
+
+# Len clones and works
+git clone file://$testdir/src.git/ dst.git
+cd dst.git
+grow 1 1 200
+cd ..
+
+# Linus works more.
+cd src0.git
+grow 6 7 4 1
+cd ..
+
+# Mirror it out
+cd src1.git
+git fetch
+cd ..
+
+# Linus works further.
+cd src0.git
+grow 8 8 1
+cd ..
+
+# Prepare "switch" script
+echo >auto-switch.sh '#!/bin/sh
+cd "'$testdir'"
+case "$(ls -l src.git)" in
+*src0.git*)	new=src1.git ;;
+*src1.git*)	new=src0.git ;;
+esac
+echo "Auto switching to $new"
+rm -f src.git && ln -s "$new" src.git'
+chmod +x auto-switch.sh
+
+# Now Len fetches; the first goes to src0 (up-to-date one) but
+# the autofollow goes to src1 (more stale one)
+
+rm -f src.git && ln -s src0.git src.git
+
+cd dst.git
+git-fetch -v --autofollow="$testdir/auto-switch.sh"
+
