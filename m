From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sun, 10 Aug 2008 13:09:25 +0200
Message-ID: <20080810110925.GB3955@efreet.light.src>
References: <20080809210733.GA6637@oh.minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Jamey Sharp <jamey@minilop.net>,
	Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 13:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS8oq-0007wr-5t
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 13:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYHJLJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 07:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbYHJLJg
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 07:09:36 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:47731 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbYHJLJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 07:09:35 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 48C9F5727D;
	Sun, 10 Aug 2008 13:09:34 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id YPxl-lmFToly; Sun, 10 Aug 2008 13:09:31 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 6B49E572EB;
	Sun, 10 Aug 2008 13:09:30 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KS8nd-0001hY-Sx; Sun, 10 Aug 2008 13:09:25 +0200
Content-Disposition: inline
In-Reply-To: <20080809210733.GA6637@oh.minilop.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91828>

Hello All,

I am glad you came up with this, as I think this is the only reasonable way
to support things like etckeeper. The metastore and similar solutions are
a kludge and fall apart in so many cases.

I am not sure your approach is the right one, though. I tend to agree with
Shawn it's not. So here is a couple of alternate proposals (sorry, it's a bit
long, as I have several variants with different drawbacks I would like to
discuss).

On Sat, Aug 09, 2008 at 14:07:33 -0700, Jamey Sharp wrote:
> The attached test illustrates a proposal for minimal plumbing support
> usable to store permissions, ownership, and other metadata in git
> repositories. This proposal is fully compatible with existing
> repositories when the new functionality is not in use. Similar to the
> introduction of subprojects, we have not yet specified the porcelain. We
> believe that the plumbing will provide sufficient functionality for many
> uses, and these uses will help determine the appropriate porcelain.

I think the main way to use it would be a hook, that would read/write the
attributes to/from the tree. That will do the right thing for storing
permissions, owners and other things represented in the worktree. And
metadata that are neither part of the tree or directly related to git's
functionality are out of our scope.

> [...]
> We propose representing objects with metadata using a new "inode"
> object. An inode object contains the hash of the real object and the
> hash of a "props" (properties) object. A props object contains a set of
> name-value pairs. Tree objects can reference inode objects in addition
> to the current possibilities of blobs, trees, and subproject commits; we
> propose using the currently invalid type 110000 (S_IFREG | S_IFIFO) for
> inode objects. We primarily see a use case for inodes referencing blobs
> and trees, though as defined they support any object type.

I think this is the overly complex -- and also the needlessly incompatible
part. By the way, I don't think you need separate type for props -- it can be
a blob too.

I would suggest investigating following options:

 1. It would be possible to use clean/smudge filters to encode the attributes
    in the blob itself.
 2. Store the metadata in separate objects, but link them in the parent tree
    directly. In this case, each attribute could probably get it's own blob,
    so eg. for a file foo the tree containing it would have entries:
      foo
      foo<sep>owner
      foo<sep>permissions
      ...
    Where <sep> would be some sepatator (more on that below).

Advantages (+), disadvantages (-) and possible (*) extensions of 1:
 
 + It should be possible to get to something useful with very little changes
   to git. Basically all it needs to be useful for things like etckeeper is
   to:
    . Make sure both clean and smudge filter always get filehandle to the
      disk file in question (I am /not/ suggesting path as the file may be
      written in a staging area and moved into place later).
    . Pass the blob id currently in index to the clean filter, so it can
      maintain the data if they are not representable in this particular
      checkout (eg. when checking out such repo on windows). Note, that this
      would also be useful for ignoring insignificant changes, eg. when
      a in some config file order is not important and the tool using it
      randomly changes that order when changing that file.

 - It does not support metadata for directories, but could be crossed with
   approach 2 to fix that. Git could special-case entry '.' for storing
   "content" of a directory, which would be wholly created by running the
   clean filter on a directory (I am not sure directory handles are portable,
   but running with that directory as current should be). This would not have
   the problem of approach 2 with the entry names for the metadata.

 * Default processing could be added to strip the metadata in smudge and
   re-add them from index on clean. This would require adding some marker to
   know which blobs need this treatment. I see two ways:
    . Using different file type for them. There are already two types
      pointing to blob (S_IFREG and S_IFLNK) and they are treated differently
      on read (clean) / write (smudge) from/to tree, so third type should be
      workable.
    . Using additional format. Currently a blob is encoded as
	"blob" <LF> <content>
      so maybe an extneded blob could be encoded as
	"blob extended" <LF> <content>
      without needing a special type for it. But I don't know git internals
      enough to know how easy, hard or dirty this would be.

Advantages (+), disadvantages (-) and possible (*) extensions of 2:

 + It would work the same way for directories and file, or mostly so.
 + Different metadata would be handled independently, so it would be easier
   to combine support for multiple attributes (not that I can imagine any
   sensible use beyond access lists (owner, permission, posix acl)).
 + Checking out without the hooks could easily create special metadata files,
   providing easy way to work with the attributes where they are not
   supported by the underlaying filesystem.
 - It would require reserving some names for the metadata entries. I see
   basically three ways to name the attribues:
    . Reserving some character for the separator, eg. @ or # or something
      like that. So with file foo, there would be entries:
        foo
	foo@owner
	foo@permissions
      This has following pros and cons:
       + Minimal changes to the index <-> tree logic (remember, index is
         flat and has no directory entries, so the tree writer must decide
	 to which tree each entry goes).
       + Trivially supports checking the metadata entries out as special
         files on filesystem without metadata support.
       - The character is reserved in trees that need the feature (the trees
	 that don't need it don't need to care).
      Note, that the metadata entries could have mode either S_ISREG, or
      a new one. Inclined to say S_ISREG -- we have the special name to
      distinguish them.
    . Using something that does not exist in a normalized path, ie either
      "//" or "/./". So with file foo, there would be entries:
        foo
	foo//owner
	foo//permissions
      This has following pros and cons:
       + Does not reserve any characters. Every filename is permitted even
         when the freature is used.
       - Harder on the index <-> tree logic, as it would have to not consider
	 such strings as not being directory separators.
       - Such files could not be checked out, though they could still be
	 manipulated using cat-file and update-index.
      The metadata entries could have mode either S_ISREG or a new one again.
      New mode would be sensible if it would make easier on the index <->
      tree logic (it's easier to check 3 bits than search string for
      a substring).
    . Leave the suffix for metadata entries to the hooks. This would be
      middle road between the above two:
       + Reserves as little as possible, while not complicating the index <->
         tree logic.
       + Remains easy to check out as special files where you can't run the
         hooks, though this would require some special-casing similar to
	 symlinks on Windows.
       - Would require new mode for these entries, so we know they are
	 created and consumed by the hooks rather than directly read/written
	 to the tree.

Best regards,
Jan

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
