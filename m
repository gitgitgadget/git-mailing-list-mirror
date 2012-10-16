From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: allow author-specific timezones
Date: Mon, 15 Oct 2012 20:50:21 -0700
Message-ID: <7v4nlvulc2.fsf@alter.siamese.dyndns.org>
References: <1350261054-5171-1-git-send-email-crorvick@cogcap.com>
 <7vpq4jws4d.fsf@alter.siamese.dyndns.org>
 <CAEUsAPY3fJJSzX8WPRVQPNOF0A0KAMCXr1u0ZzjEFvXDF=v6JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 05:50:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNyAx-0004l0-Aj
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 05:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab2JPDu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 23:50:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755489Ab2JPDu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 23:50:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 608A08EA6;
	Mon, 15 Oct 2012 23:50:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=psVlro0GnUi3v/3hYs/XPjiwk9I=; b=vhbdJF
	WZrEqai+VzzK0q5IZX6vNwVnWBelgtRya3QbxpV9/htgA+YYhRel4xHkbj+YZN6j
	f7ZHbpefQvfvA6x6m84+qRohtB+Cb9FndP7rl70Y+x0Cqi8F4m4TR1dbm4C/rZ4j
	larKoPCxIqpRY/lIp/GV2Fr4wQzYHN0W7KZfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Di8oBnDMbaiRW3vfEbCsdMWZbMP6Xe0V
	1Zx/wNXLwhMM5cTblOho0wAhApQwmRCKYUqMbYYzyY76sKoBiDRidnPhHF8lvqGu
	KtvciuY7jkd/GrrbcY1U9DrY4NRmYI2qXxMrs/iW+C6I1kN+tV0ZgjgWzq61dkH8
	M5zG91CZybU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DFD08EA5;
	Mon, 15 Oct 2012 23:50:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7C4B8EA0; Mon, 15 Oct 2012
 23:50:22 -0400 (EDT)
In-Reply-To: <CAEUsAPY3fJJSzX8WPRVQPNOF0A0KAMCXr1u0ZzjEFvXDF=v6JA@mail.gmail.com> (Chris
 Rorvick's message of "Mon, 15 Oct 2012 21:26:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C97D160-1744-11E2-82A1-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207799>

Chris Rorvick <chris@rorvick.com> writes:

> It occurred to me that the success of the unit test depends on the
> host platform's zoneinfo database.  I think this problem is inherent
> with this functionality.  Should the unit test attempt to detect
> support for the used timezones and short circuit if this fails?  Not
> sure exactly how I'd do this, but wondering if it's worth thinking
> about.

Yeah, that did indeed cross my mind.

You could say TZ=QST6QDT or something silly like that but that in
turn has to assume your tzset() is POSIX.1 compliant anyway.

We should at least protect the tests with prerequiste, perhaps like
this.

 t/t9604-cvsimport-timestamps.sh | 53 ++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git i/t/t9604-cvsimport-timestamps.sh w/t/t9604-cvsimport-timestamps.sh
index 6af41b7..f7683da 100755
--- i/t/t9604-cvsimport-timestamps.sh
+++ w/t/t9604-cvsimport-timestamps.sh
@@ -3,9 +3,30 @@
 test_description='git cvsimport timestamps'
 . ./lib-cvs.sh
 
+# Can your Perl grok these TZ settings correctly?
+test_lazy_prereq TZNAME '
+	perl -e '\''
+		use POSIX qw(strftime);
+		while (<STDIN>) {
+			my ($zone, $time, $expect) = split(q/ /);
+			$ENV{TZ} = $zone;
+			if (strftime(q/%z/, localtime($time)) ne $expect) {
+				exit(1);
+			}
+		}
+		exit(0);
+	'\'' <<-\EOF
+	America/Chicago 1345174000 -0500
+	America/Chicago 1329622000 -0600
+	Australia/Sydney 1345174000 +1000
+	Australia/Sydney 1329622000 +1100
+	Asia/Shanghai 1329622000 +0800
+	EOF
+'
+
 setup_cvs_test_repository t9604
 
-test_expect_success 'check timestamps are UTC (TZ=America/Chicago)' '
+test_expect_success TZNAME 'check timestamps are UTC (TZ=America/Chicago)' '
 	TZ=America/Chicago git cvsimport -p"-x" -C module-1 module &&
 	git cvsimport -p"-x" -C module-1 module &&
 	(
