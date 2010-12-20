From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not
 valid
Date: Sun, 19 Dec 2010 23:42:15 -0500
Message-ID: <20101220044214.GA5942@sigill.intra.peff.net>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru>
 <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru>
 <20101218161337.GB18643@sigill.intra.peff.net>
 <7vr5dddvrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 05:42:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUXa8-0000iS-1p
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 05:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab0LTEmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 23:42:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59100 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703Ab0LTEmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 23:42:38 -0500
Received: (qmail 25061 invoked by uid 111); 20 Dec 2010 04:42:25 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 20 Dec 2010 04:42:25 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Dec 2010 23:42:15 -0500
Content-Disposition: inline
In-Reply-To: <7vr5dddvrk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163980>

On Sun, Dec 19, 2010 at 06:26:55PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > PS It is a little disturbing that in fill_textconv, we handle
> > case (1), !DIFF_FILE_VALID for the non-textconv case, but not so for the
> > textconv case. I think we are OK, as get_textconv will never load a
> > textconv driver for a !DIFF_FILE_VALID filespec, so we always follow the
> > non-textconv codepath in that case. But I am tempted to do this just to
> > be more defensive:
> 
> FILE_VALID() is about "does that side have a blob there, or is this
> create/delete diff?", so the caller should be handling this properly as
> you said, but your fill_textconv() already prepares for the case where the
> caller for some reason calls this function with "no blob on this side" and
> returns an empty string (see the precontext of your patch).
> 
> I think it is fine to be defensive to prepare for such a case, but then
> dying like this patch does is inconsistent.  Perhaps we should move the
> new check higher and remove the *outbuf = "" while at it?

I'm not sure returning the empty string for a textconv is the right
solution. I am inclined to say that trying to textconv a
!DIFF_FILE_VALID is simply an error. More on that in a second.

If we were to do anything else, I would think it would be to feed "" to
the textconv filter, in case it wanted to do something magical for the
create/delete case. For example, imagine a textconv filter which turned
a string of bytes like "foo" into a length plus set of converted bytes,
like "3: FOO". You would want the /dev/null case to turn into "0: ".

Now, this is obviously a ridiculous toy case. I have no idea if anyone
would want to do something like that. So far most people have been happy
with /dev/null never being textconv'd, and always looking like the empty
string. Moreover, even if somebody did want this behavior, 99% of the
other filters _wouldn't_ want the behavior. Because programs like
odt2txt or exiftool that people _do_ use for textconv filters do not
want to be fed /dev/null; they will signal an error.

So that is my "if we wanted it to do something useful, this is what it
would do" case, and I don't see any real-world evidence that anybody
wants that. Now on to being defensive.

What we are defending against is a caller marking something as
to-be-textconv'd, even though it is !DIFF_FILE_VALID. But what did the
caller want? One sensible behavior is what I described above. Or maybe
they did just want the empty string. Or more likely, it is simply a bug
in the diff code. Since we haven't defined the semantics, I would much
rather loudly scream "BUG!" than paper over it by returning what we
guess they would have wanted (which may generate subtly wrong results).
And then we can think about that use case and decide what the semantics,
if any, should be.

So I stand by my thought that it should die(). But I don't think there
_are_ any such bugs currently, so it probably doesn't matter much either
way. I can live with "return 0", or even just leaving it alone.

-Peff
