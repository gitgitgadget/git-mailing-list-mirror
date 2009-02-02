From: Moriyoshi Koizumi <mozo@mozo.jp>
Subject: Re: [PATCH] Support various HTTP authentication methods
Date: Mon, 2 Feb 2009 17:38:17 +0900
Message-ID: <cd1fb7540902020038p4ea767c0rd01aecf62d20ff07@mail.gmail.com>
References: <7v3af2h1b0.fsf@gitster.siamese.dyndns.org>
	 <E1LTqDN-0003MF-DP@lena.gsc.riken.jp>
	 <1233556274-1354-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 09:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTuLJ-0000tF-Ku
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 09:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbZBBIiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 03:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbZBBIiT
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 03:38:19 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:10918 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZBBIiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 03:38:18 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1382389rvb.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 00:38:17 -0800 (PST)
Received: by 10.141.86.4 with SMTP id o4mr2197985rvl.172.1233563897346; Mon, 
	02 Feb 2009 00:38:17 -0800 (PST)
In-Reply-To: <1233556274-1354-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108071>

On Mon, Feb 2, 2009 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Applying style fixes to the existing code is very much appreciated, *but*
> please make such a clean-up patch a separate one.  A two-patch series
> whose [1/2] is such a pure clean-up without any feature change, with [2/2]
> that adds code to the cleaned-up state would be much less distracting for
> people who nitpick your changes.

Okay, I'll try to do so next time.

>> @@ -153,11 +159,69 @@ static int http_options(const char *var, const char *value, void *cb)
>>                       return git_config_string(&curl_http_proxy, var, value);
>>               return 0;
>>       }
>> +#if LIBCURL_VERSION_NUM >= 0x070a06
>> +     if (!strcmp("http.auth", var)) {
>> +             if (curl_http_auth == NULL)
>> +                     return git_config_string(&curl_http_auth, var, value);
>> +             return 0;
>> +     }
>> +#endif
>> +#if LIBCURL_VERSION_NUM >= 0x070a07
>> +     if (!strcmp("http.proxy_auth", var)) {
>> +             if (curl_http_proxy_auth == NULL)
>> +                     return git_config_string(&curl_http_proxy_auth, var, value);
>> +             return 0;
>> +     }
>> +#endif
>
> If you follow config.c::git_config() you will notice that we read from
> /etc/gitconfig, $HOME/.gitconfig and then finally $GIT_DIR/config.  By
> implementing "if we already have read curl_http_auth already, we will
> ignore the later setting" like above code does, you break the general
> expectation that system-wide defaults is overridable by $HOME/.gitconfig
> and that is in turn overridable by per-repository $GIT_DIR/config.

But aren't the globals supposed to be set just here? I guessed you
assume that these are set elsewhere and then it prevents the values
provided later from being applied.

> The preferred order would be:
>
>  - Use the value obtained from command line parameters, if any;
>
>  - Otherwise, if an environment variable is there, use it;
>
>  - Otherwise, the value obtained from git_config(), with "later one wins"
>    rule.
>
> I think you are not adding any command line option, so favoring
> environment and then using configuration is fine, but the configuration
> parser must follow the usual "later one wins" rule to avoid dissapointing
> the users.

I just followed the way other options behave. I was just not sure how
I was supposed to deal with them.

>> +#if LIBCURL_VERSION_NUM >= 0x070a06
>> +static long get_curl_auth_bitmask(const char* auth_method)
>
> In git codebase, asterisk that means "a pointer" sticks to the variable
> name not to type name; "const char *auth_method" (I see this file is
> already infested with such style violations, but if you are doing a
> separate clean-up patch it would be appreciated to clean them up).
>

I'm not willing to do it this time ;-)

>> +{
>> +     char buf[4096];
>
> Do you need that much space?

I think as long as we use fixed-size buffers, I should get them enough
sized. If this is not preferrable, then it'd be better off using
heap-allocated buffers.

>> +     const unsigned char *p = (const unsigned char *)auth_method;
>> +     long mask = CURLAUTH_NONE;
>> +
>> +    strlcpy(buf, auth_method, sizeof(buf));
>
> A tab is 8-char wide.

Sorry about this. I actually was careful but I just forgot to turn off
the tab expansion for the second time.

> What happens when auth_method is longer than 4kB?
>
>> +
>> +     for (;;) {
>> +             char *q = buf;
>> +             while (*p && isspace(*p))
>> +                     ++p;
>
> If there is no particular reason to choose one over the other, please use
> postincrement, p++, as other existing parts of the codebase.
>
> I'll try to demonstrate what (I think) this patch should look like as a
> pair of follow-up messages to this one, but I am not sure about my rewrite
> of get_curl_auth_bitmask().  Please consider it as an easter-egg bughunt
> ;-)

I anyway appreciate this kind of knit-picking as I'd do so to newbies.
Thanks very much for the advice.

Regards,
Moriyoshi
