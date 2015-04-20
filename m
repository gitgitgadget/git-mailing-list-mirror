From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/7] path.c: implement xdg_config_home()
Date: Sun, 19 Apr 2015 20:39:44 -0400
Message-ID: <CAPig+cQD9BH8kib98fCsiUHnsSAAMkwxAnFVxD8Gq5JMwXVjog@mail.gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
	<e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
	<20150414172854.GA27623@yoshi.chippynet.com>
	<CAPig+cTrErOBwPteeA1d_gdve5SiyLnbyFPpQ1sTN7aajGJfeA@mail.gmail.com>
	<CACRoPnR7MQsP_dAE0RV_80JDbU9h6tfu30yL2OOK+JGYLzVLNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 02:39:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yjzkh-0003r0-7V
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 02:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbbDTAjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 20:39:46 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33032 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbbDTAjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 20:39:45 -0400
Received: by iecrt8 with SMTP id rt8so93037224iec.0
        for <git@vger.kernel.org>; Sun, 19 Apr 2015 17:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OTjTqiHcv8H1Cahmjk6NqNZHvvKCZa6ODr/OtmxMcvw=;
        b=D/+khR+NTxxPdDek21vrHELLMhW9yXA4zU+nhAX/SkBLof269NRC+4aWDA3BgW7cAb
         0pfib2ELTRDS2gChXicxS/iqYxZtcu34XyxZaTcPwxgQjTMIbCY+hlsqBIBa64gnx0WG
         dJIw+radkUXlbwW2z28C7aTBbKoCWZ8HZrF/FYtLRrPt9cmzbJDTRJ6FKNhbbBLqAvkq
         GHq8LEsBtuJzJHuzoFiHny02ol/emHJuBlzapBKZQllhfs60/mtLlmZ3PbYH4TAf/wzW
         kWJjqF/CvYloECRFWkdkwEXltABJOefDWUFOPePgIStRCFLuFL6PqUGGAWzLIF0yg6MD
         idpQ==
X-Received: by 10.50.122.72 with SMTP id lq8mr17313988igb.15.1429490384801;
 Sun, 19 Apr 2015 17:39:44 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 19 Apr 2015 17:39:44 -0700 (PDT)
In-Reply-To: <CACRoPnR7MQsP_dAE0RV_80JDbU9h6tfu30yL2OOK+JGYLzVLNQ@mail.gmail.com>
X-Google-Sender-Auth: sBd3GjKvGDQvQYjlveokM83PNJs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267445>

On Sat, Apr 18, 2015 at 3:51 AM, Paul Tan <pyokagan@gmail.com> wrote:
> On Fri, Apr 17, 2015 at 5:41 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Apr 14, 2015 at 1:28 PM, Paul Tan <pyokagan@gmail.com> wrote:
>>> + * Returns the newly allocated string "$XDG_CONFIG_HOME/git/{filename}".  If
>>> + * $XDG_CONFIG_HOME is unset or empty, returns the newly allocated string
>>> + * "$HOME/.config/git/{filename}". Returns NULL if filename is NULL or an error
>>> + * occurred.
>> This is better than the original which said "$XDG_CONFIG_HOME/git/%s",
>> but is still potentially confusing. When I read the earlier iteration,
>> I was left with the impression that it was returning that literal
>> string, with '$' and '%s' embedded, and that the caller would have to
>> process it further to have '$' and '%s' expanded. Perhaps rephrasing
>> it something like this will help?
>>
>>     Return a newly allocated string with value xdg+"/git/"+filename
>>     where xdg is the interpolated value of $XDG_CONFIG_HOME if
>>     defined and non-empty, otherwise "$HOME/.config". Return NULL
>>     upon error.
>
> Personally I think interpolated strings are easier to read than
> concatenated strings. $VARIABLE (all upper case) in shell scripting is
> understood to be an environment variable, and $variable (all lower
> case) to be a local variable.
> Thinking about it again, I should not be using python-style format
> strings either ;-). So I would write it as
> "$XDG_CONFIG_HOME/git/$filename".
>
> But anyway, I don't have strong opinions on documentation, so I will
> leave this to majority opinion. I will change it if you strongly
> disagree :-).

Other than being enuinely confused by the original, and having to
check the actual implementation for clarification, I don't feel
strongly about it either. Perhaps mentioning "evaluation" like this
might help?

    Return a newly allocated string with the evaluation of
    "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is
    non-empty, otherwise "$HOME/.config/git/$filename". Return
    NULL upon error.

More below.

>>> +       if (!config_home || !config_home[0]) {
>>> +               const char *home = getenv("HOME");
>>> +
>>> +               if (!home)
>>> +                       return NULL;
>>> +               return mkpathdup("%s/.config/git/%s", home, filename);
>>> +       } else
>>> +               return mkpathdup("%s/git/%s", config_home, filename);
>>
>> This logic is more difficult to follow than it ought to be due to the
>> use of 'config_home' so distant from the 'if' which checked it, and
>> due to the nested 'if'. It could be expressed more straight-forwardly
>> as:
>>
>>     if (config_home && *config_home)
>>         return mkpathdup("%s/git/%s", config_home, filename);
>>
>>     home = getenv("HOME");
>>     if (home)
>>         return mkpathdup("%s/.config/git/%s", home, filename);
>>
>>     return NULL;
>
> Ah, flipping the conditionals definitely makes it look nicer. I guess
> I will need your sign off to use your code? Thanks!

My sign-off is probably overkill. I merely re-arranged some lines of
code which you wrote. A simple Helped-by: is sufficient if you want to
mention my name.
