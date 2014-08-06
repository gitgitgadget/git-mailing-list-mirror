From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/11] http-backend.c: replace `git_config()` with
 `git_config_get_bool()` family
Date: Wed, 6 Aug 2014 16:04:14 -0400
Message-ID: <CAPig+cT1jaRjBEU6iS2i7-Wk4ocZc=HJ5EWZdVrN01virO4mLA@mail.gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
	<1407177229-30081-3-git-send-email-tanayabh@gmail.com>
	<CAPig+cRpf9fc4HhNWpJ9Su+hSVEDc2+m4QmhY38zLD3RO8pGnA@mail.gmail.com>
	<53E24750.4000602@gmail.com>
	<vpqfvh9tygl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tanay Abhra <tanayabh@gmail.com>, Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:04:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF7Rd-0002f4-B7
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 22:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbaHFUEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 16:04:16 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:47526 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbaHFUEP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 16:04:15 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so2039271ykp.15
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lVN27+O7M7RQ2qyJ9KRGoEjMmcKzhkao95eTriaiwVM=;
        b=ISdWyc0+7tBSvQs9ENT9bsq2D3FHDIszWacjUImpi+1Pyh9mxjuyShCcpD6AX/BsP6
         xSX/UtaKM1+uTsW7JssgF0z625MVET5nqmy5tjQxNIqJBd3iQaFsUqL+Lpa6LTFCFoGr
         OUwGJ4fMTH+nvIR7ErgROTC/8PX4mPYWCU0FG/1sgy2x9cGI1/pI/OftfqlQWyS/KzLp
         1vsAq4OdfblAg//gtDLewhmlb+QvzZepZaEoh6B8LtYMgrfaTAJLepRsnYaUBDohiay4
         JOJAqi9YrHrfZ9RRlE5SA96L0dnXLPj5fxWJGwNPNPYdqoHN8lyqpip9ed8oFXT+GF3m
         vLTQ==
X-Received: by 10.236.7.109 with SMTP id 73mr19907854yho.148.1407355454918;
 Wed, 06 Aug 2014 13:04:14 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Wed, 6 Aug 2014 13:04:14 -0700 (PDT)
In-Reply-To: <vpqfvh9tygl.fsf@anie.imag.fr>
X-Google-Sender-Auth: WFVqu-N8kx-RbOU58jCFwoZYjhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254896>

On Wed, Aug 6, 2014 at 11:44 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> On 8/5/2014 12:29 AM, Eric Sunshine wrote:
>>> On Mon, Aug 4, 2014 at 2:33 PM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>>> -       if (skip_prefix(var, "http.", &p)) {
>>>> -               int i;
>>>> -
>>>> -               for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
>>>> -                       struct rpc_service *svc = &rpc_service[i];
>>>> -                       if (!strcmp(p, svc->config_name)) {
>>>> -                               svc->enabled = git_config_bool(var, value);
>>>> -                               return 0;
>>>> -                       }
>>>> -               }
>>>> +       for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
>>>> +               struct rpc_service *svc = &rpc_service[i];
>>>> +               strbuf_addf(&var, "http.%s", svc->config_name);
>>>> +               if (!git_config_get_bool(var.buf, &value))
>>>> +                       svc->enabled = value;
>>>> +               strbuf_reset(&var);
>>>>         }
>>>
>>> There is a behavior change here. The original code set svc->enabled to
>>> the first matching rpc_service[] entry, whereas the new code sets it
>>> to the last matching entry. Is this change intentional?
>>>
>>
>> I was preparing the reroll and I saw that I had missed your mail.
>> I think that I haven't changed the behaviour, the original one is
>> written in callback form so it has to go through the array every time for each
>> new value.
>> When there are multiple entries for a service say,
>>
>> http.receivepack = 1
>> http.receivepack = 0
>
> I first got convinced by Eric, but I now think you're right.
>
> Eric's point was (I think) not about multiple entries for the same
> variable, but about multiple entries for different services, like
>
> http.receivepack = 1
> http.uploadpack = 0
>
> The order of assignments to svn->enabled change, but it doesn't matter
> because svc is just a local variable pointing to the right element of
> rpc_service[i]. So in both cases, you'll assign
>
> rpc_service[<index of service>].enabled = <last occurence of variable http.<service> >
>
> even though the order of assignments will change.
>
> Eric, am I interpreting right?

Yes. During initial review, I either didn't read the old code closely
enough or I misinterpreted it. Upon re-read, Tanay's rewrite looks
fine.
