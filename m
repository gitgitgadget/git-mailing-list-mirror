From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] xread_nonblock: add functionality to read from fds without blocking
Date: Mon, 14 Dec 2015 12:59:10 -0800
Message-ID: <xmqqmvtciw69.fsf@gitster.mtv.corp.google.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:59:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8aDG-0005AM-N8
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbbLNU7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:59:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753498AbbLNU7O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:59:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6963F34418;
	Mon, 14 Dec 2015 15:59:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PEzKvxLiymjK6n3kXwA1/1U23Uc=; b=m2QaMn
	Ttk9HBY3N63jb6UTW8uhkTukrhmvMiEp7aecCQmJzblomxME4pXKQsdrhf+Hpr4G
	cwFpgn/JY18xEyNqLSnVZltgOCh2G7zHhiJvL5b1I0g5crb1vInBvCcC13RNl5cl
	HveR80JGuT3jb8gBuyt5hkrRWXNnYLoujAd+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ir4LqCodRtzbpfDvXFyzoJPR+N0PaFZr
	EDkQyk2xduKPl1gON6nY4BguvmSmmZ8EtEnnp7/wV2TG6mQuEKYo1t9u+MrSGz8R
	ukXs0W9fXgceR1P4N7hUn84uh4i6eoDLx+yPSwHvqlgkLkRQmkdZbTbhJY5qNUCl
	9H5qz7Ksi/4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 568EA34417;
	Mon, 14 Dec 2015 15:59:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9458134416;
	Mon, 14 Dec 2015 15:59:11 -0500 (EST)
In-Reply-To: <1450121838-7069-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 14 Dec 2015 11:37:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86A4D372-A2A5-11E5-AF49-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282412>

Stefan Beller <sbeller@google.com> writes:

> Provide a wrapper to read(), similar to xread(), that restarts on
> EINTR but not EAGAIN (or EWOULDBLOCK). This enables the caller to
> handle polling itself, possibly polling multiple sockets or performing
> some other action.

Do you still need this (and use of this in 4/8)?  The description of
a4433fd4 (run-command: remove set_nonblocking(), 2015-11-05) from
the previous iteration justifies the removal of set_nonblocking()
this way:

    run-command: remove set_nonblocking()
    
    strbuf_read_once can also operate on blocking file descriptors if we
    are sure they are ready.  And the poll(2) we call before calling
    this ensures that this is the case.

Updated run-command in this reroll lacks set_nonblocking(), and does
have the poll(2) before it calls strbuf_read_once().  Which means
that xread_nonblock() introduced here and used by [4/8] would read a
file descriptor that is not marked as nonblock, the read(2) in there
would never error-return with EWOULDBLOCK, and would be identical to 
xread() updated by [2/8] in this reroll.

So it appears to me that you can lose this and call xread() in [4/8]?

Ahh, there is a difference if the file descriptor the caller feeds
strbuf_read_once() happens to be marked as nonblock.  read_once()
wants to return without doing the poll() in such a case.  Even
though this series would not introduce any use of a nonblocking file
descriptor, as a general API function, [4/8] must be prepared for
such a future caller, hence [3/8] is needed.

OK, thanks.
