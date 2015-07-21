From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add support for Fountain documents
Date: Tue, 21 Jul 2015 12:33:41 -0700
Message-ID: <xmqqk2ttuwyy.fsf@gitster.dls.corp.google.com>
References: <1437484966-664-1-git-send-email-zoe@bytenoise.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Zoe=CC=88?= Blade <zoe@bytenoise.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:33:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdIS-00062d-If
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbbGUTdo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2015 15:33:44 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36086 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029AbbGUTdn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 15:33:43 -0400
Received: by pachj5 with SMTP id hj5so125213382pac.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=a84uBu+jl0jMf41e688i0PZsYpSA6UkbSGaviPH9M5o=;
        b=avafmyLT13KCvN/XCiZac1e7IcKiCuDUzv1QK4AL4yHvHV0H3CF95y+nDCKX5cYwbZ
         ahq7v15JoJtH8HMg/YA/jtTep9qgcG7Z9bShEytUee+Dwr3PoHnt4XvNkPVaZwAL4815
         P1TK3sJsSnjovi/+SxkmFx8GKFzFIGhHA7sI9esdVh5OZzifQOV6vpFVqOQsHXli7FhI
         lO3V+GZZPRPDj58O2sT8cFT6XXTA41ILNMP6Rs3TRAFHJqJznCSohU8C4S/nfb9iNRyd
         1veN29QhnMqM76mog5GvLR5NWfsNDkkZAJ4xkyiUJlZPceCdHMDOaalyUByM7H35DRsp
         ZHkg==
X-Received: by 10.70.129.73 with SMTP id nu9mr75376450pdb.166.1437507223137;
        Tue, 21 Jul 2015 12:33:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id vr2sm6057369pab.26.2015.07.21.12.33.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 12:33:41 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274403>

Zoe=CC=88 Blade <zoe@bytenoise.co.uk> writes:

Hmmmm, the pattern has too many question marks to make a simple
panda brain spin.

> "^((\\.|((int|est|ext)?\\.?|i(nt)?\\.?/e(xt)?\\.?) ).+)$"

it can start with a dot, or match "something" at the beginning,
followed by a SP (is a tab allowed there instead of SP, I have to
wonder).

One problem I noticed immediately: this allows a line that begins
with "...", which I learned in http://fountain.io/syntax when I
wrote $gmane/274127 is explicitly excluded.  A line that begin with
a dot followed by a non-dot is a forced scene heading.

Now disecting that "something" (i.e. not a forced scene heading),
which is this part ...

> ((int|est|ext)?\\.?|i(nt)?\\.?/e(xt)?\\.?)

=2E.. that gives us largely two choices:

 - It can begin with zero or one int/est/ext and can optionally be
   followed by a dot, or

 - It can be one of (i, int), optionally followed by a dot, followed
   by slash, followed by one of (e, ext), optionally followed by a
   dot.

Second problem.  Doesn't the early part of this "something" pattern
allow an empty string to match by having zero "int" and zero "."?

With this edit to the test vector (add either one of these two,
removing the other, before you run this test twice), you can see
that these over-eager matches in action.
----------------------------------------------------------------

 t/t4018/fountain-scene | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t4018/fountain-scene b/t/t4018/fountain-scene
index 6b3257d..94f0513 100644
--- a/t/t4018/fountain-scene
+++ b/t/t4018/fountain-scene
@@ -1,4 +1,7 @@
 EXT. STREET RIGHT OUTSIDE - DAY
=20
+ An indented line is WRONG.
+...we do not want ellipses.
+
 CHARACTER
 You didn't say the magic phrase, "ChangeMe".

----------------------------------------------------------------

Perhaps the pattern is trying to be too clever for its own good.
I'd prefer to see us doing simple, stupid and obviously correct.

That "syntax" page says:

    You can "force" a Scene Heading by starting the line with a
    single period. ... Note that only a single leading period
    followed by an alphanumeric character will force a Scene
    Heading. This allows the writer to begin Action and Dialogue
    elements with ellipses ...

which would give us the first part, i.e. the line may start with a
dot and then an alnum

\\.[a-z0-9]

And then

    A line beginning with any of the following, followed by either a do=
t
    or a space, is considered a Scene Heading (unless the line is
    preceded by an exclamation point !). Case insensitive.

    INT
    EXT
    EST
    INT./EXT
    INT/EXT
    I/E

which translates to

(int|ext|est|int\\.?/ext|i/e)[. ]

So taking these all together, something like this?

^((\\.[a-z0-9]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$

I personally prefer to make it slightly lenient to exclude dot
instead of forcing US-ASCII view of alnum, i.e.

^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$

I'll queue a SQUASH??? on top while waiting for a response.

Thanks.
