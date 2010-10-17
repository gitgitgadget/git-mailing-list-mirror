From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 08/15] daemon: use run-command api for async serving
Date: Sat, 16 Oct 2010 21:43:47 -0700
Message-ID: <7veibp5szg.fsf@alter.siamese.dyndns.org>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-9-git-send-email-kusmabite@gmail.com>
 <7vpqvdhfra.fsf@alter.siamese.dyndns.org>
 <AANLkTikyxEB0VRg1jWd-AdR0uyxExw7O9YQfXJzu-f_M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 17 06:44:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7L6U-0003U5-Qy
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 06:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab0JQEoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 00:44:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0JQEoC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 00:44:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47D4BDFC25;
	Sun, 17 Oct 2010 00:44:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=cbOcaV6IyQhtJeS5s8pY2G17lvU=; b=bYIZ6iphbLvkStXdb/3dg6K
	diQS5ntY2gxta89bP5rrni7U8r100mRoMKiJ73ldwfzxjV3LOLyc4Ae00eiRzPNT
	+4dyDsDbIjq+rBJSKHUw+hZpPe3fbcjra4Vhk7+rCaE/6SWQz7qIAoxwNephacqc
	hVMSDXvycBULuhcn6BGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NHoz/Ez6SB64UYMO5pqAODJG1sUX1lrYoSq7wg0o9QBGQNEnd
	EmRrCoZ4TJk7+e4dgZOQcG1jpkJE4xc166/XE2hDZ5zKpCtVCuJtDS2sWdhRa//1
	rvg2CHowldmOoNnpGyZP6ET321cHJm97pwqeC0HLPe4gfSpjCTRm87IgsE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CCDFDDFC23;
	Sun, 17 Oct 2010 00:43:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFDCBDFC1E; Sun, 17 Oct
 2010 00:43:48 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2633641A-D9A9-11DF-9F81-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159195>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Thu, Oct 14, 2010 at 12:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>> ...
>>> @@ -1017,7 +1005,12 @@ int main(int argc, char **argv)
>>> +             if (inetd_mode && !freopen("/dev/null", "w", stderr))
>>>                       die_errno("failed to redirect stderr to /dev/null");
>>
>> This is not particularly a good style.  Please make it more clear that we
>> freopen in inetd mode by writing it like this:
>>
>>        if (inetd_mode) {
>>                if (!freopen(...))
>>                        die_errno(...)
>>        }
>>
>>
>
> Much nicer, yeah. Now I'm tempted to do this also:
> ...

Yeah, that is much much saner.  Thanks.

> ---8<---
> diff --git a/daemon.c b/daemon.c
> index 7f5d72f..11a5e06 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1010,7 +1010,6 @@ int main(int argc, char **argv)
>  			continue;
>  		}
>  		if (!strcmp(arg, "--inetd")) {
> -			serve_mode = 1;
>  			inetd_mode = 1;
>  			log_syslog = 1;
>  			continue;
> @@ -1159,7 +1158,7 @@ int main(int argc, char **argv)
>  			die_errno("failed to redirect stderr to /dev/null");
>  	}
>
> -	if (serve_mode) {
> +	if (inetd_mode || serve_mode) {
>  		struct sockaddr_storage ss;
>  		struct sockaddr *peer = (struct sockaddr *)&ss;
>  		socklen_t slen = sizeof(ss);
> ---8<---
