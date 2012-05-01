From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log-tree: use custom line terminator in line termination
 mode
Date: Tue, 01 May 2012 10:06:17 -0700
Message-ID: <7vobq7al12.fsf@alter.siamese.dyndns.org>
References: <86ty01qez7.fsf@red.stonehenge.com>
 <1335811555-23564-1-git-send-email-jk@jk.gs>
 <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
 <20120501085649.GD4998@sigill.intra.peff.net>
 <7v1un3c23p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jeff King <peff@peff.net>, Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue May 01 19:06:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGWw-0001QA-2W
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754Ab2EARGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:06:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755866Ab2EARGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:06:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E05147D3A;
	Tue,  1 May 2012 13:06:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hNCi65Hw5xP4QccOaJGTZgQeKd0=; b=VrcTx5
	jPyykydg1ha8i+yFZYTW9bGyqiqQIPhgjlJ2vqWjQO0BBPeshnUvhRqFlOkEBzNo
	Xs4OnR58sc/yDdHwyKXrnaZni82Maxb4jWRntqIO6QcZhxjeqH55cbvfhSaXsph7
	INEu1z0nwQFqrJunldxxjuS0JpEi73ESR5bwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oqml0SenSdj6SeSFLpodlArtyhbNczvg
	uD2KlPxDTQlQmZbaC9F+pGOLAB302f6xxJFdCD4axIcytT8gXphYNwhkwu4qjGVX
	XhDOXSFiwosvWRLxs+mu6jcSkPDCf0NLkJYA2uJa5+s65RlV4b3580/juI0n3J5n
	1NTBPRNP12s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D78267D39;
	Tue,  1 May 2012 13:06:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35A387D37; Tue,  1 May 2012
 13:06:19 -0400 (EDT)
In-Reply-To: <7v1un3c23p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 01 May 2012 09:12:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F852F520-93AF-11E1-8954-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196696>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Hmm. This came up before, and the issue is (or can be) slightly more
>> complex:
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/122478/focus=122568
>
> Yeah, the test given completely forgets about "log -p" case, as you said
> in the above:
>
>     But we can't just modify that to use the specified line terminator,
>     because sometimes it is acting as a separator between commit message and
>     diff, and sometimes it is acting as the terminator of the whole record.
>
> So the patch is not quite right for the "log -p -z" (or "log --stat -z")
> case.
>
> The correct output would have NUL after each commit, so "-z --format=%s"
> would have a single-liner subject with the line-terminating LF replaced
> with NUL, and "-p/--stat -z --format=%s" would have a single-liner subject
> with its line-terminating LF, followed by the diff/diffstat in which the
> terminating LF of the last line is replaced with NUL, but to be consistent
> with what "-p/--stat -z --pretty=format:%s" does, I think it is OK to
> append NUL to the diff/diffstat part instead of replacing its last LF with
> NUL.

In other words, this test on top (the last one only demonstrates the
breakage).

 t/t4205-log-pretty-formats.sh |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f00e446..4afd778 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -83,4 +83,20 @@ test_expect_success 'NUL termination' '
 	test_cmp expected actual
 '
 
+test_expect_success 'NUL separation with --stat' '
+	stat0_part=$(git diff --stat HEAD^ HEAD) &&
+	stat1_part=$(git diff --stat --root HEAD^) &&
+	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n" >expected &&
+	git log -z --stat --pretty="format:%s" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'NUL termination with --stat' '
+	stat0_part=$(git diff --stat HEAD^ HEAD) &&
+	stat1_part=$(git diff --stat --root HEAD^) &&
+	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n\0" >expected &&
+	git log -z --stat --pretty="tformat:%s" >actual &&
+	test_cmp expected actual
+'
+
 test_done
