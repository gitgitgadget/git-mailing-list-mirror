From: Jeff King <peff@peff.net>
Subject: Re: Multiblobs
Date: Mon, 10 May 2010 02:36:18 -0400
Message-ID: <20100510063618.GD13340@coredump.intra.peff.net>
References: <loom.20100428T164432-954@post.gmane.org>
 <20100506062644.GB16151@coredump.intra.peff.net>
 <4BE3493B.8010409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 08:36:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBMbK-0005Al-7g
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 08:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab0EJGgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 02:36:21 -0400
Received: from peff.net ([208.65.91.99]:57820 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab0EJGgU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 02:36:20 -0400
Received: (qmail 32566 invoked by uid 107); 10 May 2010 06:36:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 10 May 2010 02:36:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 May 2010 02:36:18 -0400
Content-Disposition: inline
In-Reply-To: <4BE3493B.8010409@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146763>

On Fri, May 07, 2010 at 12:56:59AM +0200, Sergio Callegari wrote:

> >And for both of those cases, the upside is a speed increase, but the
> >downside is a breakage of the user-visible git model (i.e., blobs get
> >different sha1's depending on how they've been split).
> Is this different from what happens with clean/smudge filters? I
> wonder what hash does a cleanable object get. The hash of its cleaned
> version or its original hash? If it is the first case, the hash can

It gets the cleaned version. The idea is that the sha1 in the repository
is the "official" version, and anything else is simply a representation
suitable for use on your platform.

So in that sense, clean/smudge filters are very visible. Splitting into
multiple blobs would mean that as far as git was concerned, your data
_is_ multiple blobs. And it would diff and merge them as separate
entities. That makes sense for something where that breakdown happens
along user-visible lines, and is useful to the user. For example,
automatically breaking down a tarfile into its constituent files might
be a more desirable representation for git to diff and merge (though the
current implementation of clean/smudge filters does not allow breaking
the file into multiple blobs).

But as I argued later in my email, I think that is not the right model
for performance-oriented multiblobs. Splitting a file at certain length
boundaries simply because it is large is going to be awkward when you
want to look at it as a whole item.

> >Another benefit is that you still _store_ the original (you just don't
> >look at it as often).
> ... but of course if you keep storing the original, I guess there is
> no advantage in storage efficiency.

Yes and no. If you are storing some set of N bytes, then you need to
store N bytes whether they are in a single blob or multiple blobs. The
only way that multiple blobs can improve on that is if you can find
better delta candidates by doing so.  Which means that you are just as
well off by splitting the large blob when looking for delta candidates
as you are in splitting it in storage.

> I agree, but this is already being done. For instance on odf and zip
> files, by using clean filters capable of removing compression you can
> greatly improve the storage efficiency of the delta machinery
> included in git. And of course, to re-create the original file is
> potentially challenging. But most time, it does not really matter.
> For instance, when I use this technique with odf files, I do not need
> to care if the smudge filter recreates the original file or not, the
> important thing is that it recreates a file that can then be cleaned
> to the same thing (and this makes me think that cleanable objects get
> the sha1 of the cleaned blob, see above).

Sure. And for those cases, I think clean/smudge filters are perhaps
already doing the job.

As an aside, I don't think that _git_ cares about pristine tars. It is
that people want to store compressed tarfiles in git that have a
particular checksum because they are interacting with some _other_
system that cares about the tarfile.  In your case, where you don't care
about the particular byte pattern of the odf file, it is much simpler.
So clean/smudge filters are even easier there.

> In other terms, all the time we underline that git is about tracking
> /content/. However, when you have a structured file, and you want to
> track its /content/, most time you are not interested at all at the
> /envelope/ (e.g. the compression level of the odf/zip file): the
> content is what is inside (typically a tree-structured thing). And
> maybe scms could be made better at tracking structured files, by
> providing an easy way to tell the scm how to discard the envelope.

Right. The question is how the structured contents are handled
internally by the SCM. Git's choice is to leave contents as opaque as
possible, and let you handle conversion at the boundaries: textconv (or
a custom external diff) for viewing diffs, and clean/smudge for working
tree files.

> In fact, having the hash of the structured file only depend on its
> real content (the inner tree or list of files/streams/whatever),
> seems to me to be completely respectful of the git model. This is why

Yes, and that is how it works with clean/smudge filters.

> I originally thought that having enhanced filters enabling the
> storage of the the inner matter of a structured file as a multiblob
> could make sense.

I do think it makes sense, but only for some applications. But for those
applications, rather than a multiblob, I think creating a tree structure
is a natural fit, and works well with existing git tools. But again,
that isn't really implemented. Blobs must stay as blobs. So the closest
you can come is saying:

  - an ODF file may be a collection of structured text, but we will
    store it marshalled as a single binary data stream

  - we don't want it compressed for performance reasons, so we won't use
    the native marshalling format. Instead, we'll clean/smudge it as an
    uncompressed collection format inside of git (e.g., a zip without
    compression, or a tarball).

  - even though git doesn't understand the structure, we _do_ want to
    see the structure when doing diffs or merges. For that, we define
    custom diff/merge drivers which can operate on the file. They can
    unpack the structure as necessary.

which is really not too bad, and it means git can remain blissfully
unaware of the details of any format.

> >provide them to git individually. In other words, there is no need for
> >git to know or care at all that "foo.zip" exists, but you should simply
> >feed it a directory containing the files. The right place to do that
> >conversion is either totally outside of git, or at the edges of git
> >(i.e., git-add and when git places the file in the repository).
> Originally, I thought of creating wrappers for some git commands.
> However, things like "status" or "commit -a" appeared to me quite
> complicated to be done in a wrapper.

Yes, I would just do it manually. But in theory a clean/smudge filter
could be the right sort of place for that, if somebody made an
implementation that handle exploding a single file into an arbitrary
tree/blob hierarchy. I think it was discussed when filters were
introduced, but the complexity (both in terms of implementation, and
in meeting user expectations) prevented anyone from moving it forward.

-Peff
