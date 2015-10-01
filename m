From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv6 0/8] fetch submodules in parallel
Date: Thu, 1 Oct 2015 12:03:41 -0700
Message-ID: <CAGZ79kb7Td6v16Ypfp7Uzgh+eLf26Mdwuy6=eMQwkPJdBdMUng@mail.gmail.com>
References: <1443664456-1307-1-git-send-email-sbeller@google.com>
	<560D81B7.6090304@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 21:03:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhj8s-0004Gx-Rt
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 21:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbbJATDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 15:03:42 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33738 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbbJATDm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 15:03:42 -0400
Received: by ykft14 with SMTP id t14so89245043ykf.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2015 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zcvazh1PNLnpYt+ckbS+0TCNBcm5gc2O96n1CQj90lg=;
        b=OyiQw6keGMw+BVxwIzk/S40wCDDfqkHZ6oL+fg6fSw7PLwH/KhxxDCjZH7IsQ82Br8
         4v1UOiOHh8+2DyjrjcsA4RMTmZ3sSsgMuPqMHAMEovZM2xUsHeyKea72WeDJPmMIT9zJ
         CUf8amt+7d5398nlEAqd//0CNHwqJEnxXiZSM1o+BA0bUCRaIvcBdnhmlRSxog6AN3AG
         3lhryR4mXmo9lBTFqjsx9RZ9EsIKbfz1dmDJp4DgtDxTWzIrJxfmXVlqSI6u48Cmcn/t
         RfgWI53S2+7c2pWF0SfeqgkJUQimLkcgWvnug70nOWKpZjobjS6TTCnXewoiFRuw/9K+
         +tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zcvazh1PNLnpYt+ckbS+0TCNBcm5gc2O96n1CQj90lg=;
        b=DTQpUV4YSmVyBsMl8njkPbplSDZulFCmTu/ivssvA8mv+2dz8ZmSeRl9BN3Vz/Efhf
         ND4mp8bptI/VYL+e8TQBCzwHxXiYg1q9JguZOi5pS/BP7NqlzjrdBFXZs+CLD0/nMeMH
         f6KU4HCktr2kExWR87PBp0W+Gos8QeRCZ6xeerX/HNaTgtp37Dudj0CNnNNCldrfmw3a
         jJnzf5yfjaATjz1zGSH640bBCjwhAf+XZ5TVkszzLEASMqKJc1+r28sTlt7vIlOKf1gs
         7seHHiiSwK3PDFGoFpBRHscPRIqKmu5KWATv9MR+a7pXjYHY0oQHgfJ0xXLzbrfOxYcN
         mN/w==
X-Gm-Message-State: ALoCoQlghPAiG6xYIjO5tBG/e8vbT8A/XaQueIHdrMKyi3C35TzEn08c4olYZcPHOREq5cbCWDTI
X-Received: by 10.170.210.65 with SMTP id b62mr9280314ykf.10.1443726221289;
 Thu, 01 Oct 2015 12:03:41 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 1 Oct 2015 12:03:41 -0700 (PDT)
In-Reply-To: <560D81B7.6090304@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278902>

On Thu, Oct 1, 2015 at 11:55 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> Hi Stefan,
>
>>
>> -     if (!pp->get_next_task(pp->data,
>> +     if (!pp->get_next_task(&pp->children[i].data,
>>                              &pp->children[i].process,
>> -                            &pp->children[i].err))
>> +                            &pp->children[i].err,
>> +                            pp->data))
>>               return 1;
>
> ... the above hunk caught my eye. I don't know that it matters that
> much, but since you have reordered parameters on some functions, should
> pp->get_next_task() take the 'task_cb' as the last parameter, rather than
> the first?
>
> I have not looked at the final result yet (just the interdiff), so please
> just ignore the above if I've missed something obvious. :-D

Well I reordered such that "passive" arguments come last, i.e. the
cookies for consumption. In this specific case we ask get_next_task
to fill in the cookie if desired. Unlike all the other cookie passing
this is a double void pointer, so even syntactically we have a difference
to other cookie passing around.

If you look at the function definitions in the header, you find the arguments
ordered as

  (Active/unique arguments for that function, child process, error
buffer, cookies for consumption)

That said, I find a few things I need to improve.
pp->children[i].data, may want to be initialized to NULL before we ask
get_next_task
to fill in a cookie. If get_next_task decides not to, we have a clear default.

The call to run_processes_parallel may be reordered to its original order again,
as we pass in a cookie actively. (int n, int *cb, callbacks...)

>
> ATB,
> Ramsay Jones
>
