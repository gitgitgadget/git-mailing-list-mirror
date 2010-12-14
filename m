From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/8] mingw: make failures to unlink or move raise a
 question
Date: Tue, 14 Dec 2010 15:52:52 -0800
Message-ID: <7vk4jbrjxn.fsf@alter.siamese.dyndns.org>
References: <20101214220604.GA4084@sandbox> <20101214222122.GD4084@sandbox>
 <AANLkTi=cHb2kV2MaYu72nXVOksO7O9HhJLEo-fU0sV5N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Albert Dvornik <dvornik+git@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 15 00:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSegM-0008Mu-0G
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 00:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756466Ab0LNXxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 18:53:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab0LNXxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 18:53:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93B52331A;
	Tue, 14 Dec 2010 18:53:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A0YoCGKhHvp0ez3WC49Vkz+luTY=; b=WWqX02
	BQqsviqiQWp41oHYPStniHeVmag0g8YcRvI626ZD7uPgFpKKOVAxz+Sl+eYt6JWH
	UKyovJ0AzLIQacZQhcVJAABFD8ovXb8ZNwI7XmBAbiQtgyNY0rEinBSg2bieNPWM
	UjFS43WOVeXOVi+ZbdyO1FZK1R2P3YZHE8hcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V2qOo2AnZdAtOMheYtE8qE/EVhY14zcu
	Oj7wqNQKxK1FnLpwM5si27CaIsnS47Pt3Ar4DCNSLn2dqjlxjL8xFDIugZMYTohN
	3m9cIlv51ki2U/72Mtq2v8RHuBpb1+QgkqGcaUNOxbnrfLhFwIX97gsTdd7X0jvw
	S6U0H8MD25I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE33A3317;
	Tue, 14 Dec 2010 18:53:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 16C5E330B; Tue, 14 Dec 2010
 18:53:20 -0500 (EST)
In-Reply-To: <AANLkTi=cHb2kV2MaYu72nXVOksO7O9HhJLEo-fU0sV5N@mail.gmail.com>
 (Erik Faye-Lund's message of "Tue\, 14 Dec 2010 23\:35\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5BB17C50-07DD-11E0-AB21-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163722>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Since you're doing case insensitive checks for "yes" and "no", perhaps
> it'd make sense to allow upper case 'Y' and 'N' also? Something like:
>
> -       if (answer[0] == 'n' && strlen(answer) == 1)
> +       if (tolower(answer[0]) == 'n' && strlen(answer) == 1)
>
> hm?

Why not

	if (tolower(answer[0]) == 'n' && !answer[1])

think of the case answer[] is very long ;-)

>> +       if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
>> +               return 0;
>
> I'm wondering, doesn't this make the semantics a bit wrong? The
> function is called "ask_user_yes_no", but it might end up not asking
> after all.

I don't think that is such a big issue.

Imagine you had only getenv("GIT_ASK_YESNO") codepath, and no fallback
"tty" codepath.  And you ship with a separate program as a default
"asker".

The implementation of that asker happens to read yes/no from the tty, but
it defauts to "no" if there is no tty interaction available.

If you view it that way, the code we see above is just an optimization to
avoid spawning that default "asker" as a separate process.

I was more puzzled by the code to formulate question[]; why doesn't it
build the same question for both codepaths and spit that out to stderr
with fputs() in the fallvack asker?
