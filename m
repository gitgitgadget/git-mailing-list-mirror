From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] {checkout,reset} -p: make patch direction
 configurable
Date: Fri, 27 Nov 2009 01:41:07 -0500
Message-ID: <20091127064107.GC20844@coredump.intra.peff.net>
References: <527e9296b638eb4c9993b3fb0d1c6f51b64f4c2c.1258667920.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Nov 27 07:41:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDuW1-0000AP-QH
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 07:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbZK0GlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 01:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbZK0GlA
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 01:41:00 -0500
Received: from peff.net ([208.65.91.99]:46032 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbZK0GlA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 01:41:00 -0500
Received: (qmail 25041 invoked by uid 107); 27 Nov 2009 06:45:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Nov 2009 01:45:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Nov 2009 01:41:07 -0500
Content-Disposition: inline
In-Reply-To: <527e9296b638eb4c9993b3fb0d1c6f51b64f4c2c.1258667920.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133861>

On Thu, Nov 19, 2009 at 11:03:57PM +0100, Thomas Rast wrote:

> When we implemented the -p mode for checkout, reset and stash, some
> discussion revolved around the involved patch direction.
> 
> Make this configurable for reset and checkout with the following
> choices:
> 
>              index/HEAD       other
>   forward    undo addition    undo addition
>   mixed      undo addition    apply removal
>   reverse    apply removal    apply removal
> [...]
> ISTR that Peff wanted this, and maybe some others.  I'm not too
> interested because I'm still convinced 'mixed' is the Right Option,
> but it was somewhere deep on my todo stack and maybe you like it ;-)

Actually, I am pretty happy with the current "discard this hunk" most of
the time. It is easy enough to see "you made this change, did you want
to get rid of it?". The one exception is during patch editing. Try
something simple like:

cat >file <<EOF
this
is
a
file
with
some
content
in
it
EOF

git add file
git commit -m base

cat >file <<EOF
this
is
a
file
with
some
other
content
EOF

git checkout -p

Now try to 'e'dit the patch to throw away the addition of "other", but
keep the deletion of the other two lines. Do you find it easy or hard?
Now try it with interactive.checkout.direction set to forward. I find
editing the forward direction _much_ simpler.

Assuming you agree, I'm not sure what that tells us, though. I probably
wouldn't personally set interactive.*.direction for the yes/no part. But
I would find it more convenient to do patch editing always in the
forward direction. I'm worried that it would be too jarring to the user,
though, to see the patch presented in one direction but edit it in the
opposite direction. Maybe it would be nice to have yet another
interactive option to swap between the two for this particular hunk, and
then you could edit the direction you prefer.


Junio raised the question of consistency in another thread. I don't see
a consistency problem here. This is by definition an interactive
procedure. I don't see a reason not to allow the user their preferred
style. But I think if I could swap when editing, I would personally not
care all that much about the other direction.

-Peff
