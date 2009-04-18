From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: keep information about files to be
 deleted
Date: Fri, 17 Apr 2009 21:59:34 -0700
Message-ID: <7vskk6y2tl.fsf@gitster.siamese.dyndns.org>
References: <1239478260-7420-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7v4owsfktw.fsf@gitster.siamese.dyndns.org>
 <20090413230351.7cbb01f5@gmail.com>
 <7v1vrwdyxx.fsf@gitster.siamese.dyndns.org>
 <20090417192324.3a888abf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 07:03:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv2iO-0005oX-JN
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 07:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbZDRE7p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2009 00:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbZDRE7p
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 00:59:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbZDRE7p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2009 00:59:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ADD0BABE6C;
	Sat, 18 Apr 2009 00:59:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F3EC3ABE6B; Sat,
 18 Apr 2009 00:59:36 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA0939B8-2BD5-11DE-AEDA-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116811>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> ... However, there are some cases when these two
> rules may cause problems:
>
> patch #1: rename A to B
> patch #2: rename C to A
> patch #3: modify A
>
> Should patch #3 modify B (which was A) or A (which was C)?
>
> patch #1: rename A to B
> patch #2: rename B to A
> patch #3: modify A
> patch #4: modify B
>
> Which files should be patched by #3 and #4?
>
> In my opinion both #3 and #4 should fail (or both should succeed) --
> with my patch only #3 will work and #4 will be rejected, because in #=
2
> B was marked as deleted.

Both of the examples above cannot be emitted as a single commit by
format-patch; the user is feeding a combined patch.  Perhaps renames
in each example sequence were came from one git commit but modification=
s
are from separate commit or handcrafted "follow-up" patch.

There are two stances we can take:

 (1) The user knows what he is doing.

     In the first example, if he wanted the change in #3 to end up in B=
,
     he would have arranged the patches in a different order, namely, 3=
 1
     2, but he didn't.  We should modify A (that came from C).

 (2) In situations like these when it is unusual and there is no clear =
and
     unambiguous answer, the rule has always been "fail and ask the use=
r
     to clean up", because silently doing a wrong thing in an unusual
     situation that happens only once in a while is far worse than
     interrupting the user and forcing a manual intervention.

     In the first example, there is no clear answer.  Perhaps all three
     patches were independent patches (the first two obviously came fro=
m
     git because only we can do renames, but they may have been separat=
e
     commits), and the user may have reordered them (or just picked a
     random order because he was linearizing a history with a merge).

The second one is even iffier.  If we _know_ that originally patch #1 a=
nd
#2 came from the same commit, then they represent swapping between A an=
d
B, but if they came from different git commits, and if the user picked
patches in a random order, it may mean something completely different.

I am somewhat tempted to say that we should fail all of them, including
the original "single patch swapping files" brought up by Linus.

BUT

Can we make use simple rule to detect problematic cases?

 - An input to git-apply can contain more than one patch that affects a
   path; however

   - you cannot create a path that still exists, except for a path that
     _will_ be renamed away or removed (your patch fixes this by adding
     this "except for..." part to loosen the existing rule);

   - you cannot modify a path in a separate patch if it is involved in =
an
     either side of a rename (this will catch the ambiguity of patch #3=
 in
     your first example and #3 and #4 in your second example);

 - In addition:

   - the same path cannot be renamed from more than once (this will cat=
ch
     concatenation of two git generated patches);

With such a change, I think we can keep the safety of "when there are m=
ore
than one plausible outcomes, the tool shouldn't silently decide, nor ma=
ke
progress that the user later needs to undo and redo", while allowing a
sane use of rename patches generated out of a git commit.
