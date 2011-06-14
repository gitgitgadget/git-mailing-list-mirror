From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error: error in sideband demultiplexer
Date: Tue, 14 Jun 2011 12:32:13 -0700
Message-ID: <7vhb7sky4i.fsf@alter.siamese.dyndns.org>
References: <9E9413C214124A0980AADBDFAD7DF28E@aggress.net>
 <20110614164943.GA26764@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Shaw <richard@aggress.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:32:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWZLa-0002xS-9D
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 21:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407Ab1FNTcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 15:32:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab1FNTcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 15:32:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E0B285568;
	Tue, 14 Jun 2011 15:34:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=61xRrQttu9GAHQaI8bncY6i86xk=; b=ZViXHI
	ZnL85pwSSSFbVCJVpxUo+OxRYvhLNvwG9Ff/3R8lSvDF7lEC3H+iGjpDYD3ELz6V
	lwgFLFeIBYX8L/Y4JLgH1k3JwBv3gW9wEayVPw4Y5LUBzqHCF69qDRdnAqKZ5mlV
	iMN+OKAV7Axyq6QZxAXhwWOsb+d7aehum4K4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DMPDRNKmBmbRh2PQgEE8De29PtyY1jiS
	RahtcMhX09eey0tmsihAJPn4sQifoSDggUWAlGeVDO0+UJzJXb2uuQlrHPZA7X8x
	WD1PQ0U/rtoCj/TN+CnMy5SOTXOp3k23ycAuQN6dU5Pq7x5TEyOoase9HHPClh8M
	AklQOxfi+KA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9C475567;
	Tue, 14 Jun 2011 15:34:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2A6C85566; Tue, 14 Jun 2011
 15:34:26 -0400 (EDT)
In-Reply-To: <20110614164943.GA26764@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 14 Jun 2011 12:49:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5054C67C-96BD-11E0-91A6-85C7C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175792>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 14, 2011 at 01:20:32PM +0100, Richard Shaw wrote:
>
>> Could someone please give me an explanation of what the following error message means:
>> 
>> error: error in sideband demultiplexer
>
> The git protocol generally operates over a single stream. Most of that
> stream will have object data on it, but we also want to be able to pass
> informational messages. So there is a "sideband", which works something
> like:
>
>   1. The remote end puts a header at the beginning of each packet
>      telling us whether it's for the data stream or the sideband.
>
>   2. We either fork or start a thread to read the data from the remote
>      and demultiplex it. If it's sideband, we output it to stderr. If
>      it's data, we pass it on to the main git program.
>
> The error message indicates that the thread or forked process
> implementing the sideband demultiplexer returned an error in its exit
> code. Usually it will have printed some other error message already that
> is more specific, but you may have found a case where it doesn't.
>
> Which platform are you on? Are you building with threads (i.e., are you
> setting NO_PTHREADS)? Are there any other error messages? If not, is it
> possible to use "strace -f" to get a trace that shows the error?

Another common question to ask is...

Do you have something funky in dot files under $HOME on the remote side
(e.g. .bash_profile or .login) that cause the process started by the
non-interactive ssh session we make to the remote end give extra output?

IOW,

    $ ssh that-remote-site "cat /dev/null"

should not give us any extra "greeting".
