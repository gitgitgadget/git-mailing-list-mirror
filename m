From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] git-rebase.sh: Fix --merge --abort failures
 when path contains whitespace
Date: Thu, 10 Apr 2008 00:45:51 -0700
Message-ID: <7vr6dexids.fsf@gitster.siamese.dyndns.org>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 09:46:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjrUk-0004jG-Fk
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 09:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbYDJHqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 03:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754229AbYDJHqJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 03:46:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbYDJHqI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 03:46:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BAC73287F;
	Thu, 10 Apr 2008 03:46:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B44D6287E; Thu, 10 Apr 2008 03:46:00 -0400 (EDT)
In-Reply-To: <1207810216-27871-2-git-send-email-bdonlan@fushizen.net> (Bryan
 Donlan's message of "Thu, 10 Apr 2008 02:50:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79188>

Bryan Donlan <bdonlan@fushizen.net> writes:

> +### Test that we handle strange characters properly

Thanks for the fix and updated tests.

> +work_dir="$(pwd)/test \" ' \$ \\ dir"
> +
>  test_expect_success setup '
> +	mkdir -p "$work_dir" &&
> +	cd "$work_dir" &&
> +	git init &&

As you know that $work_dir and shell variables in general are available
inside test_expect_* framework without anything special, like the above
code,...

> @@ -27,42 +33,45 @@ testrebase() {
>  	type=$1
>  	dotest=$2
>  
> +	test_expect_success "rebase$type --abort" "
> +		cd \"\$work_dir\" &&
>  		# Clean up the state from the previous one
> +		git reset --hard pre-rebase &&
> +		test_must_fail git rebase$type master &&
> +		test -d \"\$dotest\" &&
> ...

this part would become a lot easier to read if you just stayed inside the
original single quoted test script without introducing excessive
backslashes.

I am very inclined to replace t3407 with the following.

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 37944c3..cadfb23 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -4,7 +4,13 @@ test_description='git rebase --abort tests'
 
 . ./test-lib.sh
 
+### Test that we handle strange characters properly
+work_dir="$(pwd)/test \" ' \$ \\ dir"
+
 test_expect_success setup '
+	mkdir -p "$work_dir" &&
+	cd "$work_dir" &&
+	git init &&
 	echo a > a &&
 	git add a &&
 	git commit -m a &&
@@ -28,32 +34,35 @@ testrebase() {
 	dotest=$2
 
 	test_expect_success "rebase$type --abort" '
+		cd "$work_dir" &&
 		# Clean up the state from the previous one
-		git reset --hard pre-rebase
-		test_must_fail git rebase'"$type"' master &&
-		test -d '$dotest' &&
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type master &&
+		test -d "$dotest" &&
 		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d '$dotest'
+		test ! -d "$dotest"
 	'
 
 	test_expect_success "rebase$type --abort after --skip" '
+		cd "$work_dir" &&
 		# Clean up the state from the previous one
-		git reset --hard pre-rebase
-		test_must_fail git rebase'"$type"' master &&
-		test -d '$dotest' &&
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type master &&
+		test -d "$dotest" &&
 		test_must_fail git rebase --skip &&
 		test $(git rev-parse HEAD) = $(git rev-parse master) &&
 		git-rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d '$dotest'
+		test ! -d "$dotest"
 	'
 
 	test_expect_success "rebase$type --abort after --continue" '
+		cd "$work_dir" &&
 		# Clean up the state from the previous one
-		git reset --hard pre-rebase
-		test_must_fail git rebase'"$type"' master &&
-		test -d '$dotest' &&
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type master &&
+		test -d "$dotest" &&
 		echo c > a &&
 		echo d >> a &&
 		git add a &&
@@ -61,7 +70,7 @@ testrebase() {
 		test $(git rev-parse HEAD) != $(git rev-parse master) &&
 		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d '$dotest'
+		test ! -d "$dotest"
 	'
 }
 
