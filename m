From: Roger Leigh <rleigh@codelibre.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 14:15:33 +0000
Message-ID: <20081120141533.GC6023@codelibre.net>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com> <20081120112708.GC22787@ravenclaw.codelibre.net> <492560C5.5070308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian MICHON <christian.michon@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 20 15:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3AKz-0000Bv-Sb
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 15:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbYKTOPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 09:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755239AbYKTOPh
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 09:15:37 -0500
Received: from nagini.codelibre.net ([80.68.93.164]:57739 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221AbYKTOPg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 09:15:36 -0500
Received: by nagini.codelibre.net (Postfix, from userid 1000)
	id 0FF7494676; Thu, 20 Nov 2008 14:15:33 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <492560C5.5070308@op5.se>
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 13:26:52 up 13 days,  1:44,  3 users,  load average: 0.01,
	0.11, 0.09
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101437>

On Thu, Nov 20, 2008 at 02:06:13PM +0100, Andreas Ericsson wrote:
> Roger Leigh wrote:
>> On Wed, Nov 19, 2008 at 05:18:16PM +0100, Christian MICHON wrote:
>>> On Wed, Nov 19, 2008 at 12:37 PM, Roger Leigh <rleigh@codelibre.net> wrote:
>>>> Would it be possible for git to store the mtime of files in the tree?
>>>>
>>>> This would make it possible to do this type of work in git, since it's
>>>> currently a bit random as to whether it works or not.  This only
>>>> started when I upgraded to an amd64 architecture from powerpc32,
>>>> I guess it's maybe using high-resolution timestamps.
>>>>
>>> beside the obvious answer it comes back often as a request, it is
>>> possible in theory to create a shell script which, for each file
>>> present in the sandbox in the current branch, would find the mtime of
>>> the last commit on that file (quite an expensive operation) and apply
>>> it.
>>
>> Surely this is only expensive because you're not already storing the
>> information in the tree; if it was there, it would be (relatively)
>> cheap?
>
> No, it's because git is *snapshot* based and doesn't care about anything
> but contents. Storing filestate information in the tree would be a
> backwards incompatible change that would require a major version change.

It's not strictly true that it's only caring about contents.  The
contents are of course in the blobs, but the tree is already
effectively storing inode data, since it's a directory of
filenames/subtrees, just one that only cares to store the
permissions part of the total inode data.

I understand that git stored the permissions tacked onto the hash;
would it be feasable to tack on the other bits as well.
If I understand correctly, it's binary encoded in the pack format,
and that would require updating the format to hold the additional
data?

> Caring about meta-data the way you mean it would mean that
>
>  git add foo.c; git commit -m "kapooie"; touch foo.c; git status
>
> would show "foo.c" as modified. How sane is that?

I've never come close to suggesting we do anything so insane.

What I am suggesting is that on add/commit, the inode metadata
be recorded in the tree (like we already store perms), so that
it can be (**optionally**) reused/restored on checkout.

Whether it's stored in the tree or not is a separate concern from
whether to *use* it or not.  For most situations, it won't be
useful, as has been made quite clear from all of the replies, and I
don't disagree with this.  However, for some, the ability to have
this information to hand to make use of would be invaluable.


There have been quite a few suggestions to look into using hooks,
and I'll investigate this.  However, I do have some concerns
about *where* I would store this "extended tree" data, since it
is implicitly tied to a single tree object, and I wouldn't
want to store it directly as content.


Regards,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.
