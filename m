From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sun, 03 Sep 2006 22:50:33 -0700
Message-ID: <7v3bb8qixi.fsf@assigned-by-dhcp.cox.net>
References: <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net>
	<44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
	<7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
	<20060902045246.GB25146@spearce.org>
	<7vodty1swz.fsf@assigned-by-dhcp.cox.net>
	<20060902175408.GD27826@spearce.org>
	<7vhczovf6m.fsf@assigned-by-dhcp.cox.net>
	<20060904041052.GA29369@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 10:40:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKA0O-0002dJ-7m
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 10:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWIDIk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 04:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWIDIkM
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 04:40:12 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:3203 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932331AbWIDFuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 01:50:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904055015.BZMU27846.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 Sep 2006 01:50:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id J5qF1V00g1kojtg0000000
	Mon, 04 Sep 2006 01:50:16 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060904041052.GA29369@spearce.org> (Shawn Pearce's message of
	"Mon, 4 Sep 2006 00:10:52 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26406>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>...
>> You could introduce repack.active in .git/config that points at
>> the latest active, make git-repack to notice and update when it
>> updates it.
>...
> Better that it update a symref like thing instead.  For example
> create a ".git/objects/pack/active" file holding the name
> ("pack-n{40}.pack") of the current active pack.  If this file is
> missing choose the pack that is smallest as the active pack.

Actually I like the one you did not quote even better the more I
think about it.

>> We could also just use .git/objects/pack/pack-active.{pack,idx}
>> files.  This needs some surgery to get rid of packed_git.sha1[],
>> sha1_pack_name() and friends and have them only require .pack
>> and .idx are linked by their basename only as was discussed in a
>> separate thread to make it dumb-transport friendly.

The argument given as the reason (rather, excuse) the dumb
transport routines wanted to rely on the packed_git.sha1[] and
sha1_pack_name() was because we would need to avoid packname
collisions _anyway_ so relying on the convention to have
"pack-[0-9a-f]{40}.(pack|idx)" is OK or even desirable.

We need to avoid packname collisions, and it is acceptable to
assume that SHA-1 is practically collision free like the rest of
the system does.  However, if the dumb transport wants to avoid
packname collision, it should not rely on the way how the other
side names its packs.  It first downloads the .idx files, so it
can compute the _right_ packname using the sorted object names
recorded there [*1*], and store the downloaded pack/idx under
the right name, without relying on the way how the other side
names their packs (it still needs to rely on the names in that
their name end with .pack and .idx, and .pack and .idx
corresponds with each other by their basenames.  But the point
is it should not depend on more than that, especially that the
basename is of the form "pack-[0-9a-f]{40}" nor the hex part is
the correct packname).

Now if we fix dumb transport downloaders, then we could even
make a convention that the packs named pack-[0-9a-f]{40}.pack
are archive packs.  And git-repack can even have a convention
that .git/objects/pack/pack-active.(pack|idx) is the active
pack.

[Footnote]

*1* a refresher course of the packname generation; it is SHA-1
over the object names (20-byte binary representation) in the
pack, sorted in byte order.  See builtin-pack-objects.c for
details.


-- 
VGER BF report: S 0.99883
