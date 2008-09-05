From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid warning when bisecting a merge
Date: Thu, 04 Sep 2008 23:29:15 -0700
Message-ID: <7vhc8vxg04.fsf@gitster.siamese.dyndns.org>
References: <1220562150-19962-1-git-send-email-hendeby@isy.liu.se>
 <200809050814.36937.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org,
	gitster@pobox.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 05 08:33:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbUsd-0000Hz-Sf
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 08:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbYIEG3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 02:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYIEG3Z
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 02:29:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbYIEG3Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 02:29:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D1C8F74B6D;
	Fri,  5 Sep 2008 02:29:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 15D4C74B64; Fri,  5 Sep 2008 02:29:17 -0400 (EDT)
In-Reply-To: <200809050814.36937.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 5 Sep 2008 08:14:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB108678-7B13-11DD-8135-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94995>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le jeudi 4 septembre 2008, Gustaf Hendeby a =C3=A9crit :
>> Trying to compare an empty string as a number results in an error,
>> hence make sure checkout_done is set before using it.
>
> This patch seems to work fine.=20
>
>> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
>
> Acked-by: Christian Couder <chriscool@tuxfamily.org>

Have you actually read the patch and thought about it before acking it?

Why does a variable that says "have we done checkout?" have three state=
s?
Certainly it is not like "yes, no, dunno", right?  checkout_done=3D0 wh=
ich
was added by Gustaf, checkout_done=3D1 is the state the test checks wit=
h
(presumably set by check_good_are_ancestors_of_bad), and checkout_done=3D=
''
which the code does before returning?

>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index 69a9a56..05d14b3 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -437,6 +437,7 @@ bisect_next() {
>>  		"refs/bisect/skip-*" | tr '\012' ' ') &&
>>
>>  	# Maybe some merge bases must be tested first
>> +	checkout_done=3D0
>>  	check_good_are_ancestors_of_bad "$bad" "$good" "$skip" || exit
>>  	test "$checkout_done" -eq "1" && checkout_done=3D'' && return

> PS: After thinking about it, I wonder if we should remove $checkout_d=
one=20
> entirely and use the return value from "check_merge_bases"=20
> and "check_good_are_ancestors_of_bad" to know if a checkout was done.

Yup, that might make more sense. In the meantime, I suspect this makes
more sense than introducing a new state "0".

diff --git c/git-bisect.sh w/git-bisect.sh
index 69a9a56..73f01bb 100755
--- c/git-bisect.sh
+++ w/git-bisect.sh
@@ -30,6 +30,7 @@ OPTIONS_SPEC=3D
 . git-sh-setup
 require_work_tree
=20
+checkout_done=3D
 _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
=20
@@ -418,7 +419,7 @@ check_good_are_ancestors_of_bad() {
 	_side=3D$(git rev-list $_good ^$_bad)
 	if test -n "$_side"; then
 		check_merge_bases "$_bad" "$_good" "$_skip" || return
-		test "$checkout_done" -eq "1" && return
+		test -n "$checkout_done" && return
 	fi
=20
 	: > "$GIT_DIR/BISECT_ANCESTORS_OK"
@@ -438,7 +439,7 @@ bisect_next() {
=20
 	# Maybe some merge bases must be tested first
 	check_good_are_ancestors_of_bad "$bad" "$good" "$skip" || exit
-	test "$checkout_done" -eq "1" && checkout_done=3D'' && return
+	test -n "$checkout_done" && checkout_done=3D'' && return
=20
 	# Get bisection information
 	BISECT_OPT=3D''
