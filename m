From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] unpack-trees: plug a memory leak
Date: Sun, 2 Jun 2013 14:51:27 -0500
Message-ID: <CAMP44s3aF8VsNqJA3GNLN=cw6Vp4iJEcTn5WDq2XPs-Le--szg@mail.gmail.com>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
	<1369915136-4248-4-git-send-email-felipe.contreras@gmail.com>
	<7vfvx0nw7t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 21:51:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjEJT-0005io-0a
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 21:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189Ab3FBTvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 15:51:31 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:50882 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab3FBTv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 15:51:29 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so2824440lab.1
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vfirEaLMKQHbFcppAkl3tQLXLveah/O9w4/zrP7dEw8=;
        b=wok+kyty1K0iSyZoQzMMW+3gCTNPOW0iUWM97TevKZPTS6ea/Rpw0O+L9xmRvLJ1n+
         2+5Yag6rnlBJpol30S6vo9rhEG5UglC09qpqus1Mmg/tlO6zpEBQgAo2eOTtUb1vwd7U
         B0Ec0ScB8p5lByvGSD4XdM/UDw/c2cZZuZ7UJ5ebpsctWSBKHtnyH8l/SqBE38my7yc+
         ztCmub/EvKS5RA0AaUgVHo3BjPn4YqdITBJhlGEvAwBE7hNFB/9pXZEKXXU2j4iKSwkS
         WHHIuHk5PhPkV0V3Ij7/TtaXSOafG2WFs3e7RU5zTw+4uem78P6a9vWjnVzfEibQndHa
         YyTg==
X-Received: by 10.112.160.105 with SMTP id xj9mr6951079lbb.11.1370202687944;
 Sun, 02 Jun 2013 12:51:27 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Sun, 2 Jun 2013 12:51:27 -0700 (PDT)
In-Reply-To: <7vfvx0nw7t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226178>

On Sun, Jun 2, 2013 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Before overwriting the destination index, first let's discard it's
>> contents.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  unpack-trees.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index ede4299..eff2944 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -1146,8 +1146,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>
>>       o->src_index = NULL;
>>       ret = check_updates(o) ? (-2) : 0;
>> -     if (o->dst_index)
>> +     if (o->dst_index) {
>> +             discard_index(o->dst_index);
>>               *o->dst_index = o->result;
>> +     }
>
> I seem to recall that many callers set src_index and dst_index to
> the same istate, and expect that the original istate pointed by the
> src_index to remain usable.  Is it safe to discard it like this at
> this point?

Who expects that?

-- 
Felipe Contreras
