From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sun, 10 Aug 2008 13:20:38 +0200
Message-ID: <20080810112038.GB30892@cuci.nl>
References: <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, Jamey Sharp <jamey@minilop.net>,
	Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 13:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS927-0002Bl-Jv
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 13:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbYHJLUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 07:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbYHJLUk
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 07:20:40 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:44904 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbYHJLUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 07:20:39 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 1BBBB5465; Sun, 10 Aug 2008 13:20:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080810035101.GA22664@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91830>

Shawn O. Pearce wrote:
>The proper encoding for both keys and values should permit any data
>to be stored.  Doesn't the extended attributes feature in Linux and
>FreeBSD both support any data to be attached to an inode in the fs?

I'd think so yes, so any attempt to store the metadata should support it
as well.
That also would imply that any such metadata storage would have to allow
for arbitrary blobs to be stored under tag-names.
And *that* would imply that anything that implements a kludge like
specifying a flat-file format to encode name/value pairs doesn't scale.

>I think this is a _BAD_ idea.

>A bad idea that will only clutter up the core object model, and
>the core processing code of that object model.  Extended attributes
>aren't used that much on local filesystems, because they are hard
>to work with and suck performance wise.  Performance in Git is
>a _feature_.  It matters.  Our clean object model really helps to
>make that possible.

Quite right.

However, pondering the idea a bit more, I could envision something
similar to the following:

In the git tree the following layout would be used:

plainfile.txt
otherdir/otherplainfile.txt
projects/README
projects/README/_owner
projects/README/_acl
projects/README/_icon
projects/README/_mimetype
projects/something.mpeg
projects/something.mpeg/_icon
projects/something.mpeg/_mimetype
projects/asubdir/thirdplainfile.txt

That would imply that in the tree storage, the only extension would be
that for any given reference to a blob in a tree object, there could be
a reference to a tree object as well.  I.e. something like this in the
tree object:

100644 blob f7b7414159b8a7159538fac543b2b19ef531968e  README
000000 tree df6ee415f04d6ccea5dab0de562c2f155583a2c4  README
100644 blob 0a54f8ec13df03cf6bdb5b973acec6d8141c01cc  something.mpeg
000000 tree a421448d765abb7bb979dc1d56621d0fc9b41229  soemthing.mpeg

The extra tree reference for README would actually refer to something like:

100644 blob be3365fdaae0f4ed8c22c4cf38a4b1f88f9069c3  _owner
100644 blob 739e9e8f3d095931084b54cbf7f90d8f64eb0ac6  _acl
100644 blob bc1a868bb50644712966a50150d21199c401d6d5  _icon
100644 blob 6076bde5b3b6b8bed4ec4968d09abdbf015b3b75  _mimetype

Which would contain the extra attributes.

And that would imply that during checkout you can do a rich checkout or a
flat checkout for any files under the projects directory.

A flat checkout results in the following files in the filesystem:

plainfile.txt
otherdir/otherplainfile.txt
projects/README
projects/README.attr/_owner
projects/README.attr/_acl
projects/README.attr/_icon
projects/README.attr/_mimetype
projects/something.mpeg
projects/something.mpeg.attr/_icon
projects/something.mpeg.attr/_mimetype
projects/asubdir/thirdplainfile.txt

A rich checkout results in the following files in the filesystem:

plainfile.txt
otherdir/otherplainfile.txt
projects/README
projects/something.mpeg
projects/asubdir/thirdplainfile.txt
projects/asubdir/fourthplainfile.txt

The rich checkout also applies the extended attributes/metadata to the
filesystem (i.e. it would store all the metadata in the appropriate
places).

The nice thing about this setup is that:
a. There is *no* change whatsoever to existing repositories or
   repositoryformat.
b. It's less filling (i.e. there are no special bits or object types to be
   used).
c. Speed for files without attributes is not affected.
d. It's fully 8-bit-transparent.
e. It scales, even if you have large or many attributes.
f. It uses the natural tree storage abstraction already supported in
   git repositories to store the additional data.
g. It allows reuse of attribute information at many levels.
h. It even allows for a hierarchy of attributes attached to a single
   file (no current filesystem supports that (yet)).
i. The only change in the fast-path of core-git is that it would have to
   know how to skip tree objects referenced in a tree object if a
   same-name blob object is already there.  This can even be optimised
   by requiring the attribute-tree to have a very specific (e.g. 0)
   mode to ease detection.
j. Editing and merging the meta-information could be made an almost
   natural operation in the flat-checkout mode (the extension to be used
   to name the attribute subdir should be made configurable).
-- 
Sincerely,
           Stephen R. van den Berg.

Real programmers don't produce results, they return exit codes.
