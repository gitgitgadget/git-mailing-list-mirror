From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] run-command: Remove set_nonblocking
Date: Thu, 05 Nov 2015 12:50:33 -0800
Message-ID: <xmqqa8qs5fxi.fsf@gitster.mtv.corp.google.com>
References: <1446747439-30349-1-git-send-email-sbeller@google.com>
	<1446747439-30349-2-git-send-email-sbeller@google.com>
	<563BBBBC.7070807@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	peff@peff.net, johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, tboegi@web.de
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:50:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuRUX-00042X-45
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 21:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbbKEUuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 15:50:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751252AbbKEUug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 15:50:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DE2627FC9;
	Thu,  5 Nov 2015 15:50:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4hwY6nBynRJypyqrHpGdOrd1DEw=; b=jbWjTw
	pNqcYwYV8Jp46rlKYPyKQWr39IWrVPEj4UrGd+xOx3Yp2ehCEV+E+6va3by1aPqK
	bcwOEbFNS8JjHPJGpKH8+EOMOrlMvzVcglzB7lEGWtHZxNODf6DnNhJ9fJv574D+
	yXczG6H9H4HxFDZFydsibl/PVGzmaXaHPMMxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uH5aBzY9kRI9P0y3HW5zi4elD2wDGKoG
	YRlNLD6KpnfqvnGQ25wSFTnKfUjHIqlFcBT5mh99O74tdDcoZ/NZsoT1wHuPEtU/
	fL6/Ik/3dZJfliE342RmaGAFMeYobRWSRQ6Iv4iPwG/p1Ea5wuEgUSoPn8wtqX5Q
	BxGut32rCE4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 857E427FC8;
	Thu,  5 Nov 2015 15:50:35 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B731F27FC7;
	Thu,  5 Nov 2015 15:50:34 -0500 (EST)
In-Reply-To: <563BBBBC.7070807@kdbg.org> (Johannes Sixt's message of "Thu, 5
	Nov 2015 21:27:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC75EAC2-83FE-11E5-87B1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280939>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 05.11.2015 um 19:17 schrieb Stefan Beller:
>> strbuf_read_once can also operate on blocking file descriptors if we are
>> sure they are ready. The poll (2) command however makes sure this is the
>> case.
>> 
>> Reading the manual for poll (2), there may be spurious returns indicating
>> readiness but that is for network sockets only. Pipes should be unaffected.
>> By having this patch, we rely on the correctness of poll to return
>> only pipes ready to read.
>> 
>> This fixes compilation in Windows.
>
> It certainly does (but I haven't tested, yet). But parallel processes
> will not work because we do not have a sufficiently complete waitpid
> emulation, yet. (waitpid(-1, ...) is not implemented.)
>
> However, I think that the infrastructure can be simplified even further
> to a level that we do not need additional emulation on Windows.

;-)

This is why I love this list (and in general not rushing any change
too early to 'next').

> Which makes me think: Other users of start_command/finish_command work
> such that they
>
> 1. request a pipe by setting .out = -1
> 2. start_command
> 3. read from .out until EOF
> 4. close .out
> 5. wait for the process with finish_command
>
> But the parallel_process infrastructure does not follow this pattern.
> It
>
> 1. requests a pipe by setting .err = -1
> 2. start_command
> 3. read from .err
> 4. wait for the process with waitpid
>
> (and forgets to close .err). EOF is not in the picture (but that is
> not essential).

Unrelated tangent.  daemon is another one that uses start_command()
but does not use finish_command().

> I suggest to change this such that we read from the children until EOF,
> mark them to be at their end of life, and then wait for them using
> finish_command (assuming that a process that closes stdout and stderr
> will die very soon if it is not already dead).

Hmm, interesting.  This does match the normal "spawn, interact and
wait" cycle for a single process much better.
