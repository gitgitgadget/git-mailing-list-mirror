From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] upload-pack deadlock
Date: Wed, 06 Apr 2011 10:20:55 -0700
Message-ID: <7v8vvnjnyg.fsf@alter.siamese.dyndns.org>
References: <20110404053626.GA26529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Aman Gupta <aman@github.com>, Ryan Tomayko <ryan@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 19:21:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7WPu-0003EI-SB
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 19:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab1DFRVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 13:21:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136Ab1DFRVN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 13:21:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6FE0B4ED8;
	Wed,  6 Apr 2011 13:23:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=CCiCXAggtHMDs89HfZwzbF9I1kk=; b=dk+KAa6f8r26tLY9zZp6
	EB1S5G6oPigUdILsSeNm01T7+DAQGJuMvx4jQPZTgP0LxopYla4ct1bwNu0IYls9
	iIqMmWKyqbCymYE7DFTAvhZyP7A3pwCHWnYOxUeJlEQd1dv35l7XKjY//v7Yd95v
	20fcqo7Fhypjmn/E+T8/AAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=p7gKy3nxPt1LpoToLbT01AkCIjbtKfvgPgZnuVW60EYXRZ
	SjByTosPXSMrXwLVWr9txXsDCLDIEwzQeNrtP9Pd5g4A99eZBH+y9N5qcLpfAi5d
	h3ahT5V5FrealrZPipuQ3ejqxsx6bO1dGTNnGzyvYu9ZQBWGh9HzozAYZGaXU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F049F4ED4;
	Wed,  6 Apr 2011 13:22:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2D7F74ECD; Wed,  6 Apr 2011
 13:22:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84A445BE-6072-11E0-BE6A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170993>

Jeff King <peff@peff.net> writes:

> In a pthread-enabled version of upload-pack, there's a race condition
> that can cause a deadlock on the fflush(NULL) we call from run-command.
>
> What happens is this:
>
>   1. Upload-pack is informed we are doing a shallow clone.
>
>   2. We call start_async() to spawn a thread that will generate rev-list
>      results to feed to pack-objects. It gets a file descriptor to a
>      pipe which will eventually hook to pack-objects.
>
>   3. The rev-list thread uses fdopen to create a new output stream
>      around the fd we gave it, called pack_pipe.
>
>   4. The thread writes results to pack_pipe. Outside of our control,
>      libc is doing locking on the stream. We keep writing until the OS
>      pipe buffer is full, and then we block in write(), still holding
>      the lock.
>
>   5. The main thread now uses start_command to spawn pack-objects.
>      Before forking, it calls fflush(NULL) to flush every stdio output
>      buffer. It blocks trying to get the lock on pack_pipe.
>
> And we have a deadlock. The thread will block until somebody starts
> reading from the pipe. But nobody will read from the pipe until we
> finish flushing to the pipe.

Thanks for a concise summary.

> There are a few possible solutions:
>
>   1. Flip the order of initialization, so that we don't start writing
>      anything until the pack-objects reader is already in place. That
>      works in this case, and the patch is at the end of this mail. The
>      biggest problem is that it doesn't fix the general case.

In what sense are you not fixing "the general case", though?

If a program runs two threads, both of which access the FILE streams, it
should be the responsibility of the program to get these threads
coordinated to avoid such races and deadlocks, no?

While I think you mean start_async() API should be helping the API users
(calling programs) to fulfil that responsibility better, it really is up
to the thread to do random things to wreak havoc, like the shallow
codepath that tries to fill the stream while the main codepath expected
nothing happening, and I do not think of a good abstraction to help us
being more careful.
