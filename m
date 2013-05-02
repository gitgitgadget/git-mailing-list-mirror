From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack: ignore 'shallow' lines with unknown obj-ids
Date: Thu, 02 May 2013 10:05:13 -0700
Message-ID: <7vehdp1fee.fsf@alter.siamese.dyndns.org>
References: <1367506567-36828-1-git-send-email-mheemskerk@atlassian.com>
	<7vk3nh1fwx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Heemskerk <mheemskerk@atlassian.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:05:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXwwe-000244-6o
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759155Ab3EBRFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:05:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757568Ab3EBRFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:05:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B41519AE4;
	Thu,  2 May 2013 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BYob8LVsoKPswwzg+a4R3jz8d5U=; b=DXnFlu
	TZbhQ/GAf1xaONaf96w2qU9ASCOWONmp5gbFZy/KH5Fv8zUPgHqikXJ91sTrTVc/
	ctGRXBKnhwPtdUgPW/Pe0Hh6omaAiKDva/hfKj9EQpJ6QOp0P88Bl5ehwv1oe8lr
	QGsnOizdF4/nKOy5EDnntvYRyBd++fGCWUlm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BRBC23sfHjd/irdp/v/+F4eK9evRw3Vj
	Rv06PTsO8ERYTWaKWqrF9U9zleOEwoBmt6+EcuWbhb4SM/9RXSPX98ZFwG2DbmO3
	lqJEkT6eFz/TocMcqMh+RXMKv6vg7YVQczwfpQbnF6q7HfkECSsNEZp5F7qhuxhu
	mLsPCcrozxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50E4419AE3;
	Thu,  2 May 2013 17:05:15 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A82FC19AE2;
	Thu,  2 May 2013 17:05:14 +0000 (UTC)
In-Reply-To: <7vk3nh1fwx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 02 May 2013 09:54:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7508637E-B34A-11E2-B00D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223226>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Heemskerk <mheemskerk@atlassian.com> writes:
>
>> When the client sends a 'shallow' line for an object that the server does
>> not have, the server currently dies with the error: "did not find object
>> ...
>>  Documentation/technical/pack-protocol.txt |  3 +--
>>  t/t5500-fetch-pack.sh                     | 13 +++++++++++++
>>  upload-pack.c                             |  2 +-
>>  3 files changed, 15 insertions(+), 3 deletions(-)
>
> Thanks.
>
> The previous one (without the test) is already in 'next' so I'll
> pick only the test part and queue it as an update to the series.
>
>> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
>> index d574085..3f0ca10 100755
>> --- a/t/t5500-fetch-pack.sh
>> +++ b/t/t5500-fetch-pack.sh
>> @@ -373,6 +373,19 @@ test_expect_success 'clone shallow with packed refs' '
>>  	test_cmp count8.expected count8.actual
>>  '
>>  
>> +test_expect_success 'fetch in shallow repo unreachable shallow objects' '
>> +	(
>> +		git clone --bare --branch B --single-branch "file://$(pwd)/." no-reflog &&
>> +		git clone --depth 1 "file://$(pwd)/no-reflog" shallow9 &&
>> +		cd no-reflog &&
>> +		git tag -d TAGB1 TAGB2 &&
>> +		git update-ref refs/heads/B B~~ &&
>> +		git gc --prune=now &&
>> +		cd ../shallow9 &&
>> +		git fetch origin
>> +	)
>> +'

It would also be good to make sure that shallow9 does not lose the
shallow history boundary that the origin does not know about after
this fetch, so I'll further squash this in.

 t/t5500-fetch-pack.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 3f0ca10..6133d9e 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -382,7 +382,8 @@ test_expect_success 'fetch in shallow repo unreachable shallow objects' '
 		git update-ref refs/heads/B B~~ &&
 		git gc --prune=now &&
 		cd ../shallow9 &&
-		git fetch origin
+		git fetch origin &&
+		git fsck --no-dangling
 	)
 '
 
