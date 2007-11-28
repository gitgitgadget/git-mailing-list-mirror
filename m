From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 15:42:03 -0800
Message-ID: <7vve7m0wfo.fsf@gitster.siamese.dyndns.org>
References: <C1321BD5-8F6B-47F9-9BDB-C2BF819D6F17@midwinter.com>
	<20071128221403.GA3256@midwinter.com>
	<20071128230355.GB13964@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:42:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxWY3-0001Nq-D1
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbXK1XmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757547AbXK1XmM
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:42:12 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35609 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757536AbXK1XmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:42:09 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0B7A92EF;
	Wed, 28 Nov 2007 18:42:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A3759AA39;
	Wed, 28 Nov 2007 18:42:27 -0500 (EST)
In-Reply-To: <20071128230355.GB13964@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Nov 2007 18:03:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66464>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 28, 2007 at 02:14:03PM -0800, Steven Grimm wrote:
>
>> @@ -177,7 +179,16 @@ static int receive_status(int in, struct ref *refs)
>>  
>>  		line[strlen(line)-1] = '\0';
>>  		refname = line + 3;
>> -		msg = strchr(refname, ' ');
>> +		newsha1_hex = strchr(refname, ' ');
>> +		if (newsha1_hex) {
>> +			*newsha1_hex++ = '\0';
>> +			if (get_sha1_hex(newsha1_hex, newsha1)) {
>> +				fprintf(stderr, "protocol error: bad sha1 %s\n",
>> +					newsha1_hex);
>> +				newsha1_hex = NULL;
>> +			}
>> +		}
>> +		msg = strchr(newsha1_hex, ' ');
>>  		if (msg)
>>  			*msg++ = '\0';
>
> Doesn't this always put the first "word" of a response into newsha1_hex?
> We want to do this only for 'ok' responses; 'ng' responses are already
> using that space as part of the error message.

I do not think reporting back the rewritten object name makes much sense
nor adds any value; it won't be useful information until you fetch the
object.

I do not think reporting back _anything_ other than "ok" adds much value
at all.  Sure, if the update hook did something funky you would get such
a report, but the situation is not any different if some warm body is
sitting on the other end and building on top of what you pushed
immediately he sees any push into the repository, and in such a case
your git-push would not get any such reporting anyway.

We do not even have to worry about this reporting at all if we do not
allow munging the refs in the update hook.  In a sense, this patch is
creating a problem that does not need to be solved.  Perhaps modifying
update hook to allow so makes it possible to munge refs while holding a
lock, but is it really worth this hassle?  Isn't there a better way, I
wonder?
