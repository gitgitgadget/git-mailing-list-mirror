From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [RFC] Optimize diff-delta.c
Date: Tue,  1 May 2007 16:49:27 +0200
Message-ID: <1178030967273-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 16:49:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hitff-0001Ro-8d
	for gcvg-git@gmane.org; Tue, 01 May 2007 16:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbXEAOtc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 10:49:32 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbXEAOtb
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 10:49:31 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:33484 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbXEAOta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 10:49:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 8568868092C1;
	Tue,  1 May 2007 16:49:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4OCx6wF1CxKT; Tue,  1 May 2007 16:49:27 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id D09B668075EC; Tue,  1 May 2007 16:49:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45945>

I try to use git with large blobs. Putting such blobs into pack files
is a slow operation and requires lots of memory. So I take a look at
the packing process.

As the delta format only supports 32 bit offsets, the uncompressed
blob size is limited to 4GB.

The delta index has approximately the same size in memory as the
uncompressed blob ((blob size)/16*(sizeof(index_entry)).
git-pack-objects keep the delta index of all objects in the search
window in memory.

So doing a delta of 4 GB files is totally unrealistic:
 (4GB data + ~4GB index)* window size [default: 10]=3D 80 GB in the wor=
st case

In my case, the blobs are some hundred MB big, but git-pack-objects
already uses some GB of memory. As the memory requirement of
git-pack-objects is currently below the available memory of my system,
I need not to address this issue yet.

In the future, I'll propably need to create a patch to free big delta
indexes in find_delta immediatly, after create_delta returned. This
will increase the processing time, but better than not being able to=20
pack objects.

I tried to speed up the delta generation by searching for a common
prefix, as my blobs are mostly append only. I tested it with about
less than 1000 big blobs. The time for finding the deltas decreased
from 17 to 14 minutes cpu time.

When repacking the git-repostiory itself, I get the following numbers:

Unmodified version (gcc-4.1):
$ echo | time ./git-pack-objects --non-empty --all --reflog --unpacked=3D=
pack-d44dc76d0e873a7c7566bcc4503731b9a5640b30.pack --no-reuse-delta  .g=
it/.tmp-28449-pack
Generating pack...
Done counting 42553 objects.
Deltifying 42553 objects...
 100% (42553/42553) done
Writing 42553 objects...
 100% (42553/42553) done
d44dc76d0e873a7c7566bcc4503731b9a5640b30
Total 42553 (delta 29605), reused 12346 (delta 0)
63.82user 0.80system 1:06.64elapsed 96%CPU (0avgtext+0avgdata 0maxresid=
ent)k
0inputs+0outputs (0major+29177minor)pagefaults 0swaps

Patched version (gcc-4.1):
$ echo | time ../git/git-pack-objects --non-empty --all --reflog --unpa=
cked=3Dpack-d44dc76d0e873a7c7566bcc4503731b9a5640b30.pack --no-reuse-de=
lta  .git/.tmp-28448-pack
Generating pack...
Done counting 42553 objects.
Deltifying 42553 objects...
 100% (42553/42553) done
Writing 42553 objects...
 100% (42553/42553) done
d44dc76d0e873a7c7566bcc4503731b9a5640b30
Total 42553 (delta 29581), reused 12353 (delta 0)
62.13user 0.91system 1:05.07elapsed 96%CPU (0avgtext+0avgdata 0maxresid=
ent)k
0inputs+0outputs (0major+39690minor)pagefaults 0swaps

So it can help improve the performance a little bit (62.13+0.91<->63.82=
+0.80) on normal
repositories.

The following patch is only for testing purposes and not cleaned up.

mfg Martin K=F6gler

 diff-delta.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 9f998d0..4f29eb7 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -250,6 +250,8 @@ create_delta(const struct delta_index *index,
 	int inscnt;
 	const unsigned char *ref_data, *ref_top, *data, *top;
 	unsigned char *out;
+	const unsigned char* d, *dt, *t, *td;
+	unsigned int psize;
=20
 	if (!trg_buf || !trg_size)
 		return NULL;
@@ -283,6 +285,66 @@ create_delta(const struct delta_index *index,
 	data =3D trg_buf;
 	top =3D (const unsigned char *) trg_buf + trg_size;
=20
+	psize =3D 0;
+	d=3Ddata;
+	dt=3Dtop-RABIN_WINDOW;
+	t=3Dref_data;
+	td=3Dref_top-RABIN_WINDOW;
+	while (d<dt && t<td && !memcmp (d, t, RABIN_WINDOW))
+	{
+	    psize+=3DRABIN_WINDOW;
+	    d+=3DRABIN_WINDOW;
+	    td+=3DRABIN_WINDOW;
+	}
+	while (psize)
+	{
+	    unsigned int size=3Dpsize;
+	    unsigned int offset=3D0, moff;
+	    unsigned char *op;
+
+	    if(size>0xFFFFFF)
+		size=3D0xFFFFFF;
+
+
+	    data+=3Dsize;
+	    moff=3Doffset;
+	    offset+=3Dsize;
+	    psize-=3Dsize;
+
+	    op =3D out + outpos++;
+	    i =3D 0x80;
+
+	    if (moff & 0xff) { out[outpos++] =3D moff; i |=3D 0x01; }
+	    moff >>=3D 8;
+	    if (moff & 0xff) { out[outpos++] =3D moff; i |=3D 0x02; }
+	    moff >>=3D 8;
+	    if (moff & 0xff) { out[outpos++] =3D moff; i |=3D 0x04; }
+	    moff >>=3D 8;
+	    if (moff & 0xff) { out[outpos++] =3D moff; i |=3D 0x08; }
+	   =20
+	    if (size & 0xff) { out[outpos++] =3D size; i |=3D 0x10; }
+	    size >>=3D 8;
+	    if (size & 0xff) { out[outpos++] =3D size; i |=3D 0x20; }
+	    size >>=3D 8;
+	    if (size & 0xff) { out[outpos++] =3D size; i |=3D 0x40; }
+
+	    *op =3D i;
+
+		if (outpos >=3D outsize - MAX_OP_SIZE) {
+			void *tmp =3D out;
+			outsize =3D outsize * 3 / 2;
+			if (max_size && outsize >=3D max_size)
+				outsize =3D max_size + MAX_OP_SIZE + 1;
+			if (max_size && outpos > max_size)
+				break;
+			out =3D xrealloc(out, outsize);
+			if (!out) {
+				free(tmp);
+				return NULL;
+			}
+		}
+	}
+
 	outpos++;
 	val =3D 0;
 	for (i =3D 0; i < RABIN_WINDOW && data < top; i++, data++) {
--=20
1.4.4.4
