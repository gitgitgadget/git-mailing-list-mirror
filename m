From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --follow is ignored when used with --reverse
Date: Tue, 02 Jul 2013 12:11:46 -0700
Message-ID: <7v38rw93pp.fsf@alter.siamese.dyndns.org>
References: <20130524012324.295dec77@hugo.daonet.home>
	<20130702091936.GA9161@serenity.lan> <20130702093842.GA4353@blizzard>
	<87vc4t9tn5.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas Fleischer <git@cryptocrack.de>,
	John Keeping <john@keeping.me.uk>,
	Alois Mahdal <Alois.Mahdal.1-ndmail@zxcvb.cz>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 02 21:11:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu5zW-0000xA-PR
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 21:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab3GBTLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 15:11:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498Ab3GBTLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 15:11:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 275CA2BDA3;
	Tue,  2 Jul 2013 19:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ziiEIdH7BkQ8r2xo6g26KOO/Hfc=; b=woTL1s
	/AiZy7iPwhoBr3rrihki2/GLjq3ohnCbqqay6CJDM7LlWJa7rYI8DvkYzp78QnUD
	JIPYzUpy7OfLB8QpwKNr2HbeIu+7msqaYheFry6Qe/aOYebf/o9fu7HHYlSyu45X
	JeclGDB+zS2aZ8154AJTmQKCbcrkAPf63gSv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MfQZnesdACTdgOIM/5XwjgTCwJ7XB0Qj
	kuk7gMv38hk9RmlR7D4nMhEyqc5+vuyDouJhgWWWkJP9/OpywOWNch4T8soaf19o
	GIylip5QqMlW4iA5W+JUj/OfIAC4vGN1vDtzxCv5x62gzPWvYIKUV1+eAnsKUF+/
	0nbBnWZ0RMI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C9DE2BDA2;
	Tue,  2 Jul 2013 19:11:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 765A22BD9C;
	Tue,  2 Jul 2013 19:11:48 +0000 (UTC)
In-Reply-To: <87vc4t9tn5.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Tue, 2 Jul 2013 11:51:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E7C9858-E34B-11E2-9D4B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229419>

Thomas Rast <trast@inf.ethz.ch> writes:

> Lukas Fleischer <git@cryptocrack.de> writes:
>
>> On Tue, Jul 02, 2013 at 10:19:36AM +0100, John Keeping wrote:
> [...]
>>>     $ git log --oneline --follow builtin/clone.c | wc -l
>>>     125
>>>     $ git log --oneline --follow --reverse builtin/clone.c | wc -l
>>>     3
>>
>> I just wanted to point out that it works fine when specifying the *original*
>> file name (which kind of makes sense given that everything is done in reverse
>> order):
> [...]
>> However, that also doesn't seem to work for builtin/clone.c:
>>
>>     $ git log --oneline --follow --reverse -- builtin-clone.c | wc -l
>>     65
>
> I'm pretty sure that is simply because --follow iis a horrible hack,
> known to be broken in many ways.

The machinery the follow uses simplifies the history with dynamic
pathspec correctly (in a simple history, at least), but the output
is coupled too strongly to the traversal. If you collect all the
revs you will show first, reverse them and then try to show (which
is what --reverse essentially is), the dynamic pathspec used for
each rev is long gone.

Perhaps we should make --follow mutually incompatible with
problematic options (I suspect --reverse is not the only case) at
the command line parser level to avoid hurting users.
