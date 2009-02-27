From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: fix quoting TRIED revs when "bad" commit is also
 "skip"ped
Date: Fri, 27 Feb 2009 00:45:24 -0800
Message-ID: <7v3ae0mfob.fsf@gitster.siamese.dyndns.org>
References: <20090226082918.6adbc565.chriscool@tuxfamily.org>
 <7v63ixwpnm.fsf@gitster.siamese.dyndns.org>
 <200902270730.56998.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 09:47:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcyN4-0005Qj-94
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 09:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbZB0Ipd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 03:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZB0Ipc
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 03:45:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZB0Ipc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 03:45:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BA05E255F;
	Fri, 27 Feb 2009 03:45:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5FE8F255E; Fri,
 27 Feb 2009 03:45:26 -0500 (EST)
In-Reply-To: <200902270730.56998.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 27 Feb 2009 07:30:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FCA403D6-04AA-11DE-9B0C-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111648>

Christian Couder <chriscool@tuxfamily.org> writes:

>> This makes me suspect that we are forgetting 
>> to check return status after we eval the output from filter_skipped
>> function. Shouldn't the function should string its commands together with
>> "&&" to protect it from a breakage like this?
>
> Right, that would be an improvement. I put it in another patch though, 
> because it is not really needed to fix a breakage.

Sorry, but I have to disagree.

Look at the caller of filter_skipped in bisect_next():

	eval="git rev-list --bisect-vars $BISECT_OPT $good $bad --" &&
	eval="$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
	eval=$(filter_skipped "$eval" "$skip") &&
	eval "$eval" || exit

	if [ -z "$bisect_rev" ]; then
		echo "$bad was both good and bad"
		exit 1
	fi

The eval "$eval" in the middle, if failed properly upon seeing the quote
bug, would have exited there, because "|| exit" there is all about
catching a broken eval string.  It was not effective.

You were lucky in this case that bisect_rev happens to be empty because
the bug happened to be at the place where bisect_rev was assigned to.  But
with a random other breakage in the filter_skipped, you would not have
been so lucky.

I think it is an integral part of the bugfix to string the commands
filter_skipped outputs with &&, so that an error while executing an
earlier command in the output sequence is not masked by execution of other
commands in the output.

Here is what I am thinking about queueing for 1.6.2; it may be necessary
to apply it to 1.6.1.X (or 1.6.0.X) and merge the fix upwards.

By deepinging case/esac one level without indenting the case arms deeper,
it happens to re-indent the case/esac construct correctly.  case arms
should align with case/esac, and comments on each case arm should come
inside it.

-- >8 --

From: Christian Couder <chriscool@tuxfamily.org>
Date: Fri, 27 Feb 2009 07:31:22 +0100
Subject: [PATCH] bisect: fix quoting TRIED revs when "bad" commit is also "skip"ped

When the "bad" commit was also "skip"ped and when more than one
commit was skipped, the "filter_skipped" function would have
printed something like:

    bisect_rev=<hash1>|<hash2>

(where <hash1> and <hash2> are hexadecimal sha1 hashes)

and this would have been evaled later as piping "bisect_rev=<hash1>"
into "<hash2>", which would have failed.

So this patch makes the "filter_skipped" function properly quote
what it outputs, so that it will print something like:

bisect_rev='<hash1>|<hash2>'

which will be properly evaled later.  The caller was not stopping
properly because the scriptlet this function returned to be evaled
was not strung together with && and because of this, an error in
an earlier part of the output was simply ignored.

A test case is added to the test suite.

