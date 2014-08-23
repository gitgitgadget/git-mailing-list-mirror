From: Jeff King <peff@peff.net>
Subject: Re: [BUG] resolved deltas
Date: Sat, 23 Aug 2014 06:56:40 -0400
Message-ID: <20140823105640.GA6881@peff.net>
References: <53F5D98F.4040700@redhat.com>
 <53F79CE3.60803@gmx.net>
 <53F868F8.9080000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 23 12:56:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL907-0007PG-Ml
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 12:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbaHWK4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2014 06:56:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:57392 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752479AbaHWK4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 06:56:44 -0400
Received: (qmail 30350 invoked by uid 102); 23 Aug 2014 10:56:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 05:56:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 06:56:40 -0400
Content-Disposition: inline
In-Reply-To: <53F868F8.9080000@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255744>

[+cc spearce, as I think this is a bug in code.google.com's sending
 side, and he can probably get the attention of the right folks]

On Sat, Aug 23, 2014 at 12:12:08PM +0200, Ren=C3=A9 Scharfe wrote:

> Git 1.7.6 clones the repo without reporting an error or warning, but =
a
> check shows that a tree object is missing:

Thanks for digging on this. I happened to be looking at it at the exact
same time, so now I can stop. :)

> The patch below, which makes index-pack ignore objects with unexpecte=
d
> real_type as before, changes the shown error message, but clone still
> fails:
>=20
>   $ git clone https://code.google.com/p/mapsforge/
>   Cloning into 'mapsforge'...
>   remote: Counting objects: 12879, done.
>   Receiving objects: 100% (12879/12879), 10.19 MiB | 2.43 MiB/s, done=
=2E
>   Resolving deltas: 100% (4348/4348), done.
>   fatal: did not receive expected object a0155d8d5bb58afb9a5d20459be0=
23899c9a1cef
>   fatal: index-pack failed

This makes sense. Early versions of index-pack didn't know how to check
for missing objects, but now it does. However, we only trigger that cod=
e
if we are using --strict, or if we are cloning (in which case we pass
the --check-self-contained-and-connected option).

If you are doing a regular fetch, we rely on check_everything_connected
after the pack is received. So (with your patch):

  $ git init
  $ git fetch https://code.google.com/p/mapsforge/
  remote: Counting objects: 12298, done.
  Receiving objects: 100% (12298/12298), 9.24 MiB | 959.00 KiB/s, done.
  Resolving deltas: 100% (4107/4107), done.
  error: Could not read a0155d8d5bb58afb9a5d20459be023899c9a1cef
  fatal: bad tree object a0155d8d5bb58afb9a5d20459be023899c9a1cef
  error: https://code.google.com/p/mapsforge/ did not send all necessar=
y objects

That all makes sense.

> Turning that fatal error into a warning get us a bit further:
>=20
>   $ git clone https://code.google.com/p/mapsforge/
>   Cloning into 'mapsforge'...
>   remote: Counting objects: 12879, done.
>   Receiving objects: 100% (12879/12879), 10.19 MiB | 2.38 MiB/s, done=
=2E
>   Resolving deltas: 100% (4350/4350), done.
>   warning: did not receive expected object a0155d8d5bb58afb9a5d20459b=
e023899c9a1cef
>   fatal: The same object bc386be34bd4781f71bb68d72a6e0aee3124201e app=
ears twice in the pack
>   fatal: index-pack failed
>=20
> Disabling strict checking (WRITE_IDX_STRICT) as well lets clone
> succeed, but a check shows that a tree is missing, as wiht git 1.7.6:

Interesting that one object is duplicated and another object is missing=
=2E
The pack doesn't contain the sha1s of the objects; we compute them on
the fly in index-pack. So it's likely that the real problem is that one
entry in the pack either has the wrong delta data, or mentions the wron=
g
base object. And does it in such a way that we generate the another
object that does exist (so the packfile data isn't garbled or corrupted=
;
it's a bug on the sending side that uses the wrong data).

> https://github.com/applantation/mapsforge has that missing tree
> object, by the way.

Unsurprisingly, it's a tree object quite similar to the duplicated one.

> OK, what now?  It's better to show an error message instead of
> failing an assertion if a repo is found to be corrupt because the
> issue is caused by external input.  I don't know if the patch
> below may have any bad side effects, though, so no sign-off at
> this time.

Definitely. Your patch looks like an improvement. The objects in the
delta list must have had their real_types set to REF_DELTA and OFS_DELT=
A
at some point (since that is how they got on the list). And there is no
way for the type field to change from a delta type to anything else
_except_ by us resolving the delta. So I think the condition triggering
that assert cannot mean anything except that we have a duplicate object
(and it is not actually the delta object that is duplicated, but rather
its base, as seeing it again is what causes us to try to resolve twice)=
=2E

So we know at this point that we have a duplicate object, and we could
warn or say something. But I think we probably would not want to. If
--strict is in effect, then we will notice and complain later. And if i=
t
is not, then we should allow it without comment (in this case the repo
is broken, but it would not _have_ to be).

So I think your patch is doing the right thing.

> Allowing git to clone a broken repo sounds useful, up to point.
> In this particular case older versions had no problem doing that,
> so it seems worth supporting.

I think with your patch we are fine. Without --strict (which is implied
on a clone), you can still "git init" and "git fetch" the broken pack
(fetch will complain, but it leaves the pack in place).

We may want to adjust the fact that --check-self-contained-and-connecte=
d
implies strict (it builds on the fsck bits of index-pack, but it does
not have to imply a full fsck, nor strict index writing).

> And how did the tree object went missing in the first place?

My guess is a bug on the sending side. We have seen duplicate pack
objects before, but never (AFAIK) combined with a missing object. This
really seems like the sender just sent the wrong data for one object.

IIRC, code.google.com is backed by their custom Dulwich implementation
which runs on BigTable. We'll see if Shawn can get this to the right
people as a bug report. :)

-Peff
