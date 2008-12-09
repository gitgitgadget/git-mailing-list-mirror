From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] diff: allow turning on textconv explicitly for
	plumbing
Date: Tue, 9 Dec 2008 00:48:24 -0500
Message-ID: <20081209054824.GA2972@coredump.intra.peff.net>
References: <20081208025700.GB22072@coredump.intra.peff.net> <7vfxkz9v8f.fsf@gitster.siamese.dyndns.org> <20081208045924.GA22780@coredump.intra.peff.net> <7vskoz88g8.fsf@gitster.siamese.dyndns.org> <7v63lv842a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 06:50:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9vTz-0001sM-0v
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 06:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbYLIFs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 00:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbYLIFs3
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 00:48:29 -0500
Received: from peff.net ([208.65.91.99]:4241 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbYLIFs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 00:48:28 -0500
Received: (qmail 441 invoked by uid 111); 9 Dec 2008 05:48:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Dec 2008 00:48:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2008 00:48:24 -0500
Content-Disposition: inline
In-Reply-To: <7v63lv842a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102598>

On Mon, Dec 08, 2008 at 12:27:25AM -0800, Junio C Hamano wrote:

> I imagine that web developers may want to use a textconv filter that
> replaces ">" with "\n>" on the HTML files their designer-colleagues throw
> in the source tree to make "git log -p" of the whole project easier to

Hrm, didn't you argue against textconv'ing non-binary contents earlier
in the cycle? At any rate, I agree that is a reasonable use. Maybe a
better name would have been "normalize" or "canonicalize".

> follow.  When the developers would want to suggest improvements to what
> their designer-colleagues did, however, by running "git diff --stat -p" in
> their dirty work tree to produce a patch (like I just did just now,
> visible from the mnemonic prefixes below), they would want to disable
> textconv temporarily to get an appliable patch with --no-textconv option.

Yep, exactly. I use "git diff >patch" all the time instead of
format-patch.

> You raised an intriguing possibility to use textconv in blame.  It would
> also be useful if we allowed "git show --textconv $blob" to pass the blob
> via textconv filter and any other transformation controlled by the
> attributes mechanism..  When "git show" sees the above command line, it
> only knows the blob object name and not the path, so we may need to allow
> a new option to tell the command to pretend as if the content came from a
> path, perhaps with a syntax like:
> 
> 	$ git show --attribute-path=a/b/c $blob
> 	$ git show --attribute-path=a/b/c --textconv $blob

I think that makes sense. If you are going to implement a "use this as
the attribute path" feature, though, you might also want just "use these
attributes" which I can imagine being simpler in some cases. Like:

  $ git show --attribute diff=whatever $blob

But on the subject of "other places to see textconv", another one I
considered was git log -S. I haven't looked to see if it even checks
binary files at all, but certainly if I was searching for some text
content I would want to find it in the text version (and depending on
the file format, there may be other binary cruft preventing you from
finding it in the binary version at all).

The series I posted was to show the text in gitk diffs. However, it does
nothing for finding text in gitk's "find commits introducing this
string", which I assume just uses git's pickaxe.

Unfortunately, it would probably be painfully slow. But still better
than nothing. One enhancement for textconv that I am considering is to
name the tempfiles based on the blob sha1. Then a smart helper could
cache expensive conversions if it wanted (and dumb helpers would
obviously just ignore the filename).

Side note: For one use case, storing word processor documents, this
approach seems sensible. But for my jpg example, it almost seems that
I could use git more efficiently by having two files: one with the exif
text, and one with the image content. And then I could "build" the
resulting tagged jpgs by combining the two, but operations on the text
would be very efficient. The downside, of course, being that the "build"
step is annoying, and consumes a ton of disk space. But it just occurred
to me as an alternate way to think about the use case.

> @@ -133,7 +133,8 @@ on.
>    contents can be munged into human readable form and the difference
>    between the results of the conversion can be viewed (obviously this
>    cannot produce a patch that can be applied, so this is disabled in
> -  format-patch among other things).
> +  format-patch and plumbing, but if you really wanted to, you can enable
> +  it by giving them --textconv command line option explicitly).

I wonder if we want to word this even more strongly: --textconv is there
and you can play with it if you want, but we are not promising that it
is part of the stable API yet.

-Peff
