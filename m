From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] - git-read-tree segfaults
Date: Wed, 11 Mar 2009 22:57:41 -0700
Message-ID: <7vtz5zjnai.fsf@gitster.siamese.dyndns.org>
References: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com>
 <alpine.DEB.1.00.0903102120290.14295@intel-tinevez-2-302>
 <35476bd20903110059v7d6d8aa0g93af17a940c91919@mail.gmail.com>
 <alpine.DEB.1.00.0903111300330.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiri Olsa <olsajiri@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 06:59:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhdwt-0006ST-Sf
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 06:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbZCLF5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 01:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbZCLF5u
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 01:57:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbZCLF5t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 01:57:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5977A18CD;
	Thu, 12 Mar 2009 01:57:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1748EA18CA; Thu,
 12 Mar 2009 01:57:42 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903111300330.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed, 11 Mar 2009 13:04:15 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B68CBDBE-0ECA-11DE-A91D-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113002>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 11 Mar 2009, Jiri Olsa wrote:
>
>> On Tue, Mar 10, 2009 at 9:21 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > On Tue, 10 Mar 2009, Jiri Olsa wrote:
>> >
>> >> mb=3D$($GIT merge-base HEAD yyy)
>> >> $GIT read-tree $mb HEAD yyy
>> >
>> > While I agree that it is a bad thing for Git to segfault, I think =
this=20
>> > here is a pilot error. =C2=A0You try to read 3 trees at the same t=
ime, but=20
>> > not perform a merge. =C2=A0IMHO you want to add -m at least.
>>=20
>> agreed, I've already said I executed it like this by an accident...
>
> Hey, you did the right thing!  And you even provided a script to recr=
eate,=20
> so that it was really easy to see what is happening.
>
>> it was easy to recreate so I shared... I'm not saying it is a show=20
>> stopper :)
>
> Well, Git should not crash.  But read-tree is real low-level, so I am=
=20
> torn.  OTOH, something like this may be the correct thing to do:

That's a bogus "fix".

"git read-tree" without "-m" is supposed to behave as an overlay of the
given trees.  Try it with any git older than 1.5.5 and you should see o=
ne
entry for xxx and yyy each from Jiri's example.  Somewhere between 1.5.=
4
and 1.5.5 we seem to have broken it.

Having said that, I do not think "read-tree A B C" to overlay these tre=
es
has never worked reliably.  For one thing, I do not think the code neve=
r
tried to avoid D/F conflicts in the index, and because of that, you can
end up with a bogus index that looks like this:

	$ git ls-files -s
        100644 58b2ca10b6b032c114cb934c012c3743e34e0e7a 0	xxx
        100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	xxx/zzz
        100644 363a9e8d3b0b423eab41fd12ebed489004ab3c2e 0	yyy

and trying to write it out as a tree object will produce an even more
bogus result.

I think the attached patch fixes the segfault, and also fixes the
longstanding lack of D/F conflict detection, but it needs a bit of
commentary.

The first hunk fixes the D/F conflict issue.  After reading three trees
that has (xxx), (xxx, yyy) and (xxx/zzz, yyy) in this order, the result=
ing
index should look like this with this patch, instead of the broken inde=
x
depicted above:

	$ git ls-files -s
        100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	xxx/zzz
        100644 363a9e8d3b0b423eab41fd12ebed489004ab3c2e 0	yyy

I suspect that the reason add_entry() passed SKIP_DFCHECK was to work
around an old bug in add_index_entry() that considered it a D/F conflic=
t
if you have a file D at stage N and a file D/F at stage M when N and M =
are
different.  I think such a bug has been fixed long time ago, and there =
is
no reason for such a workaround.  Besides, OK_TO_REPLACE only makes sen=
se
when you do check D/F conflict ("replace" in the name of the flag means
"If you want to add 'xxx/zzz' when the index has 'xxx', it is Ok to dro=
p
the existing 'xxx' in order to add your 'xxx/zzz''); it makes no sense =
to
give it if you are giving SKIP_DFCHECK at the same time.

The second hunk removes a noop increment of n with o->merge (at this po=
int
we know o->merge is zero) and then makes sure we only send an existing
entry taken from the tree to add_entry().

A NULL src[i] entry is obviously a missing entry from i-th tree, and an
entry that is o->df_conflict_entry is just a stand-in phantom entry the
unpack machinery uses when i-th tree has "xxx/zzz" (hence it cannot hav=
e
"xxx") and the unpacker is looking at path "xxx".  In either case, i-th
tree does not have an entry "xxx" and we should skip add_entry() for
such a src[i].

 unpack-trees.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index e547282..5820ce4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -49,7 +49,7 @@ static void add_entry(struct unpack_trees_options *o,=
 struct cache_entry *ce,
 	memcpy(new, ce, size);
 	new->next =3D NULL;
 	new->ce_flags =3D (new->ce_flags & ~clear) | set;
-	add_index_entry(&o->result, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_=
REPLACE|ADD_CACHE_SKIP_DFCHECK);
+	add_index_entry(&o->result, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_=
REPLACE);
 }
=20
 /* Unlink the last component and attempt to remove leading
@@ -286,9 +286,9 @@ static int unpack_nondirectories(int n, unsigned lo=
ng mask,
 	if (o->merge)
 		return call_unpack_fn(src, o);
=20
-	n +=3D o->merge;
 	for (i =3D 0; i < n; i++)
-		add_entry(o, src[i], 0, 0);
+		if (src[i] && src[i] !=3D o->df_conflict_entry)
+			add_entry(o, src[i], 0, 0);
 	return 0;
 }
=20
