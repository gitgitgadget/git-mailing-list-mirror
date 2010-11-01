From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] cherry-pick/revert: transparently refresh index
Date: Mon, 1 Nov 2010 15:44:43 +0700
Message-ID: <AANLkTimqpwgvHS7+Q98RPrtD+j7gN7T3-ZrJDCLBq0sF@mail.gmail.com>
References: <20101031174430.GA30236@arf.padd.com> <20101031195933.GA21240@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 09:45:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCq0y-0001Kp-QA
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 09:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774Ab0KAIpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 04:45:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40848 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727Ab0KAIpG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Nov 2010 04:45:06 -0400
Received: by wyf28 with SMTP id 28so5224100wyf.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PgHodwVMhPf8bMecipCW9G+9HmeDppAi6757jr3Vk5I=;
        b=p4d/7PnmWECi3XXkLQ+TMrSFJFSIfSl7mM8ykTSHd8y/dLOXZYvGCs0J92Yl8Ct4sC
         2hTHAc+2F3arL6G1SCjxYwpJFbgl9gapMINxdmDD8J20kUTvQfZWDa9HaK6swsEFiAEH
         17ijOgveOFgby7xKK2p5INv74XPe6pkA74eWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=F3RNH1VNPmcgMB+/pSyQJT66pfo3gMYOkTklatGCtl2IYaYJ99pb0a2W4HZNSBcO/5
         +FjZeJ2FTO0XoorB5l4fppDDlV2PfYv6fHB3+OouK44YuWdBymGOBbM+BnySfwUFskBR
         +qBxW4adrkGShttbFTkAk2T+4XdzDAeGaQiXQ=
Received: by 10.227.133.135 with SMTP id f7mr3797990wbt.117.1288601103919;
 Mon, 01 Nov 2010 01:45:03 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Mon, 1 Nov 2010 01:44:43 -0700 (PDT)
In-Reply-To: <20101031195933.GA21240@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160471>

> +static void read_and_refresh_cache(const char *me)
> +{
> + =C2=A0 =C2=A0 =C2=A0 static struct lock_file index_lock;
> + =C2=A0 =C2=A0 =C2=A0 int index_fd =3D hold_locked_index(&index_lock=
, 0);
> + =C2=A0 =C2=A0 =C2=A0 if (read_index_preload(&the_index, NULL) < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("git %s: faile=
d to read the index", me);
> + =C2=A0 =C2=A0 =C2=A0 refresh_index(&the_index, REFRESH_QUIET|REFRES=
H_UNMERGED, NULL, NULL, NULL);

Can we refresh only index entries that are cherry-picked/reverted?
=46ull refresh can be expensive on large repos while these operations
don't usually touch the whole repo.

I'm thinking of adding ce_really_uptodate() and converting most of
ce_uptodate() call sites  to the new one.

diff --git a/cache.h b/cache.h
index 123dd4b..81dc5cf 100644
--- a/cache.h
+++ b/cache.h
@@ -240,6 +240,7 @@ static inline size_t ce_namelen(const struct
cache_entry *ce)
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 #define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT=
)
 #define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
+#define ce_really_uptodate(ce) (ce_uptodate(ce) ||
(refresh_cache_entry(ce), ce_uptodate(ce)))
 #define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |=3D CE_UPTODATE)

@@ -512,6 +513,7 @@ extern void fill_stat_cache_info(struct
cache_entry *ce, struct stat *st);
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not
"needs update" */
 extern int refresh_index(struct index_state *, unsigned int flags,
const char **pathspec, char *seen, char *header_msg);
+extern struct cache_entry *refresh_cache_entry(struct cache_entry
*ce, int really);

 struct lock_file {
 	struct lock_file *next;
diff --git a/read-cache.c b/read-cache.c
index 1f42473..76525a9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1156,7 +1156,7 @@ int refresh_index(struct index_state *istate,
unsigned int flags, const char **p
 	return has_errors;
 }

-static struct cache_entry *refresh_cache_entry(struct cache_entry
*ce, int really)
+struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int re=
ally)
 {
 	return refresh_cache_ent(&the_index, ce, really, NULL);
 }
--=20
Duy
