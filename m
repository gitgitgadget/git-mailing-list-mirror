From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 08/21] remote: let guess_remote_head() optionally return 
	all matches
Date: Thu, 26 Feb 2009 13:47:45 -0500
Message-ID: <76718490902261047p6168e875wf29bcca780105d3e@mail.gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
	 <ad3c408c208c8a829b1e4a0c0818e808b19e1dfc.1235546708.git.jaysoffian@gmail.com>
	 <20090226143729.GA9693@coredump.intra.peff.net>
	 <20090226144052.GB9693@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 19:51:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LclIh-0006Uo-0f
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 19:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbZBZSrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 13:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbZBZSrt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 13:47:49 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:48925 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbZBZSrr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 13:47:47 -0500
Received: by rv-out-0506.google.com with SMTP id g37so654501rvb.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 10:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ehatm9+ysLZ7Hdz40bqA9UM+9MBaf/rZI2HHxUzfvls=;
        b=ReupT6ie2JnC0ucCk0hsSOmhzgzxEaxXhCMXfvqbwKagj+/H4e9NNA7u+vHQCj1DzB
         eTwge5Gh4gyBT0MZhmSk+UQt/Zb6rkGVMTHuM+pNGKUVgzkx0ygOlqLUa7bj5P0OdaK2
         mPjmLxYr6BRjgn3FJa9DniB92WMLTLWyeR22w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GmY+Yt2+3dWY+Vyafsy9nx7YMIYid5ZCyI4Fd6ig7N6osMlTB7Awj2YxT2v3YkNKKG
         ac5ut0nTkZjUzAaOgrn2lIwAwSW0WbtuZIFTG1rvJ/bmncGBYAMuxdwLqCQHIWd4JFn2
         kZS6OzCD/e24p4yhzPihYU5tNQ5+2oJk1cLtc=
Received: by 10.141.168.2 with SMTP id v2mr779121rvo.47.1235674065917; Thu, 26 
	Feb 2009 10:47:45 -0800 (PST)
In-Reply-To: <20090226144052.GB9693@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111586>

On Thu, Feb 26, 2009 at 9:40 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 26, 2009 at 09:37:29AM -0500, Jeff King wrote:
>
>> Hmm. This should probably be:
>>
>> =C2=A0 dst->peer_ref =3D src->peer_ref ? copy_ref(src->peer_ref) : N=
ULL;
>>
>> (or copy_ref should return NULL when given NULL). I also wonder if t=
he
>> copied ref's peer_ref should be explicitly NULL'd.

Well, if you wanted to be consistent about things (and I apologize if g=
mail
mangles the lines), I'd probably do something like:

diff --git a/remote.c b/remote.c
index 1c09cf0..9f1bf5e 100644
--- a/remote.c
+++ b/remote.c
@@ -779,10 +779,18 @@ struct ref *alloc_ref(const char *name)

 static struct ref *copy_ref(const struct ref *ref)
 {
-	struct ref *ret =3D xmalloc(sizeof(struct ref) + strlen(ref->name) + =
1);
-	memcpy(ret, ref, sizeof(struct ref) + strlen(ref->name) + 1);
-	ret->next =3D NULL;
-	return ret;
+	struct ref *cpy;
+	if (!ref)
+		return NULL;
+	cpy =3D xmalloc(sizeof(struct ref) + strlen(ref->name) + 1);
+	memcpy(cpy, ref, sizeof(struct ref) + strlen(ref->name) + 1);
+	cpy->next =3D cpy->peer_ref =3D NULL;
+	if (ref->peer_ref) {
+		ref =3D ref->peer_ref;
+		cpy->peer_ref =3D xmalloc(sizeof(struct ref) + strlen(ref->name) + 1=
);
+		memcpy(cpy->peer_ref, ref, sizeof(struct ref) + strlen(ref->name) + =
1);
+	}
+	return cpy;
 }

 struct ref *copy_ref_list(const struct ref *ref)
@@ -803,6 +811,7 @@ static void free_ref(struct ref *ref)
 		return;
 	free(ref->remote_status);
 	free(ref->symref);
+	free(ref->peer_ref);
 	free(ref);
 }

@@ -811,7 +820,6 @@ void free_refs(struct ref *ref)
 	struct ref *next;
 	while (ref) {
 		next =3D ref->next;
-		free(ref->peer_ref);
 		free_ref(ref);
 		ref =3D next;
 	}
@@ -1457,13 +1465,6 @@ struct ref *get_local_heads(void)
 	return local_refs;
 }

-struct ref *copy_ref_with_peer(const struct ref *src)
-{
-	struct ref *dst =3D copy_ref(src);
-	dst->peer_ref =3D copy_ref(src->peer_ref);
-	return dst;
-}
-
 struct ref *guess_remote_head(const struct ref *head,
 			      const struct ref *refs,
 			      int all)
@@ -1480,22 +1481,20 @@ struct ref *guess_remote_head(const struct ref =
*head,
 	 * where HEAD points; if that is the case, then
 	 * we don't have to guess.
 	 */
-	if (head->symref) {
-		r =3D find_ref_by_name(refs, head->symref);
-		return r ? copy_ref_with_peer(r) : NULL;
-	}
+	if (head->symref)
+		return copy_ref(find_ref_by_name(refs, head->symref));

 	/* If refs/heads/master could be right, it is. */
 	if (!all) {
 		r =3D find_ref_by_name(refs, "refs/heads/master");
 		if (r && !hashcmp(r->old_sha1, head->old_sha1))
-			return copy_ref_with_peer(r);
+			return copy_ref(r);
 	}

 	/* Look for another ref that points there */
 	for (r =3D refs; r; r =3D r->next) {
 		if (r !=3D head && !hashcmp(r->old_sha1, head->old_sha1)) {
-			*tail =3D copy_ref_with_peer(r);
+			*tail =3D copy_ref(r);
 			tail =3D &((*tail)->next);
 			if (!all)
 				break;


Then peer_ref is consistently a copy, so we can free it consistently, w=
e don't
need two separate copy functions, and copy_ref returns NULL upon receiv=
ing
NULL like most of the other foo_ref functions.

> BTW, all of my "probably" and "I wonder" here are because I think the
> "peer ref" pointer is a little vague as a concept. E.g., I think in m=
ost
> cases src->peer_ref->peer_ref !=3D src.
>
> Rather than having ref structs with "next" and "peer" pointers, I thi=
nk
> a more natural data structure would be a list (or array) of "ref pair=
s".

Actually, we don't need most of the fields in the peer_ref, so we could
probably just embed the extra fields that we need in a peer_struct insi=
de the
ref struct. I can add this to my git todo list.

j.
