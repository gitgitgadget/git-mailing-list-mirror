From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [RFH] unpack-trees: cache_entry lifetime issue?
Date: Tue, 06 Mar 2012 20:37:23 +0100
Message-ID: <4F566773.5060005@lsrfire.ath.cx>
References: <4F5102A2.70303@lsrfire.ath.cx> <7vk432dd89.fsf@alter.siamese.dyndns.org> <4F522758.9050205@lsrfire.ath.cx> <7vaa3uzozy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 20:37:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S50CX-0004ty-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 20:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258Ab2CFThc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 14:37:32 -0500
Received: from india601.server4you.de ([85.25.151.105]:38956 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965160Ab2CFThc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 14:37:32 -0500
Received: from [192.168.2.105] (p4FFDA8C5.dip.t-dialin.net [79.253.168.197])
	by india601.server4you.de (Postfix) with ESMTPSA id 1AB6F2F803B;
	Tue,  6 Mar 2012 20:37:30 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vaa3uzozy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192380>

Am 05.03.2012 23:01, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>=20
>> Next question: Should the function fn() in struct unpack_trees_optio=
ns
>> be able to replace src[0], and unpack_callback() is then supposed to
>> use the new pointer after calling unpack_nondirectories()?  If not
>> then we can clean up things a bit by moving the src array into
>> unpack_nondirectories().
>=20
> Sorry, I have no idea.  What kind of usage pattern do you have in
> mind?

Well, I can't imagine a merge callback that needs this ability, but
that really doesn't mean much.  Just want to avoid taking away options
that turn out to be useful later.

>> For now, just this patch, which cleans up memory, but not the code:
>>
>> -- >8 --
>> Subject: unpack-trees: plug minor memory leak
>>
>> The allocations made by unpack_nondirectories() using create_ce_entr=
y()
>> are never freed.  In the case of a merge, we hand them to
>> call_unpack_fn() and never look at them again.
>=20
> That assumes that whatever callbacks that are called will only look
> at but never takes ownership of the cache entry given to them.  I
> *think* everybody eventually calls "add_entry()" that duplicates the
> cache entry before storing it to the index, but I didn't go through
> all the codepaths.  Assuming you did, I think this is a good change.

I did that a while back and while doing that again just now with
tired eyes after a day's work noticed how deep the call chains are
and that it's certainly possible that I missed a place that assumed
it owned the cache entry.

=46or increased confidence, perhaps it's better to first patch the
non-merge leak, then clean up and const'ify the merge case and only
then free().  Or to declare that merge functions can take ownership
of the cache entries.  Timid patch for the first part below.

-- >8 --
Subject: unpack-trees: plug minor memory leak

The allocations made by unpack_nondirectories() using create_ce_entry()
are never freed.

In the non-merge case, we duplicate them using add_entry() and later
only look at the first allocated element (src[0]), perhaps even only
by mistake.  Split out the actual addition from add_entry() into the
new helper do_add_entry() and call this non-duplicating function
instead of add_entry() to avoid the leak.

Valgrind reports this for the command "git archive v1.7.9" without
the patch:

  =3D=3D13372=3D=3D LEAK SUMMARY:
  =3D=3D13372=3D=3D    definitely lost: 230,986 bytes in 2,325 blocks
  =3D=3D13372=3D=3D    indirectly lost: 0 bytes in 0 blocks
  =3D=3D13372=3D=3D      possibly lost: 98 bytes in 1 blocks
  =3D=3D13372=3D=3D    still reachable: 2,259,198 bytes in 3,243 blocks
  =3D=3D13372=3D=3D         suppressed: 0 bytes in 0 blocks

And with the patch applied:

  =3D=3D13375=3D=3D LEAK SUMMARY:
  =3D=3D13375=3D=3D    definitely lost: 65 bytes in 1 blocks
  =3D=3D13375=3D=3D    indirectly lost: 0 bytes in 0 blocks
  =3D=3D13375=3D=3D      possibly lost: 0 bytes in 0 blocks
  =3D=3D13375=3D=3D    still reachable: 2,364,417 bytes in 3,245 blocks
  =3D=3D13375=3D=3D         suppressed: 0 bytes in 0 blocks

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 unpack-trees.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 7c9ecf6..f9c74bd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -102,21 +102,28 @@ void setup_unpack_trees_porcelain(struct unpack_t=
rees_options *opts,
 		opts->unpack_rejects[i].strdup_strings =3D 1;
 }
=20
-static void add_entry(struct unpack_trees_options *o, struct cache_ent=
ry *ce,
-	unsigned int set, unsigned int clear)
+static void do_add_entry(struct unpack_trees_options *o, struct cache_=
entry *ce,
+			 unsigned int set, unsigned int clear)
 {
-	unsigned int size =3D ce_size(ce);
-	struct cache_entry *new =3D xmalloc(size);
-
 	clear |=3D CE_HASHED | CE_UNHASHED;
=20
 	if (set & CE_REMOVE)
 		set |=3D CE_WT_REMOVE;
=20
+	ce->next =3D NULL;
+	ce->ce_flags =3D (ce->ce_flags & ~clear) | set;
+	add_index_entry(&o->result, ce,
+			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
+}
+
+static void add_entry(struct unpack_trees_options *o, struct cache_ent=
ry *ce,
+	unsigned int set, unsigned int clear)
+{
+	unsigned int size =3D ce_size(ce);
+	struct cache_entry *new =3D xmalloc(size);
+
 	memcpy(new, ce, size);
-	new->next =3D NULL;
-	new->ce_flags =3D (new->ce_flags & ~clear) | set;
-	add_index_entry(&o->result, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_=
REPLACE);
+	do_add_entry(o, new, set, clear);
 }
=20
 /*
@@ -587,7 +594,7 @@ static int unpack_nondirectories(int n, unsigned lo=
ng mask,
=20
 	for (i =3D 0; i < n; i++)
 		if (src[i] && src[i] !=3D o->df_conflict_entry)
-			add_entry(o, src[i], 0, 0);
+			do_add_entry(o, src[i], 0, 0);
 	return 0;
 }
=20
--=20
1.7.9.2
