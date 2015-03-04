From: Anton Trunov <anton.a.trunov@gmail.com>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Wed, 04 Mar 2015 12:59:02 +0300
Message-ID: <54F6D766.3070607@gmail.com>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com> <54F616DD.8040904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: charles@hashpling.org, Johannes.Schindelin@gmx.de
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 10:58:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT64S-0000BC-Tq
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 10:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758942AbbCDJ6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 04:58:23 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:43288 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758932AbbCDJ6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 04:58:21 -0500
Received: by labgf13 with SMTP id gf13so18762804lab.10
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 01:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4cA5+RRyJVr+LLbUnhPFpvHNJE7MFpoQJ5Z60SMbAAw=;
        b=WqgdaCGYgRqLjkIuCbkNYC8Q/lH+tzinibt6Y+6ZTJTSnpK6GRR4Fd3p7pDZiX0cqe
         I8bMnxBTxGKxlL0X3Pd7BBGbLJzM7psHm1iXZzgIlK49mZK4liM3/Bx8pGlncF6DIVEo
         2/A5E7QM0LUwENAx7e7M/68aWfP+cenQIb3jr6hQKM3GWPIiSz7YioM3L8wXXK8SnVCo
         Y4Ap4prlKNZtGdpWxwIYaUYIc3S60541wwTk28/c4hdQHwvWnQqlaAPNEAWEStue1BBd
         7bEc2rsc9Aoc1lM7Q9rzJytddm2tnX7BUZd5k15mj+UQxnxn5VsFYEBn3U7pJ59gCZx0
         p2zA==
X-Received: by 10.152.19.228 with SMTP id i4mr2599382lae.77.1425463099806;
        Wed, 04 Mar 2015 01:58:19 -0800 (PST)
Received: from [192.168.1.185] ([195.191.146.16])
        by mx.google.com with ESMTPSA id rv1sm671951lbb.25.2015.03.04.01.58.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2015 01:58:19 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <54F616DD.8040904@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264743>

On 03/03/15 23:17, Torsten B=F6gershausen wrote:
> On 2015-03-03 18.37, Anton Trunov wrote:
> []
>> Signed-off-by: Anton Trunov <anton.a.trunov <at> gmail.com>
> Should we use the "real email" here (with the '@') ?

Didn't realize the parser for the web version mangles emails.
Will use the "real email".

>> ---
>>  t/t3032-merge-recursive-options.sh | 43 +++++++++++++++++++++++++++=
+++++++++++
>>  xdiff/xmerge.c                     | 10 ++++-----
>>  2 files changed, 48 insertions(+), 5 deletions(-)
>>
>> diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recu=
rsive-options.sh
>> index 4029c9c..4cbedb4 100755
>> --- a/t/t3032-merge-recursive-options.sh
>> +++ b/t/t3032-merge-recursive-options.sh
>> @@ -204,4 +204,47 @@ test_expect_success '--ignore-space-at-eol' '
>>  	test_cmp expected actual
>>  '
>> =20
>> +# Setup for automerging with whitespace-only changes
>> +# on both sides and in *all* lines
>> +
>> +test_expect_success 'setup: w/s only changes in all lines on both s=
ides' '
>> +	git rm -rf . &&
>> +	git clean -fdqx &&
>> +	rm -rf .git &&
>> +	git init
> missing &&

Nice catch! Thank you.

>> +
>> +	echo " two words" >text.txt &&
>> +	git add text.txt &&
>> +	test_tick &&
>> +	git commit -m "Initial revision" &&
>> +
>> +	git checkout -b remote &&
>> +	echo " \t\ttwo     words  " >text.txt &&
>> +	git commit -a -m "remote: insert whitespace only" &&
>> +
>> +	git checkout master &&
>> +	echo "    two words" >text.txt &&
>> +	git commit -a -m "master: insert whitespace only"
>> +'
>> +
>> +test_expect_success 'w/s only in all lines: --ignore-space-change p=
reserves ours' '
> []
>=20
