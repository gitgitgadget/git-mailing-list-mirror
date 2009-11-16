From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http-backend: Fix access beyond end of string.
Date: Sun, 15 Nov 2009 22:12:31 -0800
Message-ID: <7viqdb0zhs.fsf@alter.siamese.dyndns.org>
References: <1258233058-2348-1-git-send-email-tarmigan+git@gmail.com>
 <20091116013654.GX11919@spearce.org>
 <20091116045532.GC14664@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 07:12:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9upX-0000MY-I3
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 07:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbZKPGMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 01:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbZKPGMj
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 01:12:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbZKPGMi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 01:12:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D566D808BE;
	Mon, 16 Nov 2009 01:12:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oQmf2PeqnJcQH00pfcVWZVZ9pwA=; b=A4PJcd
	rOiGLIejSPANpWemCHDSABUIRwE+CwFbwXwNyqCXLCLm43UlU9h9f4aSGZUJJNSD
	QtD/NKIS9GbG2ru95znwGoBHI3OmPZdbc5bqGvuC8LoFxGoXJLLXCWtfSKWPJziV
	Zawt02rCiQUmOZRvjW1JNDYIQaEJzkLIPwa/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=De7rW83kYW9UD2aaToZr7eD2tBL7soUl
	WUEKmUTEbfdYkh0OlYZ9Z0zTvrp7OdEOwlQOiPE36/BRhYtHgYL0Pxs0NqONJTVl
	CbiCgB4wUL2ug2xxnfsA9VI7SYHquj1KDbeVKsW9ha856Zc8u1o6pRGALho/qg0E
	We/JXrR/XpQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A760808BD;
	Mon, 16 Nov 2009 01:12:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44A30808BC; Mon, 16 Nov
 2009 01:12:33 -0500 (EST)
In-Reply-To: <20091116045532.GC14664@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 15 Nov 2009 23\:55\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0B0D27FA-D277-11DE-8571-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132987>

Jeff King <peff@peff.net> writes:

> On Sun, Nov 15, 2009 at 05:36:54PM -0800, Shawn O. Pearce wrote:
> ...
>> Shouldn't this instead be:
>> 
>> diff --git a/http-backend.c b/http-backend.c
>> index 9021266..16ec635 100644
>> --- a/http-backend.c
>> +++ b/http-backend.c
>> @@ -626,7 +626,7 @@ int main(int argc, char **argv)
>>  			}
>>  
>>  			cmd = c;
>> -			cmd_arg = xmalloc(n);
>> +			cmd_arg = xmalloc(n + 1);
>>  			strncpy(cmd_arg, dir + out[0].rm_so + 1, n);
>>  			cmd_arg[n] = '\0';
>>  			dir[out[0].rm_so] = 0;
>> 
>> The cmd_arg string was simply allocated too small.  Your fix is
>> terminating the string one character too short which would cause
>> get_loose_object and get_pack_file to break.
>
> Actually, from my reading, I think his fix is right, because you trim
> the first character during the strncpy (using "out[0].rm_so + 1").

Your regexps all start with leading "/", and rm_so+1 points at the
character after the slash; the intention being that you would copy
the rest of the matched sequence without the leading "/".

So allocating n = rm_eo - rm_so is Ok.  It counts the space for
terminating NUL.  But copying "up to n bytes" using strncpy(), only to NUL
terminate immediately later, is dubious.  You would want to copy only n-1
bytes.  I.e.

	n = out[0].rm_eo - out[0].rm_so; /* allocation */
        ... validate and fail invalid method ...
        cmd_arg = xmalloc(n);
        memcpy(cmd_arg, dir + out[0].rm_so + 1, n-1);
        cmd_arg[n-1] = '\0';
