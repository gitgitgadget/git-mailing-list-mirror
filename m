From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCHv2 1/2] Add git alternate command
Date: Wed, 24 Mar 2010 23:07:30 -0700
Message-ID: <1269497251-13103-2-git-send-email-judge.packham@gmail.com>
References: <a038bef51003241335l1623ade4i4a9b7269546739d4@mail.gmail.com>
Cc: jrnieder@gmail.com, gitster@pobox.com, bebarino@gmail.com,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 07:10:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NugGt-0005DH-8L
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 07:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab0CYGKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 02:10:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39724 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab0CYGJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 02:09:57 -0400
Received: by pva18 with SMTP id 18so594031pva.19
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ek0JbJzmbgbFbcjIf4VttsvGxSsnkjWiiN6bu+buKTo=;
        b=n5PlvUXioXDnvBJPCIVXyHooOMgiKfCMS6QquJADCrBVDg8zi35OZVp38ka9lrSOFE
         1Eg9Yv+QL9dfRaUfN4mJ1tXAOJR60TU5qOYn6yVifr51XMCL+46CopyD3InS+3X7HR8l
         GtDATV1GwY7OTg2aXf5iwRjegeQvniLewet+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DEVBkI5hgRHbnocHGJEUHVxVx1KtUBK13krZSx/SaWmciK66RTFExxKwgY2dvzKPBj
         +hO7z0aEGxbiMuLnG5XQ7XK9N4YK0JqX7zItaR9UhyIkj+3OiLfr5VCAt31ka9jOVZAF
         qiPHDNF2uE96N+uYoEhw43d0aVGGkHZsHHys4=
Received: by 10.114.187.19 with SMTP id k19mr4289930waf.20.1269497396736;
        Wed, 24 Mar 2010 23:09:56 -0700 (PDT)
Received: from localhost.localdomain (adsl-71-131-190-40.dsl.sntc01.pacbell.net [71.131.190.40])
        by mx.google.com with ESMTPS id 20sm650523pzk.7.2010.03.24.23.09.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 23:09:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
In-Reply-To: <a038bef51003241335l1623ade4i4a9b7269546739d4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143164>

The current UI around alternates is lacking. There are commands to add
an alternate at the time of a clone (e.g. 'git clone --reference') but
no commands to see what alternates have been configured or to add an
alternate after a repository has been cloned. This patch adds a
friendlier UI for displaying and configuring alternates.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
Hopefully I've addressed the comments from Junio and Jonathan. I haven't tried
to re-work the commands into show|add|delete as per Stephens suggestion. I have
subtly changed from 'alternates' to 'alternate' i.e. ditched the plural in line
with commands like 'git remote'

 Makefile         |    1 +
 git-alternate.sh |  155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+), 0 deletions(-)
 create mode 100755 git-alternate.sh

diff --git a/Makefile b/Makefile
index 3a6c6ea..0dc5e42 100644
--- a/Makefile
+++ b/Makefile
@@ -334,6 +334,7 @@ TEST_PROGRAMS_NEED_X =
 unexport CDPATH
 
 SCRIPT_SH += git-am.sh
+SCRIPT_SH += git-alternate.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
diff --git a/git-alternate.sh b/git-alternate.sh
new file mode 100755
index 0000000..827baf5
--- /dev/null
+++ b/git-alternate.sh
@@ -0,0 +1,155 @@
+#!/bin/sh
+#
+# This file is licensed under the GPL v2
+#
+
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git alternate [-r|--recursive]
+git alternate [-a|--add dir]
+git alternate [-f|--force] [-d|delete dir]
+--
+r,recursive                    recursively follow alternates
+a,add=                         add dir as an alternate
+d,del=                         delete dir as an alternate
+f,force                        force a delete operation
+"
+. git-sh-setup
+
+#
+# Given the path in $1, which may or may not be a relative path,
+# convert it to an absolute path
+#
+abspath()
+{
+	cd "$1"
+	pwd
+	cd - > /dev/null
+}
+
+#
+# Runs through the alternates file calling the callback function $1
+# with the name of the alternate as the first argument to the callback
+# any additional arguments are passed to the callback function.
+#
+walk_alternates()
+{
+	alternates=$GIT_DIR/objects/info/alternates
+	callback=$1
+	shift
+
+	if test -f "$alternates"
+	then
+		while read line
+		do
+			$callback "$line" "$@"
+		done< "$alternates"
+	fi
+}
+
+#
+# Walk function to display one alternate object store and, if the user
+# has specified -r, recursively call show_alternates on the git 
+# repository that the object store belongs to.
+#
+show_alternates_walk()
+{
+	say "Object store $1"
+	say "    referenced via $GIT_DIR"
+
+	new_git_dir=${line%%/objects}
+	if test "$recursive" = "true" && test "$GIT_DIR" != "$new_git_dir"
+	then
+	(
+		export GIT_DIR=$new_git_dir
+		show_alternates
+	)
+	fi
+}
+
+# Display alternates currently configured
+show_alternates()
+{
+	walk_alternates show_alternates_walk
+}
+
+#
+# Walk function to check that the specified alternate does not
+# already exist.
+#
+check_current_alternate_walk()
+{
+	if test "$1" = "$2"; then
+		die "fatal: Object store $2 is already used by $GIT_DIR"
+	fi
+}
+
+# Add a new alternate
+add_alternate()
+{
+	if test ! -d "$dir"; then
+		die "fatal: $dir is not a directory"
+	fi
+
+	abs_dir=$(abspath "$dir")
+	walk_alternates check_current_alternate_walk "$abs_dir"
+
+	# At this point we know that $dir is a directory that exists
+	# and that its not already being used as an alternate. We could
+	# go further and verify that $dir has valid objects.
+
+	# if we're still going we can safely add the alternate
+	echo "$abs_dir" >> $GIT_DIR/objects/info/alternates
+	say "$abs_dir added as an alternate"
+	say "    use 'git repack -adl' to remove duplicate objects"
+}
+
+# Deletes the name alternate from the alternates file.
+# If there are no more alternates the alternates file will be removed
+del_alternate()
+{
+	if test ! $force = "true"; then
+		say "Not forced, use"
+		say "    'git repack -a' to fetch missing objects, then "
+		say "    '$dashless -f -d $dir' to remove the alternate"
+		die
+	fi
+
+	alternates=$GIT_DIR/objects/info/alternates
+	new_alternates=$alternates.tmp
+
+	grep -v -F "$dir" <"$alternates" >"$new_alternates"
+	if test -s "$new_alternates"
+	then
+		mv "$new_alternates" "$alternates"
+	else
+		# save the git from repeatedly reading a 0 length file
+		rm -f "$alternates"
+	fi
+}
+
+dir=""
+oper=""
+force="false"
+
+# Option parsing
+while test $# != 0
+do
+	case "$1" in
+	-r|--recursive)  recursive="true" ;;
+	-a|--add)        oper="add"; dir="$2"; shift ;;
+	-d|--delete)     oper="del"; dir="$2"; shift ;;
+	-f|--force)      force="true" ;;
+	--)              shift; break ;;
+	*)               usage ;;
+	esac
+	shift
+done
+
+# Now go and do it
+case "$oper" in
+	add) add_alternate ;;
+	del) del_alternate ;;
+	*)   show_alternates ;;
+esac
+
-- 
1.7.0.3
