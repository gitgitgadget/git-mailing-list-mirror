From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 16:51:44 -0400
Message-ID: <20120328205144.GA10174@sigill.intra.peff.net>
References: <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <20120328204221.GE8982@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>,
	Frans Klaver <fransklaver@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:51:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzqV-0007gw-Ir
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760Ab2C1Uvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:51:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36367
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593Ab2C1Uvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:51:46 -0400
Received: (qmail 21814 invoked by uid 107); 28 Mar 2012 20:52:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 16:52:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 16:51:44 -0400
Content-Disposition: inline
In-Reply-To: <20120328204221.GE8982@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194193>

On Wed, Mar 28, 2012 at 03:42:21PM -0500, Jonathan Nieder wrote:

> > +		path = mkpath("%.*s/%s", (int)(end - p), p, file);
> [...]
>  - (end - p) is not guaranteed to fit inside an int.  What should happen
>    when my PATH is very long?

That is the cost of using the mkpath convenience function (otherwise,
the compiler will complain that ".*" expects an int). We can do it
manually, but in practice, do you really expect your PATH environment
variable to overflow an int?

>  - the existence check would be simpler spelled as access(path, F_OK).

Yeah, I think that is nicer. I went with !stat() because that is our
usual file_exists test, and I was wondering if there were any
portability issues with access(..., F_OK). However, we seem to use it
already in other places, so it should be fine.

>  - the above checks if there is _any_ nonexecutable instance of "file"
>    in the directories listed in $PATH, but isn't what we want to check
>    whether _all_ of them are nonexecutable?

If there is one that is executable, then execvp would not have returned.
So if there is any entry that is non-executable, then they all are. And
we don't care about the actual number; we only care whether there is one
(in which case it is no ENOENT).

> > +int sane_execvp(const char *file, char * const argv[])
> > +{
> > +	int ret = execvp(file, argv);
> > +	if (ret < 0 && errno == EACCES && !file_in_path_is_nonexecutable(file))
> > +		errno = ENOENT;
> > +	return ret;
> > +}
> 
> Makes sense.  No objections from me.
> 
> 	if (!execvp(file, argv))
> 		return 0;
> [...]
> 	return -1;

That is nicer; I have a general avoidance of rewriting return codes, but I
think it is safe to translate a non-zero execvp result into -1.

> 	/*
> 	 * When a command can't be found because one of the directories
> 	 * listed in $PATH is unsearchable, execvp reports EACCES, but
> 	 * careful usability testing (read: analysis of occasional bug
> 	 * reports) reveals that "No such file or directory" is more
> 	 * intuitive.
> 	 */
> 	if (errno == EACCES && cannot_find_in_PATH(file))
> 		errno = ENOENT;

I think we can even simplify cannot_find to "!exists_in_PATH" to make
it even simpler. If it exists and execvp did not execute it, then it
must be non-executable (or there is a race condition :) ).

-Peff
