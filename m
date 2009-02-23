From: Eugene Letuchy <eletuchy@gmail.com>
Subject: Re: [PATCH 1/2] Make git blame's date output format configurable, 
	like git log
Date: Mon, 23 Feb 2009 01:09:13 -0800
Message-ID: <fbb390660902230109k15ed55b7le2ab08bb7dc274b6@mail.gmail.com>
References: <1235170271-10694-1-git-send-email-eletuchy@gmail.com>
	 <20090222230358.GA19011@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org,
	Eugene Letuchy <eugene@facebook.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 10:10:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbWpv-0000Lx-2x
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 10:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbZBWJJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 04:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbZBWJJS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 04:09:18 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:58781 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbZBWJJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 04:09:16 -0500
Received: by bwz5 with SMTP id 5so4490883bwz.13
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 01:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7mr9kafsp/qnmHyenIQIlAApX80klfyjAAA2YNm/IEY=;
        b=XZhgZ97C1AWWKwzCBLcj/uAnXFXAbP2PmyVZq/Uw7R1VSBVFJwdnjTmeR6a8ZkoQfM
         tuC7vWG2rusXwa2gm82BozttAlqJNoeZkit8r9lrPLL8Ooc672ElLHGIrNY8IyMLWx3t
         xy3ijnRS2EcHfbfuIWBH7mKrAKloke44Hf3IE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WTjB2eHEO2xfQXPzw/0tmGFiSt1sEbsIX18oRA9hq79NXn1wpaneMhZgPT/1NoEkxa
         v+hLXa9yzl1FUjCV1Ub9sdbc9NbKsfjgSNxUJzToNQwhfwnOe0TwseXWD+gYBXA2t9wZ
         uDL0nre71UCwELJj4sWADGjZr2X3RXNYwmiUQ=
Received: by 10.181.134.11 with SMTP id l11mr1457943bkn.73.1235380153624; Mon, 
	23 Feb 2009 01:09:13 -0800 (PST)
In-Reply-To: <20090222230358.GA19011@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111124>

On Sun, Feb 22, 2009 at 3:03 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 20, 2009 at 02:51:11PM -0800, eletuchy@gmail.com wrote:
>
>> @@ -1975,6 +1975,9 @@ static int git_blame_config(const char *var, const char *value, void *cb)
>>               blank_boundary = git_config_bool(var, value);
>>               return 0;
>>       }
>> +     if (!strcmp(var, "blame.date") && value[0]) {
>> +             blame_date_mode = parse_date_format(value);
>> +     }
>>       return git_default_config(var, value, cb);
>>  }
>
> When there is a config value we are expecting to have a value rather
> than a boolean, we usually print an error rather than silently
> discarding. IOW, something like this:
>
>  if (!strcmp(var, "blame.date")) {
>          if (!value)
>                  return config_error_nonbool(var);
>          blame_date_mode = parse_date_format(value);
>  }
>

I'll make that change to the patch.

>> +     switch (blame_date_mode) {
>> +     case DATE_RFC2822:
>> +             blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
>> +             break;
>> +     case DATE_ISO8601:
>> +             blame_date_width = sizeof("2006-10-19 16:00:04 -0700");
>> +             break;
>> +     case DATE_SHORT:
>> +             blame_date_width = sizeof("2006-10-19");
>> +             break;
>> +     case DATE_RELATIVE:
>> +             /* unfortunately "normal" is the fallback for "relative" */
>> +             /* blame_date_width = sizeof("14 minutes ago"); */
>> +             /* break; */
>> +     case DATE_LOCAL:
>> +     case DATE_NORMAL:
>> +             blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
>> +             break;
>> +     }
>> +     blame_date_width -= 1; /* strip the null */
>
> Maybe this should be a date_format_width() library function?
>

I think that's a possible change, but unfortunately my next two
patches would not apply cleanly with a date_format_width change.

I'm a n00b with respect to git contribution, but is there a procedure
for pushing my blame_date branch remotely so that it's possible to
track a series of patches?

>
> Other than that, the patch looks reasonable to me.
>
> -Peff
>



-- 
Eugene
