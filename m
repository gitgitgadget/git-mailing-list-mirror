From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] do not read beyond end of malloc'd buffer
Date: Fri, 20 May 2011 11:41:06 -0700
Message-ID: <7vfwo92p19.fsf@alter.siamese.dyndns.org>
References: <877h9lb86r.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri May 20 20:41:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNUdT-0004Hp-5S
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 20:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934501Ab1ETSlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 14:41:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933901Ab1ETSlN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 14:41:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D42AA403E;
	Fri, 20 May 2011 14:43:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q3l+43mF4wApJf9mGO6ZjOThehY=; b=QMS4yc
	gwhCNXhVaXT/yKmsRoke8IkUHEsXXqxMReTvyXPZZSUD/zCBVXALZEiUvV+mTRP2
	AVsTAP282OhzovIX+3iTtLpyLrzW6yM/d2GMJU4mzYjM1kc5IAjWFiCeWhscbJfK
	XcNpfJ5XMBdBz4a+F1KG0Ne+DBfvL9vt00BuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kiTEoecG3WFB30VTvc8WNyNEtd/MnR7O
	rm9SLt+7+141a8UgYln1N0nzbQMPLcW+rCcSLB61WeNz+C9qFKZ4dUuX6aD7kLyb
	e21Uc3fpjTnCkXLGxInj4f1VsT3fBHdNCSqJ4yKTlfRT60UzWBBSvsjf4iXvzIN2
	Q3PouPTOW0g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B109A403D;
	Fri, 20 May 2011 14:43:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B703E4038; Fri, 20 May 2011
 14:43:15 -0400 (EDT)
In-Reply-To: <877h9lb86r.fsf@rho.meyering.net> (Jim Meyering's message of
 "Fri, 20 May 2011 19:20:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 079A4804-8311-11E0-B99B-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174074>

Jim Meyering <jim@meyering.net> writes:

> I was surprised to see "git diff --word-diff" output a ton of
> garbage, and tracked it down to a bug that's triggered when the
> diff.suppress-blank-empty config option to true and when at least
> one of the context lines is empty.

Heh, I am not that surprised ;-) 

I think the real culprit is a year-old 882749a (diff: add --word-diff
option that generalizes --color-words, 2010-04-14); it probably shows that
not many people use diff.s-b-e settings?

>     printf 'a\n\n[-b-]{+c+}\n' > exp
>     git init && git config diff.suppress-blank-empty true
>     printf 'a\n\nb\n' > f && git add . && git commit -m. .
>     printf 'a\n\nc\n' > f
>     git diff --word-diff | tail -3 > out
>     diff out exp
>
> Before the patch, the git diff ... command would read from beyond
> the end of a heap buffer, and "out" would contain far more than the
> expected 5 bytes.

It is a bit unfortunate that we cannot make this into a test script, as it
depends on what is on the uninitialized part of the heap, which might
happen to be a NUL in which case the test would pass.

Running tests under the valgrind mode may catch issues, though.

Thanks. Will queue with this test squashed in.

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 37aeab0..c374aa4 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -307,4 +307,30 @@ test_language_driver python
 test_language_driver ruby
 test_language_driver tex
 
+test_expect_success 'word-diff with diff.sbe' '
+	cat >expect <<-\EOF &&
+	diff --git a/pre b/post
+	index a1a53b5..bc8fe6d 100644
+	--- a/pre
+	+++ b/post
+	@@ -1,3 +1,3 @@
+	a
+
+	[-b-]{+c+}
+	EOF
+	cat >pre <<-\EOF &&
+	a
+
+	b
+	EOF
+	cat >post <<-\EOF &&
+	a
+
+	c
+	EOF
+	test_when_finished "git config --unset diff.suppress-blank-empty" &&
+	git config diff.suppress-blank-empty true &&
+	word_diff --word-diff=plain
+'
+
 test_done
