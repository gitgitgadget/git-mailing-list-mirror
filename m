From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 18:34:34 +0200
Message-ID: <873b0dmk4l.fsf@rho.meyering.net>
References: <87wsxpobf0.fsf@rho.meyering.net>
	<81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com>
	<87r6nxo8iq.fsf_-_@rho.meyering.net>
	<81b0412b0706270618p850df2dy41b2b797d82e3276@mail.gmail.com>
	<87d4zho74h.fsf@rho.meyering.net>
	<81b0412b0706270704y58c9e05bh6ec10118d7ee406c@mail.gmail.com>
	<87tzstmqmi.fsf@rho.meyering.net>
	<81b0412b0706270857w175f2b2ey4c30bac9c0836929@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 18:34:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3aTY-0001bo-9s
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 18:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbXF0Qeg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 12:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbXF0Qeg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 12:34:36 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46048 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbXF0Qef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 12:34:35 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4E44E5A33D;
	Wed, 27 Jun 2007 18:34:34 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 1DAF42BDA2; Wed, 27 Jun 2007 18:34:34 +0200 (CEST)
In-Reply-To: <81b0412b0706270857w175f2b2ey4c30bac9c0836929@mail.gmail.com> (Alex Riesen's message of "Wed\, 27 Jun 2007 17\:57\:27 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51055>

"Alex Riesen" <raa.lkml@gmail.com> wrote:
> On 6/27/07, Jim Meyering <jim@meyering.net> wrote:
>> "Alex Riesen" <raa.lkml@gmail.com> wrote:
>>
>> > On 6/27/07, Jim Meyering <jim@meyering.net> wrote:
>> >> "Alex Riesen" <raa.lkml@gmail.com> wrote:
>> >> > Check if this works in some exotic but common
>> >> > environments (like MacOSX, Cygwin or HP-UX).
>> >>
>> >> What do you mean?
>> >> I know that dup and fdopen work in those environments.
>> >
>> > Exactly as you described?
>>
>> No, but why does that matter?
>
> Your code will need additional tweaking on this
> systems.

Why bother?  The only undesirable side effect you'd see on a buggy
system would be a meaningless strerror(errno) in that very unusual
error situation: when git-format-patch (without --stdout)
runs out of file descriptors or memory.

>> > Are you sure fdopen on Cygwin
>> > sets ENOMEM?
>>
>> Are you suggesting not to use errno because
>> it won't contain useful information on Mingw32?
>
> Yes. Mingw32 is just one example.
>
>> >> It's ok, but for the fact that when dup fails, all you get
>> >> is the uninformative EINVAL from fdopen.
>> >
>> > EBADF on Cygwin, 0 on Mingw32. Can't even imagine what msvc
>>
>> EBADF is fine.  Setting errno to 0 upon error is a bug.
>> Don't cater to buggy systems.
>
> It is my system at work. What should I do, throw it out of window?

Perhaps you misunderstood?

My saying "don't cater to buggy systems", means don't pollute or dumb-down
application code to accommodate them.  Instead, code to some best-case
standard (Linux, POSIX, whatever) and if necessary, use wrappers that
work around the deficiencies of less-well-endowed systems.  For example,
coreutils assumes that functions like fchdir and openat work properly.
Even though some really crufty systems have no fchdir syscall, and many
relatively modern systems lack openat, fstatat, etc., all of the coreutils
programs work fine in spite of that: they rely on gnulib's emulation
of those underlying functions.  This lets applications keep free of
the dirty underlying portability details and concentrate on algorithms.
Then there are the all of the wrappers for functions like stat, lstat,
rename, etc. that misbehave on certain losing (but still in use) systems.
I've been "accommodating" deficient systems for a very long time, so
know from experience that it can be done cleanly.

If this little corner of portability matters to you, it wouldn't be
hard to write dup and/or fdopen wrappers that do the right thing on
whatever buggy system you find you have to use.  Incidentally, one nice
(essential) thing about the gnulib framework is that full-featured systems
usually incur *absolutely no* overhead, because they don't even use the
wrapper functions.

>> > Then put file name and the line number in!
>>
>> Surely you're playing devil's advocate, now...
>
> No, I'm just thinking aloud about whether I should start preparing
> a reverting commit for your changes just to be able to continue
> using Git on that mismanaged, stupid, slow and very real

No need to go to such an extreme...
Unless that particular diagnostic really matters to you.

> system I have to work with. It is a Win2k laptop, in a Novell
> network and with Cygwin on (actually 2 cygwins at least, which
> cygwin does not support), and without a chance to _EVER_ use
> anything else.

You have my sympathy :-/
