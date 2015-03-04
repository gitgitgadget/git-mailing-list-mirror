From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Wed, 4 Mar 2015 02:07:21 -0500
Message-ID: <CAPig+cQSNLH2poz-gtrsTd5XWpUgDh6a9APfj3K7TC78trf6xA@mail.gmail.com>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>
	<54F616DD.8040904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anton Trunov <anton.a.trunov@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, charles@hashpling.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 04 08:07:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT3P1-0005OY-HU
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 08:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933639AbbCDHHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 02:07:24 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:43651 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650AbbCDHHX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 02:07:23 -0500
Received: by yhab6 with SMTP id b6so21107780yha.10
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 23:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=biNFE3vrUXApzTnnP7io0fPC+KuDQ6+Ee/ukl54R8ww=;
        b=0HRpRVgLi58zGoXVBAfhyKiI/LPXxh5Kw71tnKCGz6Yef1L+LWduNCMeDhzmTPaTdj
         /1NQvwRagGaNKu2ZBaCuPvInLAuvtFD15bcEnl4eCRCdfLh/w00Tb8ZYElg9fo/Cl5iO
         UcQoj3pn15g6S//qpEFssOX6zDDaZU20eIxu66SzSArwuOutGC1XVPrymFKkU1vHJIqC
         pwxYXmK2nHyC0S3H8LdIqUde2zID4pvEZEQbgrCWCquAonK23BZ2dYeB2YAtodw/T4y8
         ButthmnR/MQS5nJoX2vvRXT89vm3BXYFDekfIfEFPCBLXSBqQmfYl10cHsNYA+MBZm7f
         uG7A==
X-Received: by 10.170.190.69 with SMTP id h66mr2003445yke.51.1425452841845;
 Tue, 03 Mar 2015 23:07:21 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 3 Mar 2015 23:07:21 -0800 (PST)
In-Reply-To: <54F616DD.8040904@web.de>
X-Google-Sender-Auth: oh_oOzZm5Q7Zhlw5jUHPO6i9YeM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264722>

On Tue, Mar 3, 2015 at 3:17 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 2015-03-03 18.37, Anton Trunov wrote:
> []
>> Signed-off-by: Anton Trunov <anton.a.trunov <at> gmail.com>
> Should we use the "real email" here (with the '@') ?
>> ---
>> diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recu=
rsive-options.sh
>> index 4029c9c..4cbedb4 100755
>> --- a/t/t3032-merge-recursive-options.sh
>> +++ b/t/t3032-merge-recursive-options.sh
>> @@ -204,4 +204,47 @@ test_expect_success '--ignore-space-at-eol' '
>>       test_cmp expected actual
>>  '
>>
>> +# Setup for automerging with whitespace-only changes
>> +# on both sides and in *all* lines
>> +
>> +test_expect_success 'setup: w/s only changes in all lines on both s=
ides' '
>> +     git rm -rf . &&
>> +     git clean -fdqx &&
>> +     rm -rf .git &&
>> +     git init
> missing &&
>> +
>> +     echo " two words" >text.txt &&
>> +     git add text.txt &&
>> +     test_tick &&
>> +     git commit -m "Initial revision" &&
>> +
>> +     git checkout -b remote &&
>> +     echo " \t\ttwo     words  " >text.txt &&

Use of echo "\t" is not portable. Either embed literal tab characters
or use printf "\t".

>> +     git commit -a -m "remote: insert whitespace only" &&
>> +
>> +     git checkout master &&
>> +     echo "    two words" >text.txt &&
>> +     git commit -a -m "master: insert whitespace only"
>> +'
>> +
>> +test_expect_success 'w/s only in all lines: --ignore-space-change p=
reserves ours' '
