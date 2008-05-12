From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 16:53:44 -0700
Message-ID: <7vod7bw03a.fsf@gitster.siamese.dyndns.org>
References: <20080512122900.GA13050@mithlond.arda.local>
 <20080512155243.GA3592@mithlond.arda.local>
 <e1dab3980805121017u4c244d25s76b39cf015f6c5c5@mail.gmail.com>
 <20080512234906.GX29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Tweed <david.tweed@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 13 01:54:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvhqw-0000R5-6G
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 01:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbYELXx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 19:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755031AbYELXx4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 19:53:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbYELXx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 19:53:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FBA45D5E;
	Mon, 12 May 2008 19:53:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 34EC05D5B; Mon, 12 May 2008 19:53:47 -0400 (EDT)
In-Reply-To: <20080512234906.GX29038@spearce.org> (Shawn O. Pearce's message
 of "Mon, 12 May 2008 19:49:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD107536-207E-11DD-B20B-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81968>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> David Tweed <david.tweed@gmail.com> wrote:
>> On Mon, May 12, 2008 at 4:52 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
>> > Teemu Likonen wrote (2008-05-12 15:29 +0300):
>> > Probably a crazy idea: What if "gc --aggressive" first removed *.keep
>> > files and after packing and garbage-collecting and whatever it does it
>> > would add a .keep file for the newly created pack?
>> 
>> My understanding is that the repacking with -a redoes the computation
>> to repack ALL the objects in every pack and loose objects,
>
> No.  -a means repack all objects in all packs which do not have a
> .keep on them.  Without -a we only repack loose objects.
>
>> whereas
>> what would be preferred is to try to delta new objects (loose and
>> packed) against the existing .keep pack (extending it with the new
>> objects) but not trying to re-deltify objects in the .keep pack.
>
> We cannot do that.  Deltas in pack A may not reference base objects
> in pack B.  This is a simplification rule that prevents us from
> needing to worry about damaging a pack when we repack and delete
> another pack.
>
>> This
>> is because .keep files are primarily for those who are cloning onto a
>> machine that isn't powerful (maybe even a laptop/palmtop) but who are
>> cloning from a powerful server, so that you wouldn't necessarily want
>> to apply your strategy unconditionally.
>
> Yes, sort of.  We use .keep for two reasons:
>
>   - As a "lock file" to prevent a pack that was just created by a
>     git-fetch or git-recieve-pack from being deleted by a concurrent
>     git-repack before the objects it contains are linked into the
>     refs space and thus considered reachable;
>
>   - As a way to avoid _huge_ packs (say >1G) that would take a lot
>     of disk IO just to copy with 100% delta reuse from an old pack
>     to a new pack each time the user runs git-gc.
>
> I think git-clone marking a 150M linux-2.6 pack with .keep is wrong;
> most users working with the linux-2.6 sources have sufficient
> hardware to deal with the disk IO required to copy that with 100%
> delta reuse.  But I have a repository at day-job with a 600M pack,
> that's starting to head into the realm where git-gc while running
> on battery on a laptop would prefer to have that .keep.

Perhaps clone can decide to keep the .keep file depending on the size of
the pack then?
