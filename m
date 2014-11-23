From: Alex Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] exec_cmd: system_path memory leak fix
Date: Mon, 24 Nov 2014 01:06:32 +0600
Message-ID: <87tx1pensq.fsf@gmail.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com> <1416750981-24446-2-git-send-email-kuleshovmail@gmail.com> <xmqqioi5ycme.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 20:10:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XscXy-0002HC-TL
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 20:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbaKWTKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 14:10:04 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:37251 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbaKWTKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 14:10:03 -0500
Received: by mail-lb0-f181.google.com with SMTP id 10so1629884lbg.26
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-type;
        bh=Lh0VfmeFbtw2fi3f/BrK4gqbVJ/CWCcI4fCAxn/dSd8=;
        b=rEJJ+lbxLzDJJYPM2TD9vrrsfWukZycv37Vqf1ek4YTTc/OrhTvuZUS0gHeRTU4OXl
         ublTujro8W3hIhwpuLR4ybhd6e67ci7oigpNTZ3uZ8n0aGeqB025Ra7pEmlGsZbgBu8j
         dQBxwsX5jdZ+Bu5MqREVC2be4ZTl+hezQeqe1chkH6e8rCQyVVo8YlZAmzp77GZYPsBE
         3xlrCGan1/0Pxf/TWEOs9QkxjhqeB7YcqMkobiZSoOVhWO/k25snnJYCw2aSyrO5TBAU
         QoWcZmQ0PRXyj26EDe7e+J5BdLsvctnAH7pIeBxw3fVT55zpgMTckDLNCuVkk1i1QJaV
         aivw==
X-Received: by 10.112.133.138 with SMTP id pc10mr16759242lbb.48.1416769801158;
        Sun, 23 Nov 2014 11:10:01 -0800 (PST)
Received: from alex-desktop ([92.46.104.67])
        by mx.google.com with ESMTPSA id pc6sm2925067lbc.49.2014.11.23.11.09.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Nov 2014 11:10:00 -0800 (PST)
In-reply-to: <xmqqioi5ycme.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260098>


Junio C Hamano <gitster@pobox.com> @ 2014-11-24 00:51 ALMT:

> 0xAX <kuleshovmail@gmail.com> writes:
>
>> Signed-off-by: 0xAX <kuleshovmail@gmail.com>
>> ---
>
> The comment on names I've already mentioned elsewhere.

Yes, i understand about names.

>
> You need a better explanation than a "no log message", as you are
> not doing "system-path memory leak fix".
>
> You are doing a lot more.  Perhaps the story would start like this:
>
>     system_path(): make the callers own the returned string

Did it.

>
>     The function sometimes returns a newly allocated string and
>     sometimes returns a borrowed string, the latter of which the
>     callers must not free().
>
>     The existing callers all assume that the return value belongs to
>     the callee and most of them copy it with strdup() when they want
>     to keep it around.  They end up leaking the returned copy when
>     the callee returned a new string.
>
>     Change the contract between the callers and system_path() to
>     make the returned string owned by the callers; they are
>     responsible for freeing it when done, but they do not have to
>     make their own copy to store it away.

Yes you're right, i just started to read git source code some days ago,
and it's hard to understand in some places for the start. Now i see it,
thanks for explanation.

>
>     This accidentally fixes some unsafe callers as well.  For
>     example, ...
>
>
>>  exec_cmd.c | 25 ++++++++++++++++---------
>>  exec_cmd.h |  4 ++--
>>  git.c      | 12 +++++++++---
>
> Even though I said that this changes the contract between the caller
> and the callee and make things wasteful for some, I personally think
> it is going in the right direction.
>
> The change accidentally fixes some unsafe callers.  For example, the
> first hit from "git grep system_path" is this:
>
>     attr.c- static const char *system_wide;
>     attr.c- if (!system_wide)
>     attr.c:         system_wide = system_path(ETC_GITATTRIBUTES);
>     attr.c- return system_wide;
>
> This is obviously unsafe for a volatile return value from the callee
> and needs to have strdup() on it, but with the patch there no longer
> is need for such a caller-side strdup().
>
> But this change also introduces new bugs, I think.  For example, the
> second hit from "git grep system_path" is this:
>
>   builtin/help.c: strbuf_addstr(&new_path, system_path(GIT_MAN_PATH));
>
> Now the caller owns and is responsible for freeing the returned
> value, but without opening the file in question in an editor or a
> pager we can tell immediately that there is no way this line is not
> adding a new memory leak.
>
>> index 698e752..08f8f80 100644
>> --- a/exec_cmd.c
>> +++ b/exec_cmd.c
>> @@ -6,7 +6,7 @@
>>  static const char *argv_exec_path;
>>  static const char *argv0_path;
>>
>> -const char *system_path(const char *path)
>> +char *system_path(const char *path)
>>  {
>>  #ifdef RUNTIME_PREFIX
>>  	static const char *prefix;
>> @@ -14,9 +14,10 @@ const char *system_path(const char *path)
>>  	static const char *prefix = PREFIX;
>>  #endif
>>  	struct strbuf d = STRBUF_INIT;
>> +	char *new_path = NULL;
>>
>>  	if (is_absolute_path(path))
>> -		return path;
>> +		return strdup(path);
>>
>>  #ifdef RUNTIME_PREFIX
>>  	assert(argv0_path);
>> @@ -32,10 +33,13 @@ const char *system_path(const char *path)
>>  				"Using static fallback '%s'.\n", prefix);
>>  	}
>>  #endif
>> -
>>  	strbuf_addf(&d, "%s/%s", prefix, path);
>> -	path = strbuf_detach(&d, NULL);
>> -	return path;
>> +	new_path = malloc((strlen(prefix) + strlen(path)) + 2);
>> +	sprintf(new_path, "%s/%s", prefix, path);
>> +
>> +	strbuf_release(&d);
>> +
>> +	return new_path;
>
> Are you duplicating what strbuf_addf() is doing on the strbuf d,
> manually creating the same in new_path, while discarding what the
> existing code you did not remove with this patch already computed?
>
> Isn't it sufficient to add strdup(path) for the absolute case and do
> nothing else to this function?  I have no idea what you are doing
> here.

I have added changes from your previous feedback, how can I attach
second (changed) patch to this mail thread with git send-email?

--
Best regards.
0xAX
