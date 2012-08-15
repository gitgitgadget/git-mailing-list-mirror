From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 04/16] Connect fast-import to the remote-helper
 via pipe, adding 'bidi-import' capability.
Date: Wed, 15 Aug 2012 10:41:55 -0700
Message-ID: <7vboic6oik.fsf@alter.siamese.dyndns.org>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <7v4no59phn.fsf@alter.siamese.dyndns.org> <2444647.P1AdWcSsQk@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 19:42:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1hba-0002sy-6i
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 19:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013Ab2HORl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 13:41:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755988Ab2HORl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 13:41:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED11989A6;
	Wed, 15 Aug 2012 13:41:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GT4AVhbsLyCyBPNbr8bIwJnNtcA=; b=ZQq98N
	TXUAVFrpXeALm86h7oRHFC/XI53xURL8Et/2DbOAhTFpzS7WnayoXrLA+Al+W63p
	VRrk4H02eRiu5OaMOPAyoSRzILe2XDOWByiP9Rrsv6LojU0BwNJXR30AvaPZWNCX
	4SbQh+Ut7OzM9SvkS5QQos/opnwukMJr2FGtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eaHfNJHHKnW5fAjvGOLzIQuT4a6MmyUO
	9gFVodQ25T4gf0a0H9J5UaN2cpelPTq5Ylnjv206UuNI1aX9A+j4x64UA0JHpBcp
	RItlrDaq5RUxo/q84RXdBfXsXJ6w0a/u0jv5n/uo+R2dKKeuj0k3KEptSx06FItu
	CTZqcHfhpQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA80489A5;
	Wed, 15 Aug 2012 13:41:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 418B18998; Wed, 15 Aug 2012
 13:41:57 -0400 (EDT)
In-Reply-To: <2444647.P1AdWcSsQk@flomedio> (Florian Achleitner's message of
 "Wed, 15 Aug 2012 14:00:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 827859CC-E700-11E1-BD12-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203476>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

>> The updated code frees argv[] immediately after start_command()
>> returns, and it may happen to be safe to do so with the current
>> implementation of start_command() and friends, but I think it is a
>> bad taste to free argv[] (or env[] for that matter) before calling
>> finish_command().  These pieces of memory are still pointed by the
>> child_process structure, and users of the structure may want to use
>> contents of them (especially, argv[0]) for reporting errors and
>> various other purposes, e.g.
>> 
>> 	child = get_helper();
>> 
>>         trace("started %s\n", child->argv[0]);
>> 
>> 	if (finish_command(child))
>>         	return error("failed to cleanly finish %s", child->argv[0]);
>
> Yes, sounds reasonable. The present of immedate clearing has the advantage 
> that I don't have to store the struct argv_array, as struct child_process only 
> has a member for const char **argv.

And updated code shouldn't have to store struct argv_array either.
If you just give the ownership of argv_array.argv to child_process
and clean it as part of destroying the child_process, you do not
have to worry about argv_array at all.

In order to cleanly support that use case at the API level, we may
want to introduce argv_array_detach() that is similar in spirit to
strbuf_detach(), which transfers ownership of the underlying memory
to the caller.
