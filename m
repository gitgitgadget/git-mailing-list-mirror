From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Sparse checkout
Date: Fri, 21 Aug 2009 16:15:28 +0700
Message-ID: <fcaeb9bf0908210215t5f694e3fp20c34e9c327f515b@mail.gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com> 
	<7vprapip1v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 11:15:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeQE0-000594-Qb
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 11:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbZHUJPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2009 05:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755188AbZHUJPr
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 05:15:47 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:48163 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbZHUJPq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 05:15:46 -0400
Received: by ywh3 with SMTP id 3so813321ywh.22
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=k/y4XezvaO0egyGA+Mg04pDrq2LKVVYdioyI3cGNxg0=;
        b=DMyLX9tqM2S93LQlhD8Z6S7M5A4fihAUMf0li4hstJLhwuouY6XWkGXPRm1gbFbDUY
         bFpiCaGDLxMX+yBY9sJ0yzREFTiO3YlbV/PqhLti7MdajiWcJpeHlmlmWEa0cjgESQOZ
         P46nttlFBvPpyDRXWDg7Yuxdjvxmd7mFDYYIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=egLfc8D/4CjeMdmXI9/s+FMPOqvTKXVMghbaEfIZcVWeYCLX7YJ7v3+LKRbJATU+xS
         OQuekYx4jMKaFEzKIvCy5wo6LW4R/dkC06yY1jeVDc8biH6t2hhT+vxCFDHSFRRih/Sb
         gviMvFQI3pxkhRFmTUn6of4kS+96gtSYidmSY=
Received: by 10.101.87.7 with SMTP id p7mr770650anl.59.1250846148139; Fri, 21 
	Aug 2009 02:15:48 -0700 (PDT)
In-Reply-To: <7vprapip1v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126699>

2009/8/21 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> The recent assume-unchanged "breakage" that lets Git overwrite
>> assume-unchanged files worried me. I sat back, checked and wrote tes=
ts
>
> Yeah, it worries me, too. =C2=A0Does the fix to make sure the sparse =
stuff
> won't be broken apply equally to assume-unchanged? =C2=A0Does the ser=
ies have
> such fixes to assume-unchanged bit as well?

This series does not fix assume-unchanged bit. I'd like to focus on
skip-worktree bit now. I still need to write a few more tests for
git-apply, git-checkout... but I think they are safe. It's up to you
to see if changes apply to assume-unchanged bit, in patches 4/19 and
5/19. I don't know if I understand assume-unchanged semantics
correctly anymore :-)

Anyway I think we could put a big fat warning above ce_uptodate()
macro definition, saying that this bit/macro could be faked by
assume-unchanged or skip-worktree bit, so don't rely on that macro
when it comes to writing (at least for skip-worktree part).

Hmm.. _or_ we could make it clear whether it is truly uptodate, or
faked uptodate. Some code path will be updated to only trust "truly
uptodate" bit, which is clearer and easier to grasp than messy logics
like "if (ce_uptodate(ce) && !ce_skip_worktree(ce))". Something like
this as a starting point (for demonstration only, I don't think it
compiles)

diff --git a/cache.h b/cache.h
index a401daf..05fb746 100644
--- a/cache.h
+++ b/cache.h
@@ -179,6 +179,7 @@ struct cache_entry {

 /* Only remove in work directory, not index */
 #define CE_WT_REMOVE (0x400000)
+#define CE_ASSUME_UPTODATE  (0x800000)

 /*
  * Extended on-disk flags
@@ -236,9 +237,11 @@ static inline size_t ce_namelen(const struct
cache_entry *ce)
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 #define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT=
)
-#define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
+#define ce_truely_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
+#define ce_uptodate(ce) ((ce)->ce_flags & (CE_UPTODATE | CE_ASSUME_UPT=
ODATE))
 #define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |=3D CE_UPTODATE)
+#define ce_mark_assume_uptodate(ce) ((ce)->ce_flags |=3D CE_ASSUME_UPT=
ODATE)

 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
 static inline unsigned int create_ce_mode(unsigned int mode)
diff --git a/read-cache.c b/read-cache.c
index 5ee7d9d..c022955 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1005,7 +1005,7 @@ static struct cache_entry
*refresh_cache_ent(struct index_state *istate,
 		return ce;

 	if (!ignore_valid && ((ce->ce_flags & CE_VALID) || ce_skip_worktree(c=
e))) {
-		ce_mark_uptodate(ce);
+		ce_mark_assume_uptodate(ce);
 		return ce;
 	}

Still thinking of it. Seems like a good change...

> By the way, I think the first patch in the earlier series, 540e694
> (Prevent diff machinery from examining assume-unchanged entries on
> worktree, 2009-08-11), is a good change regardless of the sparse
> implementation, and I'm inclined to say that we should merge that par=
t
> (and I suspect there will be similar fixes to really ignore differenc=
es to
> CE_VALID entries) first and then queue this new series on top.

I have no problem with that.
--=20
Duy
