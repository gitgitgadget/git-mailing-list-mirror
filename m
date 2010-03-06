From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Pass t5530 on Windows
Date: Sat, 06 Mar 2010 12:12:58 -0800
Message-ID: <7vk4tpdx9x.fsf@alter.siamese.dyndns.org>
References: <cover.1267889072.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:29:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No17I-0004YU-80
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab0CFUNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 15:13:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab0CFUNI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 15:13:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F7C99F957;
	Sat,  6 Mar 2010 15:13:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NRzJoRwD72oeZAX5LzcggId5QYo=; b=bTzB+f
	873eDxr2FQIy0rP54cDFjXYAxYoKHjP4FgIFhH3qxxdzZdMrLvrrru98jriVTKlP
	KNNzBK5z9lGQgPIiCk4cp9EdPlGmTb3wE+7oxUsY5B+bVjdU6kYsY0oNoWuCp9qC
	N02BGxx0XmuihomjPxu/D+KvInjqRzvp8VaA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZHOIE59IqD8jHhiR4PnRKox8f+ZmC4GJ
	QZotoxK6lxOLhv31C6Q4xnONdNDSEJ9H+yzNQQUeDI2Hi4m6BrGibnLj4Lj2l4pe
	rOhlIYjXcSlDw5wgT1sJvMZrOOnkuZ6UpaxXGkJHBwUFVoSZQNuBxaACni0KmgKC
	/bizORSfPiM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D13B9F953;
	Sat,  6 Mar 2010 15:13:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 805299F951; Sat,  6 Mar
 2010 15:13:00 -0500 (EST)
In-Reply-To: <cover.1267889072.git.j6t@kdbg.org> (Johannes Sixt's message of
 "Sat\,  6 Mar 2010 16\:40\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AB4EBE5E-295C-11DF-A8FA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Quite frankly, I don't quite know what to do with this series. On the
> one hand, it is a clean-up, but in practice it is not relevant whether
> die() kills only the async thread or the whole process because all
> callers of async die() themselves anyway when the async procedure died.
> On the other hand, it does enable threaded async procedures on POSIX...

You wrote in [PATCH 5/6]:

    A new configuration option is introduced so that the threaded
    implementation can also be used on POSIX systems. Since this option is
    intended only as playground on POSIX, but is mandatory on Windows, the
    option is not documented.

but I am wondering how much of the real world is threads-challenged these
days.  Here is what you have at the end of technical/api-run-command.txt:

   There are serious restrictions on what the asynchronous function can do
   because this facility is implemented by a pipe to a forked process on
   UNIX, but by a thread in the same address space on Windows:

   . It cannot change the program's state (global variables, environment,
     etc.) in a way that the caller notices; in other words, .in and .out
     are the only communication channels to the caller.

   . It must not change the program's state that the caller of the
     facility also uses.

And calling die() from async is obviously "change the program's state that
the caller of the facility also uses".  We didn't uncover this as a bug
because the above "serious restrictions" go both ways.

If we make threaded-async the default on any platform that is thread
capable, we would increase the likelihood of catching bugs that violate
the latter condition.  I am sure there may be downsides for going that
route, but it might be better than the current situation where two major
platforms use quite different underlying semantics for the same call, and
rely on the program (both caller and callee) to honor the above
conditions, without much tool support [*1*].

[Footnote]

*1* I sometimes wonder if people who are interseted in static analysis can
help with issues like this: "In a function started by start_async() and
its callees, you are not supposed to touch these globals, nor call those
functions".  That would be more useful than reports we occasionally get
"in this codepath this variable can be used before assigned" with many
false positives, that presumably come from from the canned set of rules
these static checkers may have.
