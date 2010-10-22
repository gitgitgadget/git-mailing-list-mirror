From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-apply with -p greater than 1
Date: Thu, 21 Oct 2010 22:01:20 -0700
Message-ID: <7viq0urfbz.fsf@alter.siamese.dyndns.org>
References: <1287699122-26702-1-git-send-email-fedux@lugmen.org.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Federico Cuello <fedux@lugmen.org.ar>
X-From: git-owner@vger.kernel.org Fri Oct 22 07:01:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P99l3-0006i2-Uj
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 07:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab0JVFBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 01:01:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab0JVFB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 01:01:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 244ECE0DFD;
	Fri, 22 Oct 2010 01:01:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QoAavUabKCgOjsMKJSRYsHvilMw=; b=eUk7Du
	dmA0fzh2VPVuJ9hJjADzUiB5EHe4O+oCpPXEkDpdkd/O0X9rgb9Gy8W8r7URoQ5a
	nFzGWXuGmRUEhnBIC8LWq691Ps3haAD4vA+LrNtqD9lwbAx+db9Wm+vSdPy2QnWr
	hAhTT9ojTXu76G7gpR6k4ZXriEam5CSlCZpBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CY5kECewttAGsV1bmlG7vILI8Vw78fy7
	qOQNj7tRSzX1wnJwmzBaXpmJrA9Caa76BkYaDDkC+oeN0AyzMY/W0ZlVJAVipIcK
	Adh2cvRLF5S1xMl6IbYEDby3X+ANl1k97ZCFpDKjfoJXAv0WvX939tJpGfh4BZO5
	+0vswhSk4L4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE1A7E0DFC;
	Fri, 22 Oct 2010 01:01:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EA4DE0DFA; Fri, 22 Oct
 2010 01:01:22 -0400 (EDT)
In-Reply-To: <1287699122-26702-1-git-send-email-fedux@lugmen.org.ar>
 (Federico Cuello's message of "Thu\, 21 Oct 2010 19\:12\:02 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B9B292C-DD99-11DF-870A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159640>

Federico Cuello <fedux@lugmen.org.ar> writes:

> Fix the case when the patch is a rename or mode-change only
> and -p is used with a value greater than one.
> The git_header_name function did not remove more than one path
> component.
>
> Signed-off-by: Federico Cuello <fedux@lugmen.org.ar>

Thanks.

It is customary to protect your fix with additional test script so that
you do not have to be constantly monitoring the mailing list traffic to
make sure somebody else will not break your changes.

Perhaps something like this?  Note that I didn't run the test myself,
though (for that matter, I haven't applied your patch to see if it
compiles, yet).



 t/t4120-apply-popt.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index 2b2d00b..579c9e6 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -56,4 +56,30 @@ test_expect_success 'apply with too large -p and fancy filename' '
 	grep "removing 3 leading" err
 '
 
+test_expect_success 'apply (-p2) diff, mode change only' '
+	cat >patch.chmod <<-\EOF &&
+	diff --git a/sub/file1 b/sub/file1
+	old mode 100644
+	new mode 100755
+	EOF
+	chmod 644 file1 &&
+	git apply -p2 patch.chmod &&
+	test -x file1
+'
+
+test_expect_success 'apply (-p2) diff, rename' '
+	cat >patch.rename <<-\EOF &&
+	diff --git a/sub/file1 b/sub/file2
+	similarity index 100%
+	rename from sub/file1
+	rename to sub/file2
+	EOF
+	echo A >expected &&
+
+	cp file1.saved file1 &&
+	rm -f file2 &&
+	git apply -p2 patch.rename &&
+	test_cmp expected file2
+'
+
 test_done
