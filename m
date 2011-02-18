From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Merging limitations after directory renames -- interesting test repo
Date: Fri, 18 Feb 2011 15:27:36 -0800
Message-ID: <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
References: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com> <20110218222151.GB4258@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=90e6ba4fc23c25bb68049c96ddb9
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 19 00:28:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqZk3-0006jb-Qy
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 00:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334Ab1BRX17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 18:27:59 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35935 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751791Ab1BRX15 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 18:27:57 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p1INRum7005563
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 18 Feb 2011 15:27:56 -0800
Received: by iyj8 with SMTP id 8so4023621iyj.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 15:27:56 -0800 (PST)
Received: by 10.231.206.131 with SMTP id fu3mr952901ibb.98.1298071676107; Fri,
 18 Feb 2011 15:27:56 -0800 (PST)
Received: by 10.231.16.129 with HTTP; Fri, 18 Feb 2011 15:27:36 -0800 (PST)
In-Reply-To: <20110218222151.GB4258@sigill.intra.peff.net>
X-Spam-Status: No, hits=-102.962 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167234>

--90e6ba4fc23c25bb68049c96ddb9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 18, 2011 at 2:21 PM, Jeff King <peff@peff.net> wrote:
>
> =A01. Did you bump up your merge.renamelimit? It's hard to see because it
> =A0 =A0 scrolls off the screen amidst the many conflicts, but the first
> =A0 =A0 message is:
>
> =A0 =A0 =A0 warning: too many files (created: 425 deleted: 1093), skippin=
g
> =A0 =A0 =A0 inexact rename detection
>
> =A0 =A0 which you want to use. Try "git config merge.renamelimit
> =A0 =A0 10000". Which runs pretty snappily on my machine; I wonder if we
> =A0 =A0 should up the default limit.

Yeah, for the kernel, I have

	[diff]
		renamelimit=3D0

to disable the limit entirely, because the default limit is very low
indeed. Git is quite good at the rename detection.

However, the reason for the low default is not because it's not snappy
enough - it's because it can end up using a lot of memory (and if
you're low on memory, the swapping will mean that it goes from "quite
snappy" to "slow as molasses" - but it still will not be CPU limited,
it's just paging like crazy).

That said, having the error message scroll by and not even be noticed
by somebody doing a merge is really not good. It's an important hint,
and if you miss that hint you can easily have a totally trivial merge
turn into a totally unacceptable one.

So I do think we could try to lift the default a bit, but it might be
even more important to just make the message much more noticeable and
avoid scrolling past it. For example, setting a flag, and not printing
out the message immediately, but instead print it out only if it turns
into trouble at the end.

I dunno.

> =A02. Which version of git are you using? Commit 83c9031 produces some
> =A0 =A0 funky results on merges. It's not in any released version of git,
> =A0 =A0 but it is in master.

Ouch. I thought that commit wasn't _supposed_ to make any difference.
If it does, then that sounds like a bad bug. Junio?

> Hmm. That is probably because it was substantially rewritten:

Damn. We suck.

Lookie here, here's the problem (well, at least part of it):

  [torvalds@i5 etherpad]$ git diff --summary -M10 master...origin/pg |
grep rebuildjar
   rename {trunk/etherpad =3D> etherpad}/bin/rebuildjar.sh (89%)

That looks fine. But how about doing it the other way around:

  [torvalds@i5 etherpad]$ git diff --summary -M10 origin/pg...master |
grep rebuildjar
   copy trunk/infrastructure/bin/comp.sh =3D> etherpad/bin/rebuildjar.sh (1=
3%)
   delete mode 100755 trunk/etherpad/bin/rebuildjar.sh

Yeah, not such a good match. And it's total crap too: that rename is
much worse than the real one. So we've actually done something
actively wrong. Because we have:

   .../etherpad =3D> master:etherpad}/bin/rebuildjar.sh |   92
+++++++++++++++++++-
   1 files changed, 89 insertions(+), 3 deletions(-)

and

   .../comp.sh =3D> master:etherpad/bin/rebuildjar.sh   |  296
+++++++++-----------
   1 files changed, 129 insertions(+), 167 deletions(-)

so that choice of comp.sh was total and utter crap, and the 13%
similarity comes from that.

So we did something wrong in picking that comp.sh file. And I bet it's
because on a very superficial level it looks better: despite the diff
being *obviously* bigger for the crazy comp.sh choice, I think it
decided that they had more lines in common.

We've had stupid bugs in the "diffcore_count_changes()" logic before.
It's just that they're _usually_ hidden by overwhelming common code.

In fact, the attached patch improves things a bit. At a huge added CPU
cost in rename detection. Then I get

  [torvalds@i5 etherpad]$ git diff --summary -M10 origin/pg...master |
grep rebuildjar
   rename {trunk/etherpad =3D> etherpad}/bin/rebuildjar.sh (32%)

which is at least the sane choice for rename detection. It won't fix
really the merge-from-hell issue, though, since we won't consider "32%
similar" to be a rename.

We might want to have a way to force rename detection for certain
patterns for cases like this.

                                    Linus

--90e6ba4fc23c25bb68049c96ddb9
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gkbq9l7i0

IGRpZmZjb3JlLXJlbmFtZS5jIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZGlmZmNvcmUtcmVuYW1lLmMgYi9k
aWZmY29yZS1yZW5hbWUuYwppbmRleCBkZjQxYmU1Li4xOTk1N2NkIDEwMDY0NAotLS0gYS9kaWZm
Y29yZS1yZW5hbWUuYworKysgYi9kaWZmY29yZS1yZW5hbWUuYwpAQCAtMTcwLDcgKzE3MCw3IEBA
IHN0YXRpYyBpbnQgZXN0aW1hdGVfc2ltaWxhcml0eShzdHJ1Y3QgZGlmZl9maWxlc3BlYyAqc3Jj
LAogCSAqIGFuZCB0aGUgZmluYWwgc2NvcmUgY29tcHV0YXRpb24gYmVsb3cgd291bGQgbm90IGhh
dmUgYQogCSAqIGRpdmlkZS1ieS16ZXJvIGlzc3VlLgogCSAqLwotCWlmIChiYXNlX3NpemUgKiAo
TUFYX1NDT1JFLW1pbmltdW1fc2NvcmUpIDwgZGVsdGFfc2l6ZSAqIE1BWF9TQ09SRSkKKwlpZiAo
bWF4X3NpemUgKiAoTUFYX1NDT1JFLW1pbmltdW1fc2NvcmUpIDwgZGVsdGFfc2l6ZSAqIE1BWF9T
Q09SRSkKIAkJcmV0dXJuIDA7CiAKIAlpZiAoIXNyYy0+Y250X2RhdGEgJiYgZGlmZl9wb3B1bGF0
ZV9maWxlc3BlYyhzcmMsIDApKQo=
--90e6ba4fc23c25bb68049c96ddb9--
