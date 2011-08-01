From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 1 Aug 2011 20:02:22 +0200
Message-ID: <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
 <1311012516-4836-5-git-send-email-kusmabite@gmail.com> <7vmxga7zb9.fsf@alter.siamese.dyndns.org>
 <CABPQNSYtpRpNQVW=QvyfFhmWge5-C+k85bs2EJeK8k0jdfHzrw@mail.gmail.com>
 <20110728160845.GA14337@sigill.intra.peff.net> <20110728164758.GA15931@sigill.intra.peff.net>
 <20110728170222.GB15931@sigill.intra.peff.net> <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com>
 <20110801174603.GB10302@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	j6t@kdbg.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:03:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwpa-0000Q8-2q
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075Ab1HASDG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 14:03:06 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61466 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab1HASDD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 14:03:03 -0400
Received: by pzk37 with SMTP id 37so11901719pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=1tDwlYcVFMCOWq6s4MO6b3PB5v2a5LBOgilbEeGCbG0=;
        b=OENWRj4AUQRza82WTYFpbM3Zg62v5d1sNS17Y9v9h+n9DEAwWs8uSQbnQ47cmbjfL9
         0+rw98PWQWtPwk6E1d19b8UbEsXPEmmWQY+OkR3I9aj7FxyysEOywrrmFsNSzBezndGW
         deNiPIxCEo1CixkSpYIzuxJFt/bBy88dJuk50=
Received: by 10.68.39.167 with SMTP id q7mr8493514pbk.415.1312221782119; Mon,
 01 Aug 2011 11:03:02 -0700 (PDT)
Received: by 10.68.56.65 with HTTP; Mon, 1 Aug 2011 11:02:22 -0700 (PDT)
In-Reply-To: <20110801174603.GB10302@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178369>

On Mon, Aug 1, 2011 at 7:46 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 01, 2011 at 04:45:03PM +0200, Erik Faye-Lund wrote:
>
>> > And that patch would look something like the one below.
>>
>> This is the most straight forward way of doing this, thanks. I'll po=
st
>> a new version with this squashed in soon.
>>
>> What's the proper way of attributing you for the work?
>
> If you're squashing, just make a note in the text, or add a Helped-by
> header at the end.
>

OK, that's basically what I did already ;)

>> > You can also now
>> > drop the "remote" parameter to write_archive entirely, but I didn'=
t do
>> > so here.
>>
>> I'm not entirely sure how you propose we do this... do you mean by
>> hoisting the relevant logic from write_archive up to cmd_archive or
>> something?
>
> Sorry, I wrote that comment, then totally changed how my patch was
> implemented and failed to update the comment. :)
>
> The arguments to git-archive actually get parsed in two places:
>
> =A01. cmd_archive passes them to decide on meta stuff like remote vs
> =A0 =A0 local
>
> =A02. write_archive has a parse_archive_args function to actually par=
se
> =A0 =A0 the arguments that both upload-archive and archive share
>
> My patch puts the new argument in (1). We could put it in (2) and do
> away with passing the flag all the way down the call stack. But it se=
ems
> conceptually cleaner to me to have it in (1) (and the diff is much
> shorter, too).
>

Makes sense. Thanks for the explanation, I agree.

>> $ make t5000-tar-tree
>> *** t5000-tar-tree.sh ***
>> ok 1 - populate workdir
>> <snip>
>> ok 53 - infer tgz from .tar.gz filename
>> not ok - 54 extract tgz file
>> #
>> # =A0 =A0 =A0 =A0 =A0 =A0 =A0 $GUNZIP -c <j.tgz >j.tar &&
>> # =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_cmp b.tar j.tar
>> #
>> not ok - 55 remote tar.gz is allowed by default
>> #
>> # =A0 =A0 =A0 =A0 =A0 =A0 =A0 git archive --remote=3D. --format=3Dta=
r.gz HEAD >remote.tar.gz &&
>> # =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_cmp j.tgz remote.tar.gz
>> #
>> ok 56 - remote tar.gz can be disabled
>> # failed 2 among 56 test(s)
>> 1..56
>> make: *** [t5000-tar-tree.sh] Error 1
>>
>> It seems "git archive --format=3Dtgz HEAD" is broken on Windows:
>> $ git archive --format=3Dtgz HEAD > j.tgz
>> $ gunzip -c j.tgz > j.tar && echo ok
>>
>> gzip: j.tgz: invalid compressed data--format violated
>>
>> But if I perform the compression manually, the archive is fine:
>> $ git archive --format=3Dtar HEAD | gzip -cn > j.tgz
>> $ gunzip -c j.tgz > j.tar && echo ok
>> ok
>
> Weird. What does j.tgz end up looking like? Is it empty, or does it h=
ave
> bogus data in it? Does gzip actually get invoked at all? Try running
> with GIT_TRACE=3D1. I don't suppose you guys have something like stra=
ce,
> which might be helpful.
>

It does have data, and gzip does get invoked:
$ gunzip -c j.tgz | wc -c

gzip: j.tgz: invalid compressed data--format violated
 131072

So it seems there are around 130k of valid data before it barfs.

Hmm, but when I try the same after re-running the test, I get a
different amount of valid data (491520 bytes this time)... Is this a
timing-related issue?

Yeah, strace would have been useful, but we don't have that on
Windows. There are probably other alternatives, but I'm not aware...
perhaps procmon can be of help?

>> So, the big question is, are all tar-filters broken on Windows? It
>> seems not; the tests for the foo-filter works fine... any clues? Cou=
ld
>> it somehow be newline-related, perhaps?
>
> I'm not sure that newlines would make a difference. We use straight
> write() everywhere in the archive code, which should be binary safe.
>

OK, so that hunch was a bad one ;)
