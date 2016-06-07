From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Tue, 7 Jun 2016 11:06:53 +0200
Message-ID: <20160607090653.GA4665@Messiaen>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
 <xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
 <20160606203901.GA7667@Messiaen>
 <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
 <20160606225847.GA22756@sigill.intra.peff.net>
 <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 11:07:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bACyd-0002VL-QF
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 11:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbcFGJHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 05:07:01 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:34057 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754243AbcFGJG5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 05:06:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D179120AE;
	Tue,  7 Jun 2016 11:06:54 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9WyLGoGxAhhv; Tue,  7 Jun 2016 11:06:54 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B6A2220AD;
	Tue,  7 Jun 2016 11:06:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id AFE1E2066;
	Tue,  7 Jun 2016 11:06:54 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SibjmoA7HlLx; Tue,  7 Jun 2016 11:06:54 +0200 (CEST)
Received: from Messiaen (eduroam-032048.grenet.fr [130.190.32.48])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 927A52064;
	Tue,  7 Jun 2016 11:06:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296621>

On Mon, Jun 06, 2016 at 04:24:53PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>>> I think that call should reset line.buf to the original buffer on
>>> the stack, instead of saying "Ok, I'll ignore the original memory
>>> not owned by us and instead keep pointing at the allocated memory",
>>> as the allocation was done as a fallback measure.
>>
>> I am not sure I agree. Do we think accessing the stack buffer is somehow
>> cheaper than the heap buffer (perhaps because of cache effects)? If so,
>> how much cheaper?
> 
> This is not about stack vs heap or even "cheaper" (whatever your
> definition of cheap is).  The principle applies equally if the
> original buffer came from BSS.
> 
> Perhaps I made it clearer by using a more exaggerated example e.g. a
> typical expected buffer size of 128 bytes, but the third line of
> 1000 line input file was an anomaly that is 200k bytes long.  I do
> not want to keep that 200k bytes after finishing to process that
> third line while using its initial 80 bytes for the remaining 977
> lines.

"its initial 128 bytes", rather than "its initial 80 bytes", no?
Or else I'm lost :)
 
> By the way, William seemed to be unhappy with die(), but I actually
> think having a die() in the API may not be a bad thing if the check
> were about something more sensible.  For example, even if a strbuf
> that can grow dynamically, capping the maximum size and say "Hey
> this is a one-lne-at-a-timve text interface; if we need to grow the
> buffer to 10MB, there is something wrong and a producer of such an
> input does not even deserve a nice error message" could be an
> entirely sensible attitude.  But that does not mean an initial
> allocation should be 10MB.  If the expected typical workload fits
> within a lot lower bound, starting from there and allowing it to
> grow up to that maximum would be the more natural thing to do.
> 
> And the problem I have with the proposed "fixed" is that it does not
> allow us to do that.

The "fixed" feature was aimed to allow the users to use strbuf with
strings that they doesn't own themselves (a function parameter for
example). From Michael example in the original mail:

void f(char *path_buf, size_t path_buf_len)
{
    struct strbuf path;
    strbuf_wrap_fixed(&path, path_buf,
    strlen(path_buf),
    path_buf_len);
    ...
    /*
     * no strbuf_release() required here, but if called it
     * is a NOOP
     */
}

I don't have enough knowledge of the codebase to judge if this is
useful, you seem to think it's not.

About this capping, I have troubles to understand if this is something
you'd like to see in this patch (assuming I include your changes)? Or is
this theoretical?


To sum up:
* Rename "wrap" to "attach"
* Forget about this "fixed" feature
* Make the strbuf reuse the preallocated buffer after a reset() (and a
detach() probably?)
* Introduce a more practical macro STRBUF_INIT_ON_STACK() (maybe the
name is too technical?)
* A few code corrections
