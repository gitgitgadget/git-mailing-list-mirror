From: Pete Wyckoff <pw@padd.com>
Subject: Re: [RFC/PATCHv2] git-p4: handle files with shell metacharacters
Date: Tue, 27 Sep 2011 09:03:34 -0400
Message-ID: <20110927130334.GA24327@arf.padd.com>
References: <20110926214758.GB3433@arf.padd.com>
 <1317112836-14135-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vitor.hda@gmail.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 15:03:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8XK8-0005Ih-PM
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 15:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab1I0NDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 09:03:44 -0400
Received: from honk.padd.com ([74.3.171.149]:54390 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab1I0NDn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 09:03:43 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 6E08BE10;
	Tue, 27 Sep 2011 06:03:42 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A751C313B4; Tue, 27 Sep 2011 09:03:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1317112836-14135-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182237>

luke@diamand.org wrote on Tue, 27 Sep 2011 09:40 +0100:
> Updated git-p4 changes incorporating Pete's comments.
> 
>  - p4CmdList's stdin argument can now be a list.

I think this fits in with the rest of the patch and can stay.

>  - Getting rid of the string option entirely is very hard; there are
>    places where currently git-p4 creates a pipeline.

Yeah, thanks for checking though.  Best to leave it consistent
like you did.

>  - I wonder if verbose should actually be enabled for all the test
>    cases?

It is way too verbose, even for test, but I see the argument.
One easy place to change it would be in the definition in
t/lib-git-p4.sh.  You could do this by hand when testing the
tests perhaps.

>  - The $ENV{PWD} is needed now because the shell used to set that; now
>    that the shell isn't in use git-p4 has to set it.
> 
> Pete - I wasn't sure whether you were saying I should rework
> my patch against next (and you would then rework your series) or
> something else. That sounds complicated though - let me know!

If you don't mind, I'll just queue it up with the utf16 and
test-refactor stuff I have, and send it all to Junio post-1.7.7.
Here's how I plan to adjust your tests, given the feedback that
Junio gave earlier and from reading other tests in t/.

		-- Pete


-----------8<------------------
From 6b4bd671df338210ffd0348358420f0feb6f35c0 Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <pw@padd.com>
Date: Tue, 27 Sep 2011 08:53:25 -0400
Subject: [PATCH] git-p4 t9803: align syntax with other tests


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9803-git-shell-metachars.sh |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/t/t9803-git-shell-metachars.sh b/t/t9803-git-shell-metachars.sh
index c166603..6cf4298 100755
--- a/t/t9803-git-shell-metachars.sh
+++ b/t/t9803-git-shell-metachars.sh
@@ -5,9 +5,7 @@ test_description='git-p4 transparency to shell metachars in filenames'
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
-	kill_p4d || : &&
-	start_p4d &&
-	cd "$TRASH_DIRECTORY"
+	start_p4d
 '
 
 test_expect_success 'init depot' '
@@ -30,25 +28,18 @@ test_expect_success 'shell metachars in filenames' '
 		echo f2 >"file with spaces" &&
 		git add "file with spaces" &&
 		P4EDITOR=touch git commit -m "add files" &&
-		"$GITP4" submit --verbose &&
+		"$GITP4" submit
+	) &&
+	(
 		cd "$cli" &&
 		p4 sync ... &&
-		ls -l "file with spaces" &&
-		ls -l "foo\$bar"
+		test -e "file with spaces" &&
+		test -e "foo\$bar"
 	)
 '
 
-check_missing () {
-	for i in $*; do
-		if [ -f $i ]; then
-			echo $i found but should be missing 1>&2
-			exit 1
-		fi
-	done
-}
-
 test_expect_success 'deleting with shell metachars' '
-	"$GITP4" clone --dest="$git" --verbose //depot &&
+	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -56,10 +47,13 @@ test_expect_success 'deleting with shell metachars' '
 		git rm foo\$bar &&
 		git rm file\ with\ spaces &&
 		P4EDITOR=touch git commit -m "remove files" &&
-		"$GITP4" submit --verbose
+		"$GITP4" submit
+	) &&
+	(
 		cd "$cli" &&
 		p4 sync ... &&
-		check_missing "file with spaces" foo\$bar
+		test ! -e "file with spaces" &&
+		test ! -e foo\$bar
 	)
 '
 
-- 
1.7.6.3
