From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sat, 9 Aug 2008 20:51:01 -0700
Message-ID: <20080810035101.GA22664@spearce.org>
References: <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jamey Sharp <jamey@minilop.net>,
	Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 05:52:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS1yS-0008Sk-BL
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 05:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbYHJDvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 23:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753008AbYHJDvD
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 23:51:03 -0400
Received: from george.spearce.org ([209.20.77.23]:42595 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbYHJDvC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 23:51:02 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 45BEA38438; Sun, 10 Aug 2008 03:51:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91802>

Scott Chacon <schacon@gmail.com> wrote:
> > We began trying to implement this proposal, but we found this enum
> > definition in cache.h, which made us think there's only room for one
> > more kind of object:
> >
> >        enum object_type {
> >                OBJ_BAD = -1,
> >                OBJ_NONE = 0,
> >                OBJ_COMMIT = 1,
> >                OBJ_TREE = 2,
> >                OBJ_BLOB = 3,
> >                OBJ_TAG = 4,
> >                /* 5 for future expansion */
> >                OBJ_OFS_DELTA = 6,
> >                OBJ_REF_DELTA = 7,
> >                OBJ_ANY,
> >                OBJ_MAX,
> >        };
> >
> > Do these object_type values appear in any on-disk structure, or does any
> > other reason exist why this set of values cannot change? Can we add
> > additional object types for inodes and props? If not, what would you
> > recommend instead?
> 
> If I'm not mistaken, these are the values used to identify data in the
> header sections of packfile objects.  The first four bits are used to
> identify the object type, where the first bit is static and the next
> three are the object type of the data following the header.  Since the
> type is encoded using those three bits, 0-7 is the valid range.  I
> would assume that would be difficult to change, since all the
> packfiles depend on that range.

Correct.  There is only room in the pack file for 3 bits in the
type field, resulting in types 0-7 as being the only valid range.

Only type 0 and 5 are available for use.

Nico and I have (at least in the past) agreed that type 0 is meant
as an escape indicator.  If the type is set to 0 then the real type
code appears in another byte of data which follows the object's
inflated length.

That leaves only type 5 available.  Note that because type 5 can be
encoded into a really small space (3 bits) compared to any other
type we may add we really want to use it for something which will
appear _very_frequently_.  The OBJ_DICT_TREE encoding we were talking
about doing for pack v4 fits that bill, as nearly any project (even
huge ones like Mozilla or KDE) would probably be using OBJ_DICT_TREE
thoughout their pack files, and there is a noticable reduction in
disk usage (and increased performance due to lower page faults)
as a result.

The proposed "inode" and "props" types sound like they are useful
for only less common cases, and would appear very infrequently
compared to a tree object.

So yea, there really aren't any new type bits available.

But tossing aside the type bit argument, I'm not sure I see the
value in adding limited arbitrary properties to names in a tree.
How does one edit these?  How do you inspect them before you get
a checkout, assuming they might actually have an impact on the
checkout process?  How the hell do you merge them?

I'm also very concerned about the limited range of values for both
keys and values in a "props" type.  Even if we did go down this
road of supporting such a concept at the plumbing layer (and in the
storage modal) everwhere else we are 8-bit clean.  Commit messages,
tag messages, blob contents, even file names in tree objects.
(OK, file names cannot contain a NUL byte, but whatever, that is
their only limitation.)

The proper encoding for both keys and values should permit any data
to be stored.  Doesn't the extended attributes feature in Linux and
FreeBSD both support any data to be attached to an inode in the fs?

Please don't get me wrong.

I think this is a _BAD_ idea.

A bad idea that will only clutter up the core object model, and
the core processing code of that object model.  Extended attributes
aren't used that much on local filesystems, because they are hard
to work with and suck performance wise.  Performance in Git is
a _feature_.  It matters.  Our clean object model really helps to
make that possible.

-- 
Shawn.
