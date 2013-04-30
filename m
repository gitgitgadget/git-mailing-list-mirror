From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] unpack_entry: invalidate newly added cache entry in case of error
Date: Tue, 30 Apr 2013 14:53:06 +0200
Message-ID: <87d2tcw571.fsf@linux-k42r.v.cablecom.net>
References: <1367288992-14979-1-git-send-email-pclouds@gmail.com>
	<87ppxcxw1i.fsf@linux-k42r.v.cablecom.net>
	<CACsJy8Bi6UpfA-0BCFY6H=BAKMmWYgwbf-94yJXEn5Zi4gwPCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 14:53:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXA3X-0003PO-WB
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 14:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760558Ab3D3MxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 08:53:10 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:2237 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab3D3MxJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 08:53:09 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 30 Apr
 2013 14:53:04 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 30 Apr 2013 14:53:06 +0200
In-Reply-To: <CACsJy8Bi6UpfA-0BCFY6H=BAKMmWYgwbf-94yJXEn5Zi4gwPCA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 30 Apr 2013 17:25:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222933>

Duy Nguyen <pclouds@gmail.com> writes:

> Apply this patch on top of master (no need to apply full series) and =
run t5303
>
> http://article.gmane.org/gmane.comp.version-control.git/222895
[...]
> OK since you know this code much better than me, I withdraw my patch
> (consider it a bug report) and let you work on a proper fix. I see yo=
u
> already have the commit message ready :) Happy to test it for you if
> the above instruction is still not reproducible for you.

Ok.  So I really think just dropping the free() is the way to go.  Can
you test this?  Your series didn't apply cleanly on anything I had
locally, and 'am -3' doesn't work.  A simpler reproducer, and using
valgrind to detect the use-after-free, didn't get me anywhere either.

-- >8 --
Subject: [PATCH] unpack_entry: avoid freeing objects in base cache
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

In the !delta_data error path of unpack_entry(), we run free(base).
This became a window for use-after-free() in abe601b (sha1_file:
remove recursion in unpack_entry, 2013-03-27), as follows:

Before abe601b, we got the 'base' from cache_or_unpack_entry(..., 0);
keep_cache=3D0 tells it to also remove that entry.  So the 'base' is at
this point not cached, and freeing it in the error path is the right
thing.

After abe601b, the structure changed: we use a three-phase approach
where phase 1 finds the innermost base or a base that is already in
the cache.  In phase 3 we therefore know that all bases we unpack are
not part of the delta cache yet.  (Observe that we pop from the cache
in phase 1, so this is also true for the very first base.)  So we make
no further attempts to look up the bases in the cache, and just call
add_delta_base_cache() on every base object we have assembled.

But the !delta_data error path remained unchanged, and now calls
free() on a base that has already been entered in the cache.  This
means that there is a use-after-free if we later use the same base
again.

So remove that free().

Reported-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 sha1_file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 64228a2..67e815b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2128,7 +2128,6 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 			error("failed to unpack compressed delta "
 			      "at offset %"PRIuMAX" from %s",
 			      (uintmax_t)curpos, p->pack_name);
-			free(base);
 			data =3D NULL;
 			continue;
 		}
--=20
1.8.3.rc0.333.gdb39496
