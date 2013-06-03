From: Junio C Hamano <gitster@pobox.com>
Subject: Re: preventing evil merges
Date: Mon, 03 Jun 2013 10:20:06 -0700
Message-ID: <7vvc5vglh5.fsf@alter.siamese.dyndns.org>
References: <20130530163459.GI31679@gnash>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sandro Santilli <strk@keybit.net>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:20:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYQY-0000c0-Tv
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759101Ab3FCRUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:20:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412Ab3FCRUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:20:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18B182495D;
	Mon,  3 Jun 2013 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qLUsvlxe0Us7Ts135EnrbFdyAZ8=; b=xa5lyy
	ebJI0NqgEcSwU/y0wpcQpWpGuWlp21UugnQlgJ9BP/5X4dC7D7ld/x1VqH5ywzCk
	2uS/DM+4TsmMUJelkjjdALRuebNcohbUPsNZ9fg7MYX+A3UGnUap0OrtrnIUYOTq
	OKMlVY4NH0eX1THjD+zZXgL8yr9pqrdfIHN6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aya5g7AOzScS35W/hjFQR0x8Me/D5RvH
	r5ahkk4If6HNIz3vywgxLT7x0wxxsM0qUjtHqswa7gP7nV4QHY+/rwvgbsMDYD+C
	jhR/9AV/EpqG/KPio5ai2+btefSx77+0PkIBoQkVo6K0WOCbFizEudKbp3jTXRaX
	x+/paUllyVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03C032495C;
	Mon,  3 Jun 2013 17:20:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B4822495B;
	Mon,  3 Jun 2013 17:20:08 +0000 (UTC)
In-Reply-To: <20130530163459.GI31679@gnash> (Sandro Santilli's message of
	"Thu, 30 May 2013 18:34:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7020F36-CC71-11E2-A15E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226239>

Sandro Santilli <strk@keybit.net> writes:

>  git merge anotherbranch
>  git add something
>  git commit --amend
>
> After the steps above the addition of "something" can't be found in
> the history anymore, but the file is there.

This is a very common and sensible thing to do when dealing with
semantic conflict.  Imagine that you changed the name of a global
variable in the code on your current branch since the anotherbranch
you are pulling from forked from you.  Then imagine further that the 
anotherbranch added one location that refers to that variable.

Since they are not aware of the name change, they added the new
reference with the old variable name.  The part they added is a new
code, so it is very likely that there is no textual conflict when
you did "git merge anotherbranch".  But now the result is broken.

And you fix that semantic conflict by editing the file they added
the new reference to the variable under the old name and make it use
the variable with the new name.  You "git add something" and amend
the merge.

"git show" of the result will show you what happened, I think.
