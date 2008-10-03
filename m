From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Fix argument handling for fetch-pack call when stdout is connected and -q/--quiet is supplied.
Date: Fri, 3 Oct 2008 22:44:35 +0200
Message-ID: <4ac8254d0810031344q12638e4ra5982373ae9c8908@mail.gmail.com>
References: <4ac8254d0810031234x26ebc96cy7cf5dcae2ef516e0@mail.gmail.com>
	 <alpine.LNX.1.00.0810031548260.19665@iabervon.org>
	 <4ac8254d0810031318j3e0f326ewc4bf250c51681670@mail.gmail.com>
	 <85647ef50810031333m254036bav81d6dd4a58fb56da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 22:45:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlrX3-0000tI-6H
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 22:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbYJCUoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 16:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbYJCUoi
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 16:44:38 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:7758 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbYJCUoh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 16:44:37 -0400
Received: by yw-out-2324.google.com with SMTP id 9so299268ywe.1
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JsYKMn9sgn/esPR2Ea8Od8jDls/8vU6bNrWTlqCSj5U=;
        b=a+qP7Qb5kpeFotpl0g21p/b45OCMA6IrAM0TwMfqppczUjlXC5v2dw/2hzPL1/2isZ
         F43nK9K7mBIt8EbYxZM/tZIlpUYX/7+Zu/K4rZc+3QStnczyFHG8IwNt/zIUpnQGHSb8
         K3Gm4Ap1+pbvTQ3b6MD5s6i4NVAwhD61vkyDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hX4j2NAOVTjdUqGTicZxWbrs8aetS0N5xVocwpbb7ZDrcdstSGLpKuxy2WMplvF1+B
         4jaQRrZPzAXupUrIrSv8C8VVaVUwKfSyM4IyjWGgnl/yYfVzTgFrfwSTGjJoMj20+Wr/
         S4hJypYEI1NWcjTB2tCPYrH250bISaJEQiL+c=
Received: by 10.65.72.7 with SMTP id z7mr1742470qbk.23.1223066675234;
        Fri, 03 Oct 2008 13:44:35 -0700 (PDT)
Received: by 10.65.251.6 with HTTP; Fri, 3 Oct 2008 13:44:35 -0700 (PDT)
In-Reply-To: <85647ef50810031333m254036bav81d6dd4a58fb56da@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97454>

On Fri, Oct 3, 2008 at 10:33 PM, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> I think such patch would be too harsh for IDE plugin developers. When
> git is run from IDE, the isatty(1) will be true. But progress
> information will be still useful, to display an operation progress to
> user. Please provide a way to force output of progress (for example
> using environment).

Hi Constantine,

this only fixes what was wrong: If you call "git clone -q" args.no_progress
was meant to be 1 but wasn't due to a small error.
If isatty(1) returns 1 then args.no_progress=0, so you will get progress
logging in that case - assuming you haven't supplied -q.

To get progress logging call without -q _and_ have isatty(1)==1.

> Regards,
> Constantine
>
>
> On Sat, Oct 4, 2008 at 12:18 AM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
>> On Fri, Oct 3, 2008 at 9:50 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>>> On Fri, 3 Oct 2008, Tuncer Ayaz wrote:
>>
>> <snip>
>>
>>>> diff --git a/transport.c b/transport.c
>>>> index 71433d9..1f24011 100644
>>>> --- a/transport.c
>>>> +++ b/transport.c
>>>> @@ -644,7 +644,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>>>>     args.include_tag = data->followtags;
>>>>     args.verbose = (transport->verbose > 0);
>>>>     args.quiet = args.no_progress = (transport->verbose < 0);
>>>> -   args.no_progress = !isatty(1);
>>>> +   args.no_progress = args.quiet || !isatty(1);
>>>
>>> If you're doing that, remove the "args.no_progress =" from the previous
>>> line, which was there to have that effect (but not so clearly). Aside from
>>> that, it looks good to me.
>>>
>>
>> <snip>
>>
>> Thanks Daniel, that makes a lot of sense.
>>
>> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
>> ---
>>  transport.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/transport.c b/transport.c
>> index 71433d9..35cac44 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -643,8 +643,8 @@ static int fetch_refs_via_pack(struct transport *transport,
>>        args.use_thin_pack = data->thin;
>>        args.include_tag = data->followtags;
>>        args.verbose = (transport->verbose > 0);
>> -       args.quiet = args.no_progress = (transport->verbose < 0);
>> -       args.no_progress = !isatty(1);
>> +       args.quiet = (transport->verbose < 0);
>> +       args.no_progress = args.quiet || !isatty(1);
>>        args.depth = data->depth;
>>
>>        for (i = 0; i < nr_heads; i++)
>> --
>> 1.6.0.2
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
