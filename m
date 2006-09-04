From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Mon, 04 Sep 2006 00:39:14 -0700
Message-ID: <7v8xl0ozbx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
	<7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
	<20060902045246.GB25146@spearce.org>
	<7vodty1swz.fsf@assigned-by-dhcp.cox.net>
	<20060902175408.GD27826@spearce.org>
	<7vhczovf6m.fsf@assigned-by-dhcp.cox.net>
	<20060904041052.GA29369@spearce.org>
	<7v3bb8qixi.fsf@assigned-by-dhcp.cox.net>
	<20060904064443.GB30032@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 10:39:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK9zb-0002Sg-BD
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 10:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWIDIjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 04:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIDIjh
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 04:39:37 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:58241 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932421AbWIDHi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 03:38:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904073856.DHZD20060.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 Sep 2006 03:38:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id J7ew1V00e1kojtg0000000
	Mon, 04 Sep 2006 03:38:57 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060904064443.GB30032@spearce.org> (Shawn Pearce's message of
	"Mon, 4 Sep 2006 02:44:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26403>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Now if we fix dumb transport downloaders, then we could even
>> make a convention that the packs named pack-[0-9a-f]{40}.pack
>> are archive packs.  And git-repack can even have a convention
>> that .git/objects/pack/pack-active.(pack|idx) is the active
>> pack.
>
> Seems reasonable.
>
> I take it you are proposing that a dumb transport always downloads
> pack-active.pack as pack-n{40}.pack where the dumb protocol
> downloader computed the correct pack name from its contents.  Thus
> any remote pack downloaded over a dumb transport is automatically
> treated as a historical pack by the receiving repository.

It is a lot lot lot stronger than that.  If the dumb transport
(or git in general) uses [0-9a-f]{40} part as the assuarance
mechanism to avoid packname collisions, it should be prepared to
recompute the correct name for not just pack-acrive but _all_
remote packs and store them under the right name.

Also, if repack uses the convention to treat pack-active.* as
the active pack, it might make sense for dumb transport to use
that as a clue and explode what the other side calls pack-active.*
upon reception.  For the purpose of repacking decision for the
person at the other end, they are subject for frequent repacking,
so maybe we should treat it as such.

> [snipped and re-ordered]
>> It first downloads the .idx files, so it can compute the
>> _right_ packname using the sorted object names recorded there
>
> Why trust the .idx?  I've seen you post that the .idx is purely
> a local matter.  The "smart" Git protocol only receives the .pack
> from the remote and computes the .idx locally or unpacks it to loose
> objects locally; why should a dumb transport trust the remote .idx?

Remote .idx is paired with remote .pack and must be able to
access into .pack otherwise the remote person could not use the
pack locally ;-).  Note that we are not talking about malicious
repository.

The issue here is not about _trusting_, but adjusting its name
to its contents to match your local convention, which is what
the recent pack-objects spits out to its standard output.  Older
versions of pack-objects named the resulting pack with pretty
much randomly (it used to use SHA-1 checksum of object names in
input order, not in index order which is sorted, so the same
pack _could_ have different names), and its output files should
be considered valid packs if they are still around.


-- 
VGER BF report: S 0.999988
