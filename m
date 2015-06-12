From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 01/12] for-each-ref: extract helper functions out of
 grab_single_ref()
Date: Fri, 12 Jun 2015 23:02:59 +0530
Message-ID: <557B17CB.70001@gmail.com>
References: <5579B253.4020804@gmail.com>
 <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
 <xmqq616sesw7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 19:33:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3SpL-0004Xs-FQ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 19:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbbFLRdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 13:33:07 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32807 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbFLRdF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 13:33:05 -0400
Received: by pablj1 with SMTP id lj1so7788340pab.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=guoGZdZyvY6bfKh/pV6Yq82skJd6uVTSA3PdC1lmmr0=;
        b=PBnl05tsvMgZDhglOJmGqMQrYDeMJijFNiA24WmWAiGuFnmjVnQZhtJ6yyiZ2kvPWr
         To4w8Nq7QYQlgzShKhz+jCocT21aK2RGT0KeT2vKD4bB0rgCuhdd2QVBJwbBAfL33oK5
         2tVUivzi5TBhN/TBE332PKbvLalAawZv8dnHuHUMTpyXtM0ZGCLFaLhdh9AQWl6cyBbA
         X3vK72jCZAATC3ADIR0+WWNdpNVmnDwoguLLdpOAb1PqSmUw72Gt6stsuxjYXl+KUBBM
         4OWpmYSz0R2iHDh48uDw3Qr4RyAqtJk7KboTb/DTG3bwqIDPXz/h9FmLqgb1n3kFA+Eg
         4xEQ==
X-Received: by 10.70.109.199 with SMTP id hu7mr25202087pdb.71.1434130385384;
        Fri, 12 Jun 2015 10:33:05 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id d6sm4226111pdp.88.2015.06.12.10.33.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2015 10:33:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <xmqq616sesw7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271502>

On 06/12/2015 11:00 PM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Extract two helper functions out of grab_single_ref(). Firstly,
>> new_refinfo() which is used to allocate memory for a new refinfo
>> structure and copy the objectname, refname and flag to it.
>> Secondly, match_name_as_path() which when given an array of patterns
>> and the refname checks if the refname matches any of the patterns
>> given while the pattern is a pathname, also supports wildcard
>> characters.
>>
>> This is a preperatory patch for restructuring 'for-each-ref' and
>> eventually moving most of it to 'ref-filter' to provide the
>> functionality to similar commands via public API's.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>   builtin/for-each-ref.c | 64 ++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 41 insertions(+), 23 deletions(-)
>>
>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index f7e51a7..67c8b62 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -851,6 +851,44 @@ struct grab_ref_cbdata {
>>   };
>>
>>   /*
>> + * Return 1 if the refname matches with one of the patterns,
>
> s/with //;

Thanks! will change :)

>
>> + * otherwise 0.  The patterns can be literal prefix (e.g. a
>> + * refname "refs/heads/master" matches a pattern "refs/heads/")
>> + * or a wildcard (e.g. the same ref matches "refs/heads/m*",too).
>> + */
>
> I know this was my bad suggestion, but "refs/heads/m" can be thought
> of as a "literal prefix" that may match "refs/heads/master"; we do
> not want to make that match, so perhaps "literal" is a bad way to
> say this.  "A pattern can be a path prefix or a worldcard"?
>

Yes! that sounds right, after all its doing a path match.

-- 
Regards,
Karthik
