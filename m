From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Thu, 14 Jan 2016 21:57:44 +0100
Message-ID: <56980BC8.90506@kdbg.org>
References: <1452708927-9401-1-git-send-email-sbeller@google.com>
 <xmqq4mehm92b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:58:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJoyJ-0000F0-Eb
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 21:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbcANU6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 15:58:08 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:21856 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755903AbcANU5s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 15:57:48 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3phHyx6jl8z5tlC;
	Thu, 14 Jan 2016 21:57:45 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 188A351ED;
	Thu, 14 Jan 2016 21:57:45 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqq4mehm92b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284092>

Am 13.01.2016 um 23:03 schrieb Junio C Hamano:
> Stefan Beller <sbeller@google.com> writes:
>> +	while (url) {
>> +		if (starts_with_dot_dot_slash(url)) {
>> +			char *rfind;
>> +			url += 3;
>> +
>> +			rfind = last_dir_separator(remoteurl);
>> +			if (rfind)
>> +				*rfind = '\0';
>> +			else {
>> +				rfind = strrchr(remoteurl, ':');
>> +				if (rfind) {
>> +					*rfind = '\0';
>> +					colonsep = 1;
>> +				} else {
>> +					if (is_relative || !strcmp(".", remoteurl))
>> +						die(_("cannot strip one component off url '%s'"), remoteurl);
>> +					else
>> +						remoteurl = xstrdup(".");
>> +				}
>> +			}
>
> It is somewhat hard to see how this avoids stripping one (or both)
> slashes just after "http:" in remoteurl="http://site/path/", leaving
> just "http:/" (or "http:").
>
> This codepath has overly deep nesting levels.  Is this the simplest
> we can do?

The code as written is quite easy to follow when compared to the 
original shell code. I think that is a reasonable goal, and improvements 
can into separate patches.

>
> The final else { if .. else } can be made into else if .. else to
> dedent the overlong die() by one level, but I am wondering if the
> deep nesting is just a symptom of logic being unnecessarily complex.
>
>> +		} else if (starts_with_dot_slash(url)) {
>> +			url += 2;
>> +		} else
>> +			break;
>> +	}

For example, the section that begins here...

>> +	strbuf_reset(&sb);
>> +	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
>> +
>> +	if (starts_with_dot_slash(sb.buf))
>> +		out = xstrdup(sb.buf + 2);
>> +	else
>> +		out = xstrdup(sb.buf);
>> +	strbuf_reset(&sb);
>> +
>> +	free(remoteurl);
>> +	if (!up_path || !is_relative)
>> +		return out;
>> +
>> +	strbuf_addf(&sb, "%s%s", up_path, out);
>> +	free(out);
>> +	return strbuf_detach(&sb, NULL);


... and ends here can easily be rewritten to become a single 
strbuf_addf() without the xstrdup()s and without the early exit (at the 
cost of some additional ?: conditionals in the arguments).

-- Hannes
