From: Jeff King <peff@peff.net>
Subject: Re: upload-pack is slow with lots of refs
Date: Wed, 3 Oct 2012 19:15:29 -0400
Message-ID: <20121003231529.GA11618@sigill.intra.peff.net>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net>
 <CACBZZX4Grya=FbL9XEh_EK6KVsFZYWCuHveV2QevcBwr+iYTMQ@mail.gmail.com>
 <20121003212007.GC4484@sigill.intra.peff.net>
 <CACBZZX6yMfeOx6x4iy8beq5niy9HvPq0c8ND5jZkoiJWAgVjfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:06:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtLo-0001DP-U2
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611Ab2JCXPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 19:15:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39565 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932583Ab2JCXPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 19:15:32 -0400
Received: (qmail 14057 invoked by uid 107); 3 Oct 2012 23:16:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Oct 2012 19:16:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2012 19:15:29 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX6yMfeOx6x4iy8beq5niy9HvPq0c8ND5jZkoiJWAgVjfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206965>

On Thu, Oct 04, 2012 at 12:15:47AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> I think he was wrong, I tested this on git.git by first creating a lo=
t
> of tags:
>=20
>      parallel --eta "git tag -a -m"{}" test-again-{}" ::: $(git rev-l=
ist HEAD)
>=20
> Then doing:
>=20
>     git pack-refs --all
>     git repack -A -d
>=20
> And compiled with -g -O3 I get around 1.55 runs/s of git-upload-pack
> on 1.7.8 and 2.59/s on the master branch.

Thanks for the update, that's more like what I expected.

> FWIW here are my results on the above pathological git.git
>=20
>     $ uname -r; perf --version; echo 0000 | perf record
> ./git-upload-pack .>/dev/null; perf report | grep -v ^# | head
>     3.2.0-2-amd64
>     perf version 3.2.17
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.026 MB perf.data (~1131 sampl=
es) ]
>         29.08%  git-upload-pack  libz.so.1.2.7       [.] inflate
>         17.99%  git-upload-pack  libz.so.1.2.7       [.] 0xaec1
>          6.21%  git-upload-pack  libc-2.13.so        [.] 0x117503
>          5.69%  git-upload-pack  libcrypto.so.1.0.0  [.] 0x82c3d
>          4.87%  git-upload-pack  git-upload-pack     [.] find_pack_en=
try_one
>          3.18%  git-upload-pack  ld-2.13.so          [.] 0x886e
>          2.96%  git-upload-pack  libc-2.13.so        [.] vfprintf
>          2.83%  git-upload-pack  git-upload-pack     [.] search_for_s=
ubdir
>          1.56%  git-upload-pack  [kernel.kallsyms]   [k] do_raw_spin_=
lock
>          1.36%  git-upload-pack  libc-2.13.so        [.] vsnprintf
>=20
> I wonder why your report doesn't note any time in libz. This is on
> Debian testing, maybe your OS uses different strip settings so it
> doesn't show up?

Mine was on Debian unstable. The difference is probably that I have 400=
K
refs, but only 12K unique ones (this is the master alternates repo
containing every ref from every fork of rails/rails on GitHub). So I
spend proportionally more time fiddling with refs and outputting than
I do actually inflating tag objects.

Hmm. It seems like we should not need to open the tags at all. The main
reason is to produce the "peeled" advertisement just after it. But for =
a
packed ref with a modern version of git that supports the "peeled"
extension, we should already have that information.

The hack-ish patch below tries to reuse that. The interface is terrible=
,
and we should probably just pass the peel information via for_each_ref
(peel_ref tries to do a similar thing, but it also has a bad interface;
if we don't have the information already, it will redo the ref lookup.
We could probably get away with a peel_sha1 which uses the same
optimization trick as peel_ref).

With this patch my 800ms upload-pack drops to 600ms. I suspect it will
have an even greater impact for you, since you are spending much more o=
f
your time on object loading than I am.

And note of course that while these micro-optimizations are neat, we're
still going to end up shipping quite a lot of data over the wire. Movin=
g
to a protocol where we are advertising fewer refs would solve a lot mor=
e
problems in the long run.

---
diff --git a/refs.c b/refs.c
index 551a0f9..68eca3a 100644
--- a/refs.c
+++ b/refs.c
@@ -510,6 +510,14 @@ static struct ref_entry *current_ref;
=20
 static struct ref_entry *current_ref;
=20
+/* XXX horrible interface due to implied argument. not for real use */
+const unsigned char *peel_current_ref(void)
+{
+	if (!current_ref || !(current_ref->flag & REF_KNOWS_PEELED))
+		return NULL;
+	return current_ref->u.value.peeled;
+}
+
 static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		      int flags, void *cb_data, struct ref_entry *entry)
 {
diff --git a/refs.h b/refs.h
index 9d14558..88c5445 100644
--- a/refs.h
+++ b/refs.h
@@ -14,6 +14,8 @@ struct ref_lock {
 #define REF_ISPACKED 0x02
 #define REF_ISBROKEN 0x04
=20
+const unsigned char *peel_current_ref(void);
+
 /*
  * Calls the specified function for each ref file until it returns
  * nonzero, and returns the value.  Please note that it is not safe to
diff --git a/upload-pack.c b/upload-pack.c
index 8f4703b..cdf43b0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -736,8 +736,9 @@ static int send_ref(const char *refname, const unsi=
gned char *sha1, int flag, vo
 		" include-tag multi_ack_detailed";
 	struct object *o =3D lookup_unknown_object(sha1);
 	const char *refname_nons =3D strip_namespace(refname);
+	const unsigned char *peeled =3D peel_current_ref();
=20
-	if (o->type =3D=3D OBJ_NONE) {
+	if (!peeled && o->type =3D=3D OBJ_NONE) {
 		o->type =3D sha1_object_info(sha1, NULL);
 		if (o->type < 0)
 		    die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1)=
);
@@ -756,11 +757,13 @@ static int send_ref(const char *refname, const un=
signed char *sha1, int flag, vo
 		o->flags |=3D OUR_REF;
 		nr_our_refs++;
 	}
-	if (o->type =3D=3D OBJ_TAG) {
+	if (!peeled && o->type =3D=3D OBJ_TAG) {
 		o =3D deref_tag_noverify(o);
 		if (o)
-			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname_nons);
+			peeled =3D o->sha1;
 	}
+	if (peeled && !is_null_sha1(peeled))
+		packet_write(1, "%s %s^{}\n", sha1_to_hex(peeled), refname_nons);
 	return 0;
 }
=20
