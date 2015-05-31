From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 4/8] for-each-ref: introduce new structures for
 better organisation
Date: Sun, 31 May 2015 13:46:05 +0530
Message-ID: <556AC345.2070101@gmail.com>
References: <5569EF77.4010300@gmail.com>	<1433008411-8550-4-git-send-email-karthik.188@gmail.com> <CAPig+cSj8Ri=cz9gt_MmMcQQg7iH1beweKfrvEL3MExDY_EiKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:16:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyyPr-0007UK-2M
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 10:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbbEaIQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 04:16:14 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34282 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbbEaIQK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 04:16:10 -0400
Received: by payr10 with SMTP id r10so5371458pay.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fErkcFmNBJcicbhHjuowatP9dJRIv+xfqxqNp53V8iw=;
        b=jmG8uc+0CNv0SPSEdGM9s4f8Za2eQTx3o+7WZtJmyK5ZobWZsVQJme0ObRF4ptU43s
         XjKpOTAKxdGqS+KYomqQm4qBlVKIByk503AWnQ2QdMbWf+wAjDYFitRWgg4w8s+bq9kD
         5DpPAZrBm4du7l3GdhxCL93zWnjfau2jkQRqAb6cRlir1Fah7gweh6nMfr/wWbqUksPB
         WQD8CN5s3+TqwFLJJ5TVExbeMupbBPHvPgCFSR5otUexTl/+U1a9NGXJ/g5O0yQj0L3Q
         y0yfdXm1MNY0Dr1N0Za/v9/tL/YD70kdhskaE8jUlt8RZ6NiRYiggn2UO0JEDjxCoFXx
         DCsQ==
X-Received: by 10.66.236.226 with SMTP id ux2mr30488438pac.64.1433060170008;
        Sun, 31 May 2015 01:16:10 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id dd3sm10726540pad.45.2015.05.31.01.16.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 01:16:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cSj8Ri=cz9gt_MmMcQQg7iH1beweKfrvEL3MExDY_EiKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270319>

On 05/31/2015 08:44 AM, Eric Sunshine wrote:
> On Sat, May 30, 2015 at 1:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Intoduce 'ref_filter_cbdata' which will hold 'ref_filter'
>
> s/Intoduce/Introduce/
>
>> (Conditions to filter the refs on) and 'ref_array' (The array
>
> s/Conditions/conditions/
> s/The/the/
>
>> of ref_array_items). Modify the code to use these new structures.
>>
>> This is a preparatory patch to eventually move code from 'for-each-ref'
>> to 'ref-filter' and making it publically available.
>
> s/publically/publicly/
>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index e634fd2..ef54c90 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -85,7 +99,7 @@ static struct {
>>    * a "*" to denote deref_tag().
>>    *
>>    * We parse given format string and sort specifiers, and make a list
>> - * of properties that we need to extract out of objects.  ref_array_item
>> + * of properties that we need to extract out of objects. ref_array_item
>
> Sneaking in whitespace change?
>
>>    * structure will hold an array of values extracted that can be
>>    * indexed with the "atom number", which is an index into this
>>    * array.
>> @@ -1076,12 +1085,12 @@ static char const * const for_each_ref_usage[] = {
>>
>>   int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>>   {
>> -       int i, num_refs;
>> +       int i;
>>          const char *format = "%(objectname) %(objecttype)\t%(refname)";
>>          struct ref_sort *sort = NULL, **sort_tail = &sort;
>>          int maxcount = 0, quote_style = 0;
>> -       struct ref_array_item **refs;
>> -       struct grab_ref_cbdata cbdata;
>> +       struct ref_filter_cbdata ref_cbdata;
>> +       memset(&ref_cbdata, 0, sizeof(ref_cbdata));
>>
>>          struct option opts[] = {
>
> Declaration (struct option opts[]) after statement (memset). I think
> you want to leave the memset() where it was below.
>
>>                  OPT_BIT('s', "shell", &quote_style,
>> @@ -1119,17 +1128,14 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>>          /* for warn_ambiguous_refs */
>>          git_config(git_default_config, NULL);
>>
>> -       memset(&cbdata, 0, sizeof(cbdata));
>> -       cbdata.grab_pattern = argv;
>> -       for_each_rawref(grab_single_ref, &cbdata);
>> -       refs = cbdata.grab_array;
>> -       num_refs = cbdata.grab_cnt;
>> +       ref_cbdata.filter.name_patterns = argv;
>> +       for_each_rawref(grab_single_ref, &ref_cbdata);
>>
>> -       sort_refs(sort, refs, num_refs);
>> +       sort_refs(sort, &ref_cbdata.array);
>>
>> -       if (!maxcount || num_refs < maxcount)
>> -               maxcount = num_refs;
>> +       if (!maxcount || ref_cbdata.array.nr < maxcount)
>> +               maxcount = ref_cbdata.array.nr;
>>          for (i = 0; i < maxcount; i++)
>> -               show_ref(refs[i], format, quote_style);
>> +               show_ref(ref_cbdata.array.items[i], format, quote_style);
>>          return 0;
>>   }
>> --
>> 2.4.2

Will change these, thanks!

-- 
Regards,
Karthik
