From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Tue, 07 Apr 2015 16:04:15 +0530
Message-ID: <5523B2A7.6060604@gmail.com>
References: <551F7984.5070902@gmail.com> <1428126162-18987-1-git-send-email-karthik.188@gmail.com> <xmqq7ftrg02b.fsf@gitster.dls.corp.google.com> <55204141.9070100@gmail.com> <xmqqiodbdnkn.fsf@gitster.dls.corp.google.com> <5520E9D2.4010603@gmail.com> <xmqqbnj2e4ah.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 12:35:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfQqV-0006Vk-LK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 12:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbbDGKe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 06:34:58 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33432 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbbDGKe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 06:34:57 -0400
Received: by pdbnk13 with SMTP id nk13so74884181pdb.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uw6XF9QUQvSawRa2uiUZ/WcKqBzJB3swXX4v9NDI/tE=;
        b=N/FFuec1j865QV43UgJc3kDySN/nS62lHJPCj+qzGtqFB4eYuBnBmUgJa8T5ps8cSO
         Gvb6eEkv45UCDm79fFmaBSFAsKc/vBzBhzCSEYfYhVkm93N/ItVa5j34UCbIpQVSNdM8
         oFZ0fYsSi0kk+hPcyTL2QpD5Wm3CZRpoD1enUNBxrA9+e4G1tCna8JLxkHxgefEDTEm/
         7Supq8rTgIL0rSQ2omR7spUorr9rEuyAZCmg06alJEgBs9CjJdkjfLsnQeEx2WD4Wf/E
         q5f5ZsG9PX5jNppJdLvxOAPOBMk5CjPtm1c8sY4EfpODu5ldZQ0H2LNha7QYeK/kDlL9
         HcrQ==
X-Received: by 10.70.2.98 with SMTP id 2mr34754591pdt.91.1428402896989;
        Tue, 07 Apr 2015 03:34:56 -0700 (PDT)
Received: from [192.168.43.24] ([49.15.200.33])
        by mx.google.com with ESMTPSA id n5sm7566212pdn.63.2015.04.07.03.34.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2015 03:34:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqbnj2e4ah.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266906>


On 04/06/2015 01:27 AM, Junio C Hamano wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
> > On 04/05/2015 01:16 PM, Junio C Hamano wrote:
> >
> >> If it semantically does not make sense to ask for the typename
> >> without asking for the type code, then we can and should make that
> >> as a new calling convention _all_ callers must follow.
> >>
> >> In other words, I think it is better to have
> >>
> >>     if (oi->typename && !oi->typep)
> >>         die("BUG");
> >>
> >> somewhere near the beginning of the callchain that takes oi; that
> >> will ensure all callers understand the rule.
> >
> > Yes! this is a better approach as it will enforce that typep must be
> > set when typename is set.
>
> Not so fast ;-)
>
> The key phrase in what I wrote above is "If it does not make sense",
> and I am not yet convinced if that is the case or not.  If we are to
> change the calling convention for the callers, the reason why it
> does not make sense to ask only for typename but not typep must be
> explained in the log message.
>
> And if it turns out that the answer to that question is "it is valid
> to ask only for typename", then it would be wrong to force everybody
> who wants to learn the stringified typename to supply typep.  And in
> such a case it might be better to do something like this instead (on
> top of your patch I am responding to):
>
>   sha1_file.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index f4055dd..26fbb7c 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2639,6 +2639,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>       struct cached_object *co;
>       struct pack_entry e;
>       int rtype;
> +    enum object_type real_type;
>       const unsigned char *real = lookup_replace_object_extended(sha1, flags);
>
>       co = find_cached_object(real);
> @@ -2670,9 +2671,18 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>               return -1;
>       }
>
> +    /*
> +     * packed_object_info() does not follow the delta chain to
> +     * find out the real type, unless it is given oi->typep.
> +     */
> +    if (oi->typename && !oi->typep)
> +        oi->typep = &real_type;
> +
>       rtype = packed_object_info(e.p, e.offset, oi);
>       if (rtype < 0) {
>           mark_bad_packed_object(e.p, real);
> +        if (oi->typep == &real_type)
> +            oi->typep = NULL;
>           return sha1_object_info_extended(real, oi, 0);
>       } else if (in_delta_base_cache(e.p, e.offset)) {
>           oi->whence = OI_DBCACHED;
> @@ -2686,6 +2696,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>       if (oi->typename)
>           strbuf_addstr(oi->typename, typename(*oi->typep));
>
> +    if (oi->typep == &real_type)
> +        oi->typep = NULL;
>       return 0;
>   }
>
>
Haha, If there is anything I love about code revisions its how you are subjected to
so many different ways of thinking. I didn't think of what you said.

We could do this and support typename without typep being used. This could probably
even eliminate the typep used by cat-file while getting the type of an object.

Will go through this again.

Thanks a lot.
