From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make
 them public
Date: Mon, 01 Jun 2015 01:04:12 +0530
Message-ID: <556B6234.2010809@gmail.com>
References: <5569EF77.4010300@gmail.com>	<1433008411-8550-6-git-send-email-karthik.188@gmail.com> <xmqqmw0kab94.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 21:38:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz93v-0000RP-JT
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 21:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbbEaTeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 15:34:20 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34762 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbbEaTeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 15:34:18 -0400
Received: by payr10 with SMTP id r10so11583333pay.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VHhnZCy7tdYAf/wVWeYwFDcI1H8rUGBVo7O3p6CfbwY=;
        b=yvp//FD/24bdHGzNumVXyEhKJ+Pspu3KqMY7Pv8vlFHpLxWmrrnni+6ClXEX9RdflH
         +Vzs0Kh7tytjchV7m9lTE0dKLL75dxeoKrD0DaHQgml7fxu7Qe+NpEFC0rQUH3WIlzTI
         jDQu1UVxSu41aqncbnPIwGrStf0eB2rEA0TDOWw+jWg1G+GblfHV0RZ1Byhy8V1wTdnh
         Ol2vdKntum5cIfhR5uFJutx5GXbgANGKguTjlfoXHdS8BRase5E1i2em8rYhFm56B8DA
         BkrWtPKHV/EfXTe/TRN4bzHDCV/sdmKx4WJt+3XUIFE+y3TBdysochlsedRlvXp/ABF1
         Xdsg==
X-Received: by 10.68.243.9 with SMTP id wu9mr34192910pbc.28.1433100858269;
        Sun, 31 May 2015 12:34:18 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id t2sm2372992pdo.81.2015.05.31.12.34.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 12:34:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqmw0kab94.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270348>

On 05/31/2015 11:18 PM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>   /*
>> - * A call-back given to for_each_ref().  Filter refs and keep them for
>> + * A call-back given to for_each_ref(). Filter refs and keep them for
>>    * later object processing.
>>    */
>> -static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>> +int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>>   {
>
> I am not sure if this is a good external interface, i.e. to expect
> callers of ref-filter API to do this:
>
> 	prepare cbdata;
> 	for_each_ref(ref_filter_handler, &cbdata);
>
> It might be better to expect callers to do this instead:
>
> 	prepare cbdata;
>          filter_refs(for_each_ref, &cbdata);
>
> i.e. introducing a new "filter_refs()" function as the entry point
> to the ref-filter API.  The filter_refs() entry point may internally
> use ref_filter_handler() that will be file-scope static to ref-filter.c
> and at that point the overly generic "-handler" name would not bother
> anybody ;-) but more importantly, then you can extend the function
> signature of filter_refs() not to be so tied to for_each_ref() API.
> It could be that the internals of cbdata may not be something the
> callers of filter-refs API does not even have to know about, in
> which case the call might even become something like:
>
> 	struct ref_array refs = REF_ARRAY_INIT;
>          const char **ref_patterns = { "refs/heads/*", "refs/tags/*", NULL};
>
> 	filter_refs(&refs, for_each_rawref, ref_patterns);
>
>          /* now "refs" has the result, the caller uses them */
> 	for (i = 0; i < refs.nr; i++)
>          	refs.item[i];
>
> Just a thought.
>

Thats brilliant, How about I introduce something of this sort

int filter_refs(int (*for_each_ref_fn)(each_ref_fn, void *), 
ref_filter_cbdata *cbdata)
{
	return for_each_ref_fn(ref_filter_handler, cbdata);
}

where its the most basic form, and things like

 >
 > 	struct ref_array refs = REF_ARRAY_INIT;
 >          const char **ref_patterns = { "refs/heads/*", "refs/tags/*", 
NULL};
 >
 > 	filter_refs(&refs, for_each_rawref, ref_patterns);
 >
 >          /* now "refs" has the result, the caller uses them */
 > 	for (i = 0; i < refs.nr; i++)
 >          	refs.item[i];
 >

Could be achieved using a simple wrapper around 'filter_refs()' 
something like this perhaps.

int filter_refs_with_pattern(struct ref_array *ref, int 
(*for_each_ref_fn)(each_ref_fn, void *), char **patterns)
{
	int i;
	struct ref_filter_cbdata data;
	data.filter.name_patterns = patterns;
	filter_refs(for_each_ref_fn, &data);
	refs->nr = data.array.nr;
	for(i = 0; i < refs->nr; i++) {
		/* copy over the refs */
	}
	return 0;
}

Is this on the lines of what you had in mind? If it is, than I could 
just create a new patch which would make ref_filter_handler() private 
and introduce filter_refs() as shown.

-- 
Regards,
Karthik
