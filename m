From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Mon, 11 Feb 2008 22:58:06 +0100
Message-ID: <20080211215806.GA24971@auto.tuwien.ac.at>
References: <20080210175812.GB12162@auto.tuwien.ac.at> <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:58:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOgfs-0006Ov-F2
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 22:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584AbYBKV6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 16:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756156AbYBKV6L
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 16:58:11 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:35832 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878AbYBKV6J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 16:58:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D9DE3680B59A;
	Mon, 11 Feb 2008 22:58:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKBqe5Ppi8oR; Mon, 11 Feb 2008 22:58:06 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id AE1B768018E5; Mon, 11 Feb 2008 22:58:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802111513360.2732@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73592>

On Mon, Feb 11, 2008 at 03:41:06PM -0500, Nicolas Pitre wrote:
> On Mon, 11 Feb 2008, Martin Koegler wrote:
> > Please remember, that --strict is used for pushing data.
>=20
> And what exactly does it provide in terms of safetiness that index-pa=
ck=20
> doesn't already do?  I'm not sure I fully understood the goal here.

The patch is about verifing the content of objects. My intented use is
for running a (restricted) server, which allows pushing via git-daemon
(or git-shell) from (untrusted) users. It can be also used to catch
corrupt objects, before they leave your repository, but this is for me
only a side effect.

receive-pack accepts any crap (anything, which you can pipe into
git-hash-object with -t parameter of your choice), if the pack file
format is correct.

But lots of code in git assums that the object content is welformd.

Having such objects somewhere reachable in your repository will
disturb cloning (In the best case you get a error messages, in the
worst a child process of upload-pack segfaults), gitweb, ... . To fix
it, you will need a person with native access to the repository in the
worst case.=20

> > Maybe I have missed something, but all repack problems reported on =
the
> > git mailing list happen durring the deltifing phase. The problemati=
c
> > files are mostly bigger blobs. I'm aware of these problems, so my
> > patch does not keep any blobs in memory.
>=20
> This is not only repack, which is something that few people should ru=
n=20
> anyway.
>=20
> It is also index-pack which takes an awful amount of time on the OOO=20
> repo (much less than the repack but still), and that's something that=
 is=20
> visible to anyone cloning it.
>=20
> So the comparison with pack-objects is useless.  In absolute terms,=20
> index-pack has to inprove, not regress.

The patch does not change the cloning/fetching behaviour:
@@ -18,6 +19,7 @@ struct object_entry
        unsigned int hdr_size;
        enum object_type type;
        enum object_type real_type;
+       struct object *obj;
 };

 union delta_base {
@@ -44,6 +49,7 @@ static int nr_deltas;
 static int nr_resolved_deltas;

 static int from_stdin;
+static int strict;
 static int verbose;

 static struct progress *progress;
@@ -325,8 +366,8 @@ static int find_delta_children(const union delta_ba=
se *base,
        return 0;
 }

-static void sha1_object(const void *data, unsigned long size,
-                       enum object_type type, unsigned char *sha1)
+static struct object* sha1_object(const void *data, unsigned long size=
,
+                                 enum object_type type, unsigned char =
*sha1)
 {
        hash_sha1_file(data, size, typename(type), sha1);
        if (has_sha1_file(sha1)) {
@@ -341,6 +382,29 @@ static void sha1_object(const void *data, unsigned=
 long size,
                        die("SHA1 COLLISION FOUND WITH %s !", sha1_to_h=
ex(sha1));
                free(has_data);
        }
+       if (strict) {
[..]
+       return NULL;
 }

 static void resolve_delta(struct object_entry *delta_obj, void *base_d=
ata,
@@ -361,7 +425,7 @@ static void resolve_delta(struct object_entry *delt=
a_obj, void *base_data,
        free(delta_data);
        if (!result)
                bad_object(delta_obj->idx.offset, "failed to apply delt=
a");
-       sha1_object(result, result_size, type, delta_obj->idx.sha1);
+       delta_obj->obj =3D sha1_object(result, result_size, type, delta=
_obj->idx.sha1);
        nr_resolved_deltas++;

        hashcpy(delta_base.sha1, delta_obj->idx.sha1);
@@ -420,7 +484,7 @@ static void parse_pack_objects(unsigned char *sha1)
                        delta->obj_no =3D i;
                        delta++;
                } else
-                       sha1_object(data, obj->size, obj->type, obj->id=
x.sha1);
+                       obj->obj =3D sha1_object(data, obj->size, obj->=
type, obj->idx.sha1);
                free(data);
                display_progress(progress, i+1);
        }
@@ -714,6 +778,8 @@ int main(int argc, char **argv)
                                from_stdin =3D 1;
                        } else if (!strcmp(arg, "--fix-thin")) {
                                fix_thin_pack =3D 1;
+                       } else if (!strcmp(arg, "--strict")) {
+                               strict =3D 1;
                        } else if (!strcmp(arg, "--keep")) {
                                keep_msg =3D "";
                        } else if (!prefixcmp(arg, "--keep=3D")) {
@@ -812,6 +878,8 @@ int main(int argc, char **argv)
                            nr_deltas - nr_resolved_deltas);
        }
        free(deltas);
+       if (strict)
+               check_objects();

        idx_objects =3D xmalloc((nr_objects) * sizeof(struct pack_idx_e=
ntry *));
        for (i =3D 0; i < nr_objects; i++)

Do you see any problem, if int strict is zero?

=46or pushing, you must distinguish two case:

* pushing some changes/new branches
  You will have a maximum of a few thousands of objects.

* pushing the whole content into an empty repository

  This is not an every day operation.=20

  I implemented a config option to disable the checking. It can be
  used safe time/memory in such cases.
=20
  To make this working for OOO repository, my patch will probable need
  more tuning.

> > So my conclusion is, that the memory usage of index-pack with --str=
ict
> > should not be too worse compared to pack-objects.
>=20
> Well, the comparison is flawed anyway.  Agressively repacking the OOO=
=20
> repo is reported to take around 14 GB of RAM if not bounded, whereas=20
> index-pack remained around 300MB.  But the buffer cache managed by th=
e=20
> kernel is also a big performance factor and anything that requires mo=
re=20
> memory in user space will affect that cache.

The 14 GB is caused by the memory used in the deltifing phase. I
compared it to the counting object phase.

> Then remember that this repo has 2411764 objects.

How many blobs, tags, trees and commits? What is the uncompressed size
of all tags? What is the uncompressed size of all trees? What is the
uncompressed size of all commits?

This information would give me a clue, what bad effects my approach
would have.

mfg Martin K=F6gler
