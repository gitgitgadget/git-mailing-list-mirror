From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 02/11] http-backend.c: replace `git_config()` with `git_config_get_bool()` family
Date: Wed, 06 Aug 2014 17:44:10 +0200
Message-ID: <vpqfvh9tygl.fsf@anie.imag.fr>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
	<1407177229-30081-3-git-send-email-tanayabh@gmail.com>
	<CAPig+cRpf9fc4HhNWpJ9Su+hSVEDc2+m4QmhY38zLD3RO8pGnA@mail.gmail.com>
	<53E24750.4000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:44:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF3O8-0003tI-OI
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbaHFPoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:44:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42556 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbaHFPoY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:44:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s76Fi8sm006681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Aug 2014 17:44:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s76FiA8S024929;
	Wed, 6 Aug 2014 17:44:10 +0200
In-Reply-To: <53E24750.4000602@gmail.com> (Tanay Abhra's message of "Wed, 06
	Aug 2014 20:48:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Aug 2014 17:44:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s76Fi8sm006681
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407944649.85919@Sc0Se6P1l2GX54JBU2O1/A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254870>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 8/5/2014 12:29 AM, Eric Sunshine wrote:
>> On Mon, Aug 4, 2014 at 2:33 PM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>> -       if (skip_prefix(var, "http.", &p)) {
>>> -               int i;
>>> -
>>> -               for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
>>> -                       struct rpc_service *svc = &rpc_service[i];
>>> -                       if (!strcmp(p, svc->config_name)) {
>>> -                               svc->enabled = git_config_bool(var, value);
>>> -                               return 0;
>>> -                       }
>>> -               }
>>> +       for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
>>> +               struct rpc_service *svc = &rpc_service[i];
>>> +               strbuf_addf(&var, "http.%s", svc->config_name);
>>> +               if (!git_config_get_bool(var.buf, &value))
>>> +                       svc->enabled = value;
>>> +               strbuf_reset(&var);
>>>         }
>> 
>> There is a behavior change here. The original code set svc->enabled to
>> the first matching rpc_service[] entry, whereas the new code sets it
>> to the last matching entry. Is this change intentional?
>>
>
> I was preparing the reroll and I saw that I had missed your mail.
> I think that I haven't changed the behaviour, the original one is
> written in callback form so it has to go through the array every time for each
> new value.
> When there are multiple entries for a service say,
>
> http.receivepack = 1
> http.receivepack = 0

I first got convinced by Eric, but I now think you're right.

Eric's point was (I think) not about multiple entries for the same
variable, but about multiple entries for different services, like

http.receivepack = 1
http.uploadpack = 0

The order of assignments to svn->enabled change, but it doesn't matter
because svc is just a local variable pointing to the right element of
rpc_service[i]. So in both cases, you'll assign

rpc_service[<index of service>].enabled = <last occurence of variable http.<service> >

even though the order of assignments will change.

Eric, am I interpreting right?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
