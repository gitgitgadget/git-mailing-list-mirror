From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] pretty.c: make git_pretty_formats_config return -1 on
 git_config_string failure
Date: Mon, 4 Aug 2014 14:56:03 -0400
Message-ID: <CAPig+cRo05mG9yeU61VSjAvXWRHU9soaaH-Cv7MKoxZ=it15Rw@mail.gmail.com>
References: <1407163275-3006-1-git-send-email-tanayabh@gmail.com>
	<vpqmwbki7h3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tanay Abhra <tanayabh@gmail.com>, Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 04 20:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XENQb-00038y-AH
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbaHDS4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:56:08 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:41778 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbaHDS4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:56:04 -0400
Received: by mail-yh0-f52.google.com with SMTP id t59so4628766yho.11
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SNwQtPKuK14roO7B0KmqE2QnnuIce9KeFqomiIwYG6U=;
        b=SzBnZmwKlgBBoyFZMW7Su4RZm/R5dvtZJy2L38N5RQ3/Q71hVymfsxxSjUiWK35A8d
         PNH+hVzC1R2/BUUXE3WKf+ZMSrGzd3KKQZGX/K20VlBAWL9GL+A6hae0YbQYIyeRiauC
         GCE/NrGNlqJN6a1rvADwFc8p/pXDJqxaojRq6uIMBS1C9yFyU9OonKlqWWAFPo04Icup
         xgWcnl4AQqn8uNEbuYKhvInqwHydq/4B/TZY6+C34AWZ9ELjHdyQ9s624f1L0ycj7HLl
         GNQU/xib22Sig4f6Nml9T9kam4V5JIJBOhIruNYOz/qktvA0wsn1jexb2+CyIaYHEnDx
         H2pw==
X-Received: by 10.236.82.147 with SMTP id o19mr40391431yhe.112.1407178563906;
 Mon, 04 Aug 2014 11:56:03 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Mon, 4 Aug 2014 11:56:03 -0700 (PDT)
In-Reply-To: <vpqmwbki7h3.fsf@anie.imag.fr>
X-Google-Sender-Auth: WSEWJm6-4MfuBHi0O01IhetxgHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254766>

On Mon, Aug 4, 2014 at 11:45 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> `git_pretty_formats_config()` continues without checking git_config_string's
>> return value which can lead to a SEGFAULT.
>
> Indeed, without the patch:
>
> $ git -c pretty.my= log --pretty=my
> error: Missing value for 'pretty.my'
> zsh: segmentation fault  git -c pretty.my= log --pretty=my

This probably should be formalized as a proper test and included with
Tanay's patch.

>> diff --git a/pretty.c b/pretty.c
>> index 3a1da6f..72dbf55 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -65,7 +65,9 @@ static int git_pretty_formats_config(const char *var, const char *value, void *c
>>
>>       commit_format->name = xstrdup(name);
>>       commit_format->format = CMIT_FMT_USERFORMAT;
>> -     git_config_string(&fmt, var, value);
>> +     if (git_config_string(&fmt, var, value))
>> +             return -1;
>> +
>
> Ack-ed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> My first thought reading this was "why not rewrite using non-callback
> API?", but this particular call to git_config needs to iterate over
> config keys anyway.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
