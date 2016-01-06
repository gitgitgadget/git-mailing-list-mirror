From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4] reflog-walk: don't segfault on non-commit sha1's in
 the reflog
Date: Wed, 6 Jan 2016 16:30:56 +0700
Message-ID: <CACsJy8DLWex0fCaLxCe+ZGeoVcStWcdhBwmeU8fMxonO4VfKcg@mail.gmail.com>
References: <1451552227.11138.6.camel@kaarsemaker.net> <20160105211206.GA12057@spirit>
 <CAPig+cRufd4qOwZRpw2TR39npkRGg=7S+7YwfSu6EvRR95kRSA@mail.gmail.com>
 <1452043212.5562.18.camel@kaarsemaker.net> <CAPig+cThSHKBiUk5CmtE59mci3JLMv7QPNfHZAYmkqQvZHHofA@mail.gmail.com>
 <CAPig+cQ7MineqezZXxpfAotVwoM9Ju1qwVGpEnEh9qNKBF1Pjg@mail.gmail.com> <1452071624.2668.21.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 10:31:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGkRL-0007cC-0c
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 10:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbcAFJbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 04:31:31 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36836 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbcAFJb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 04:31:27 -0500
Received: by mail-lf0-f50.google.com with SMTP id z124so304463670lfa.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 01:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZOrScNvhHYzSpWVcROx+r6PLw9iDWWp2vAlBCQzVtaI=;
        b=TshwkCwpRndguH5aI7orYR2sRM8xken6/Gx35wq5VwHa79+YQlPUGKsCoLsjt9Z2uV
         9qX3IjC81Bko81UiZa2rPFHDdcbtrAcLoAtCHJ2g/+Knx2PdaHVVseuZkijLevSuX2L8
         +Mse7N/10/hHeKGFsnYqL+78W8ma81qdRAJM8XsXcs3qhpyPKNs41FqgvUJHQV11wKtP
         +EjzlDff1ScB3onK7U463XOSSb3UTKmy+KRCbOwwd1wFZjWyZSKAJfO/eb68Mg1RykAb
         qAcWgi18/iG7K8m8XjQ2ENdLDjJD5pTRsW3r29tiTk6D79MdOW4S/Ti1T5pOiAmCVQF9
         1q7A==
X-Received: by 10.25.137.84 with SMTP id l81mr35233226lfd.45.1452072686139;
 Wed, 06 Jan 2016 01:31:26 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 6 Jan 2016 01:30:56 -0800 (PST)
In-Reply-To: <1452071624.2668.21.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283427>

On Wed, Jan 6, 2016 at 4:13 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On di, 2016-01-05 at 20:52 -0500, Eric Sunshine wrote:
>> On Tue, Jan 5, 2016 at 8:28 PM, Eric Sunshine <
>> sunshine@sunshineco.com> wrote:
>> > On Tue, Jan 5, 2016 at 8:20 PM, Dennis Kaarsemaker
>> > <dennis@kaarsemaker.net> wrote:
>> > > On di, 2016-01-05 at 20:05 -0500, Eric Sunshine wrote:
>> > > > Hmm, this test is successful for me on OS X even without the
>> > > > reflog-walk.c changes applied.
>> > > >
>> > > > And this test actually fails (inversely) because it's expecting
>> > > > a
>> > > > failure, but doesn't get one since the command produces the
>> > > > expected
>> > > > output.
>> > >
>> > > That's... surprising to say the least. What's the content of
>> > > 'actual',
>> > > and which git.git commit are you on?
>> >
>> > % cat t/trash\ directory.t1410-reflog/actual
>> > b60a214 refs/tests/tree-in-reflog@{0}: Restoring to commit
>> > 140c527 refs/tests/tree-in-reflog@{1}: Forcing tree
>> > b60a214 refs/tests/tree-in-reflog@{2}: Creating ref
>> > %
>> >
>> > This is with only the t/t1410-reflog.sh changes from your patch
>> > applied atop current 'master' (SHA1 7548842).
>>
>> By the way, the segfault does occur for me on Linux and FreeBSD.
>>
>> And, in all cases, on all tested platforms, with the full patch
>> applied, both tests behave sanely (in the expected fashion). So, even
>> though the crash doesn't manifest everywhere, the fact that the tests
>> are meaningfully testing it on the "affected" platforms may mean that
>> it's not worth worrying about why it doesn't segfault on OS X.
>>
>> (Of course, practicality aside, one might want to satisfy one's
>> intellectual curiosity about why it behaves differently on OS X.)
>
> The only explanation I can think of (and that's with practically no
> knowledge of OS X internals) is that OS X's memory allocation strategy
> is unlucky. Git is definitely writing to a location it should not write
> to. On linux and freebsd this is unallocated memory, so you get a
> segfault. On OS X, it happens to be memory actually allocated by git,
> resulting not in a segfault but in silent corruption of other in-memory
> data. I would argue that this is a much worse result, even though in
> this small test that corruption seems to not trigger a crash.

Agreed. For a guaranteed crash, put assert(c->object.type ==
OBJ_COMMIT); in the macro function "slabname## _at_peek" in
commit-slab.h. That is if I analyzed the crash correctly. I'm not
suggesting to put the assert() in the code permanently though because
I don't know how often this function is called.
-- 
Duy
