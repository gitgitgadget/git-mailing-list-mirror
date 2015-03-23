From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] update-index: Don't copy memory around
Date: Mon, 23 Mar 2015 09:53:40 -0700
Message-ID: <1427129620-13380-1-git-send-email-sbeller@google.com>
References: <xmqqwq2baui7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, karsten.blees@gmail.com
X-From: git-owner@vger.kernel.org Mon Mar 23 17:53:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya5br-0000qD-0E
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 17:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbbCWQxq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2015 12:53:46 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33656 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbCWQxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 12:53:45 -0400
Received: by ignm3 with SMTP id m3so36273352ign.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Jr4Z+INhy2xTkvKJap7u8hKF52vAWpaZa+uhUDNQljA=;
        b=LrPApU1srZ3h9EC7IhFsvwN3bZ7vxYcjXVcECno2wdzVHfWW8JcMeA1kUCV3V0YiF4
         YgXJlFJ/Eg1RxE2LBfBK3jxa35UXQRXTAoADbg72FHLroWxFTor17LO1bylmlU2/SrQq
         LK0gXZ5i+iAT1piuWnLFVVFDX4U1AC89qsWbwwU8O8ZRS8+PxfJuCg61mdOos92LZ9oz
         2qPeD779t1FYZPv/XOIe586pTP81c4EXSW5qUoEuhDF+vm/HxwNJ/KeULBpN0UMZP0UU
         8OR6cLOQHnJvLjt27tCbwQUJSGztqZFGRjRceO2KvSAKPmLlnAFLsVw6RSc2q9mX0qcu
         Zyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Jr4Z+INhy2xTkvKJap7u8hKF52vAWpaZa+uhUDNQljA=;
        b=czgW+2k5YHRbZHp58KU4qgPNJ0xDEaH+SeWQNqJKkG3x+k+YnXct57frSBuYFp9Qxg
         tsmGqEab0skouNLw52ZnhFd2/qbHULH1mf4/IZxLLal13boz6rHpUaKE/ZXW0v960nIp
         Lk23LuDtgSCMr7RujlsnJJuz9KzEa1rHVNfDwrB9D776WFZpaXeRhEmuVkGqMe6TsdGS
         Xh9CTPv3hhi5Qf3uFEWChMbS0hAYRbwQd+jo9tVxz4p/RhGD/vW3pYBTdw+jtgjc5iMX
         23j/QMRQ7v2ro51i6plI+41jsakI3tBa6KM2nIyOWe9SmpJAqoa/4QGczoWNinT24dww
         spow==
X-Gm-Message-State: ALoCoQkrld3a8Gw1eD1OpEBzl6H7OwqC+D40tlxKfTueUl2w8kscX52AAaRHNzyU2dbcYyX+YEkJ
X-Received: by 10.43.157.67 with SMTP id lp3mr20809599icc.23.1427129624807;
        Mon, 23 Mar 2015 09:53:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4d5:daa7:294c:bc0b])
        by mx.google.com with ESMTPSA id k9sm6792421ige.6.2015.03.23.09.53.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Mar 2015 09:53:44 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <xmqqwq2baui7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266148>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

On Fri, Mar 20, 2015 at 8:40 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Stefan Beller <sbeller@google.com> writes:
>
>> `old` is not used outside the loop and would get lost
>> once we reach the goto.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> =C2=A0builtin/update-index.c | 1 +
>> =C2=A01 file changed, 1 insertion(+)
>>
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index 5878986..6271b54 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -584,6 +584,7 @@ static int do_reupdate(int ac, const char **av,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D xstrdup(ce=
->name);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_one(path);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(path);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(old);
>
> The change looks trivially correct.
>
> A tangent; I wonder if we want to make path a strbuf that is
> declared in the function scope, reset (not released) at each
> iteration of the loop and released after the loop; keep allocating
> and freeing a small piece of string all the time feels somewhat
> wasteful.

> Also, we might want to add to the "Be careful" comment to describe
> why this cannot just be a call to "update_one(ce->name)" that does
> not use "path".

Indeed I am rather wondering why we need to pass in a copy to update_on=
e
instead of ce->name. I was reading update_one and looking for why, but
eventually noticed update_one accepts a 'const char *', so it's not cha=
nged
in there. Digging down the into update_one also doesn't make it obvious=
 to me.

I found (5699d17ee094, 2013-11-14, read-cache.c: fix memory leaks cause=
d by
removed cache entries), which adds this duplication, though I do not un=
derstand
why. This passes the test suite, so I wonder if this patch would be a s=
ubtle bug
now.

 builtin/update-index.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6271b54..5857405 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -564,7 +564,6 @@ static int do_reupdate(int ac, const char **av,
 		const struct cache_entry *ce =3D active_cache[pos];
 		struct cache_entry *old =3D NULL;
 		int save_nr;
-		char *path;
=20
 		if (ce_stage(ce) || !ce_path_match(ce, &pathspec, NULL))
 			continue;
@@ -581,9 +580,7 @@ static int do_reupdate(int ac, const char **av,
 		 * or worse yet 'allow_replace', active_nr may decrease.
 		 */
 		save_nr =3D active_nr;
-		path =3D xstrdup(ce->name);
-		update_one(path);
-		free(path);
+		update_one(ce->name);
 		free(old);
 		if (save_nr !=3D active_nr)
 			goto redo;
--=20
2.3.0.81.gc37f363
