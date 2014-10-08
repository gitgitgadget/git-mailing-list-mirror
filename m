From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/16] prune: factor out loose-object directory traversal
Date: Wed, 8 Oct 2014 03:33:16 -0400
Message-ID: <20141008073315.GB25250@peff.net>
References: <20141003202045.GA15205@peff.net>
 <20141003202943.GI16293@peff.net>
 <5433F3B8.2080505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 08 09:33:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XblkQ-0001Wg-0V
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 09:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbaJHHdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 03:33:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:56097 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752084AbaJHHdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 03:33:17 -0400
Received: (qmail 1072 invoked by uid 102); 8 Oct 2014 07:33:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 02:33:18 -0500
Received: (qmail 12792 invoked by uid 107); 8 Oct 2014 07:33:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 03:33:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Oct 2014 03:33:16 -0400
Content-Disposition: inline
In-Reply-To: <5433F3B8.2080505@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 07, 2014 at 04:07:52PM +0200, Michael Haggerty wrote:

> On 10/03/2014 10:29 PM, Jeff King wrote:
> > Prune has to walk $GIT_DIR/objects/?? in order to find the
> > set of loose objects to prune. Other parts of the code
> > (e.g., count-objects) want to do the same. Let's factor it
> > out into a reusable for_each-style function.
> > 
> > Note that this is not quite a straight code movement. There
> > are two differences:
> > 
> >   1. The original code iterated from 0 to 256, trying to
> >      opendir("$GIT_DIR/%02x"). The new code just does a
> >      readdir() on the object directory, and descends into
> >      any matching directories. This is faster on
> >      already-pruned repositories, and should not ever be
> >      slower (nobody ever creates other files in the object
> >      directory).
> 
> This would change the order that the objects are processed. I doubt that
> matters to anybody, but it's probably worth mentioning in the commit
> message.

Yeah, I don't think it matters, but I'll mention it.

> > +	if (!dir)
> > +		return opendir_error(path->buf);
> 
> OK, so if there is a non-directory named $GIT_DIR/objects/33, then we
> emit an "unable to open" error rather than treating it as cruft. I think
> this is reasonable.

Correct. The original "prune" silently ignored this case, but I think
it makes sense to complain about oddities. We must treat ENOENT
as a noop, even though the value comes from readdir() and therefore
should exist. A simultaneous prune might have deleted it (hopefully
nobody is insane enough to run two prunes at once, but ignoring
directories that went away seems like the only sane behavior to me).

> > +		if (cruft_cb) {
> > +			r = cruft_cb(de->d_name, path->buf, data);
> 
> So, files *and* directories at the $GIT_DIR/objects/XX/ level are
> reported as cruft (as opposed to, say, descending into the directories
> and reporting any files found deeper in the hierarchy). This seems fine,
> too.

Yes, this matches the original prune behavior (and anyway, this is the
object database; anything that is not a loose object is cruft).

> > +			if (r)
> > +				break;
> > +		}
> > +	}
> > +	if (!r && subdir_cb)
> > +		r = subdir_cb(de->d_name, path->buf, data);
> 
> By my reading, path->buf still contains the name of the last file in the
> directory at this point. I assume you want to pass it the original
> "baselen"-length path here.

Ack, good catch. This was originally in the outer for_each_loose_file
loop, but I thought it was more clear to handle it in the subdir
function. Not only is path->buf wrong here, but de->d_name is totally
bogus here.

Will fix in the re-roll.

> > +int for_each_loose_file_in_objdir(const char *path,
> [...]
> So other files or directories at the $GIT_DIR/objects/ level are just
> ignored; they are not considered cruft. This is worth clarifying in the
> docstring.

I tried to clarify that by indicating that we iterated only over the
"loose-object parts of the object directory". I guess that needs a more
clear definition.

-Peff
