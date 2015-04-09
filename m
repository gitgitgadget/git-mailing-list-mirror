From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [v6 PATCH] daemon: add systemd support
Date: Wed, 08 Apr 2015 20:51:38 -0700
Message-ID: <xmqqr3ruarhx.fsf@gitster.dls.corp.google.com>
References: <1428372206-120089-1-git-send-email-shawn@churchofgit.com>
	<5523B933.8080302@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Landden <shawn@churchofgit.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Apr 09 05:52:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yg3Vm-0007if-JW
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 05:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbbDIDwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 23:52:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754949AbbDIDvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 23:51:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E881C47F92;
	Wed,  8 Apr 2015 23:51:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bjWwkZ/EyzJqE4Wi9hDdsAsiO4Q=; b=h3FPt8
	ihHCejw4LEabIg4jByr6bMqWv4LHa/DC9gVRBb7tELbTjylkR9wrdGEc5uYDEDv3
	ZSIFID3/76GQ5friFEzOG7VQFzG+QeOqu3RO6tDvyuYJ0gd9c8yF3LfbVjsae66I
	o2U954xKT6VHjJqj2QwkQgOPAiTRM3LWfwwFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WO5h3Xiyi3+XBxlZgRZqVwRzNGMyzFE4
	mIh/pErJiuH7AQC42JR7yr/N3U7BblIRE8RZjU14KgURoZr/ZtovmwzUKSQakx9k
	lqobILX/2b4vAbj1kG/XtyE/b98PayXetlu/jRAWLsQqsZh35VOAgmrLAclUablw
	WkiYrMxmeWI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0A7D47F91;
	Wed,  8 Apr 2015 23:51:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EEA747F90;
	Wed,  8 Apr 2015 23:51:39 -0400 (EDT)
In-Reply-To: <5523B933.8080302@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Tue, 07 Apr 2015 12:02:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA1E3E36-DE6B-11E4-83AE-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266981>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On 07/04/15 03:03, Shawn Landden wrote:
>> systemd supports git-daemon's existing --inetd mode as well.
>> --systemd allows git-daemon has the advantage of allowing one git-daemon
>> to listen to multiple interfaces as well as the system one(s),
>> and more allow git-daemon to not be spawned on every connection.
>> 
>> Signed-off-by: Shawn Landden <shawn@churchofgit.com>
>> ---
>
> I have not been following this patch review, but I just happened to
> notice something while skimming the patch as this email floated by ...
>
>> Respond to review by Eric Sunshine here:
>> http://marc.info/?l=git&m=142836529908207&w=2
>> 
>
> [snip]
>
>> diff --git a/daemon.c b/daemon.c
>> index 9ee2187..9880858 100644
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -1,3 +1,7 @@
>> +#ifdef HAVE_SYSTEMD
>> +#  include <systemd/sd-daemon.h>
>> +#endif
>> +
>>  #include "cache.h"
>>  #include "pkt-line.h"
>>  #include "exec_cmd.h"
>> @@ -28,7 +32,11 @@ static const char daemon_usage[] =
>>  "           [--(enable|disable|allow-override|forbid-override)=<service>]\n"
>>  "           [--access-hook=<path>]\n"
>>  "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
>> +#ifdef HAVE_SYSTEMD
>> +"                      [--systemd | [--detach] [--user=<user> [--group=<group>]]]\n" /* exactly 80 characters */
>> +#else
>>  "                      [--detach] [--user=<user> [--group=<group>]]\n"
>> +#endif
>>  "           [<directory>...]";
>>  
>>  /* List of acceptable pathname prefixes */
>> @@ -1176,11 +1184,23 @@ static void store_pid(const char *path)
>>  }
>>  
>>  static int serve(struct string_list *listen_addr, int listen_port,
>> -    struct credentials *cred)
>> +    struct credentials *cred, int systemd_mode)
>>  {
>>  	struct socketlist socklist = { NULL, 0, 0 };
>>  
>
> ... this hunk splits a statement in two ...
>
>> -	socksetup(listen_addr, listen_port, &socklist);
>> +#ifdef HAVE_SYSTEMD
>> +	if (systemd_mode) {
>> +		int i, n;
>> +
>> +		n = sd_listen_fds(0);
>> +		ALLOC_GROW(socklist.list, socklist.nr + n, socklist.alloc);
>> +		for (i = 0; i < n; i++)
>> +			socklist.list[socklist.nr++] = SD_LISTEN_FDS_START + i;
>> +	}
>> +
>> +	if (listen_addr->nr > 0 || !systemd_mode)
>> +#endif
>> +		socksetup(listen_addr, listen_port, &socklist);
>
> ... here. I have not considered any possible subtlety in the code, but simply
> considering the patch text, I think the following may be easier to read:
>
>     #ifdef HAVE_SYSTEMD
>     	if (systemd_mode) {
>     	...
>     	}
>
>     	if (listen_addr->nr > 0 || !systemd_mode)
>     		socksetup(listen_addr, listen_port, &socklist);
>     #else
>     	socksetup(listen_addr, listen_port, &socklist);
>     #endif
>
> Or, maybe:
>
>     #if !defined(HAVE_SYSTEMD)
>     	socksetup(listen_addr, listen_port, &socklist);
>     #else
>     	...
>     #endif
>
> Or, ... ;-)


Yes, I'd really prefer to avoid #if/#else#endif in the main
codeflow.

It is vastly prefereable, if you can arrange so, to have a set of
helper functions

#if USE_SYSTEMD
static void enumerate_sockets(struct socklist *slist)
{
    ... /* do systemd specific enumeration */
}
#else
static void enumerate_sockets(struct socklist *slist)
{
    ... /* something else */
}
#endif

and then just call that helper from the main codeline.

	enumerate_sockets(&socklist);
        socksetup(...);

without #ifdef/#else/#endif
