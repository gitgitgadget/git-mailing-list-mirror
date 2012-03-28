From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 17:04:07 -0400
Message-ID: <20120328210407.GC10174@sigill.intra.peff.net>
References: <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <7vzkb0tq10.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD02R-0001Bp-A4
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 23:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802Ab2C1VEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 17:04:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36391
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758210Ab2C1VEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 17:04:09 -0400
Received: (qmail 22052 invoked by uid 107); 28 Mar 2012 21:04:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 17:04:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 17:04:07 -0400
Content-Disposition: inline
In-Reply-To: <7vzkb0tq10.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194199>

On Wed, Mar 28, 2012 at 01:43:39PM -0700, Junio C Hamano wrote:

> > +	while (1) {
> > +		const char *end = strchrnul(p, ':');
> > +		const char *path;
> > +		struct stat st;
> > +
> > +		path = mkpath("%.*s/%s", (int)(end - p), p, file);
> 
> Given PATH=":/usr/bin:/bin" and file "frotz" (please call it "cmd" or
> something, by the way), end points at the first colon and path becomes
> "/frotz".  Oops?

Ugh, yeah. This is what I meant when I said "checking afterwards
basically means re-implementing execvp". :)

Regarding the name, I pulled it from the linux-manpages execvp(3), since
this is supposed to be compatible. POSIX uses the even worse "path" as
the first element. But there is no reason we have to follow those naming
conventions.

> > +int sane_execvp(const char *file, char * const argv[])
> > +{
> > +	int ret = execvp(file, argv);
> > +	if (ret < 0 && errno == EACCES && !file_in_path_is_nonexecutable(file))
> > +		errno = ENOENT;
> > +	return ret;
> 
> Double negation makes my head hurt, but unfortunately, we cannot rename it
> to "executable_exists_on_path()" and negate its return value.

Right, technically it could exist in two places, and we care about
finding the first one.

In practice, I think we can just do exists_on_path() and not even worry
about the executable bit. If it exists, execvp did not run it, and we
got EACCES, then it is not executable. Any other error would trump
EACCES (i.e., execvp would have returned immediately; with EACCES it
waits until it has processed all entries before returning EACCES).

I actually think this would be easier to read if we simply
re-implemented execvp.

> Anyway, the logic is to set errno to ENOENT when
> 
>  - We tried to exec, and got EACCES; and
>  - There is a file on the PATH that lacks executable bit.
> 
> In such a case, the error from execvp() is not about the file it tried to
> execute lacked executable bit, but there was nothing that match the name,
> but it couldn't be certain because some directories were not readable.
> 
> OK.  I think I can follow that logic.

I think you are backwards. There is _no_ file on the PATH that lacks the
executable bit, and therefore the error is about an inaccessible
directory.

You could also search for an inaccessible directory, but that is not
quite right. If you have an inaccessible directory _and_ a matching file
with no executable bit, then you would make the wrong assumption.

> If there are more than one entry on PATH, and a system call made during
> first round of the loop fails but a later round finds a non-executable
> file, i.e.
> 
> 	$ PATH=/nosuch:/home/peff/bin; export PATH
>         $ >/home/peff/bin/frotz; chmod -x /home/peff/bin/frotz
>         git frotz
> 
> we would get EACCES from execvp(), the first round runs stat("/nosuch/frotz")
> and sets errno to ENOTDIR, and the second round runs stat() and access()
> on "/home/peff/bin/frotz" and returns 1 to say "Yeah, there is a plain
> file frotz that cannot be executed".
> 
> And sane_execvp() will return ENOTDIR?
>
> So sane_execvp() would probably need to do a bit more (but not that much).
> 
> 	if (ret < 0 && errno == EACCES)
> 		errno = file_in_path_is_nonexecutable(file) ? EACCES : ENOENT;
> 	return ret;
> 
> or something.

Good point. We definitely need to save the EACCES errno across the
second round lookup.

-Peff
