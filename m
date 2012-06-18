From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external
 file>' finds changes
Date: Mon, 18 Jun 2012 11:00:31 -0700
Message-ID: <7v1ulc4i0w.fsf@alter.siamese.dyndns.org>
References: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
 <7vzk849zxg.fsf@alter.siamese.dyndns.org>
 <20120615193724.GB26473@sigill.intra.peff.net>
 <CAFoueth2Hfcv0p0SZmichi_6e5--SNkemrSsSivnU73bdFOB4g@mail.gmail.com>
 <7vipes9w0p.fsf@alter.siamese.dyndns.org>
 <CAFouetjkSQuY6pyFdiVsM5tUnEiFK6uWTqDO38uhwUjaDVre1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 20:00:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SggFh-0000Uh-MI
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 20:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab2FRSAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 14:00:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab2FRSAd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 14:00:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E65038DE5;
	Mon, 18 Jun 2012 14:00:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hvdC9WNU6P53rzbKyJ//c3SYqDE=; b=W5AUNC
	5pgRLW3lTTq6dxvbgPgRsatVsyHw+ByaIH+1LLcaAv67oCMfqjTBqAQfTUjqgQMO
	6owQxd1s/Ity0mZQevNGdvgoO3tzFk2WFJ0JORx4gvCzTNa2RCntKZPoZDEGYkPm
	7zxazrESOMAqO397rcPg8uOhCZR2OYbTyt3cM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FYXMI8b883Fs3G5b55RryTtCV3R3eKaK
	AQjvkxtveN3iDNIrF3S8UaOVyK3VWj3Ep41+JU1RZo0E54y0FWB0WWKEEHs904PH
	HHUFCrQNE/vjmgQhfKb/aIU/Nfh0QuFH4H6bkaSgL5PYhtm8Ul8zjI7Ip0x4mZ9C
	p9Kg3EOXTs8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCD0E8DE4;
	Mon, 18 Jun 2012 14:00:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7161F8DE3; Mon, 18 Jun 2012
 14:00:32 -0400 (EDT)
In-Reply-To: <CAFouetjkSQuY6pyFdiVsM5tUnEiFK6uWTqDO38uhwUjaDVre1w@mail.gmail.com> (Tim
 Henigan's message of "Mon, 18 Jun 2012 13:51:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F3902D4-B96F-11E1-9D56-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200154>

Tim Henigan <tim.henigan@gmail.com> writes:

> To obtain full coverage, it seems we need to test:
>     1) git diff --quiet <file in repo> <file outside repo>
>     2) git diff --quiet <file outside repo> <file outside repo>
>
> for each of the following options:
>     a) no additional options
>     b) --ignore-space-at-eol
>     c) --ignore-all-space
>
> These seem like the only diff options that should be tested...am I
> missing anything?
>
> Because some of the tests require one directory that is a repo and one
> directory that is not, it seems best to create a new test file with
> $TEST_NO_CREATE_REPO set.  Then the setup function can create both the
> repo and the plain directory.

It is probably overkill to add a new test that only to add 3 (the
"two paths outside repo" among the 6 = 2 * 3 combinations above).
Inside t4035, you could dig new directory two levels deep, chdir to
it and set GIT_CEILING_DIRECTORY to its first level and run test,
no?  Something along these lines (the diff invoked would obviously
be not between foo and bar)...

 t/t4035-diff-quiet.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index cdb9202..e7065cc 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -77,4 +77,16 @@ test_expect_success 'git diff-index --cached HEAD' '
 	}
 '
 
+test_expect_success 'git diff-no-index outside repository' '
+	mkdir -p not/here &&
+	(
+		cd not/here &&
+		GIT_CEILING_DIRECTORIES=$TRASH_DIRECTORY/not &&
+		export GIT_CEILING_DIRECTORIES &&
+		echo foo >foo &&
+		echo bar >bar &&
+		git diff foo bar
+	)
+'
+
 test_done
