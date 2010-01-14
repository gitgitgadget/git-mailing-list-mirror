From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] start_command: detect execvp failures early
Date: Thu, 14 Jan 2010 14:40:27 -0800
Message-ID: <7vska88g4k.fsf@alter.siamese.dyndns.org>
References: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <201001101411.22418.j6t@kdbg.org> <7viqb49xwb.fsf@alter.siamese.dyndns.org>
 <201001142253.19595.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 23:40:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVYN0-0003VE-36
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 23:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787Ab0ANWkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 17:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757610Ab0ANWkl
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 17:40:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251Ab0ANWkh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 17:40:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0620D9050A;
	Thu, 14 Jan 2010 17:40:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BexCe3VSmAM21Lzn3xAplIMqe0I=; b=G4VGsB
	rHSyBWVAJFSUIX9WsKL1d6rk8+/tpmkas5r/iIC942uky5xe2xj56pAKdh5gUSjX
	sEIJk6eqa0aOn0euGjZOb/IHIx8Jxa313vAu5tWixNAkRyqGMtwtIsYeVR0mXUbm
	hj+8kbL9AHXJU34eTXkcjKe8myzMys6hhr/dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XmHwltYLngtS8JcU+BV9p989hyZfpD2T
	olIjYaX1mZk2hGpmiYCKUTzhQOSH/9Xq+FYKWXFABiNVInHrOJc2jogwCbKHWvw3
	360gQR8kCrsAO/MWlMBz1fgwgUHN4YXgTsTv5mdGnJIg9zSos3djhYou1rujpxco
	hDq/Nl55xrc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8F8A90508;
	Thu, 14 Jan 2010 17:40:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C543D90507; Thu, 14 Jan
 2010 17:40:28 -0500 (EST)
In-Reply-To: <201001142253.19595.j6t@kdbg.org> (Johannes Sixt's message of
 "Thu\, 14 Jan 2010 22\:53\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2EC8C24-015D-11DF-ADBA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137032>

Johannes Sixt <j6t@kdbg.org> writes:

> On Donnerstag, 14. Januar 2010, Junio C Hamano wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> > Previously, failures during execvp could be detected only by
>> > finish_command. However, in some situations it is beneficial for the
>> > parent process to know earlier that the child process will not run.
>> >
>> > The idea to use a pipe to signal failures to the parent process and
>> > the test case were lifted from patches by Ilari Liusvaara.
>>
>> I wonder if we can do this without pipe, perhaps using "vfork, exec, then
>> update a variable"....
>
> Except that some systems implement vfork(2) in terms of fork(2), I heard. 

As long as they implement it correctly, we don't care if it is implemented
in terms of fork or knife or chopstick.  The only thing we care about in
this crazy-idea was the shared address space the child can write into
until it exec or _exit while the parent is in a frozen state.

> Moreover, I think that we do way too many things before the exec; isn't that 
> dangerous?

Yeah, we do seem to do quite a lot more than I thought.  Scratch that
crazy idea, then.
