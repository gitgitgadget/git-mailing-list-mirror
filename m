From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Fri, 04 Jan 2013 17:55:18 +0100
Message-ID: <50E70976.5040001@kdbg.org>
References: <20130104124756.GA402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 17:55:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrAYY-0005OH-Nv
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 17:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab3ADQzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 11:55:24 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:9036 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754984Ab3ADQzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 11:55:23 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B2A67A7EB2;
	Fri,  4 Jan 2013 17:55:19 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A6C6219F45B;
	Fri,  4 Jan 2013 17:55:18 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130104124756.GA402@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212632>

Am 04.01.2013 13:47, schrieb Jeff King:
> I have two reservations with this patch:
> 
>   1. We are ignoring SIGPIPE all the time. For an alias that is calling
>      "log", that is fine. But if pack-objects dies on the server side,
>      seeing that it died from SIGPIPE is useful data, and we are
>      squelching that. Maybe callers of run-command should have to pass
>      an "ignore SIGPIPE" flag?

I am of two minds. On the one hand, losing useful debugging information
is not something we should do lightly. On the other hand, the message is
really noise most of the time, even on servers: when pack-objects dies
on the server side, it is most likely due to a connection that breaks
(voluntarily or involuntarily) half-way during a transfer, and is
presumably a frequent event, and as such not worth noting most of the time.

>   2. The die_errno in handle_alias is definitely wrong. Even if we want
>      to print a message for signal death, showing errno is bogus unless
>      the return value was -1. But is it the right thing to just pass the
>      negative value straight to exit()? It works, but it is depending on
>      the fact that (unsigned char)(ret & 0xff) behaves in a certain way
>      (i.e., that we are on a twos-complement platform, and -13 becomes
>      141). That is not strictly portable, but it is probably fine in
>      practice. I'd worry more about exit() doing something weird on
>      Windows.

It did something weird on Windows until we added this line to
compat/mingw.h:

#define exit(code) exit((code) & 0xff)

-- Hannes
