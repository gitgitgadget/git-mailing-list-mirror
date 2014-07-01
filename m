From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] notes-util.c: replace git_config with git_config_get_string
Date: Tue, 01 Jul 2014 10:36:10 +0200
Message-ID: <vpqha31fpc5.fsf@anie.imag.fr>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-4-git-send-email-tanayabh@gmail.com>
	<CAPig+cRcbamkpeaoCMQ9yXtYeMEEL-ve--VWKg4MAWeS08Lqyg@mail.gmail.com>
	<53ABD78E.3050800@gmail.com>
	<CAPig+cSRBk5Q2amvFXyjH4dpoP83qbYUEUizE7v38Wh8Ofnfpw@mail.gmail.com>
	<53B16748.8080703@gmail.com> <53B17696.3060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 10:36:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1tYB-0000mh-2L
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 10:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbaGAIgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 04:36:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43826 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515AbaGAIgU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 04:36:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s618aAow014773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 Jul 2014 10:36:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s618aAYG012235;
	Tue, 1 Jul 2014 10:36:11 +0200
In-Reply-To: <53B17696.3060808@gmail.com> (Tanay Abhra's message of "Mon, 30
	Jun 2014 20:09:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 01 Jul 2014 10:36:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s618aAow014773
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404808573.87431@4ghwLcAougg6PoXDPfGhag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252712>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 6/30/2014 7:04 PM, Karsten Blees wrote:
>> Am 29.06.2014 13:01, schrieb Eric Sunshine:
>>> On Thu, Jun 26, 2014 at 4:19 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>>> On 6/25/2014 1:24 PM, Eric Sunshine wrote:
>>>>> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>>>>> Use git_config_get_string instead of git_config to take advantage of
>>>>>> the config hash-table api which provides a cleaner control flow.
>>>>>>
>>>>>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>>>>>> ---
>>>>>>  notes-utils.c | 31 +++++++++++++++----------------
>>>>>>  1 file changed, 15 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> diff --git a/notes-utils.c b/notes-utils.c
>>>>>> index a0b1d7b..fdc9912 100644
>>>>>> --- a/notes-utils.c
>>>>>> +++ b/notes-utils.c
>>>>>> @@ -68,22 +68,23 @@ static combine_notes_fn parse_combine_notes_fn(const char *v)
>>>>>>                 return NULL;
>>>>>>  }
>>>>>>
>>>>>> -static int notes_rewrite_config(const char *k, const char *v, void *cb)
>>>>>> +static void notes_rewrite_config(struct notes_rewrite_cfg *c)
>>>>>>  {
>>>>>> -       struct notes_rewrite_cfg *c = cb;
>>>>>> -       if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
>>>>>> -               c->enabled = git_config_bool(k, v);
>>>>>> -               return 0;
>>>>>> -       } else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
>>>>>> +       struct strbuf key = STRBUF_INIT;
>>>>>> +       const char *v;
>>>>>> +       strbuf_addf(&key, "notes.rewrite.%s", c->cmd);
>>>>>> +
>>>>>> +       if (!git_config_get_string(key.buf, &v))
>>>>>> +               c->enabled = git_config_bool(key.buf, v);
>>>>>> +
>>>>>> +       if (!c->mode_from_env && !git_config_get_string("notes.rewritemode", &v)) {
>>>>>>                 if (!v)
>>>>>> -                       return config_error_nonbool(k);
>>>>>> +                       config_error_nonbool("notes.rewritemode");
>>>>>
>>>>> There's a behavior change here. In the original code, the callback
>>>>> function would return -1, which would cause the program to die() if
>>>>> the config.c:die_on_error flag was set. The new code merely emits an
>>>>> error.
>>>>
>>>> Is this change serious enough? Can I ignore it?
>> 
>> IMO its better to Fail Fast than continue with some invalid config (which
>> may lead to more severe errors such as data corruption / data loss).
>
> Noted but, what I am trying to do with the rewrite is emit an error and
> not set the value if the value found is a NULL. The only change is that
> program will not crash in this case and warn the user not set a NULL value for
> a non boolean key.
> This won't lead to severe errors as the value will not be set if found value
> is a NULL.

The change probably makes sense, but as much as possible, keep
refactoring patches and patches introducing a semantic change separate.
It's much easier to review, and helps user digging history and finding
one of the commits.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
