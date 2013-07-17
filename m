From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3032 - make compatible with systems using \r\n as a line ending
Date: Wed, 17 Jul 2013 12:33:19 -0700
Message-ID: <7vtxjt56dc.fsf@alter.siamese.dyndns.org>
References: <20130716185933.GO14690@google.com>
	<1374006769-1878-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 21:33:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzXTb-0002XY-9t
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 21:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956Ab3GQTdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 15:33:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63460 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755505Ab3GQTdW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 15:33:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D364C31349;
	Wed, 17 Jul 2013 19:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ik4ZkGXEp15Jc+qiOvvifZEl3Kc=; b=sER3fC
	hSdAqqbvZqrScUZw0XM0rtkbIO1cuh+isajkC2J3r9KQkECRiRwztj08GtR1ubtf
	ma4WvSWKIN2F7S/yug0o9Rx7igBUhh8yZo5gJqG0IGO1JTyTW2geJ9PI8NDmkHog
	LxIVlYz6317yyad3X12wPOdb8zdkxv9JhOrEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JCyksf8kNLIvZ0g+xPVfjHTmiakkp5NO
	fnGG0czs2pNZnmIodtp/VK2Q0IquHZXAnqMKijzSctsT6PUuGkVPg0yUs4nH5fzL
	8tgAqStsBtRouJj59eXE8DfAxaQ/cjlMeBl7pmAG0XW+JZ1kNQYlV3RffPVSOdfC
	c6mH79waoew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C666D31348;
	Wed, 17 Jul 2013 19:33:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB5CD31344;
	Wed, 17 Jul 2013 19:33:20 +0000 (UTC)
In-Reply-To: <1374006769-1878-1-git-send-email-mlevedahl@gmail.com> (Mark
	Levedahl's message of "Tue, 16 Jul 2013 16:32:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD0F89AA-EF17-11E2-AAC7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230643>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Subtests 6, 7, and 9 rely test that merge-recursive correctly
> ignores whitespace when so directed. These tests create and test for
> lines ending in \r\n, but as this is a valid line separator on Windows,
> convert such lines in the output to avoid confusion by line-oriented
> grep.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
> Sorry, forgot to copy Jonathan...

Sounds sensible.  Thanks.

>
>  t/t3032-merge-recursive-options.sh | 22 +++++++++++++---------
>  t/test-lib-functions.sh            |  4 ++++
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
> index 2b17311..41ba184 100755
> --- a/t/t3032-merge-recursive-options.sh
> +++ b/t/t3032-merge-recursive-options.sh
> @@ -125,13 +125,14 @@ test_expect_success '-Xignore-space-change makes cherry-pick succeed' '
>  '
>  
>  test_expect_success '--ignore-space-change: our w/s-only change wins' '
> -	q_to_cr <<-\EOF >expected &&
> +	cat <<-\EOF >expected &&
>  	    justice and holiness and is the nurse of his age and theQ
>  	EOF
>  
>  	git read-tree --reset -u HEAD &&
>  	git merge-recursive --ignore-space-change HEAD^ -- HEAD remote &&
> -	grep "justice and holiness" text.txt >actual &&
> +	cr_to_q <text.txt > text.txt+ &&
> +	grep "justice and holiness" text.txt+ >actual &&
>  	test_cmp expected actual
>  '
>  
> @@ -150,14 +151,15 @@ test_expect_success '--ignore-space-change: does not ignore new spaces' '
>  	cat <<-\EOF >expected1 &&
>  	Well said, Cephalus, I replied; but as con cerning justice, what is
>  	EOF
> -	q_to_cr <<-\EOF >expected2 &&
> +	cat <<-\EOF >expected2 &&
>  	un intentionally; and when he departs to the world below he is not inQ
>  	EOF
>  
>  	git read-tree --reset -u HEAD &&
>  	git merge-recursive --ignore-space-change HEAD^ -- HEAD remote &&
> -	grep "Well said" text.txt >actual1 &&
> -	grep "when he departs" text.txt >actual2 &&
> +	cr_to_q <text.txt >text.txt+
> +	grep "Well said" text.txt+ >actual1 &&
> +	grep "when he departs" text.txt+ >actual2 &&
>  	test_cmp expected1 actual1 &&
>  	test_cmp expected2 actual2
>  '
> @@ -174,18 +176,19 @@ test_expect_success '--ignore-all-space drops their new spaces' '
>  '
>  
>  test_expect_success '--ignore-all-space keeps our new spaces' '
> -	q_to_cr <<-\EOF >expected &&
> +	cat <<-\EOF >expected &&
>  	un intentionally; and when he departs to the world below he is not inQ
>  	EOF
>  
>  	git read-tree --reset -u HEAD &&
>  	git merge-recursive --ignore-all-space HEAD^ -- HEAD remote &&
> -	grep "when he departs" text.txt >actual &&
> +	cr_to_q <text.txt >text.txt+ &&
> +	grep "when he departs" text.txt+ >actual &&
>  	test_cmp expected actual
>  '
>  
>  test_expect_success '--ignore-space-at-eol' '
> -	q_to_cr <<-\EOF >expected &&
> +	cat <<-\EOF >expected &&
>  	<<<<<<< HEAD
>  	is not in his right mind; ought I to give them back to him?  No oneQ
>  	=======
> @@ -196,7 +199,8 @@ test_expect_success '--ignore-space-at-eol' '
>  	git read-tree --reset -u HEAD &&
>  	test_must_fail git merge-recursive --ignore-space-at-eol \
>  						 HEAD^ -- HEAD remote &&
> -	conflict_hunks text.txt >actual &&
> +	cr_to_q <text.txt >text.txt+ &&
> +	conflict_hunks text.txt+ >actual &&
>  	test_cmp expected actual
>  '
>  
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index a7e9aac..aa8e38f 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -87,6 +87,10 @@ q_to_cr () {
>  	tr Q '\015'
>  }
>  
> +cr_to_q () {
> +	tr '\015' Q
> +}
> +
>  q_to_tab () {
>  	tr Q '\011'
>  }
