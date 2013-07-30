From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] sha1_file: introduce close_one_pack() to close packs on
 fd pressure
Date: Tue, 30 Jul 2013 15:59:54 -0700
Message-ID: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
References: <1375157113-608-1-git-send-email-bcasey@nvidia.com>
	<7v61vsxdiz.fsf@alter.siamese.dyndns.org>
	<20130730195257.GA16247@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 31 01:00:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Itc-0000HC-Ro
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 01:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596Ab3G3W75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 18:59:57 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:44812 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab3G3W74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 18:59:56 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi8so4470wib.15
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 15:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=waXYPdz1J5RgfnkV+GDqbJGpybXgGpRULAgjEL3sDqM=;
        b=TN4kK/DqcklLJMkhZlhRse5oy0shofdmWNm2dg2cFddSGU6GAvB9u/V09ef8G55BSK
         bV+CFecpQhJLN8NOGClprlS84vGyK4VpgVYuFG4C/P8W1yz9UNvYbNN06pjBnxhPr96N
         mfZPf8h0zswnS8QLhro/uMPWFvFEhOABaMqxMB5XQMGXSy1vtqMrJyWggEZ1NEwrCQBf
         ab2r2xbi5+BDJoD5ueiSb/paQhEOaEp4WLritrvYkoVs5iLb4hAYfANmcMutoR4wnddP
         kYCn1Onss/o+Yg9SxKRoKAJjDapdRQ23eIKEl7NYlUXlR19UQfr3F5GCobIEN4qS2hYN
         inhg==
X-Received: by 10.194.234.100 with SMTP id ud4mr47907329wjc.44.1375225194758;
 Tue, 30 Jul 2013 15:59:54 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Tue, 30 Jul 2013 15:59:54 -0700 (PDT)
In-Reply-To: <20130730195257.GA16247@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231396>

On Tue, Jul 30, 2013 at 12:52 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 30, 2013 at 08:39:48AM -0700, Junio C Hamano wrote:
>
>> Brandon Casey <bcasey@nvidia.com> writes:
>>
>> > From: Brandon Casey <drafnel@gmail.com>
>> >
>> > When the number of open packs exceeds pack_max_fds, unuse_one_window()
>> > is called repeatedly to attempt to release the least-recently-used
>> > pack windows, which, as a side-effect, will also close a pack file
>> > after closing its last open window.  If a pack file has been opened,
>> > but no windows have been allocated into it, it will never be selected
>> > by unuse_one_window() and hence its file descriptor will not be
>> > closed.  When this happens, git may exceed the number of file
>> > descriptors permitted by the system.
>>
>> An interesting find.  The patch from a cursory look reads OK.
>
> Yeah. I wonder if unuse_one_window() should actually leave the pack fd
> open now in general.
>
> If you close packfile descriptors, you can run into racy situations
> where somebody else is repacking and deleting packs, and they go away
> while you are trying to access them. If you keep a descriptor open,
> you're fine; they last to the end of the process. If you don't, then
> they disappear from under you.
>
> For normal object access, this isn't that big a deal; we just rescan the
> packs and retry. But if you are packing yourself (e.g., because you are
> a pack-objects started by upload-pack for a clone or fetch), it's much
> harder to recover (and we print some warnings).
>
> We had our core.packedGitWindowSize lowered on GitHub for a while, and
> we ran into this warning on busy repositories when we were running "git
> gc" on the server. We solved it by bumping the window size so we never
> release memory.
>
> But just not closing the descriptor wouldn't work until Brandon's patch,
> because we used the same function to release memory and descriptor
> pressure. Now we could do them separately (and progressively if we need
> to).

I had thought about whether to stop closing the pack file in
unuse_one_window(), but didn't have a reason to do so.  I think the
scenario you described provides a justification.  If we're not under
file descriptor pressure and we can possibly avoid rescanning the pack
directory, it sounds like a net win.

>> > This is not likely to occur during upload-pack since upload-pack
>> > reads each object from the pack so that it can peel tags and
>> > advertise the exposed object.
>>
>> Another interesting find.  Perhaps there is a room for improvements,
>> as packed-refs file knows what objects the tags peel to?  I vaguely
>> recall Peff was actively reducing the object access during ref
>> enumeration in not so distant past...
>
> Yeah, we should be reading almost no objects these days due to the
> packed-refs peel lines. I just did a double-check on what "git
> upload-pack . </dev/null >/dev/null" reads on my git.git repo, and it is
> only three objects: the v1.8.3.3, v1.8.3.4, and v1.8.4-rc0 tag objects.
> In other words, the tags I got since the last time I ran "git gc". So I
> think all is working as designed.

Ok, looks like this has been the case since your 435c8332 which taught
upload-pack to use peel_ref().  So looks like we do avoid reaching
into the pack for any ref that was read from a (modern) packed-refs
file.  The repository I was testing with had mostly loose refs.
Indeed, after packing refs, upload-pack encounters the same problem as
receive-pack and runs out of file descriptors.

So my comment about upload-pack is not completely accurate.
Upload-pack _can_ run into this problem, but the refs must be packed,
as well as there being enough of them that exist in enough different
pack files to exceed the processes fd limit.

> We could give receive-pack the same treatment; I've spent less time
> micro-optimizing it because because we (and most sites, I would think)
> get an order of magnitude more fetches than pushes.

I don't think it would need the 435c8332 treatment since receive-pack
doesn't peel refs when it advertises them to the client and hence does
not need to load the ref object from the pack file during ref
advertisement, but possibly some of the other stuff you did would be
applicable.  But like you said, the number of fetches far exceed the
number of pushes.

-Brandon
