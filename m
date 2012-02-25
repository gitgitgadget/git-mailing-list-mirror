From: Ian Kumlien <pomac@vapor.com>
Subject: Re: [PATCH 2/2] index-pack: reduce memory usage when the pack has
 large blobs
Date: Sat, 25 Feb 2012 14:17:08 +0100
Message-ID: <20120225131708.GI9526@pomac.netswarm.net>
References: <1330086201-13916-1-git-send-email-pclouds@gmail.com>
 <1330086201-13916-2-git-send-email-pclouds@gmail.com>
 <20120224161613.GH9526@pomac.netswarm.net>
 <CACsJy8C-8dvXpNTU=JpdupSpS8OuqqTpGvDs6s1ASeKdk9d5Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 14:17:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1HVI-0007kr-Vu
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 14:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab2BYNRR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 08:17:17 -0500
Received: from mail.vapor.com ([83.220.149.2]:43733 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416Ab2BYNRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 08:17:16 -0500
Received: from twilight.demius.net (c-387a71d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.122.56])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id A92B92B6005;
	Sat, 25 Feb 2012 14:17:09 +0100 (CET)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id B01FC8E6935; Sat, 25 Feb 2012 14:17:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACsJy8C-8dvXpNTU=JpdupSpS8OuqqTpGvDs6s1ASeKdk9d5Dg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191534>

On Sat, Feb 25, 2012 at 08:49:55AM +0700, Nguyen Thai Ngoc Duy wrote:
> 2012/2/24 Ian Kumlien <pomac@vapor.com>:
> > Writing objects: 100% (1425/1425), 56.06 MiB | 4.62 MiB/s, done.
> > Total 1425 (delta 790), reused 1425 (delta 790)
> > fatal: Out of memory, malloc failed (tried to allocate 3310214315 b=
ytes)
> > fatal: Out of memory, malloc failed (tried to allocate 3310214315 b=
ytes)
> > fatal: Out of memory, malloc failed (tried to allocate 3310214315 b=
ytes)
> > fatal: Out of memory, malloc failed (tried to allocate 3310214315 b=
ytes)
> > To ../test_data/
> > =A0! [remote rejected] master -> master (missing necessary objects)
> > =A0! [remote rejected] origin/HEAD -> origin/HEAD (missing necessar=
y objects)
> > =A0! [remote rejected] origin/master -> origin/master (missing nece=
ssary objects)
> > error: failed to push some refs to '../test_data/'
> >
> > So there are additional code paths to look at... =3D(
>=20
> I can't say where that came from. Does this help? (Space damaged, may
> need manual application)

Everything has so far, since i'm using mainline to get the gzip fixes i=
n
;)

Anyway, with:
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 264e3ae..533081d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -183,7 +183,8 @@ static void show_object(struct object *obj,
        struct rev_list_info *info =3D cb_data;

        finish_object(obj, path, component, cb_data);
-       if (info->revs->verify_objects && !obj->parsed && obj->type !=3D=
 OBJ_COMMIT)
+       if (info->revs->verify_objects && !obj->parsed
+                       && obj->type !=3D OBJ_COMMIT && obj->type !=3D =
OBJ_BLOB)
                parse_object(obj->sha1);
        show_object_with_name(stdout, obj, path, component);
 }
---

I get:
=2E./git/git push --mirror ../test_data/
Counting objects: 1425, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (617/617), done.
Writing objects: 100% (1425/1425), 56.06 MiB | 4.22 MiB/s, done.
Total 1425 (delta 790), reused 1425 (delta 790)
error: index-pack died of signal 11
error: unpack failed: index-pack abnormal exit
To ../test_data/
 ! [remote rejected] master -> master (n/a (unpacker error))
 ! [remote rejected] origin/HEAD -> origin/HEAD (n/a (unpacker error))
 ! [remote rejected] origin/master -> origin/master (n/a (unpacker erro=
r))
error: failed to push some refs to '../test_data/'

Which, to me, means that the installed git is now the problem - it can'=
t verify=20
the pack and say that it's all ok ;)

I'll have to look some more at this on monday, or during the weekend if=
 i get too curious =3D)

=46or now, thank $deity that $company i work for allows VPN from Linux =
machines! It looks
really good, i wonder if there is further tests i should do - any clues=
?


> --=20
> Duy
