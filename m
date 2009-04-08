From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Wed, 8 Apr 2009 13:28:54 +0200
Message-ID: <20090408112854.GA8624@atjola.homenet>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 13:30:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrVzI-0007KN-Qf
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 13:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbZDHL3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 07:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbZDHL3D
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 07:29:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:36999 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932317AbZDHL3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 07:29:00 -0400
Received: (qmail invoked by alias); 08 Apr 2009 11:28:57 -0000
Received: from i59F5B7E9.versanet.de (EHLO atjola.local) [89.245.183.233]
  by mail.gmx.net (mp010) with SMTP; 08 Apr 2009 13:28:57 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+3vuR6bOu38gGgLK74PiyqWuPab7W89/dEyGT5Xp
	yPcYGIzGXH1ktO
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116080>

The name of the processed object was duplicated for passing it to
add_object(), but that already calls path_name, which allocates a new
string anyway. So the memory allocated by the xstrdup calls just went
nowhere, leaking memory.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
This reduces the RSS usage for a "rev-list --all --objects" by about 10=
% on
the gentoo repo (fully packed) as well as linux-2.6.git:

gentoo:
		| old		| new	=09
----------------|-------------------------------
RSS		|	1537284 |	1388408
VSZ		|	1816852 |	1667952
time elapsed	|	1:49.62 |	1:48.99
min. page faults|	 417178 |	 379919

linux-2.6.git:
		| old		| new	=09
----------------|-------------------------------
RSS		|	 324452 |	 292996
VSZ		|	 491792 |	 460376
time elapsed	|	0:14.53 |	0:14.28
min. page faults|	  89360 |	  81613

 list-objects.c |    2 --
 reachable.c    |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index c8b8375..dd243c7 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -23,7 +23,6 @@ static void process_blob(struct rev_info *revs,
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 	obj->flags |=3D SEEN;
-	name =3D xstrdup(name);
 	add_object(obj, p, path, name);
 }
=20
@@ -78,7 +77,6 @@ static void process_tree(struct rev_info *revs,
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	obj->flags |=3D SEEN;
-	name =3D xstrdup(name);
 	add_object(obj, p, path, name);
 	me.up =3D path;
 	me.elem =3D name;
diff --git a/reachable.c b/reachable.c
index 3b1c18f..b515fa2 100644
--- a/reachable.c
+++ b/reachable.c
@@ -48,7 +48,6 @@ static void process_tree(struct tree *tree,
 	obj->flags |=3D SEEN;
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
-	name =3D xstrdup(name);
 	add_object(obj, p, path, name);
 	me.up =3D path;
 	me.elem =3D name;
--=20
1.6.2.2.446.gfbdc0.dirty
