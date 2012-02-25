From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] index-pack: reduce memory usage when the pack has
 large blobs
Date: Sat, 25 Feb 2012 08:49:55 +0700
Message-ID: <CACsJy8C-8dvXpNTU=JpdupSpS8OuqqTpGvDs6s1ASeKdk9d5Dg@mail.gmail.com>
References: <1330086201-13916-1-git-send-email-pclouds@gmail.com>
 <1330086201-13916-2-git-send-email-pclouds@gmail.com> <20120224161613.GH9526@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ian Kumlien <pomac@vapor.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 02:50:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S16mQ-0004pO-5Q
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 02:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353Ab2BYBu2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 20:50:28 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:45792 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190Ab2BYBu1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2012 20:50:27 -0500
Received: by wgbdt10 with SMTP id dt10so54178wgb.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 17:50:26 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) client-ip=10.180.99.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.99.65])
        by 10.180.99.65 with SMTP id eo1mr456313wib.13.1330134626316 (num_hops = 1);
        Fri, 24 Feb 2012 17:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=sZnn0bSZKnE6UOopgHe83dMBmStOa6uCg2q4qsB+N9Y=;
        b=OTI35UEZdMoVMHJFFnBRM9zi+YQHXL6BG2jABL/bxjDNBp60Kegm9nio1Z6aLRksxr
         58E8iKvmp3hjIvRoyce8h2m0W03e1OT4CU8eOEaYqNFsw97IRGSHL69q6+SNm2Fs1Chl
         VlTyUfiM/wgwZfZxnEzXNuQoR5UV/jwmbwMbI=
Received: by 10.180.99.65 with SMTP id eo1mr352083wib.13.1330134626245; Fri,
 24 Feb 2012 17:50:26 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Fri, 24 Feb 2012 17:49:55 -0800 (PST)
In-Reply-To: <20120224161613.GH9526@pomac.netswarm.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191504>

2012/2/24 Ian Kumlien <pomac@vapor.com>:
> Writing objects: 100% (1425/1425), 56.06 MiB | 4.62 MiB/s, done.
> Total 1425 (delta 790), reused 1425 (delta 790)
> fatal: Out of memory, malloc failed (tried to allocate 3310214315 byt=
es)
> fatal: Out of memory, malloc failed (tried to allocate 3310214315 byt=
es)
> fatal: Out of memory, malloc failed (tried to allocate 3310214315 byt=
es)
> fatal: Out of memory, malloc failed (tried to allocate 3310214315 byt=
es)
> To ../test_data/
> =C2=A0! [remote rejected] master -> master (missing necessary objects=
)
> =C2=A0! [remote rejected] origin/HEAD -> origin/HEAD (missing necessa=
ry objects)
> =C2=A0! [remote rejected] origin/master -> origin/master (missing nec=
essary objects)
> error: failed to push some refs to '../test_data/'
>
> So there are additional code paths to look at... =3D(

I can't say where that came from. Does this help? (Space damaged, may
need manual application)

-- 8< --
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 264e3ae..6dc46eb 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -183,7 +183,8 @@ static void show_object(struct object *obj,
        struct rev_list_info *info =3D cb_data;

        finish_object(obj, path, component, cb_data);
-       if (info->revs->verify_objects && !obj->parsed && obj->type !=3D
OBJ_COMMIT)
+       if (info->revs->verify_objects && !obj->parsed &&
+           obj->type !=3D OBJ_COMMIT && obj->type !=3D OBJ_BLOB)
                parse_object(obj->sha1);
        show_object_with_name(stdout, obj, path, component);
 }
-- 8< --

If not, you might need to apply this to generate coredump, then look
and see where that failed malloc comes from

-- 8< --
diff --git a/wrapper.c b/wrapper.c
index 85f09df..03f423e 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -40,9 +40,11 @@ void *xmalloc(size_t size)
                ret =3D malloc(size);
                if (!ret && !size)
                        ret =3D malloc(1);
-               if (!ret)
+               if (!ret) {
+                       *(char*)0 =3D 1;
                        die("Out of memory, malloc failed (tried to
allocate %lu bytes)",
                            (unsigned long)size);
+               }
        }
 #ifdef XMALLOC_POISON
        memset(ret, 0xA5, size);
-- 8< --

--=20
Duy
