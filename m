From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-ref: make --head always show the HEAD ref
Date: Mon, 15 Jul 2013 09:37:51 -0700
Message-ID: <7vtxjvbwyo.fsf@alter.siamese.dyndns.org>
References: <7v38rlt88j.fsf@alter.siamese.dyndns.org>
	<1373680988-72804-1-git-send-email-madcityzen@gmail.com>
	<1373680988-72804-2-git-send-email-madcityzen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Doug Bell <madcityzen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 18:38:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uylmm-0005kt-1d
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 18:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933401Ab3GOQh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 12:37:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933394Ab3GOQhz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 12:37:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1149931570;
	Mon, 15 Jul 2013 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KGihk1vulSzb7UicnldNSWEYl+Y=; b=UQ7Tkq
	EJZknq8IqSs+UKNUv+us0zKY2/PyAblxweES+gWOVVA9kwZXpkyU+mxxg9E0BMAC
	cX22Zv9/mSKnL9+pvPuxYHLihwSFwMXTTgTlxZQZDANP++llZEiWsMWWcBwORpO6
	Gq5LysQbaNyXaxzCdB91gfOYu7Msx4jvU3Kks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q5va7s/uUu1El1t2Xv7a7NqEuR9DTpUB
	5nT7x3SoJC1lvTwknoEhfTBhrOn3v/es+sSElPnct5A2jAUrvgghCu9RILcCXNY7
	iKpiVdyqgBejTtbWFhnoslJD887GRFhKMGU+T5AoJbk2IvdhNF2hkc0/DQf3WUi8
	/GK78R27pZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 056AF3156E;
	Mon, 15 Jul 2013 16:37:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08F523156D;
	Mon, 15 Jul 2013 16:37:52 +0000 (UTC)
In-Reply-To: <1373680988-72804-2-git-send-email-madcityzen@gmail.com> (Doug
	Bell's message of "Fri, 12 Jul 2013 21:03:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5198A92-ED6C-11E2-BD5C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230486>

Doug Bell <madcityzen@gmail.com> writes:

> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index 4a0310d..4b069e7 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -31,6 +31,9 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
>  	const char *hex;
>  	unsigned char peeled[20];
>  
> +	if (show_head && !strncmp(refname, "HEAD\0", 5))
> +		goto match;
> +
>  	if (tags_only || heads_only) {
>  		int match;

I think !strcmp(refname, "HEAD") is better up there.

Also we would want some basic test, which so far seems to be lacking
for the command.

How about this squashed in?

 builtin/show-ref.c   |   2 +-
 t/t1403-show-ref.txt | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 497ad66..099c2a4 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -31,7 +31,7 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	const char *hex;
 	unsigned char peeled[20];
 
-	if (show_head && !strncmp(refname, "HEAD\0", 5))
+	if (show_head && !strcmp(refname, "HEAD"))
 		goto match;
 
 	if (tags_only || heads_only) {
diff --git a/t/t1403-show-ref.txt b/t/t1403-show-ref.txt
new file mode 100755
index 0000000..3e500ed
--- /dev/null
+++ b/t/t1403-show-ref.txt
@@ -0,0 +1,167 @@
+#!/bin/sh
+
+test_description='show-ref'
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit A &&
+	git tag -f -a -m "annotated A" A &&
+	git checkout -b side &&
+	test_commit B &&
+	git tag -f -a -m "annotated B" B &&
+	git checkout master &&
+	test_commit C &&
+	git branch B A^0
+'
+
+test_expect_success 'show-ref' '
+	echo $(git rev-parse refs/tags/A) refs/tags/A >expect &&
+
+	git show-ref A >actual &&
+	test_cmp expect actual &&
+
+	git show-ref tags/A >actual &&
+	test_cmp expect actual &&
+
+	git show-ref refs/tags/A >actual &&
+	test_cmp expect actual &&
+
+	>expect &&
+
+	test_must_fail git show-ref D >actual
+	test_cmp expect actual
+'
+
+test_expect_success 'show-ref -q' '
+	>expect &&
+
+	git show-ref -q A >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -q tags/A >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -q refs/tags/A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref -q D >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show-ref --verify' '
+	echo $(git rev-parse refs/tags/A) refs/tags/A >expect &&
+
+	git show-ref --verify refs/tags/A >actual &&
+	test_cmp expect actual &&
+
+	>expect &&
+
+	test_must_fail git show-ref --verify A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify tags/A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify D >actual
+	test_cmp expect actual
+'
+
+test_expect_success 'show-ref --verify -q' '
+	>expect &&
+
+	git show-ref --verify -q refs/tags/A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify -q A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify -q tags/A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify -q D >actual
+	test_cmp expect actual
+'
+
+test_expect_success 'show-ref -d' '
+	{
+		echo $(git rev-parse refs/tags/A) refs/tags/A &&
+		echo $(git rev-parse refs/tags/A^0) "refs/tags/A^{}"
+		echo $(git rev-parse refs/tags/C) refs/tags/C
+	} >expect &&
+	git show-ref -d A C >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -d tags/A tags/C >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -d refs/tags/A refs/tags/C >actual &&
+	test_cmp expect actual &&
+
+	echo $(git rev-parse refs/heads/master) refs/heads/master >expect &&
+	git show-ref -d master >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -d heads/master >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -d refs/heads/master >actual &&
+	test_cmp expect actual
+
+	git show-ref -d --verify refs/heads/master >actual &&
+	test_cmp expect actual
+
+	>expect &&
+
+	test_must_fail git show-ref -d --verify master >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref -d --verify heads/master >actual &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'show-ref --heads, --tags, --head, pattern' '
+	for branch in B master side
+	do
+		echo $(git rev-parse refs/heads/$branch) refs/heads/$branch
+	done >expect.heads &&
+	git show-ref --heads >actual &&
+	test_cmp expect.heads actual &&
+
+	for tag in A B C
+	do
+		echo $(git rev-parse refs/tags/$tag) refs/tags/$tag
+	done >expect.tags &&
+	git show-ref --tags >actual &&
+	test_cmp expect.tags actual &&
+
+	cat expect.heads expect.tags >expect &&
+	git show-ref --heads --tags >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo $(git rev-parse HEAD) HEAD &&
+		cat expect.heads expect.tags
+	} >expect &&
+	git show-ref --heads --tags --head >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo $(git rev-parse HEAD) HEAD &&
+		echo $(git rev-parse refs/heads/B) refs/heads/B
+		echo $(git rev-parse refs/tags/B) refs/tags/B
+	} >expect &&
+	git show-ref --head B >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo $(git rev-parse HEAD) HEAD &&
+		echo $(git rev-parse refs/heads/B) refs/heads/B
+		echo $(git rev-parse refs/tags/B) refs/tags/B
+		echo $(git rev-parse refs/tags/B^0) "refs/tags/B^{}"
+	} >expect &&
+	git show-ref --head -d B >actual &&
+	test_cmp expect actual
+'
+
+test_done