And while at it, we also initialize the VARS, FOUND and TRIED
variables, so that we protect ourselves from environment variables
the user may have with these names.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-bisect.sh               |   70 ++++++++++++++++++++++++------------------
 t/t6030-bisect-porcelain.sh |   25 +++++++++++++++
 2 files changed, 65 insertions(+), 30 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 85db4ba..f863c88 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -290,56 +290,66 @@ filter_skipped() {
 
 	# Let's parse the output of:
 	# "git rev-list --bisect-vars --bisect-all ..."
-	eval "$_eval" | while read hash line
-	do
-		case "$VARS,$FOUND,$TRIED,$hash" in
-			# We display some vars.
-			1,*,*,*) echo "$hash $line" ;;
+	eval "$_eval" | {
+		VARS= FOUND= TRIED=
+		while read hash line
+		do
+			case "$VARS,$FOUND,$TRIED,$hash" in
+			1,*,*,*)
+				# "bisect_foo=bar" read from rev-list output.
+				echo "$hash &&" ;;
 
-			# Split line.
-			,*,*,---*) ;;
+			,*,*,---*)
+				# Separator
+				;;
 
-			# We had nothing to search.
 			,,,bisect_rev*)
-				echo "bisect_rev="
+				# We had nothing to search.
+				echo "bisect_rev= &&"
 				VARS=1
 				;;
 
-			# We did not find a good bisect rev.
-			# This should happen only if the "bad"
-			# commit is also a "skip" commit.
 			,,*,bisect_rev*)
-				echo "bisect_rev=$TRIED"
+				# We did not find a good bisect rev.
+				# This should happen only if the "bad"
+				# commit is also a "skip" commit.
+				echo "bisect_rev='$TRIED' &&"
 				VARS=1
 				;;
 
-			# We are searching.
 			,,*,*)
+				# We are searching.
 				TRIED="${TRIED:+$TRIED|}$hash"
 				case "$_skip" in
 				*$hash*) ;;
 				*)
-					echo "bisect_rev=$hash"
-					echo "bisect_tried=\"$TRIED\""
+					echo "bisect_rev=$hash &&"
+					echo "bisect_tried='$TRIED' &&"
 					FOUND=1
 					;;
 				esac
 				;;
 
-			# We have already found a rev to be tested.
-			,1,*,bisect_rev*) VARS=1 ;;
-			,1,*,*) ;;
-
-			# ???
-			*) die "filter_skipped error " \
-			    "VARS: '$VARS' " \
-			    "FOUND: '$FOUND' " \
-			    "TRIED: '$TRIED' " \
-			    "hash: '$hash' " \
-			    "line: '$line'"
-			;;
-		esac
-	done
+			,1,*,bisect_rev*)
+				# We have already found a rev to be tested.
+				VARS=1
+				;;
+			,1,*,*)
+				;;
+			*)
+				# Unexpected input
+				echo "die 'filter_skipped error'"
+				die "filter_skipped error " \
+				    "VARS: '$VARS' " \
+				    "FOUND: '$FOUND' " \
+				    "TRIED: '$TRIED' " \
+				    "hash: '$hash' " \
+				    "line: '$line'"
+				;;
+			esac
+		done
+		echo ':'
+	}
 }
 
 exit_if_skipped_commits () {
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index dd7eac8..052a6c9 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -224,6 +224,31 @@ test_expect_success 'bisect skip: cannot tell between 2 commits' '
 	fi
 '
 
+# $HASH1 is good, $HASH4 is both skipped and bad, we skip $HASH3
+# and $HASH2 is good,
+# so we should not be able to tell the first bad commit
+# among $HASH3 and $HASH4
+test_expect_success 'bisect skip: with commit both bad and skipped' '
+	git bisect start &&
+	git bisect skip &&
+	git bisect bad &&
+	git bisect good $HASH1 &&
+	git bisect skip &&
+	if git bisect good > my_bisect_log.txt
+	then
+		echo Oops, should have failed.
+		false
+	else
+		test $? -eq 2 &&
+		grep "first bad commit could be any of" my_bisect_log.txt &&
+		! grep $HASH1 my_bisect_log.txt &&
+		! grep $HASH2 my_bisect_log.txt &&
+		grep $HASH3 my_bisect_log.txt &&
+		grep $HASH4 my_bisect_log.txt &&
+		git bisect reset
+	fi
+'
+
 # We want to automatically find the commit that
 # introduced "Another" into hello.
 test_expect_success \
-- 
1.6.2.rc2.91.gf9a36
