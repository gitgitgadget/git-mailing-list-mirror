From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] allowing hooks to ignore input?
Date: Mon, 15 Sep 2014 10:51:38 -0700
Message-ID: <xmqqmwa093h1.fsf@gitster.dls.corp.google.com>
References: <xmqqzje48nh4.fsf@gitster.dls.corp.google.com>
	<5413FE06.1020901@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 19:51:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTaRG-00045j-Q8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 19:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbaIORvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 13:51:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64126 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836AbaIORvl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 13:51:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 498B13A92E;
	Mon, 15 Sep 2014 13:51:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EnRWj9Gj9pWt1HzWwXvqszjHtHE=; b=A3m+S/
	bcJvF3kJCjOyF8A+t1vOv2QA6g6L7IRPrew4Ajc9KI56C4vwfQ7VMN9tfXwyGyBm
	6YUrQVDVL0s326qYLkwUnwBU2ZGjpWbFw1R+2pL8R8r0zF77Jl5PzYqcrYTPj8HO
	/b9mUouhMmP8G96wk+6ta5dxm5zOJWobEGAco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gNCEzx+F5vOIM6YYV3rtSWAeau3dUuRG
	69WBMiND73E2Lw1EfYIiIyjyV7FQrMcv8ZPNFwzypudABb2RkGw6QSkoeuMseQbS
	hj8TTPY0HICw9GdJUWkR0Mw3GWHMHwSAzrKYeHR/8lJktl+S+Jpwg19+tmrfaD2x
	jv7MMd/Fxsw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 403153A92D;
	Mon, 15 Sep 2014 13:51:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B682B3A92B;
	Mon, 15 Sep 2014 13:51:40 -0400 (EDT)
In-Reply-To: <5413FE06.1020901@kdbg.org> (Johannes Sixt's message of "Sat, 13
	Sep 2014 10:19:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F29C64D4-3D00-11E4-8099-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257057>

Johannes Sixt <j6t@kdbg.org> writes:

> I think this is a good move. Hooks are written by users, who sometimes
> are not clueful enough.
>
> But what do our writers do when they fail with EPIPE? Die? If so, this
> patch alone is not sufficient.

I think it is in a loop

	while (...) {
        	if (write_in_full(...))
                	break;
	}
	...
        return finish_command(&proc);

and the caller only cares about the tatus of finish_command(),
i.e. the exit status of the downstream of the pipe.  In an EPIPE
situation, they have already exited with the status they want to
give to us without listening to what we wanted to tell them, so I
think there is no issue.

We _might_ want to check, at that point of "break", if we got a
write error other than EPIPE and act somewhat differently, but that
would be a different issue the current code already has.  E.g. if we
broke out of the loop due to an EIO or EPERM, it will not be affect
what the later code would do in the current code.
