From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Tue, 18 Mar 2014 07:16:21 +0100
Message-ID: <87pplkvxoq.fsf@fencepost.gnu.org>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
	<1394976904-15395-6-git-send-email-pclouds@gmail.com>
	<20140318045050.GB8240@sigill.intra.peff.net>
	<CACsJy8CU3JyL74OuurjDr5-FHmBOCRahtXukukCqGx1cTdjvMQ@mail.gmail.com>
	<20140318051342.GA17200@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 07:20:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPnNx-0005UI-Dj
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 07:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbaCRGUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Mar 2014 02:20:11 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:57091 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbaCRGUJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Mar 2014 02:20:09 -0400
Received: from localhost ([127.0.0.1]:56129 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WPnNg-0005fB-3c; Tue, 18 Mar 2014 02:20:08 -0400
Received: by lola (Postfix, from userid 1000)
	id 0C070EACCD; Tue, 18 Mar 2014 07:16:22 +0100 (CET)
In-Reply-To: <20140318051342.GA17200@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 18 Mar 2014 01:13:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244335>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 18, 2014 at 12:00:48PM +0700, Duy Nguyen wrote:
>
>> On Tue, Mar 18, 2014 at 11:50 AM, Jeff King <peff@peff.net> wrote:
>> > On Sun, Mar 16, 2014 at 08:35:04PM +0700, Nguy=E1=BB=85n Th=C3=A1i=
 Ng=E1=BB=8Dc Duy wrote:
>> >
>> >> As explained in the previous commit, current aggressive settings
>> >> --depth=3D250 --window=3D250 could slow down repository access
>> >> significantly. Notice that people usually work on recent history =
only,
>> >> we could keep recent history more loosely packed, so that repo ac=
cess
>> >> is fast most of the time while the pack file remains small.
>> >
>> > One thing I have not seen is real-world timings showing the slowdo=
wn
>> > based on --depth. Did I miss them, or are we just making assumptio=
ns
>> > based on one old case from 2009 (that, AFAIK does not have real nu=
mbers,
>> > just speculation)? Has anyone measured the effect of bumping the d=
elta
>> > cache size (and its hash implementation)?
>>=20
>> David tested it with git-blame [1]. I should probably run some tests
>> too (I don't remember if I tested some operations last time).
>>=20
>> http://thread.gmane.org/gmane.comp.version-control.git/242277/focus=3D=
242435
>
> Ah, thanks. I do remember that thread now.
>
> It looks like David's last word is that he gets a significant
> performance from bumping the delta base cache size (and number of
> buckets).

Increasing number of buckets was having comparatively minor effects
(that was the suggestion I started with), actually _degrading_
performance rather soon.  The delta base cache size was much more
noticeable.  I had prepared a patch serious increasing it.  The reason
I=C2=A0have not submitted it yet is that I have not found a compelling
real-world test case _apart_ from the fast git-blame that is still
missing implementation of -M and -C options.

There should be other commands digging through large amounts of old
history, but I did not really find something benchmarking convincingly.
Either most stuff is inefficient anyway, or the access order is
better-behaved, causing fewer unwanted cache flushes.

Access order in the optimized git-blame case is basically done with a
reverse commit-time based priority queue leading to a breadth-first
strategy.  It still beats unsorted access solidly in its timing.  Don't
think I compared depth-first results (inversing the priority queue
sorting condition) with regard to cache results, but it's bad for
interactive use as it tends to leave some recent history unblamed for a
long time while digging up stuff in the remote past.

Moderate cache size increases seem like a better strategy, and the
default size of 16M does not make a lot of sense with modern computers.
In particular since the history digging is rarely competing with other
memory intensive operations at the same time.

> And that matches the timings I just did. I suspect there are still
> pathological cases that could behave worse, but it really sounds like
> we should be looking into improving that cache as a first step.

I can put up a patch.  My git-blame experiments used 128M, and the patc=
h
proposes a more conservative 64M.  I don't actually have made
experiments for the 64M setting, though.  The current default is 16M.

--=20
David Kastrup
