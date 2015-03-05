From: Anton Trunov <anton.a.trunov@gmail.com>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Thu, 05 Mar 2015 12:50:22 +0300
Message-ID: <54F826DE.6010506@gmail.com>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>	<xmqqzj7takks.fsf@gitster.dls.corp.google.com>	<54F6D3B0.60600@gmail.com> <xmqqfv9k8rcs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, tboegi@web.de,
	sunshine@sunshineco.com, charles@hashpling.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 10:49:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTSPX-0007NM-ON
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 10:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbbCEJti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 04:49:38 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:44141 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbbCEJtg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 04:49:36 -0500
Received: by lbiv13 with SMTP id v13so31323899lbi.11
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 01:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3sxC1W9/sWo8jJ+4BhVACmlKUF5MqZcSyrYa5yT5kAQ=;
        b=BfBGKPsiD3yzyEokJk11+ew1jah8OZj5Xtp28C+fsnCBPqhqp1bEbW3hRDTv/HB7cp
         ZS8zMc9UudObdW4AwA6U9sTVZpJuNvE2nN3iW7B47st4hHJ7ZyfWjmlIPmN5s7GYUMJE
         WB0M3LT50a8gff1eFtmEzVLu7Qfy/HrYXZPMSNo5xzboJxLD9D0u1YG7gG0bktWZboLb
         wmQj1OoPLsUIrqM+G4rdKwgoOiZcpQJpuhV7hsbpjCw4jgSnm/ZPHOS1/QpjUsmBfKpR
         YINsiIj9/dzSBegYppEMva+ZiSCpdSks2Dlc0ejkYLiwfOF67VGW8D7VuS9AB9KZto21
         PyfQ==
X-Received: by 10.152.183.165 with SMTP id en5mr7371838lac.0.1425548975272;
        Thu, 05 Mar 2015 01:49:35 -0800 (PST)
Received: from [192.168.1.185] ([195.191.146.16])
        by mx.google.com with ESMTPSA id j9sm1194151lbp.7.2015.03.05.01.49.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 01:49:34 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqfv9k8rcs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264820>

On 04/03/15 23:01, Junio C Hamano wrote:
> Anton Trunov <anton.a.trunov@gmail.com> writes:
> 
>> For the code version before applying this patch the following scenario
>> will take place if "git merge -Xignore-all-space remote" gets executed.
>>
>> base file:
>> 1st line
>> 2nd line
>>
>> master file:
>>   1st line
>>   2nd line with substantial change
>>
>> remote file:
>>               1st line
>>               2nd line
>>
>> merge result file:
>>   1st line
>>   2nd line with substantial change
>>
>> So essentially it does what "git merge -s ours remote" does in case if
>> all their changes are trivial.
>> This seems like reasonable solution to me: we _are_ trying to ignore
>> whitespace changes and we are explicit about it.
> 
> Now, the above makes readers wonder what happens when you merged
> master into the remote.  I.e. in the opposite direction.
> 
Interesting observation.
I'd like to point out that the patch doesn't change the way this merge
works.

But let us discuss it with the help of git log.

The function xdl_merge() was introduced to the code base in commit
857b933e04bc21ce02043c3107c148f8dcbb4a01.

As it was pointed out in 1cd12926cedb340d176db607e087495381032ce2
(t6023: merge-file fails to output anything for a degenerate merge) the
merge-file command would just refuse to merge identical changes and
produce output.

Then in 5719db91ce5915ee07c50f1afdc94fe34e91529f (Change xdl_merge to
generate output even for null merges) this was fixed.

Let's return to the issue you've mentioned.
According to the manual the merge result file should be:
               1st line                     <- our line
   2nd line with substantial change         <- their line

The problem with the current code that it doesn't work line-wise when at
least one side has only whitespace changes. It just completely throws
away a side without any changes and takes the other side.

If we wanted to fix it then I'd suggest to completely remove the checks
for null changes in xdl_merge() because xdl_do_merge() handles those.
