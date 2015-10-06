From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2015, #01; Mon, 5)
Date: Mon, 05 Oct 2015 22:55:49 -0700
Message-ID: <xmqqd1wswnfe.fsf@gitster.mtv.corp.google.com>
References: <xmqqwpv0x6op.fsf@gitster.mtv.corp.google.com>
	<561339C1.704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: rappazzo@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 06 07:56:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjLEj-00005v-6I
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 07:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbbJFFzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 01:55:55 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35768 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbJFFzz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 01:55:55 -0400
Received: by pacfv12 with SMTP id fv12so203656089pac.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 22:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=STA2ozMdpjagaFkZiOb9S/JPQ3RlXjVVU/AFJDrvJ4k=;
        b=hFEagzGjO4ICT3t8uN4G+fButs/23ym1fkO5RanRkhX/At4cJs8WOAhJi9kk5VOXOL
         oa/AjW3lbVlQZbLxXL46vGtuLD3DR5geP99GOIO9fIo/okfQLIkjXDkcrXkhM5oPH3a0
         qWP6qgAn1acJ5CtlWuWLhVzECwWuigthQWgpzBT5MIyrjy3+CTfWBKD2SNzxzVPKZuyU
         laO1AQIJF67CqlY4M1XX+kr+s4ZdWFbm5uXZ4Sf1zf3zNz0+We9NnJVx7sGGaHX4P+TD
         AbdhBUwYjTQvNRbA6pYrGmLKPVknbkixAv7vEvoP9c0CMmDEwxS7U818bAPPM6pcPvtS
         Agig==
X-Received: by 10.66.102.97 with SMTP id fn1mr38557832pab.97.1444110954570;
        Mon, 05 Oct 2015 22:55:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a14c:f96c:97d2:eee0])
        by smtp.gmail.com with ESMTPSA id gj10sm30972570pbc.68.2015.10.05.22.55.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 22:55:53 -0700 (PDT)
In-Reply-To: <561339C1.704@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of "Tue,
	6 Oct 2015 05:02:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279121>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Minor comment from my compiler:
>
> worktree.c:181: warning: assuming signed overflow does not occur when=
 assuming
> that (X + c) > X is always true

Thanks; I think the allocation in that function (the use it uses
ALLOC_GROW()) is somewhat bogus.

It does this:

	if ((linked =3D get_linked_worktree(d->d_name))) {
		ALLOC_GROW(list, alloc + 1, alloc);
		list[counter++] =3D linked;
	}

where "alloc" keeps track of the size of the list, and "counter"
keeps track of the first unused entry.  The second argument to the
helper macro smells bad.

The correct way to use ALLOC_GROW() helper macro is:

 * Use three variables, an array, the size of the allocation and the
   size of the used part of the array.  If you call the array $thing,
   the size of the allocation is typically called $thing_alloc and
   the size of the used part $thing_nr.  E.g. opts[], opts_alloc & opts=
_nr.

 * When adding a new thing at the end of the $thing, do this:

	ALLOC_GROW($thing, $thing_nr + 1, $thing_alloc);
        $thing[$thing_nr++] =3D <<new thing>>;


Perhaps something like this needs squashing in.

Subject: [PATCH] fixup! worktree: add a function to get worktree detail=
s

---
 worktree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index 90282d9..f7304a2 100644
--- a/worktree.c
+++ b/worktree.c
@@ -178,12 +178,13 @@ struct worktree **get_worktrees(void)
 				continue;
=20
 				if ((linked =3D get_linked_worktree(d->d_name))) {
-					ALLOC_GROW(list, alloc + 1, alloc);
+					ALLOC_GROW(list, counter + 1, alloc);
 					list[counter++] =3D linked;
 				}
 		}
 		closedir(dir);
 	}
+	ALLOC_GROW(list, counter + 1, alloc);
 	list[counter] =3D NULL;
 	return list;
 }
--=20
2.6.1-284-g1f14bb6
