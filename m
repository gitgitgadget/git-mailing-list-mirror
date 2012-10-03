From: Jeff King <peff@peff.net>
Subject: Re: upload-pack is slow with lots of refs
Date: Wed, 3 Oct 2012 17:20:07 -0400
Message-ID: <20121003212007.GC4484@sigill.intra.peff.net>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net>
 <CACBZZX4Grya=FbL9XEh_EK6KVsFZYWCuHveV2QevcBwr+iYTMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:55:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtJy-0001DP-D6
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab2JCVUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 17:20:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39469 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755577Ab2JCVUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 17:20:09 -0400
Received: (qmail 12839 invoked by uid 107); 3 Oct 2012 21:20:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Oct 2012 17:20:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2012 17:20:07 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX4Grya=FbL9XEh_EK6KVsFZYWCuHveV2QevcBwr+iYTMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206940>

On Wed, Oct 03, 2012 at 10:16:56PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> I can't provide all the details now (not with access to that machine
> now), but briefly:
>=20
>  * The git client/server version is 1.7.8
>=20
>  * The repository has around 50k refs, they're "real" refs, almost al=
l
>    of them (say all but 0.5k-1k) are annotated tags, the rest are
>    branches.

I'd definitely try upgrading, then; I got measurable speedups from this
exact case using the patches in v1.7.10.

>  * >99% of them are packed, there's a weekly cronjob that packs them
>    all up, there were a few newly pushed branches and tags outside of
>    the

A few strays shouldn't make a big difference. The killer is calling
open(2) 50,000 times, but having most of it packed should prevent that.
I suspect Michael Haggerty's work on the ref cache may help, too
(otherwise we have to try each packed ref in the filesystem to make sur=
e
nobody has written it since we packed).

>  * I tried "echo -n | git upload-pack <repo>" on both that 50k
>    repository and a repository with <100 refs, the former took around
>    ~1-2s to run on a 24 core box and the latter ~500ms.

More cores won't help, of course, as dumping the refs is single-threade=
d.

With v1.7.12, my ~400K test repository takes about 0.8s to run (on my
2-year-old 1.8 GHz i7, though it is probably turbo-boosting to 3 GHz).
So I'm surprised it is so slow.

Your 100-ref case is slow, too. Upload-pack's initial advertisement on
my linux-2.6 repository (without about 900 refs) is more like 20ms. I'd

>  * A co-worker who was working on this today tried it on 1.7.12 and
>    claimed that it had the same performance characteristics.

That's surprising to me. Can you try to verify those numbers?

>  * I tried to profile it under gcc -pg && echo -n | ./git-upload-pack
>    <repo> but it doesn't produce a profile like that, presumably
>    because the process exits unsuccessfully.

If it's a recent version of Linux, you'll get much nicer results with
perf. Here's what my 400K-ref case looks like:

  $ time echo 0000 | perf record git-upload-pack . >/dev/null
  real    0m0.808s
  user    0m0.660s
  sys     0m0.136s

  $ perf report | grep -v ^# | head
  11.40%  git-upload-pack  libc-2.13.so        [.] vfprintf
   9.70%  git-upload-pack  git-upload-pack     [.] find_pack_entry_one
   7.64%  git-upload-pack  git-upload-pack     [.] check_refname_format
   6.81%  git-upload-pack  libc-2.13.so        [.] __memcmp_sse4_1
   5.79%  git-upload-pack  libc-2.13.so        [.] getenv
   4.20%  git-upload-pack  libc-2.13.so        [.] __strlen_sse42
   3.72%  git-upload-pack  git-upload-pack     [.] ref_entry_cmp_sslice
   3.15%  git-upload-pack  git-upload-pack     [.] read_packed_refs
   2.65%  git-upload-pack  git-upload-pack     [.] sha1_to_hex
   2.44%  git-upload-pack  libc-2.13.so        [.] _IO_default_xsputn

So nothing too surprising, though there is some room for improvement
(e.g., it looks like we are calling getenv in a tight loop, which could
be hoisted out to a single call).

Do note that this version of git was compiled with -O3. Compiling with
-O0 produces very different results (it's more like 1.3s, and the
hotspots are check_refname_component and sha1_to_hex).

>    Maybe someone here knows offhand what mock data I could feed
>    git-upload-pack to make it happy to just list the refs, or better
>    yet do a bit more work which it would do if it were actually doing
>    the fetch (I suppose I could just do a fetch, but I wanted to do
>    this from a locally compiled checkout).

If you feed "0000" as I did above, that is the flush signal for "I have
no more lines to send you", which means that we are not actually
fetching anything. I.e., this is the exact same conversation a no-op
"git fetch" would produce.

-Peff
