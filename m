From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 6/8] Add a script to coalesce the valgrind outputs
Date: Wed, 4 Feb 2009 00:26:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040026220.9822@pacific.mpi-cbg.de>
References: <cover.1233702893u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 00:27:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUfy-0007K0-KY
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbZBCXZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbZBCXZw
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:25:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:57655 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752593AbZBCXZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:25:50 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:25:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 04 Feb 2009 00:25:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dzhIRQMZdZpe7HhJbtJc0SYGIU8Yr4Y1WaVcRwQ
	YkX+IafCPN18ub
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233702893u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108275>

After running the valgrind tests with GIT_TEST_TREE=t, the test output
is in the test-results/$TEST.out files.

Call ./valgrind/analyze.sh in $GIT_ROOT/t/ to group the valgrind errors
by backtrace.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/valgrind/analyze.sh |  123 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 123 insertions(+), 0 deletions(-)
 create mode 100755 t/valgrind/analyze.sh

diff --git a/t/valgrind/analyze.sh b/t/valgrind/analyze.sh
new file mode 100755
index 0000000..d8105d9
--- /dev/null
+++ b/t/valgrind/analyze.sh
@@ -0,0 +1,123 @@
+#!/bin/sh
+
+out_prefix=$(dirname "$0")/../test-results/valgrind.out
+output=
+count=0
+total_count=0
+missing_message=
+new_line='
+'
+
+# start outputting the current valgrind error in $out_prefix.++$count,
+# and the test case which failed in the corresponding .message file
+start_output () {
+	test -z "$output" || return
+
+	# progress
+	total_count=$(($total_count+1))
+	test -t 2 && printf "\rFound %d errors" $total_count >&2
+
+	count=$(($count+1))
+	output=$out_prefix.$count
+	: > $output
+
+	echo "*** $1 ***" > $output.message
+}
+
+finish_output () {
+	test ! -z "$output" || return
+	output=
+
+	# if a test case has more than one valgrind error, we need to
+	# copy the last .message file to the previous errors
+	test -z "$missing_message" || {
+		while test $missing_message -lt $count
+		do
+			cp $out_prefix.$count.message \
+				$out_prefix.$missing_message.message
+			missing_message=$(($missing_message+1))
+		done
+		missing_message=
+	}
+}
+
+# group the valgrind errors by backtrace
+output_all () {
+	last_line=
+	j=0
+	i=1
+	while test $i -le $count
+	do
+		# output <number> <backtrace-in-one-line>
+		echo "$i $(tr '\n' ' ' < $out_prefix.$i)"
+		i=$(($i+1))
+	done |
+	sort -t ' ' -k 2 | # order by <backtrace-in-one-line>
+	while read number line
+	do
+		# find duplicates, do not output backtrace twice
+		if test "$line" != "$last_line"
+		then
+			last_line=$line
+			j=$(($j+1))
+			printf "\nValgrind error $j:\n\n"
+			cat $out_prefix.$number
+			printf "\nfound in:\n"
+		fi
+		# print the test case where this came from
+		printf "\n"
+		cat $out_prefix.$number.message
+	done
+}
+
+handle_one () {
+	OLDIFS=$IFS
+	IFS="$new_line"
+	while read line
+	do
+		case "$line" in
+		# backtrace, possibly a new one
+		==[0-9]*)
+
+			# Does the current valgrind error have a message yet?
+			case "$output" in
+			*.message)
+				test -z "$missing_message" &&
+				missing_message=$count
+				output=
+			esac
+
+			start_output $(basename $1)
+			echo "$line" |
+			sed 's/==[0-9]*==/==valgrind==/' >> $output
+			;;
+		# end of backtrace
+		'}')
+			test -z "$output" || {
+				echo "$line" >> $output
+				test $output = ${output%.message} &&
+				output=$output.message
+			}
+			;;
+		# end of test case
+		'')
+			finish_output
+			;;
+		# normal line; if $output is set, print the line
+		*)
+			test -z "$output" || echo "$line" >> $output
+			;;
+		esac
+	done < $1
+	IFS=$OLDIFS
+
+	# just to be safe
+	finish_output
+}
+
+for test_script in "$(dirname "$0")"/../test-results/*.out
+do
+	handle_one $test_script
+done
+
+output_all
-- 
1.6.1.2.582.g3fdd5
