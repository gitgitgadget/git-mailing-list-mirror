From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 11:43:42 -0500
Message-ID: <GL75k5fYVorDQQh654Db9qgZ3DAr5EfRqLBwQe-VpacRGGbsy3c7WA@cipher.nrlssc.navy.mil>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil> <20080612041847.GB24868@sigill.intra.peff.net> <u5dYyGz0Q8KNQXnvGOEGmG2BTfT-vJCEFeSUa2I_99Q@cipher.nrlssc.navy.mil> <20080613054840.GA27122@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 18:50:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7CUB-00080g-LV
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 18:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbYFMQts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 12:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbYFMQts
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 12:49:48 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35297 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbYFMQtr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 12:49:47 -0400
Received: by mail.nrlssc.navy.mil id m5DGhhDd018535; Fri, 13 Jun 2008 11:43:43 -0500
In-Reply-To: <20080613054840.GA27122@sigill.intra.peff.net>
X-OriginalArrivalTime: 13 Jun 2008 16:43:43.0313 (UTC) FILETIME=[A41A0C10:01C8CD74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84898>

Jeff King wrote:
> On Thu, Jun 12, 2008 at 11:46:34AM -0500, Brandon Casey wrote:

>> Also, the sequence above would not have to be performed _exactly_ at the
>> expiration date. The listing of the stashes i.e. git-log, does not perform
>> reflog expiration AFAIK. So the initial 'stash list' and the 'git pull' do
>> not have to straddle the expiration date, they can all be performed any time
>> after the expiration point to produce the above behavior.
> 
> No, but it would have to be performed _after_ the expiration, but
> _before_ any auto-gc happened. So it is a smaller window than "anytime
> after expiration" but not as small as a particular 30-second window.

Right, that's why I showed the 'git-stash list' which still had the stash entry
before the 'git-pull'.

>> from reflogs even though stashes are implemented using reflogs. The big
>> difference is that reflogs are created automatically and stashes are created
>> by explicit user action. Automatically deleting something that git creates
>> automatically is ok and desirable, doing so for something the user explicitly
>> created is not necessarily so.
> 
> Wincent made this same argument. I don't really agree with it. It is
> predicated on the assumption that stashing something _is_ asking for git
> to remember it. My mental model of stashing is that it hasn't been saved
> at all, but is rather a convenient way of naming and storing a set of
> changes for a second while I do something else.  I think of it in the
> same way as a register in vi: I can yank text into it for pasting
> after a few commands. But I don't expect yanked text to be stored in the
> register a month later.

Funny you should mentioned that since I had thought of using a similar
example in defense of my point of view. So I offer a question: after how
much time after you have yanked some text into a register in vi do you
expect vi to clear that register?

I work in a linux environment and as such I use vim. It seems vim retains
text yanked to a register even across sessions (terminate vi, start vi, text
is still yanked). I was not aware of this and I didn't expect it (but it is
a welcome feature). I had expected that registers would be cleared when vi
was terminated, but _only_ when vi was terminated. So even if I left a session
running for 2 years, the register with yanked text would not be cleared. And
this is not because I think a certain workflow which requires a 2 year vi
editing session should be encouraged, but just because I told the editor to
do something, and I expect it to continue doing it until I tell it to stop.

There is a difference between git and applications like vi, and that is that
vi has a 'begin' and an 'end. You begin a vi session, you edit some text, you
yank, paste, save, then you terminate the session. So it is easy to think of the
yanks as being tied to the session. Similarly with something like X11 when you
highlight text, you expect it to be there in the copy buffer until other text is
highlighted or until X terminates.

Git does not really have a 'begin' and an 'end'.  Well there is one thing, and
that is a clone operation. Transient objects, including stashes are not copied
to the clone.

> So I think we are disagreeing not on how stashes should expire, but
> rather on what a stash _is_, and what it is useful for. And I am open to
> arguments that stashes are useful for longer-term storage. But I also
> find the expiration behavior useful (I seem to have accumulated some
> cruft in my stash list, and I expect git to clean it out during a gc,
> rather than me having to clean it manually). So personally, I would not
> be in favor of removing the expiration unless I saw evidence that the
> utility of keeping stashes long-term outweighed the benefit of cleaning.
> 
> And that evidence is probably "here is a workflow I find useful, and
> here is why it is better than any other way of doing it in git" (and
> maybe the "better" is simply "new users are going to jump on this way of
> using stash, even though it was not as intended").

I see it as less of a workflow issue than a safety issue, and a user interface
issue. I don't know if there are workflows that would be made possible by
not expiring the stash. I do think the benefit of automatically cleaning
out the stash so it doesn't accumulate old cruft is less important to me
than an intuitive interface and predictable behavior.

-brandon
