From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Fri, 06 Mar 2015 16:28:16 -0800
Message-ID: <xmqqr3t1vefz.fsf@gitster.dls.corp.google.com>
References: <20150302092136.GA30278@lanh>
	<1425685087-21633-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 01:28:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU2bQ-0004VG-Di
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 01:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbbCGA2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 19:28:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750979AbbCGA2S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 19:28:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B11393E4F3;
	Fri,  6 Mar 2015 19:28:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wdYAq2nY/zOOPLA3OGzzAnDq5TI=; b=Jk63Ap
	JsjG83uUe0v/SNPAeOjdbvrWOa9NQL9TrPW6Z5JKsLDkvlfBj/HRHAAMSP7HjhAJ
	TXKi2NqY0G39QilNvA6RilsNFFxy3SrpAY25mHawb8FVl7BOaPjeapwhAfKWQ6mx
	qmPk/mrVRuXx6Pp6m2z8z8wFVgTkh85eS+1Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vIDY0hS7fh3e7dEWgn0d7rW4rEIIldiM
	VUx4f5yOmqy5lRsbyW1Xtf6Lrpab/A625pe1GcjdopUcpndOkpPkYDVoCzxaij6P
	9cXi/58k+eE8tw8FUw+fO1HaWBy3pVX4p5NJ2mVbSup7tLrYYxkr4+KEgpjnx3bw
	wg6HW7fui3Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A8D473E4F2;
	Fri,  6 Mar 2015 19:28:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 354DC3E4F1;
	Fri,  6 Mar 2015 19:28:17 -0500 (EST)
In-Reply-To: <1425685087-21633-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 6 Mar 2015 15:38:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D97738B6-C460-11E4-AA8D-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264980>

Stefan Beller <sbeller@google.com> writes:

> @@ -67,7 +74,6 @@ gracefully with an error message.
>    error-line     =  PKT-LINE("ERR" SP explanation-text)
>  ----
>  
> -
>  SSH Transport

Noise?

> @@ -124,9 +130,56 @@ has, the first can 'fetch' from the second.  This operation determines
>  what data the server has that the client does not then streams that
>  data down to the client in packfile format.
>  
> +Capability discovery (v2)
> +-------------------------
>  
> +In version 1, capability discovery is part of reference discovery and
> +covered in reference discovery section.
> +
> +In version 2, when the client initially connects, the server
> +immediately sends its capabilities to the client. Then the client must
> +send the list of server capabilities it wants to use to the server.
> +
> +   S: 00XXcapabilities 4\n
> +   S: 00XXcap:lang\n
> +   S: 00XXcap:thin-pack\n
> +   S: 00XXcap:ofs-delta\n
> +   S: 00XXagent:agent=git/2:3.4.5+custom-739-gb850f98\n
> +
> +   C: 00XXcapabilities 3
> +   C: 00XXcap:thin-pack\n
> +   C: 00XXcap:ofs-delta\n
> +   C: 00XXcap:lang=en\n
> +   C: 00XXagent:agent=git/custom_string\n

I do not see a good reason why we want "I am sending N caps"
upfront, instead of "this, that, and here is the end of the group".
If you expect the recipient to benefit by being able to pre-allocate
N slots, then that might make sense, but otherwise, I'd rather see
us stick to a (weaker) flush that says "group ends here".

Besides, I do not know how you counted 4 on the S: side and 3 on
the C: side in the above example and missing LF after 3 ;-).

> +----
> +  cap              =  PKT-LINE("capabilities" SP size LF list)

Isn't a cap packet terminated by LF without any "list" following it?
The notation PKT-LINE(<blah>) is "wrap <blah> in a single packet",
and I do not think you meant to send the capability line and a series
of cap:foo entries in a single packet.

> +  size             =  *DIGIT
> +  capability-list  =  *(capability) [agent LF]
> +  capability       =  "cap:" keyvaluepair LF
> +  agent            =  keyvaluepair LF

I do not see a reason to make 'agent' as part of capability.  That
was an implementation detail of v1 but v2 does not have an
obligation to consider agent announcement as capability.

server-announcement = PKT-LINE("capabilities" ...) capability-list [agent-announcement]
capability-list = as you have it w/o "[agent LF]"
agent-announcement = PKT-LINE("agent=" agent-token LF)

or something, perhaps?

> +The client MUST ignore any data before the pkt-line starting with "capabilities"
> +for future easy of extension.

s/easy/ease/; but I am not sure if this makes sense.  Without
knowing the extended preamble, you cannot even tell if a packet line
that happens to start with "capabilities" is a proper beginning of
0-th iteration of v2 protocol, or an embedded data in the preamble,
no?

> +Reference Discovery (v2)
> +------------------------
> +
> +In version 2, reference discovery is initiated by the client with
> +"want-refs" line. The client may skip reference discovery phase
> +entirely by not sending "want-refs" (e.g. the client has another way
> +to retrieve ref list).
> +
> +----
> +  want-refs  =  PKT-LINE("want-refs" SP mode *argument)
> +  mode       =  "all"
> +  argument   =  SP arg
> +  arg        =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
> +----
> +
> +Mode "all" sends all visible refs to the client like in version 1. No
> +arguments are accepted in this mode. More modes may be available based
> +on capabilities.

I tend to agree with Duy that the protocol must anticipate that args
can become longer.

> +----
> +  advertised-refs  =  (no-refs / list-of-refs)
> +		      *shallow
> +		      flush-pkt

I am not sure if defining "shallow" as part of "refs advertisement"
is a good idea.  The latter lives in the same place in the v1
protocol merely because that was how it was later bolted onto the
protocol.  But this concern can easily be allayed by retitling
"advertised-refs" to something else.
