From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] test-lib.sh: support -x option for shell-tracing
Date: Mon, 13 Oct 2014 15:22:50 -0700
Message-ID: <xmqqh9z71uf9.fsf@gitster.dls.corp.google.com>
References: <20141010062722.GB17481@peff.net>
	<20141010064727.GC17481@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 14 00:22:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdo13-0000e6-AW
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 00:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbaJMWWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 18:22:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753241AbaJMWWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 18:22:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EB2915233;
	Mon, 13 Oct 2014 18:22:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pp/0Bz386744WJyeSe14Dl/FbxE=; b=v4rZXC
	8Dtvs7mZY4Rrqpz2BbKsQ+xkxnufMOALV4dN0XAK35k2EyfeECo522datxV3W4D1
	GuuLS3/fiF7ZhWAKw6PNAuSw7mUHo6rb4s/6yHm4JZvk1LzS2JIJ3ckB9e/dCOjx
	ogRkrA3DkGUhOtvRIAK1J++ghd3HCCOeYd4dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L1PZjJFF43E+1DkyTKxkvRAgGjn4JYzr
	SgMb1ATzxqUGGlJ1/HvLlJX1f1dNeYkuV/7k23v3RgpztRXwWhN64Ws2mm9O7R10
	3tpK3e0hgVfoFvQ+0fLjIaRw+oZ3DFF1tm5T3eIVw3jLHJLClLOkrW5UxhILLABx
	GQnY4eA89uM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05D2315232;
	Mon, 13 Oct 2014 18:22:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EF9415231;
	Mon, 13 Oct 2014 18:22:51 -0400 (EDT)
In-Reply-To: <20141010064727.GC17481@peff.net> (Jeff King's message of "Fri,
	10 Oct 2014 02:47:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7850054A-5327-11E4-AC2F-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 10, 2014 at 02:21:56AM -0400, Jeff King wrote:
>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index a60ec75..81ceb23 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -237,7 +237,11 @@ do
>>  		shift ;;
>>  	-x)
>>  		test_eval_start_='set -x'
>> -		test_eval_end_='set +x'
>> +		test_eval_end_='
>> +			set +x
>> +			test "$test_eval_ret_" = 0 ||
>> +			  say_color error >&4 "last command exited with \$?=$?"
>
> That should be \$?=$test_eval_ret_, of course. The patch below fixes it.
>
> Rerolled patch is below. Sorry for all the emails. I'll stop looking at
> it now to give you guys a chance to find any remaining mistakes. ;)

Does 1308 pass with this patch for you (running it without "-x")?

The original that expects a hardcoded line number (not relative to
the original or something) is a bad taste, and also the test setup
procedure is broken (see below for a fix of that breakage, which
does not fix the breakage this patch seems to bring in anyway).

But still it is disturbing to see that there is a blank line
difference with and without this change in the file created by the
test (i.e. the client of the code this patch touches).

 t/t1308-config-set.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index ea0bce2..462bb64 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -23,7 +23,7 @@ check_config () {
 }
 
 test_expect_success 'setup default config' '
-	cat >.git/config <<\EOF
+	cat >.git/config <<-\EOF
 	[case]
 		penguin = very blue
 		Movie = BadPhysics
