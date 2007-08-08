From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH] patch open-editor-at-top-line
Date: Wed, 8 Aug 2007 19:11:45 +0400
Organization: SWsoft
Message-ID: <20070808151145.GA2897@dnb.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Aug 08 17:11:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IInBt-0002lB-6X
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 17:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbXHHPLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 11:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbXHHPLN
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 11:11:13 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:44114 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449AbXHHPLM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 11:11:12 -0400
Received: from sw.ru ([192.168.3.106])
	by relay.sw.ru (8.13.4/8.13.4) with SMTP id l78FB8To007446
	for <git@vger.kernel.org>; Wed, 8 Aug 2007 19:11:09 +0400 (MSD)
Received: by sw.ru (nbSMTP-1.00) for uid 1008
	dmonakhov@sw.ru; Wed,  8 Aug 2007 19:11:46 +0400 (MSD)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55324>

When i use "guilt series -e" for realy long series file
it is not confortable always search current top patch line.
IMHO editor have to start at the top patch automaticaly.
Btw: open_editor_at_line may be useful in other places

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 guilt        |   34 ++++++++++++++++++++++++++++++++++
 guilt-series |    5 +++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/guilt b/guilt
index bc51472..66c3078 100755
--- a/guilt
+++ b/guilt
@@ -287,6 +287,18 @@ series_insert_patch()
 	mv "$series.tmp" "$series"
 }
 
+# usage: line=get_series_top_line
+# return top patch line number in series
+get_series_top_line()
+{
+	awk -v top="`get_top`" -v new="$1" \
+		'BEGIN{if (top == "") ; iter=0;}
+		{
+			iter=iter+1;
+			if (top != "" && top == $0)  {print iter; exit};
+		}' "$series"
+}
+
 # usage: series_remove_patch <patchname>
 series_remove_patch()
 {
@@ -508,6 +520,28 @@ __refresh_patch()
 	push_patch "$1"
 }
 
+# usage: open_editor_at_line <editor> <filename> <line>
+# try to open editor with "filename"" at "line"
+# different editors use different syntax for start line parameter
+# so the only thing we can do is just compare with known editiors
+# and ignore line if editor is unknown.
+open_editor_at_line()
+{
+	editor_name=$1
+	file_name=$2
+	line_pos=$3
+	case "$editor_name" in
+		"vi" |"vim")
+			$editor_name $file_name +$line_pos;;
+		"emacs")
+			$editor_name $file_mame:$line_pos;;
+		*)
+			# editor is unknown, line_pos is just ignored
+			$editor_name $file_name;;
+	esac
+	return $?
+}
+
 # usage: munge_hash_range <hash range>
 #
 # this means:
diff --git a/guilt-series b/guilt-series
index 9c34a08..5a9ebbc 100755
--- a/guilt-series
+++ b/guilt-series
@@ -21,8 +21,9 @@ do
 	shift
 done
 
-if [ ! -z "$edit" ]; then 
-	$editor "$series"
+if [ ! -z "$edit" ]; then
+	top_line=`get_series_top_line`
+	open_editor_at_line $editor "$series" "$top_line"
 elif [ ! -z "$gui" ]; then
 	[ -z "`get_top`" ] && die "No patches applied."
 	bottom=`head -1 $applied | cut -d: -f1`
-- 
1.5.2.2
