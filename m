From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] diff-index: pass pathspec down to unpack-trees machinery
Date: Wed, 11 Jan 2012 19:33:52 +0700
Message-ID: <CACsJy8D7EnOebAxBYF8ua7htu-81nKY=ghUMgg=JOe4Fc1uigQ@mail.gmail.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <1314653603-7533-4-git-send-email-gitster@pobox.com> <20120111063104.GA3153@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 13:34:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkxNu-00048N-58
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 13:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589Ab2AKMeZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 07:34:25 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54434 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab2AKMeY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 07:34:24 -0500
Received: by bkvi17 with SMTP id i17so461794bkv.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 04:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=K+a1VwP/FRTj+/J9dFG0SKBiKp/jv1F9adSI68WZJJs=;
        b=Xwvvzmt9b5oOiyRi949Js5l0uhJ/OePFti7hijKQX19O5SdSfKenrnxC86CnYvmItb
         tKM2Uh148PtBu+AKgQTX/HZmxczfqDQR71YDlDXqX8yqcLN/nBB/ATNjnITZpI1NJR8u
         KYOJevEEkh92rh1y9WZSJp3M7ifCGuf+CbhS0=
Received: by 10.204.156.156 with SMTP id x28mr10134476bkw.76.1326285263155;
 Wed, 11 Jan 2012 04:34:23 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Wed, 11 Jan 2012 04:33:52 -0800 (PST)
In-Reply-To: <20120111063104.GA3153@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188358>

On Wed, Jan 11, 2012 at 1:31 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Check this out:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir -p test-repo/subdir
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cd test-repo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git init
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo hi >subdir/hello.h
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add subdir/hello.h
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m 'say hi'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff-index --abbrev HEAD -- '*.h'

This seems to fix this.

diff --git a/unpack-trees.c b/unpack-trees.c
index 7c9ecf6..5cf58b6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1042,6 +1042,7 @@ int unpack_trees(unsigned len, struct tree_desc
*t, struct unpack_trees_options
                info.data =3D o;
                info.show_all_errors =3D o->show_all_errors;
                info.pathspec =3D o->pathspec;
+               info.pathspec->recursive =3D 1;

                if (o->prefix) {
                        /*

Still scratching my head why this flag is zero by default, which would
affect all other places.. Or perhaps the right fix would be this
instead

diff --git a/tree-walk.c b/tree-walk.c
index f82dba6..0345938 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -634,7 +634,7 @@ enum interesting tree_entry_interesting(const
struct name_entry *entry,
                                 * Match all directories. We'll try to
                                 * match files later on.
                                 */
-                               if (ps->recursive && S_ISDIR(entry->mod=
e))
+                               if (S_ISDIR(entry->mode))
                                        return entry_interesting;
                        }

@@ -662,7 +662,7 @@ match_wildcards:
                 * Match all directories. We'll try to match files
                 * later on.
                 */
-               if (ps->recursive && S_ISDIR(entry->mode))
+               if (S_ISDIR(entry->mode))
                        return entry_interesting;
        }
        return never_interesting; /* No matches */
--=20
Duy
