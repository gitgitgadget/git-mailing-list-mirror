From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] format-patch: always --mbox and show sane Date:
Date: Fri, 13 Jan 2006 15:56:44 -0800
Message-ID: <7v1wzb1y2r.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0601082207510.3169@g5.osdl.org>
	<20060108140109.909925BE8D@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jan 14 00:57:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExYmo-0005dS-PF
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 00:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423125AbWAMX4r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 18:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423126AbWAMX4r
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 18:56:47 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:35792 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1423125AbWAMX4q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 18:56:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113235650.WWHA25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 18:56:50 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14657>

Make --mbox, --author, and --date options a no-op, and always
use --mbox output, and rewrite the commit log formatting in
Perl.  This makes it easier to output Date: header in RFC 2822
format, so do that as well.

Inspiration for this patch came from Andreas Ericsson's earlier
patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I admit that trying to avoid Perl and sticking to multiple
   sed invocations in this script was a lost battle.  This patch
   is still minimalistic and it does not go all the way to
   rewrite the main loop of the program, which probably should
   happen someday.

   I would not mind if someday somebody rewrote most of the
   barebone Porcelainish in Python or Perl, but the rewrite
   should not be for the sake of using that language.  It should
   have other justifications: "there is too much text processing
   there it would not make sense to do that in shell".  I think
   this patch is borderline to qualify to be in that camp.

   As the version string at the end shows, this was prepared
   with the script source itself before building, as a test
   case.

 git-format-patch.sh |  143 +++++++++++++++++++++++++++------------------------
 1 files changed, 75 insertions(+), 68 deletions(-)

8b4271ef24818e6d52926bc615e5ce78ba0ed01b
diff --git a/git-format-patch.sh b/git-format-patch.sh
index d3979d7..7e67c4e 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -34,14 +34,12 @@ outdir=./
 while case "$#" in 0) break;; esac
 do
     case "$1" in
-    -a|--a|--au|--aut|--auth|--autho|--author)
-    author=t ;;
     -c|--c|--ch|--che|--chec|--check)
     check=t ;;
-    -d|--d|--da|--dat|--date)
-    date=t ;;
-    -m|--m|--mb|--mbo|--mbox)
-    date=t author=t mbox=t ;;
+    -a|--a|--au|--aut|--auth|--autho|--author|\
+    -d|--d|--da|--dat|--date|\
+    -m|--m|--mb|--mbo|--mbox) # now noop
+    ;;
     -k|--k|--ke|--kee|--keep|--keep-|--keep-s|--keep-su|--keep-sub|\
     --keep-subj|--keep-subje|--keep-subjec|--keep-subject)
     keep_subject=t ;;
@@ -173,80 +171,89 @@ titleScript='
 	q
 '
 
-whosepatchScript='
-/^author /{
-	s/'\''/'\''\\'\'\''/g
-	s/author \(.*>\) \(.*\)$/au='\''\1'\'' ad='\''\2'\''/p
-	q
-}'
-
 process_one () {
-	mailScript='
-	/./d
-	/^$/n'
-	case "$keep_subject" in
-	t)  ;;
-	*)
-	    mailScript="$mailScript"'
-	    s|^\[PATCH[^]]*\] *||
-	    s|^|[PATCH'"$num"'] |'
-	    ;;
-	esac
-	mailScript="$mailScript"'
-	s|^|Subject: |'
-	case "$mbox" in
-	t)
-	    echo 'From nobody Mon Sep 17 00:00:00 2001' ;# UNIX "From" line
-	    ;;
-	esac
+	perl -w -e '
+my ($keep_subject, $num, $signoff, $commsg) = @ARGV;
+my ($signoff_pattern, $done_header, $done_subject, $signoff_seen,
+    $last_was_signoff);
+
+if ($signoff) {
+	$signoff = `git-var GIT_COMMITTER_IDENT`;
+	$signoff =~ s/>.*/>/;
+	$signoff_pattern = quotemeta($signoff);
+}
 
-	eval "$(sed -ne "$whosepatchScript" $commsg)"
-	test "$author,$au" = ",$me" || {
-		mailScript="$mailScript"'
-	a\
-From: '"$au"
-	}
-	test "$date,$au" = ",$me" || {
-		mailScript="$mailScript"'
-	a\
-Date: '"$ad"
-	}
+my @weekday_names = qw(Sun Mon Tue Wed Thu Fri Sat);
+my @month_names = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
 
-	mailScript="$mailScript"'
-	a\
+sub show_date {
+    my ($time, $tz) = @_;
+    my $minutes = abs($tz);
+    $minutes = ($minutes / 100) * 60 + ($minutes % 100);
+    if ($tz < 0) {
+        $minutes = -$minutes;
+    }
+    my $t = $time + $minutes * 60;
+    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday) = gmtime($t);
+    return sprintf("%s %s %d %02d:%02d:%02d %d %+05d",
+		   $weekday_names[$wday],
+		   $month_names[$mon],
+		   $mday, $hour, $min, $sec,
+		   $year+1900, $tz);
+}
 
-	: body
-	p
-	n
-	b body'
+print "From nobody Mon Sep 17 00:00:00 2001\n";
+open FH, "git stripspace <$commsg |" or die "open $commsg pipe";
+while (<FH>) {
+    unless ($done_header) {
+	if (/^$/) {
+	    $done_header = 1;
+	}
+	elsif (/^author (.*>) (.*)$/) {
+	    my ($author_ident, $author_date) = ($1, $2);
+	    my ($utc, $off) = ($author_date =~ /^(\d+) ([-+]?\d+)$/);
+	    $author_date = show_date($utc, $off);
 
-	(cat $commsg ; echo; echo) |
-	sed -ne "$mailScript" |
-	git-stripspace
-
-	test "$signoff" = "t" && {
-		offsigner=`git-var GIT_COMMITTER_IDENT | sed -e 's/>.*/>/'`
-		line="Signed-off-by: $offsigner"
-		grep -q "^$line\$" $commsg || {
-			echo
-			echo "$line"
-			echo
-		}
+	    print "From: $author_ident\n";
+	    print "Date: $author_date\n";
 	}
-	echo
-	echo '---'
-	echo
+	next;
+    }
+    unless ($done_subject) {
+	unless ($keep_subject) {
+	    s/^\[PATCH[^]]*\]\s*//;
+	    s/^/[PATCH$num] /;
+	}
+        print "Subject: $_";
+	$done_subject = 1;
+	next;
+    }
+
+    $last_was_signoff = 0;
+    if (/Signed-off-by:/i) {
+        if ($signoff ne "" && /Signed-off-by:\s*$signoff_pattern$/i) {
+	    $signoff_seen = 1;
+	}
+    }
+    print $_;
+}
+if (!$signoff_seen && $signoff ne "") {
+    if (!$last_was_signoff) {
+        print "\n";
+    }
+    print "$signoff\n";
+}
+print "\n---\n\n";
+close FH or die "close $commsg pipe";
+' "$keep_subject" "$num" "$signoff" $commsg
+
 	git-diff-tree -p $diff_opts "$commit" | git-apply --stat --summary
 	echo
 	git-diff-tree -p $diff_opts "$commit"
 	echo "-- "
 	echo "@@GIT_VERSION@@"
 
-	case "$mbox" in
-	t)
-		echo
-		;;
-	esac
+	echo
 }
 
 total=`wc -l <$series | tr -dc "[0-9]"`
-- 
@@GIT_VERSION@@
