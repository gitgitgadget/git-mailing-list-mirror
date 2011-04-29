From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] lookup_object(): Speed up 'git gc' by 12%, by reducing
 hash chain length
Date: Fri, 29 Apr 2011 09:57:55 -0700
Message-ID: <BANLkTinKCmaAY_qrdvfW78zHCfJ6rftgZQ@mail.gmail.com>
References: <20110427213502.GA13647@elte.hu> <7vtydh1r3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:58:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFr1K-0008H2-Gx
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759844Ab1D2Q6R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 12:58:17 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59043 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759772Ab1D2Q6Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 12:58:16 -0400
Received: by vxi39 with SMTP id 39so2909604vxi.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 09:58:15 -0700 (PDT)
Received: by 10.52.179.42 with SMTP id dd10mr1750784vdc.305.1304096295114;
 Fri, 29 Apr 2011 09:58:15 -0700 (PDT)
Received: by 10.52.161.169 with HTTP; Fri, 29 Apr 2011 09:57:55 -0700 (PDT)
In-Reply-To: <7vtydh1r3q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172474>

On Thu, Apr 28, 2011 at 23:58, Junio C Hamano <gitster@pobox.com> wrote=
:
> Ingo Molnar <mingo@elte.hu> writes:
>
>> diff --git a/object.c b/object.c
>> index 7e1f2bb..b3fe485 100644
>> --- a/object.c
>> +++ b/object.c
>> @@ -91,7 +91,7 @@ struct object *lookup_object(const unsigned char *=
sha1)
>> =A0static void grow_object_hash(void)
>> =A0{
>> =A0 =A0 =A0 int i;
>> - =A0 =A0 int new_hash_size =3D obj_hash_size < 32 ? 32 : 2 * obj_ha=
sh_size;
>> + =A0 =A0 int new_hash_size =3D obj_hash_size < 32 ? 32 : 16 * obj_h=
ash_size;
>> =A0 =A0 =A0 struct object **new_hash;
>
> Shawn was telling me about this exact topic a few months ago, and I d=
o
> agree that object hash grows too slowly when you need to slurp in man=
y
> objects.

My experience in JGit with this data structure isn't directly
repeatable in C Git. In Java I am battling more than just telling the
compiler what assembly instructions to emit. :-)

The table starts out too small, yes. JGit now has two different table
representations; one allocates at 2048 entries initially. With a load
factor of 50% (matches current C Git code before Ingo's x16 patch), we
fit 1024 objects before doubling in size. Within a hash chain JGit's
hashcmp() function evaluates like this:

  !memcmp(a + 4, b + 4, 16) && memcmp(a, b, 4)

because the 1st word was already used as the hash index. This does
seem to help break away from a non-match quickly. But remember, this
is in Java where some stuff is pretty damn costly. A good x86 chip and
a halfway decent C compiler might be penalized with this variant of
hashcmp(), I don't know.


Our second table in JGit is very different from what C Git uses... but
it works better for the purpose we are discussing. We extended our
equivalent of "struct object" to have a chained "struct object *next"
field within the object itself, rather than using the table to contain
the chain. This does limit the object to being placed into only one
object hashtable, but this isn't actually a problem for either
implementation. The entire point of struct object and this table in
object.c is to have only one of them for the process.

The table is actually a variable sized array, similar to dynamic
hashing. There is a directory array of 1024 entries that points to
segment arrays; each segment array is 2048 struct object* entries.
Growing the array is just a matter of malloc(sizeof(struct object*) *
2048) and linking it into the next free slot of the directory array.
This avoids needing to grow the array and pay memory management
penalties associated with dropping the old one and picking up the new
one. glibc malloc/free might handle this workload OK, the Java GC
didn't so we had to use this more complex table. The table still
doubles in size, so during the 2nd grow we have to malloc 2 segment
arrays, 3rd grow we malloc 4 segment arrays, 4th grow we malloc 8
segment arrays.

Searching in the table is a matter of taking the first 4 bytes of the
SHA-1, applying a mask to find which index of the directory array
holds the relevant segment array to scan. The higher bits get used to
access the index in the segment, and then the hash chain is walked
using a classical singly linked list:

  unsigned int h =3D *((unsigned int*)obj_sha1);
  V obj =3D directory[h & mask][h >>> SEGMENT_SHIFT];
  for (; obj; obj =3D obj->next) {
    if (!hashcmp(obj->sha1, obj_sha1))
      return obj;

With this approach we run the table at 100% capacity, which means the
table is much smaller. Its approximately only 1 segment entry per
object. But each object is 1 pointer larger. For 1,886,362 objects,
this approach wastes 200,000 pointers, even though each object has a
"next" pointer field within it. This is because the table doubling
with a 50% load factor has to grow to 4,194,304 pointers to store
1,886,362 objects. That's wasting 2,307,942 pointers.

A nice thing about the table is, it grows in small allocation bursts
and doesn't need to find 32 MiB of contiguous heap. Again this may not
matter much in a short-lived C process that has a relatively clean
heap. It matters a lot in a Java process that has been running for a
while and whose heap is pretty fragmented. Its also nice that the
older part of the table remains with us. We reuse the old segments as
we rehash objects on the chain. The rehashing is also very efficient,
we only need to inspect 1 additional bit on each object in the chain
to determine if it stays in the old segment, or moves to the newly
allocated sister segment.


Around this same time I did look at the chain lengths. The repository
in question was linux-2.6, but from around January 2011:

------
As far as chain lengths go, we're not that bad.

Here is the raw data. Objects is the number of items in the table at
the end, table is the size of the obj_hash array, wasted is the
difference. A hit is a successful get() returning an object, a miss is
a get that returned null and later turns into an insert. The number of
calls on chain lengths above 18 falls off fast so I elided it out.
With a 50% load factor, most operations have shorter than 7 items in
their chain. A wide majority are below 2.

objects: 1886362
table: 4194304
 (wasted 2307942)
chains (hit):
 length   0 : 42396217 get calls
 length   1 : 13675300 get calls
 length   2 : 6756795 get calls
 length   3 : 3759100 get calls
 length   4 : 2213449 get calls
 length   5 : 1413852 get calls
 length   6 : 1046289 get calls
 length   7 : 812226 get calls
 length   8 : 596076 get calls
 length   9 : 529995 get calls
 length  10 : 357039 get calls
 length  11 : 321895 get calls
 length  12 : 261752 get calls
 length  13 : 162623 get calls
 length  14 : 163727 get calls
 length  15 : 112538 get calls
 length  16 : 78401 get calls
 length  17 : 103203 get calls
 length  18 : 81563 get calls
 ...
 length >63 : 11553 get calls

chains (miss):
 length   0 : 872894 get calls
 length   1 : 345177 get calls
 length   2 : 187751 get calls
 length   3 : 117402 get calls
 length   4 : 78825 get calls
 length   5 : 55710 get calls
 length   6 : 41359 get calls
 length   7 : 31547 get calls
 length   8 : 24517 get calls
 length   9 : 19507 get calls
 length  10 : 15565 get calls
 length  11 : 12767 get calls
 length  12 : 10550 get calls
 length  13 : 8895 get calls
 length  14 : 7573 get calls
 length  15 : 6382 get calls
 length  16 : 5542 get calls
 length  17 : 4847 get calls
 length  18 : 4162 get calls
 ...
 length >63 : 1096 get calls
------

I unfortunately didn't rerun the chain data with the newer table
design. Our goals weren't to reduce chain length, it was to reduce
memory management overheads associated with using the table in Java.
We succeeded there.

--=20
Shawn.
