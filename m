From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 07/15] cache_tree_update(): Capability to handle tree
 entries missing from index
Date: Mon, 6 Sep 2010 15:02:50 +1000
Message-ID: <AANLkTikvJoVdUWAbQw0xT=JOiry4FaA0jsOMTNf=iZqH@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-8-git-send-email-newren@gmail.com>
	<AANLkTi=ijbaATavcujUY-WnEfKFKrNue_kP6vSngKSvQ@mail.gmail.com>
	<AANLkTikK9vGgtzrrAAyqptPVHM2wjOjK_cH6GB0rgewP@mail.gmail.com>
	<AANLkTinufi3TwnPZ+smq5FE5S3zZdQSzKpqYv=hVfcLV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 07:02:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsTr7-000761-UH
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 07:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab0IFFCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 01:02:52 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46067 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab0IFFCw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 01:02:52 -0400
Received: by wyf22 with SMTP id 22so2509870wyf.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 22:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1NMQddKTifQJhMSp7u5urF6n5OJvBBLVpq8kcVltzlk=;
        b=DtFWmd+xLJzUtq5RmppSsO3p+42E9aLn4DBC9+fGTFzckwp9YUB4kCoTr9P/Py9Fwr
         2+LgBKPJTScRLILrSZGkxVlufYynoVqeicGB+MlPx/WyIC9PI6GYsjLAomV70RRhXN2D
         OaccaDcuzx8xo9vgvAlE0pbdixVY4Tw2iVDUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sUjCzjcjZL+5z175jX4SpNOxoVzsc+lX5eNkHhnBx3CFG2sEa7A62Xs3db0TcY0Yzy
         5umM6zN9Fd8gmAduF6rWPzNUH9cdT6RTQDrDLhHq5zAYWgT/4f/xw/GNZTj7MT4rEAWb
         LFR/KY1rJjQdkkjO64myYSpARW9mvxvZsw+9c=
Received: by 10.216.186.70 with SMTP id v48mr693455wem.64.1283749370420; Sun,
 05 Sep 2010 22:02:50 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Sun, 5 Sep 2010 22:02:50 -0700 (PDT)
In-Reply-To: <AANLkTinufi3TwnPZ+smq5FE5S3zZdQSzKpqYv=hVfcLV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155526>

On Mon, Sep 6, 2010 at 2:42 PM, Elijah Newren <newren@gmail.com> wrote:
> On Sun, Sep 5, 2010 at 3:09 PM, Elijah Newren <newren@gmail.com> wrot=
e:
>> n Sun, Sep 5, 2010 at 1:54 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.c=
om> wrote:
>>> On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> w=
rote:
>>>> cache_tree_update() will write trees using the index. =C2=A0With s=
parse clones,
>>>> the index will only contain entries matching the sparse limits, me=
aning
>>>> that the index does not provide enough information to write comple=
te tree
>>>> objects. =C2=A0Having cache_tree_update() take a tree (typically H=
EAD), will
>>>> allow new complete trees to be constructed by using entries from t=
he
>>>> specified tree outside the sparse limits together with the index.
>>>
>>> You are moving it closer to the index (from my view because I chang=
ed
>>> in commit_tree()). This makes me think, why don't you move the base
>>> tree into the index itself?
>>>
>>> The index is supposed to save the image of full worktree. While you
>>> don't have all path names, you have the clue to all of them, the ba=
se
>>> tree. To me, that means it belongs to the index. That would reduce
>>> code change to
>>> =C2=A0- cache-tree.c (generate new tree from the base tree and inde=
x)
>>> =C2=A0- read-cache.c (new sparse-clone index extension)
>>> =C2=A0- index writing operations (save the base tree in index): rea=
d-tree and merge
>>
>> That's a really good idea. =C2=A0I'll look into that.
>
> Hmm..maybe before I get ahead of myself, I should back up for a
> second. =C2=A0Which way do we think is better -- handling this in
> cache_tree_update() or doing a fixup in commit_tree()? =C2=A0If the l=
atter,
> then I should just drop my 7/15 and 8/15 for your 13/17 and 14/17. =C2=
=A0If
> the former, then it makes sense to look into this change you suggest.
> In that case, we'd probably keep my 7/15 but drop 8/15 for patch(es)
> that implement your idea above. =C2=A0But you're more familiar with t=
he
> index format than I am and it's your idea, so you'd probably be the
> better one to implement it.
>
> Thoughts?

The former makes more sense. I still keep an eye on remote merge
support. Think of this case: you request a remote merge and have a
completely new base tree, different from HEAD. Then you get some
conflicts inside narrow/sparse area. By the time you resolve all
conflicts and are about to commit, where do you get the base tree?

It could follow the same way merge does, store it in a file in
$GIT_DIR, similar to $GIT_DIR/MERGE_HEAD, and make "git commit" pick
it up. Or just store it in index. You would need to (or should) change
the index anyway, to prevent naive git implementation from using it.
It makes more sense to put some more in index rather than a separate
file. Some commands (especially "git commit") make use of temporary
index. I think putting the base tree in index is a good point here,
but I'm not quite sure.

Anyway if you want to play with it, apply this on top of my 04/17
(then change index_state.narrow_base to something suitable for sparse
clone)

diff --git a/cache.h b/cache.h
index 9c014ef..c7d626d 100644
--- a/cache.h
+++ b/cache.h
@@ -293,6 +293,7 @@ struct index_state {
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
 	char *narrow_prefix;
+	unsigned char narrow_base[20];
 	void *alloc;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
diff --git a/read-cache.c b/read-cache.c
index 250013c..15c1c9e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1191,7 +1191,8 @@ static int read_index_extension(struct
index_state *istate,
 		istate->resolve_undo =3D resolve_undo_read(data, sz);
 		break;
 	case CACHE_EXT_NARROW:
-		istate->narrow_prefix =3D xstrdup(data);
+		hashcpy(istate->narrow_base, data);
+		istate->narrow_prefix =3D xstrdup(data+sizeof(istate->narrow_base));
 		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
@@ -1396,6 +1397,7 @@ int discard_index(struct index_state *istate)
 	istate->alloc =3D NULL;
 	istate->initialized =3D 0;
 	free(istate->narrow_prefix);
+	hashcpy(istate->narrow_base, (const unsigned char *)EMPTY_TREE_SHA1_B=
IN);
 	istate->narrow_prefix =3D NULL;

 	/* no need to throw away allocated active_cache */
@@ -1627,11 +1629,15 @@ int write_index(struct index_state *istate, int=
 newfd)
 			return -1;
 	}
 	if (get_narrow_prefix()) {
+		struct strbuf sb =3D STRBUF_INIT;
 		char *buf =3D get_narrow_string();
-		int len =3D strlen(buf)+1;
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_NARROW, len) < 0=
 ||
-			ce_write(&c, newfd, buf, len) < 0;
+		int len =3D 20+strlen(buf)+1;
+		strbuf_add(&sb, istate->narrow_base, 20);
+		strbuf_addstr(&sb, buf);
 		free(buf);
+		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_NARROW, len) < 0=
 ||
+			ce_write(&c, newfd, sb.buf, len) < 0;
+		strbuf_release(&sb);
 		if (err)
 			return -1;
 	}
--=20
Duy
