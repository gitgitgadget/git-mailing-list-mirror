From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rerere is confused with identical conflicts in multiple files
Date: Fri, 10 Jul 2015 07:13:28 -0700
Message-ID: <xmqqvbdsksmv.fsf@gitster.dls.corp.google.com>
References: <559F7C81.50805@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Markos Chandras <Markos.Chandras@imgtec.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 16:13:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDZ3a-0001cd-8h
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 16:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbbGJONf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 10:13:35 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33179 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbbGJONc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 10:13:32 -0400
Received: by iggp10 with SMTP id p10so36061492igg.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 07:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HjPglCGjlAx3mCd7OnqLY7+ATyxGxBsQ1O/84dmXKKs=;
        b=ef+V6IoHq9UtzfQU4E1VpGEmNDbHtdWSJPrDgYd3ZjMSiSu+z4XJLpPNsuMBGsvn8n
         MTPXJhKJhUgn5bu6IXPrgqTucIBJ7WOZJLdxnJHctRq2toErHqQwzYLIlVIoto7vH4OY
         TtfgPsW4Xl86wCHixYlM4k7k1Tgp7sE85+sBu26X+udB4cGqBuYrzpzJsL0pryCGVg7s
         oQu7pmlFPEogjb8U+Dt07Pr+xOSq6nqr/83TveQ3gembrfjTQU+HFtvQBDSY/wP5FS4u
         TZFcCe8j2GFe/kdRxgKuMTk/Qene45ZBRZ+6UftSRKRf3dzwWtzHo7WloNFVtNCatgkf
         hswQ==
X-Received: by 10.107.164.22 with SMTP id n22mr31651691ioe.73.1436537612231;
        Fri, 10 Jul 2015 07:13:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6de3:8019:a2a4:79ec])
        by smtp.gmail.com with ESMTPSA id i7sm1452456igt.18.2015.07.10.07.13.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jul 2015 07:13:30 -0700 (PDT)
In-Reply-To: <559F7C81.50805@imgtec.com> (Markos Chandras's message of "Fri,
	10 Jul 2015 09:04:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273818>

Markos Chandras <Markos.Chandras@imgtec.com> writes:

> $ cat .git/MERGE_RR
> 5563edc0fb427275a0ca5677c93c40def8b53258
> arch/mips/include/asm/cpu-type.hf175ff6228f624296b661664bce4ab4e84d712cc
>
> arch/mips/include/asm/cpu.h5563edc0fb427275a0ca5677c93c40def8b53258
>    arch/mips/kernel/idle.c5563edc0fb427275a0ca5677c93c40def8b53258
> arch/mips/kernel/spram.c5563edc0fb427275a0ca5677c93c40def8b53258
> arch/mips/kernel/traps.c5563edc0fb427275a0ca5677c93c40def8b53258
> arch/mips/mm/c-r4k.c
>
> so as you see, multiple files share the same hash. That's probably
> because the "conflicting context ( the part between >>> <<<<)" in every
> file but cpu.h is identical and git seems to calculate the hash purely
> on the conflicting context. That makes git rerere thinks that it only
> has to resolve 2 conflicts instead of 6.

Yes, that is by design, and should not change.  The thing is, you do
want to share the same resolution across files, regardless of the
path, when the recorded resolution replays cleanly [*1*].

> Does anyone have an idea how to resolve that? If my assumption is
> correct (I only looked at the git code briefly) I believe it would make
> sense to throw the filepath into the sha1 calculation as well in order
> to ensure it will not conflict with similar changes across different files.

Interesting coincidence, but I have been looking at this for the
past few weeks myself but when you are doing the maintainer of a
reasonably active project, time for your own development is hard
to come by X-<.

My current plan is to allow hashing exactly the same way, but
recording different preimage/postimage pairs as necessary.

Right now we do something like this:

    - See conflict; compute conflict ID.
    - Does rr-cache/$ID/ exist?
      - If not, record rr-cache/$ID/preimage
    - Add $ID to MERGE_RR.

And then for each $ID (and path) in MERGE_RR:

    - Does rr-cache/$ID/postimage exist?
      - If so, attempt three-way merge using preimage, postimage and
        thisimage.
        - Did three-way merge replay cleanly?  If so, be happy.
        - Did three-way merge conflict?  If so, punt.
    - Does path still have conflicts?
      - If not, record rr-cache/$ID/postimage.

The thing to fix is "did it conflict, if so punt" step.  Within the
same conflict ID, we would introduce the concept of "variant", and
allow you to keep rr_cache/$ID/{preimage,postimage}.$variant.  The
first part of the per MERGE_RR entry process would instead go like
so:

    - Does rr-cache/$ID/ has one or more postimages?
      - If so, for each variant, attempt three-way merge using
        preimage, postimage and thisimage.
      - Did one of the three-way merges replay cleanly?
        - If so, be happy.
        - If not, assign an unused variant to this path and change
          its MERGE_RR entry from $ID to $ID.$variant

    - Does path still have conflicts?
      - If not, record rr-cache/$ID/postimage for "variant".

The current "preimage", "postimage" will be kept as the first
variant in rr-cache/$ID/ directory.  The second variant will likely
be named (I don't have a code yet but have been slowly laying out
the fundation to allow us to do this) "preimage.0" and "postimage.0",
and the third one will have ".1" suffix.

This approach has the added benefit that existing rr-cache entries
will stay valid (in addition to being able to replay the same
resolution even after you renamed the path that conflict, unlike the
case when you hashed the pathname together to break the conflict ID
computtion).

A WIP has been published on jc/rerere topic in my repository for the
past few weeks, but I haven't reached the interesting "multi variant"
part yet, as I said.


[Footnote]

*1* My experience urges me to add "And most of the time, the same
resolution does apply cleanly even to multiple paths conflicted in
the same merge" to that sentence.
