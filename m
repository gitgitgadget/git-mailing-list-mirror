From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 3/9] for-each-ref: add '--points-at' option
Date: Tue, 09 Jun 2015 17:31:21 +0530
Message-ID: <5576D591.6030704@gmail.com>
References: <5573520A.90603@gmail.com>	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>	<1433621052-5588-3-git-send-email-karthik.188@gmail.com> <xmqqzj4a9fpn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 14:01:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2IDq-0003CO-Oo
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 14:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbbFIMBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 08:01:35 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34732 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbbFIMBd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 08:01:33 -0400
Received: by pdbki1 with SMTP id ki1so13676568pdb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EHi8nZL0OHidyqaHOmCm9f4nmxCF7SC1P+oHrF1F9/8=;
        b=v1navHbKuqum/CLOe4RPpZaBQKfa8uF/6RKx1YYaOVO9OEVExrxdqI/MBDcNb65H6n
         RqlLYy5MagZwNPcMP6XufxblEN6ThPNOCRJpTb3SW+ZjFO9JEBUus3BWr6lynIKKaKI7
         XpHk9WzniT7zEWTYXoA+fG7hOsVlHnFZrW0+gt762zPCdUmyJM/6cinoaG3kdjyhmFuY
         D6Zbe+hvxJK2AG6Tc6V6qU7/dZlBU1RSMYuvV+z2sVSy59RZqGVvGYkkt+wUUolC4QxH
         8c5rkfPM7A9HDBjuTG0hEzn8rEGAkpNdZRcuH8rG6Hh+grsJosDqs/D5tJkoFxoCwhF5
         WYDw==
X-Received: by 10.68.103.164 with SMTP id fx4mr38424526pbb.125.1433851292893;
        Tue, 09 Jun 2015 05:01:32 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id h1sm5484529pdp.34.2015.06.09.05.01.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 05:01:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqzj4a9fpn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271167>

On 06/09/2015 12:42 AM, Junio C Hamano wrote:
>
> Is this intended?  I would have expected if I did
>
> 	git for-each-ref --points-at master
>
> I would get refs/heads/master and any other refs that exactly points
> at that commit.
>

Thats to be changed, thanks!

>>
>>   FIELD NAMES
>>   -----------
>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index 4d2d024..b9d180a 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -7,6 +7,7 @@
>>
>>   static char const * const for_each_ref_usage[] = {
>>   	N_("git for-each-ref [<options>] [<pattern>]"),
>> +	N_("git for-each-ref [--points-at <object>]"),
>>   	NULL
>>   };
>>
>> @@ -17,6 +18,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>>   	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
>>   	int maxcount = 0, quote_style = 0;
>>   	struct ref_filter_cbdata ref_cbdata;
>> +	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
>>
>>   	struct option opts[] = {
>>   		OPT_BIT('s', "shell", &quote_style,
>> @@ -33,6 +35,9 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>>   		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
>>   		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
>>   			    N_("field name to sort on"), &parse_opt_ref_sorting),
>> +		OPT_CALLBACK(0, "points-at", &ref_cbdata.filter.points_at,
>> +			     N_("object"), N_("print only tags of the object"),
>> +			     parse_opt_points_at),
>>   		OPT_END(),
>>   	};
>>
>> @@ -54,7 +59,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>>   	/* for warn_ambiguous_refs */
>>   	git_config(git_default_config, NULL);
>>
>> -	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
>
> I cannot quite see how this change relates to the addition of the
> new option.
>

Well if we memset() after calling parse_opt_points_at(), we loose all 
the information we would have obtained.
So the memset() is moved to an earlier location.

-- 
Regards,
Karthik
