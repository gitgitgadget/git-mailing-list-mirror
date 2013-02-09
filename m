From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] Introduce branch.<name>.pushremote
Date: Sat, 9 Feb 2013 13:16:38 +0530
Message-ID: <CALkWK0kp5SvbeTQgLRKWUAT_koSi0wyp6iPTC324iH8+D8oeJg@mail.gmail.com>
References: <1360307982-20027-1-git-send-email-artagnon@gmail.com> <7v8v6y1sih.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 08:47:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U459g-0008Vw-Pf
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 08:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab3BIHq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 02:46:59 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:43228 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab3BIHq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 02:46:59 -0500
Received: by mail-ia0-f174.google.com with SMTP id o25so5045558iad.33
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=k3+OBgCTYgQiWIX/MpqZ+xVFcH+0WLN0sSa80LVKT6Y=;
        b=kqxpBy3cchcgPpLKY9HAVbtv5JrWjsJWJqPLURMrTVw4djP90JPanWD0JE41X3HJ0X
         pp2gy12ZVN7xqxScNljC40kWwCvDZY1EPQQhemehA4ofmRUER5/trL7zaTjnyVK/AYOr
         ZKXS4Cyl80cq3XtIeAKkQlOCyHlL6FK14R84gX6SSSm7bE173DMTju4yd9l4TR+q8aI1
         DzNyD6hRSbz3bQmKBjm1LbRBOLwHH0lC7FUthutZLe5fW/izuE+HVvv1cdo9+XcCqT45
         SuCVh9rX66NgANsfOOi+mqDLm1ZF1lk2gWBpSZiqhISOSGmoX7oYnQJws/CICG0QzNAv
         ZYJg==
X-Received: by 10.50.189.163 with SMTP id gj3mr7316992igc.14.1360396018607;
 Fri, 08 Feb 2013 23:46:58 -0800 (PST)
Received: by 10.64.86.18 with HTTP; Fri, 8 Feb 2013 23:46:38 -0800 (PST)
In-Reply-To: <7v8v6y1sih.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215854>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> diff --git a/remote.c b/remote.c
>> index e53a6eb..d6fcfc0 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -48,6 +48,7 @@ static int branches_nr;
>>
>>  static struct branch *current_branch;
>>  static const char *default_remote_name;
>> +static const char *pushremote_name;
>>  static int explicit_default_remote_name;
>>
>>  static struct rewrites rewrites;
>> @@ -363,6 +364,12 @@ static int handle_config(const char *key, const char *value, void *cb)
>>                               default_remote_name = branch->remote_name;
>>                               explicit_default_remote_name = 1;
>>                       }
>> +             } else if (!strcmp(subkey, ".pushremote")) {
>> +                     if (!value)
>> +                             return config_error_nonbool(key);
>> +                     branch->pushremote_name = xstrdup(value);
>
> Perhaps use git_config_string()?

I was just following the style of the surrounding code without
thinking.  However, it looks like the surrounding code may be dated,
so I'll include a patch to update it to use git_config_string() before
making the change here.

>> +                     if (branch == current_branch)
>> +                             pushremote_name = branch->pushremote_name;
>
> Why is this global only when current_branch is involved?
>
> In other words, does it make sense to read branch.$name.pushremote
> for all the other irrelevant branches?
>
> In yet other words, perhaps adding pushremote_name to the branch
> structure is unneeded, and you only need this single global
> variable?

Frankly, I'm unhappy with this global.  Setting a global here and
subsequently reading it in pushremote_get() feels flaky.  Why use it
at all when we have branch->remote_name, branch->remote, and (the now
introduced) branch->pushremote_name?  I left the pushremote_name field
around, with the expectation that other codepaths that use the
remote_name field might be able to use it.

Thanks.
