From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 17:48:17 -0400
Message-ID: <20150429214817.GA2725@peff.net>
References: <1430341032.14907.9.camel@ubuntu>
 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
 <1430343059.14907.18.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:48:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZqG-0001q4-C4
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbbD2VsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:48:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:51898 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751445AbbD2VsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:48:20 -0400
Received: (qmail 23280 invoked by uid 102); 29 Apr 2015 21:48:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 16:48:20 -0500
Received: (qmail 31299 invoked by uid 107); 29 Apr 2015 21:48:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 17:48:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 17:48:17 -0400
Content-Disposition: inline
In-Reply-To: <1430343059.14907.18.camel@ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268027>

On Wed, Apr 29, 2015 at 02:30:59PM -0700, David Turner wrote:

> > I personally don't, exactly because we track the contents of the
> > symlink itself, not the referent.  Your "major wrinkle" that they
> > can point outside the repository is a mere manifestation of that.
> 
> I'm not sure I understand why tracking the contents of the symlink is a
> problem for this approach.  It seems reasonable to ask what would have
> happened had I checked out the repo at a certain SHA and said "cat
> foo/bar/baz".

But git can't answer that question, can it? That is something that you
are asking the filesystem and the OS, and it may involve leaving the git
repository altogether (and depend on things like your cwd). Certainly
git can ask the filesystem for you, but it's more flexible if you do it
yourself (at the expense of more code on your end; see below).

> > Perhaps an ideal interface might be something like this:
> > 
> >     $ echo HEAD:RelNotes |
> >       git cat-file --batch='%(objecttype) %(intreemode) %(objectsize)'
> >     blob 160000 32
> >     Documentation/RelNotes/2.4.0.txt
> > 
> > I suspect it would be just the matter of teaching "cat-file --batch"
> > to read from get_sha1_with_context() in batch_one_object(), instead
> > of reading from get_sha1() which it currently does.
> > 
> > And that inteferface I think I can live with.
> 
> Even if I had %(intreemode), I would still have to do a recursive search
> to figure out whether Documentation or RelNotes was a symlink.  This is
> why I want a follow-symlinks mode.  And since I am already reading
> RelNotes, I can (and presently do) parse the mode out of that data.
> $(intreedmode) would save me some parsing, but it would not save me any
> reading, nor would it make my code any less complex.  But
> --follow-symlinks would simplify my code.

Wouldn't git have to do the same recursive search? That is, with the
interface above, you would see "ah, %(intreemode) says we are a symlink;
let me ask again using the filename from the symlink contents". And
repeat until you get a non-symlink. But with a --follow-symlinks option,
git is just doing the same thing internally. It cannot ask the
filesystem because these are not real files.

So the advantages of --follow-symlinks are:

  1. It's more efficient. Instead of round-tripping across the pipe, git
     follows the link internally.

  2. It's easier for callers. Git only has to implement it once, and
     callers get it for free. Also, callers do not have to have a
     bidirectional conversation with cat-file (which is doubly awkward
     if they are trying to send the output of cat-file elsewhere, since
     they end up having to forward along the non-symlinked output).

The disadvantages are:

  1. Git has to make a decision about what to do in corner cases. What
     is our cwd for relative links? The project root? Can we be in a
     subdir of the repo? What do we do about symlinks that point to
     non-existent files?  Ones that point outside the repository? If we
     cat the actual filesystem, what is the cwd of the pretend
     working-tree that we start from? Do we need to be able to show the
     contents _and_ the fact that we followed one or more links (and
     their intermediate names?).

Can you think of arguments (either on pro or con side) that I am
missing? Or did I misunderstand what you meant by "recursive search"?

-Peff
