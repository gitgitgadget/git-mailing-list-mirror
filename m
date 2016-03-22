From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Make t1300-repo-config resilient to being run via 'sh -x'
Date: Tue, 22 Mar 2016 13:34:13 -0700
Message-ID: <xmqqfuvigsl6.fsf@gitster.mtv.corp.google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
	<b4df45088aa68d8410895f66a814dd6780e2e451.1458668543.git.johannes.schindelin@gmx.de>
	<20160322175948.GG28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 21:34:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiT0O-0002GH-S1
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 21:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbcCVUeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 16:34:17 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751041AbcCVUeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 16:34:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 524314E9D1;
	Tue, 22 Mar 2016 16:34:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2b4IPAfBie3Tv0oeYajV6kz2DTo=; b=AMHehs
	6kzquzRxdavS7xovzccNxZBJIhnq8yo7HeIGrCKVzbHzHCcZWNBrjWkp4YwJeiaY
	/5fF6AaN5rvl5wsavMnowifEqyTHW11uZRyDc91ekaJOPhTICzIsEM84+rWjQCaX
	TTryZnE3vChndaUT33eQzWKTVvlTX5yYAWjKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kJZXNvlfTiDRJ98bgRjr9o0lUWpAc66E
	2H4aYwXAjYYKxV2eOWoRrBcWDavh86UtddvBtu9Mqcg+K1yLzZ7tEYCb1WC0+aB0
	lqOVkTuaU6HSP17kP5VJM4nn7dcUIk4GpGDXMks6S1VLVY0q1m8Jrql/BmXnZN8p
	1GjUAnCo9rA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 497E64E9D0;
	Tue, 22 Mar 2016 16:34:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ACE3D4E9CF;
	Tue, 22 Mar 2016 16:34:14 -0400 (EDT)
In-Reply-To: <20160322175948.GG28749@google.com> (Jonathan Nieder's message of
	"Tue, 22 Mar 2016 10:59:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 71511B82-F06D-11E5-B0E3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289556>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Johannes Schindelin wrote:
>
>> --- a/t/t1300-repo-config.sh
>> +++ b/t/t1300-repo-config.sh
>> @@ -699,17 +699,13 @@ test_expect_success 'invalid unit' '
>>  	echo 1auto >expect &&
>>  	git config aninvalid.unit >actual &&
>>  	test_cmp expect actual &&
>> -	cat >expect <<-\EOF &&
>> -	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'' in file .git/config: invalid unit
>> -	EOF
>>  	test_must_fail git config --int --get aninvalid.unit 2>actual &&
>> -	test_i18ncmp expect actual
>> +	grep "^fatal: bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit$" actual
>
> Would test_i18ngrep work?
>
>>  '
>>  
>>  test_expect_success 'invalid stdin config' '
>> -	echo "fatal: bad config line 1 in standard input " >expect &&
>>  	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
>> -	test_cmp expect output
>> +	grep "^fatal: bad config line 1 in standard input $" output
>
> This test is very strange.  Why do we care that it starts with
> "fatal:" as opposed to error?  Why are we testing for an extra space at
> the end of the line?
>
> I would expect something like
>
> 	test_i18ngrep 'line 1 in standard input' output
>
> to be more useful for testing the useful part of the error message while
> remaining resilient against error message changes.

Both sounds sensible.  Should we squash this in, then?

 t/t1300-repo-config.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 0236fe2..dca27a3 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -700,12 +700,12 @@ test_expect_success 'invalid unit' '
 	git config aninvalid.unit >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config --int --get aninvalid.unit 2>actual &&
-	grep "^fatal: bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit$" actual
+	test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit" actual
 '
 
 test_expect_success 'invalid stdin config' '
 	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
-	grep "^fatal: bad config line 1 in standard input $" output
+	test_i18ngrep "bad config line 1 in standard input" output
 '
 
 cat > expect << EOF
