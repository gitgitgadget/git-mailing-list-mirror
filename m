From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH RFC] parse_object: pass on the original sha1, not the 
	replaced one
Date: Tue, 3 Aug 2010 16:01:32 +1000
Message-ID: <AANLkTikaPhV+SkzCJ+G3V39mS4FORELP34ePrPWbHFeV@mail.gmail.com>
References: <1280579802-8606-1-git-send-email-pclouds@gmail.com>
	<201008020942.58137.chriscool@tuxfamily.org>
	<AANLkTin0eymuYFv_6hamDuan0TELogtCyW3Xwjm=pAwH@mail.gmail.com>
	<201008030700.40533.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Aug 03 08:01:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgAZI-0006L4-8Y
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 08:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252Ab0HCGBe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 02:01:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55397 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab0HCGBd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 02:01:33 -0400
Received: by wyb39 with SMTP id 39so4040879wyb.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QeN/WnycMH/uxSyeU9d2kXJT47TopRFCE2sM91jC+z4=;
        b=EzjFczC0nH8f3d02DYLHxDgTyOMZ96aFIus0tkaBWlRJu+3+t70DhDO9or60fYgk48
         eXdmGD7+bOL/6La1+yqQR0730+OQwIVe34jt/CAn/PE3uNZJe3pjcRdGZkkclCQ/Gl5M
         VCzygjOpoPJQLN6+nxCSfLDYLYSz3BIst3oaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PFP0Hnmdm4aeF451pWxWLxBwtrg/TNtWvv33VHXxeEKBjcO4a8yPR00u86fiwZA5uj
         /RlapfNdL/YtK+Ykn6hQZeXsLI2r/ZcQjJosDtyrSuebPXqNq77gB9r6aebkHQPoCSQP
         vBM4lpR5q0AANDA1PC1arkP11q5GGr8pm8URU=
Received: by 10.216.11.131 with SMTP id 3mr284027wex.92.1280815292565; Mon, 02 
	Aug 2010 23:01:32 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Mon, 2 Aug 2010 23:01:32 -0700 (PDT)
In-Reply-To: <201008030700.40533.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152486>

On Tue, Aug 3, 2010 at 3:00 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
>> With parse_object(A), I get an object pointer whose sha1 is B.
>>
>> With =C2=A0lookup_commit(A), I get an object pointer whose sha1 is A=
=2E
>
> Maybe there is a bug somewhere and you should get an object pointer w=
hose sha1
> is B or maybe the content of the object that was inserted in the look=
up table
> should have been the content from A and not from B. I will try to hav=
e a
> deeper look at that, but it would help if you could give an example o=
f a
> command that triggers this behavior.

The following patch add "sha1" command. These commands give different s=
ha1:

git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` A
git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` B

(hopefully gmail won't break the patch, otherwise I'll resend to you pr=
ivately)

diff --git a/Makefile b/Makefile
index f33648d..8556c65 100644
--- a/Makefile
+++ b/Makefile
@@ -649,6 +649,7 @@ LIB_OBJS +=3D ws.o
 LIB_OBJS +=3D wt-status.o
 LIB_OBJS +=3D xdiff-interface.o

+BUILTIN_OBJS +=3D builtin/sha1.o
 BUILTIN_OBJS +=3D builtin/add.o
 BUILTIN_OBJS +=3D builtin/annotate.o
 BUILTIN_OBJS +=3D builtin/apply.o
diff --git a/builtin/sha1.c b/builtin/sha1.c
new file mode 100644
index 0000000..4700bc0
--- /dev/null
+++ b/builtin/sha1.c
@@ -0,0 +1,21 @@
+#include "cache.h"
+#include "commit.h"
+
+int cmd_sha1(int argc, char **argv)
+{
+	unsigned char old[20];
+	unsigned char new[20];
+	struct object *obj;
+
+	get_sha1_hex(argv[1], old);
+	get_sha1_hex(argv[2], new);
+	printf("old  =3D %s\nnew  =3D %s\n", argv[1], argv[2]);
+	replace_pair(old, new);
+	if (argv[3][0] =3D=3D 'A')
+		obj =3D parse_object(old);
+	else
+		obj =3D lookup_commit(old);
+
+	printf("sha1 =3D %s\n", sha1_to_hex(obj->sha1));
+	return 0;
+}
diff --git a/git.c b/git.c
index f37028b..9bc2391 100644
--- a/git.c
+++ b/git.c
@@ -288,6 +288,7 @@ static int run_builtin(struct cmd_struct *p, int
argc, const char **argv)
 	return 0;
 }

+int cmd_sha1(int, const char **, const char*);
 static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd =3D argv[0];
@@ -378,6 +379,7 @@ static void handle_internal_command(int argc,
const char **argv)
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
+		{ "sha1", cmd_sha1, RUN_SETUP },
 		{ "shortlog", cmd_shortlog, USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
diff --git a/replace_object.c b/replace_object.c
index eb59604..1ec5df7 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -50,6 +50,16 @@ static int register_replace_object(struct
replace_object *replace,
 	return 0;
 }

+int replace_pair(const unsigned char *old,
+		 const unsigned char *new)
+{
+	struct replace_object *ro =3D xmalloc(sizeof(*ro));
+	hashcpy(ro->sha1[0],old);
+	hashcpy(ro->sha1[1],new);
+	register_replace_object(ro, 1);
+	return 0;
+}
+
 static int register_replace_ref(const char *refname,
 				const unsigned char *sha1,
 				int flag, void *cb_data)

--=20
Duy
