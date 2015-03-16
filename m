From: Jeff King <peff@peff.net>
Subject: Re: Bug in fetch-pack.c, please confirm
Date: Sun, 15 Mar 2015 21:13:43 -0400
Message-ID: <20150316011343.GA928@peff.net>
References: <0758b2029b41448a77a4e4df1c4e406@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 02:16:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXJdS-0000pq-Ed
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 02:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbbCPBNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 21:13:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:33421 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751562AbbCPBNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 21:13:45 -0400
Received: (qmail 7040 invoked by uid 102); 16 Mar 2015 01:13:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 15 Mar 2015 20:13:45 -0500
Received: (qmail 13233 invoked by uid 107); 16 Mar 2015 01:13:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 15 Mar 2015 21:13:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Mar 2015 21:13:43 -0400
Content-Disposition: inline
In-Reply-To: <0758b2029b41448a77a4e4df1c4e406@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265541>

On Sat, Mar 14, 2015 at 11:37:37PM -0700, Kyle J. McKay wrote:

> Peff, weren't you having some issue with want and have and hide refs?

Yes, but the problem was on the server side. I didn't look at this code
at all. :)

> Tell me please how the "local" variable above gets initialized?

So I think we all agree that this is bogus code, and the fix you
proposed is reasonable (but spoiler alert, if you read to the end, I
think we can do something even more extreme). Like Junio, I am puzzled
not by the bug itself, but by its lack of effect over the past 10 years.

I'm not all that familiar with this code, so I started with some rather
blunt-hammer tracing.

If you replace that hashcpy with "exit(1)", you get quite a few failures
in the test suite. So we really are running the code. Interestingly, if
you replace it with "hashclr(ref->old_sha1)" (note old, not new, so
impacting the sha1 that we know is actually valid), you still get some
failures, but many fewer.

It looks like one of the ways to hit this code path is by doing a clone
in which we don't actually need any objects (e.g., using "--reference").
Clone runs fetch-pack to acquire the objects, but then throws away the
returned refs and writes its own.

But there are still some failures, so clearly some code paths actually
do look at the resulting ref. But nobody seems to care about
ref->new_sha1. Let's take one of the cases that the hashclr() experiment
found and trace that. In t1507, we do a "git fetch" that hits this case.
I instrumented it like this:

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 1978947..e2a192d 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -82,7 +82,7 @@ test_expect_success 'refs/heads/my-side@{upstream} does not resolve to my-side{u
 test_expect_success 'my-side@{u} resolves to correct commit' '
 	git checkout side &&
 	test_commit 5 &&
-	(cd clone && git fetch) &&
+	(cd clone && gdb --args ../../../git fetch </dev/tty >/dev/tty) &&
 	test 2 = "$(commit_subject my-side)" &&
 	test 5 = "$(commit_subject my-side@{u})"
 '

If we break in everything_local at that hashcpy, we can see:

  (gdb) print ref->name
  $1 = 0x8422b0 "refs/heads/master"
  (gdb) print sha1_to_hex(ref->old_sha1)
  $2 = 0x815a40 <hexbuffer> "8f489d01d0cc65c3b0f09504ec50b5ed02a70bd5"
  (gdb) print sha1_to_hex(ref->new_sha1)
  $3 = 0x815a69 <hexbuffer+41> "f2795a000000000056134b", '0' <repeats 11 times>, "8000000"

So that's the bogus value copied in. Presumably it's random bytes and
not bleed over from some other sha1, as it's rather unlikely to have
that many zeroes in a real hash.

If we then leave everything_local, we see that the bogus value comes out
to do_fetch_pack via the "ref" parameter. We feed that into find_common,
but it only looks at ref->old_sha1, the other side. We keep going, and
do_fetch_pack returns the bogus ref up to fetch_pack(). That in turn
passes it up to fetch_refs_via_pack.
 
And there we stop. We don't pass the "refs" list out of that function
(which, as an aside, is probably a leak). Instead, we depend on the list
of heads we already knew in the "to_fetch" array. That comes from
processing the earlier list of refs returned from get_refs_via_connect.

I think it was the case once upon a time that fetch-pack did more of the
"which refs to fetch, and how to update them" logic. The pipeline for
fetch is now more like:

  1. get_refs_via_connect returns a list of refs

  2. caller munges the list of refs, based on refspecs

  3. fetch_refs_via_pack takes that list of refs as input

Of course, this being git, there's always a way to try to access the
"old" code paths. :)

You can do something like:

  git init
  git commit --allow-empty -m foo
  git fetch-pack --all .

which hits the same code path, but actually retains the return value
from fetch_pack(). But even there, it looks like we don't look at
ref->new_sha1 at all. fetch-pack doesn't update refs at all, but just
prints the list of new values to stdout.

So I think there is literally no code path that ever looks at the bogus
sha1. We could just drop that hashcpy() entirely.

That doesn't mean there isn't an additional bug lurking. That is,
_should_ somebody be caring about that value? I don't think so. The
old/new pairs in a "struct ref" are meaningful as "I proposed to update
to X, and we are at Y". But this list of refs does not have anything to
do with the update of local refs. It is only "what is the value of the
ref on the other side". The local refs are taken care of in a separate
list.

-Peff
