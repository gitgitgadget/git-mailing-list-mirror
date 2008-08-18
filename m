From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: work around ksh's trap shortcomings
Date: Mon, 18 Aug 2008 16:48:51 -0700
Message-ID: <7vbpzplw9o.fsf@gitster.siamese.dyndns.org>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil> <gPlIc7E6mNDrXE6mwaHXFoin7rDpLmjvuzlhJfCp-YmuyVK3pEzqNA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:50:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEU5-0005VO-3O
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbYHRXs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbYHRXs6
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:48:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbYHRXs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:48:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D2C65F10A;
	Mon, 18 Aug 2008 19:48:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 25BE05F107; Mon, 18 Aug 2008 19:48:52 -0400 (EDT)
In-Reply-To: <gPlIc7E6mNDrXE6mwaHXFoin7rDpLmjvuzlhJfCp-YmuyVK3pEzqNA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon, 18 Aug 2008 18:16:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3879E960-6D80-11DD-8DCD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92764>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> In ksh, if trap is called within a function with 0 or EXIT as its signal,
> then the trap will be executed at the time the function returns. This
> causes a problem in the test functions since 'trap - exit' is called
> within the test_done function

Your alias test_done that calls function test_done look ugly and confusing
beyond words.  Perhaps test_done() can instead set a global variable and
die() can notice it instead, like this?  I haven't bothered to change the
other "trap - exit" but I think you got the idea...

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 11c0275..010bfda 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -156,10 +156,16 @@ test_count=0
 test_fixed=0
 test_broken=0
 test_success=0
+test_exit_ok=0
 
 die () {
-	echo >&5 "FATAL: Unexpected exit with code $?"
-	exit 1
+	status=$?
+	if test 1 != $test_exit_ok
+	then
+		echo >&5 "FATAL: Unexpected exit with code $status"
+		exit 1
+	fi
+	exit $status
 }
 
 trap 'die' exit
@@ -415,6 +421,7 @@ test_create_repo () {
 }
 
 test_done () {
+	test_exit_ok=1
 	trap - exit
 	test_results_dir="$TEST_DIRECTORY/test-results"
 	mkdir -p "$test_results_dir"
