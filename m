From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] Introduce remote.pushdefault
Date: Sat, 9 Feb 2013 13:20:31 +0530
Message-ID: <CALkWK0nq9Nir9NA9CxyajazrTxNURA_6r4kN6c3v+G8MtQtqsg@mail.gmail.com>
References: <7v1ucr43mk.fsf@alter.siamese.dyndns.org> <1360314123-1259-1-git-send-email-artagnon@gmail.com>
 <7v4nhm1s85.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 08:51:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U45DP-0002Nt-K1
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 08:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab3BIHux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 02:50:53 -0500
Received: from mail-ia0-f169.google.com ([209.85.210.169]:54255 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab3BIHuw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 02:50:52 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so5134920iaf.0
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 23:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ASWAwjP6pvel3XAq2hqA/IzGJv2LRFd9rAGCauDeRiE=;
        b=WOHcZ2orbsXdemefti72G62S/8ZwgwW1pyifrXv6VKTYKPrb0Bwx6H+Qp0192bcFM6
         q5dlAJaF+R+jhZVNxQHeMNU8fgvFeToG1W8BZsrIaIPlH3w7TpK70V7xwpj5NjQ0zN32
         jxjA8GJqxCrjug4bO0iEmpcevgov3PMnrAPaGJlnfIO7/S+wMI0dA8ppaAVE0uWllQcx
         p3/4B4tUVncdNg+mU2SaP0RPST9rk1mkUu7Q/zLIs1soq/iP1JUbgfRqBW7oAlvP0YtY
         wnSEZiE67s/OITgJb1kl2XiEFWwHXKTFfBYevqCncqb8Jmi02LNZ5mpKYuuNbabxF19B
         EFGw==
X-Received: by 10.42.67.10 with SMTP id r10mr13282184ici.7.1360396251976; Fri,
 08 Feb 2013 23:50:51 -0800 (PST)
Received: by 10.64.86.18 with HTTP; Fri, 8 Feb 2013 23:50:31 -0800 (PST)
In-Reply-To: <7v4nhm1s85.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215855>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 9b11597..82a4a78 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1884,6 +1884,10 @@ receive.updateserverinfo::
>>       If set to true, git-receive-pack will run git-update-server-info
>>       after receiving data from git-push and updating refs.
>>
>> +remote.pushdefault::
>> +     The remote to push to by default.  Overrides the
>> +     branch-specific configuration `branch.<name>.remote`.
>
> It feels unexpected to see "I may have said while on this branch I
> push there and on that branch I push somewhere else, but no, with
> this single configuration I'm invalidating all these previous
> statements, and all pushes go to this new place".
>
> Shouldn't the default be the default that is to be overridden by
> other configuration that is more specific?  That is, "I would
> normally push to this remote and unless I say otherwise that is all
> I have to say, but for this particular branch, I push to somehwere
> else".

Oops, I meant to have it overriden by branch-specific configuration.  Fixed now.

>> diff --git a/builtin/push.c b/builtin/push.c
>> index 42b129d..d447a80 100644
>> --- a/builtin/push.c
>> +++ b/builtin/push.c
>> @@ -322,7 +322,7 @@ static int push_with_options(struct transport *transport, int flags)
>>  static int do_push(const char *repo, int flags)
>>  {
>>       int i, errs;
>> -     struct remote *remote = remote_get(repo);
>> +     struct remote *remote = pushremote_get(repo);
>>       const char **url;
>>       int url_nr;
>>
>> diff --git a/remote.c b/remote.c
>> index e53a6eb..08bb803 100644
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
>> @@ -349,6 +350,14 @@ static int handle_config(const char *key, const char *value, void *cb)
>>       const char *subkey;
>>       struct remote *remote;
>>       struct branch *branch;
>> +     if (!prefixcmp(key,  "remote.")) {
>> +             name = key + 7;
>> +             if (!strcmp(name, "pushdefault")) {
>> +                     if (!value)
>> +                             return config_error_nonbool(key);
>> +                     pushremote_name = xstrdup(value);
>> +             }
>> +     }
>>       if (!prefixcmp(key, "branch.")) {
>>               name = key + 7;
>>               subkey = strrchr(name, '.');
>> @@ -388,8 +397,6 @@ static int handle_config(const char *key, const char *value, void *cb)
>>                       add_instead_of(rewrite, xstrdup(value));
>>               }
>>       }
>> -     if (prefixcmp(key,  "remote."))
>> -             return 0;
>
> Why is this no longer needed?
>
> All the remainder of this function is about "remote.*" config and
> this rejects other keys, like "user.name", etc.

I'm sorry.  I read that as if (!prefixcmp(key, "remote.")), which is
an entirely different thing.  Fixed now.

Thanks.
