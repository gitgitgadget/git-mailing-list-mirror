From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] add function test_must_fail_or_sigpipe and use it to fix flaky tests
Date: Fri, 06 Nov 2015 10:49:15 -0800
Message-ID: <xmqqmvur2cb8.fsf@gitster.mtv.corp.google.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
	<1446800323-2914-2-git-send-email-larsxschneider@gmail.com>
	<xmqqr3k32dc9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, sschuberth@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, avila.jn@gmail.com, luke@diamand.org,
	dturner@twopensource.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 06 19:49:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zum4g-00027x-O9
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 19:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbbKFStS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 13:49:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750893AbbKFStS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 13:49:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1AD4328C83;
	Fri,  6 Nov 2015 13:49:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ydYtNkNNxKYMZoPZ800Y2QrSjF8=; b=rhuzXH
	XitwwBf7gSzpQIr5ayPXv/pCPQAW4XtOZ0/YmkX27ao9IwNAlofY2v8KAPRz2x+W
	3PJiehse/no86v2DWzpuy7pqxD1g+sGuBsZwhQSDaDZrb1SRIfZSYK71nRhkFUo3
	rqHf8JbFzxgzSH1TpqKarI4VeODomusIosTUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rl5fghir3QOijE3KD8GiVXKubi6higCp
	HJwgWRDEF0chDnybNdM4sDwyJDuZQNoJ5u9SOdYupi+l07nRhiXpdC7EIFxC/Wqs
	dbOoCyRhUJKX112R1W6Px/IZ+oUXkbe0X6RQLeGo21IS8Orv3uF02CIStOYSb25Q
	IjTTfrab9bg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1025628C82;
	Fri,  6 Nov 2015 13:49:17 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7A5D028C80;
	Fri,  6 Nov 2015 13:49:16 -0500 (EST)
In-Reply-To: <xmqqr3k32dc9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Nov 2015 10:27:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 14B2F49E-84B7-11E5-A156-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280996>

Junio C Hamano <gitster@pobox.com> writes:

> Adding the third variant in the way this patch does is making things
> worse by inviting more mistakes.
>
> How about doing something like the attached to consolidate the
> existing two into one, and then build this third one on top?

Actually, I think this other variant I came up with is cleaner and
is more easily extensible.  It already has the support for sigpipe,
e.g. you can do

	test_must_fail ok=sigpipe git fetch ...

Of course, you can do

	test_must_fail_or_sigpipe () {
		test_must_fail ok=sigpipe "$@"
	}

if it is easier to read.  I do not have a very strong opinion either
way.

 t/test-lib-functions.sh | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e8d3c0f..b732f87 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -560,11 +560,26 @@ test_line_count () {
 # the failure could be due to a segv.  We want a controlled failure.
 
 test_must_fail () {
+	case "$1" in
+	ok=*)
+		_test_ok=${1#ok=}
+		shift
+		;;
+	*)
+		_test_ok=
+		;;
+	esac
 	"$@"
 	exit_code=$?
-	if test $exit_code = 0; then
+	if ! case ",$_test_ok," in *,success,*) false;; esac &&
+	   test $exit_code = 0
+	then
 		echo >&2 "test_must_fail: command succeeded: $*"
 		return 1
+	elif ! case ",$_test_ok," in *,sigpipe,*) false;; esac &&
+	   test $exit_code = 141
+	then
+		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192; then
 		echo >&2 "test_must_fail: died by signal: $*"
 		return 1
@@ -590,16 +605,7 @@ test_must_fail () {
 # because we want to notice if it fails due to segv.
 
 test_might_fail () {
-	"$@"
-	exit_code=$?
-	if test $exit_code -gt 129 && test $exit_code -le 192; then
-		echo >&2 "test_might_fail: died by signal: $*"
-		return 1
-	elif test $exit_code = 127; then
-		echo >&2 "test_might_fail: command not found: $*"
-		return 1
-	fi
-	return 0
+	test_must_fail ok=success "$@"
 }
 
 # Similar to test_must_fail and test_might_fail, but check that a
