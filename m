From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] [RFC] Design for pathname encoding gitattribute [RESEND]
Date: Tue, 22 Jan 2008 22:57:27 +1300
Message-ID: <4795BE07.4040500@catalyst.net.nz>
References: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>	<7vlk6iv0ik.fsf@gitster.siamese.dyndns.org> <7vr6gatidd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 10:57:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHFt0-0006fu-2n
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 10:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761214AbYAVJ4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 04:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761961AbYAVJ4t
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 04:56:49 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:35362 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761948AbYAVJ4r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 04:56:47 -0500
Received: from 203-97-235-49.cable.telstraclear.net ([203.97.235.49] helo=[192.168.69.104])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <sam.vilain@catalyst.net.nz>)
	id 1JHFrl-0007aR-B5; Tue, 22 Jan 2008 22:56:25 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <7vr6gatidd.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71439>

Junio C Hamano wrote:
> To support the above scenarios, I think each instance of
> repository needs to be able to say "this path (specified with a
> matching pattern in the filename encoding) should be converted
> this way coming in, and that way going out."  UTF-8 only project
> would have NKC<->NKD on HFS+ partition, and nothing on
> everywhere else.

I think there is another reason to do this - simple sanity.  Two people
adding the same filename should not end up with a different tree ID, if
they for whatever reason ended up entering a differing equivalent
variant of the same Unicode NKC form.

But, that rule of sanity breaks the C semantics sanity, so it must be a
per-project setting.  Not a necessity, but a good feature I think.  It
can be enforced with external scripts/hooks of course.

What happens on the way in and out of the filesystem, I see that as a
side issue.  Once you define what the normalized form is for the
project, then the features should just fall into place without messy
heuristics.  There is also a correct behaviour when faced with
filesystems that have a different idea about who enforces encoding rules
- so long as you can detect what those ideas are :).  It also means that
users can choose to use the same local encoding as their locale, which
might interoperate better with other apps.

The readdir() (case|normalization) tolerance change is good in its own
right, but it's a slightly different scenario, and an independent
question to what is the normalized form.  Of course, on case folding,
unicode normalizing filesystems you'd have to have a mixture of these
settings for sane operation.

On the chicken and egg thing, I guess .gitattributes is too late, you're
right - unless you say that at each directory level, the globbing is
always C.  But I haven't thought about that very hard.  I was just
re-using a mechanism that already exists rather than try to invent
something new.  I do agree with Dscho's point that mixing encodings in a
repository is not necessarily a use case worth catering for.

Sam.
