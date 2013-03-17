From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Preallocate hash tables when the number of inserts are
 known in advance
Date: Sat, 16 Mar 2013 23:18:10 -0700
Message-ID: <7vfvzusg65.fsf@alter.siamese.dyndns.org>
References: <1363490886-29729-1-git-send-email-pclouds@gmail.com>
 <7vzjy2si7l.fsf@alter.siamese.dyndns.org>
 <CACsJy8B=KrmbsqAuvoJTVxmUVYF_fG7XNnKvu3zDVELsWcmtQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 07:18:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6vY-0000aO-H1
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 07:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab3CQGSO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 02:18:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab3CQGSN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 02:18:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9E16A798;
	Sun, 17 Mar 2013 02:18:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=O6SbxDTbL4fI
	JIAsG9X6S+n374o=; b=qh2VLPovOP4E9HzCVkyM42+4wsfdxLnnL9fBksjxJig0
	MfBYMMW8m2EQx94IBxoH0T9NaKEU8AXQ6bSUagQwdvkPEPA+s1z3MvXvy+bhceCI
	GBl5srPmU9BypNK1ZklRD6HnVpOpvVyILkSiJrNlQWje+zCLx57lxGp3lzlmqco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UjNMn/
	xpljgbpANc3Gj6bRvKbY8v9L/qDzBlHveOA4DZooCSVTsC4l7b/pUtlCXWm0QbiI
	CdbNenVC+HMU4kC5mH2f5ItecgFLcR9RPt0hA11gnCjaIEsXp4WWj07V+cqj7jKJ
	sE7heg6ShdU50s6CvGU/Hyy6Jk4l60qIGUrKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF8B8A797;
	Sun, 17 Mar 2013 02:18:12 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34035A796; Sun, 17 Mar 2013
 02:18:12 -0400 (EDT)
In-Reply-To: <CACsJy8B=KrmbsqAuvoJTVxmUVYF_fG7XNnKvu3zDVELsWcmtQg@mail.gmail.com> (Duy
 Nguyen's message of "Sun, 17 Mar 2013 12:39:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 720817FE-8ECA-11E2-A1D3-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218341>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Mar 17, 2013 at 12:34 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>> This avoids unnecessary re-allocations and reinsertions. On webkit.=
git
>>> (i.e. about 182k inserts to the name hash table), this reduces abou=
t
>>> 100ms out of 3s user time.
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>
>> I think this is a very good idea, but I would prefer the second
>> parameter to the "preallocate" to be "expected number of entries"
>> and have the preallocate, which is a part of the hash API, decide
>> how to inflate that number to adjust to the desired load factor of
>> the hash table.  We shouldn't have to adjust the caller when the
>> internal implementation of the hash table changes.
>
> OK will do.

I've squashed it in myself, so no need to resend only for this.

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 8d3d9bb..6c7a72f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -389,7 +389,7 @@ static int find_exact_renames(struct diff_options *=
options)
 	struct hash_table file_table;
=20
 	init_hash(&file_table);
-	preallocate_hash(&file_table, (rename_src_nr + rename_dst_nr) * 2);
+	preallocate_hash(&file_table, rename_src_nr + rename_dst_nr);
 	for (i =3D 0; i < rename_src_nr; i++)
 		insert_file_table(&file_table, -1, i, rename_src[i].p->one);
=20
diff --git a/hash.h b/hash.h
index 244d1fe..1d43ac0 100644
--- a/hash.h
+++ b/hash.h
@@ -40,11 +40,11 @@ static inline void init_hash(struct hash_table *tab=
le)
 	table->array =3D NULL;
 }
=20
-static inline void preallocate_hash(struct hash_table *table, unsigned=
 int size)
+static inline void preallocate_hash(struct hash_table *table, unsigned=
 int elts)
 {
 	assert(table->size =3D=3D 0 && table->nr =3D=3D 0 && table->array =3D=
=3D NULL);
-	table->size =3D size;
-	table->array =3D xcalloc(sizeof(struct hash_table_entry), size);
+	table->size =3D elts * 2;
+	table->array =3D xcalloc(sizeof(struct hash_table_entry), table->size=
);
 }
=20
 #endif
diff --git a/name-hash.c b/name-hash.c
index 90c7b99..2a1f108 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -93,7 +93,7 @@ static void lazy_init_name_hash(struct index_state *i=
state)
 	if (istate->name_hash_initialized)
 		return;
 	if (istate->cache_nr)
-		preallocate_hash(&istate->name_hash, istate->cache_nr * 2);
+		preallocate_hash(&istate->name_hash, istate->cache_nr);
 	for (nr =3D 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized =3D 1;
