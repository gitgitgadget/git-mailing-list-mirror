From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Fri, 10 Apr 2009 15:20:18 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain>
References: <20090408112854.GA8624@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 00:28:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsPCv-00008m-8n
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 00:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875AbZDJW0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Apr 2009 18:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758041AbZDJW0s
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 18:26:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42988 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756723AbZDJW0r (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 18:26:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3AMKKYp032520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Apr 2009 15:20:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3AMKIYU020387;
	Fri, 10 Apr 2009 15:20:19 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090408112854.GA8624@atjola.homenet>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.445 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116281>



On Wed, 8 Apr 2009, Bj=F6rn Steinbrink wrote:
>
> The name of the processed object was duplicated for passing it to
> add_object(), but that already calls path_name, which allocates a new
> string anyway. So the memory allocated by the xstrdup calls just went
> nowhere, leaking memory.

Ack, ack.

There's another easy 5% or so for the built-in object walker: once we'v=
e=20
created the hash from the name, the name isn't interesting any more, an=
d=20
so something trivial like this can help a bit.

Does it matter? Probably not on its own. But a few more memory saving=20
tricks and it might all make a difference.

		Linus

---
 builtin-pack-objects.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9fc3b35..d00eabe 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1912,6 +1912,8 @@ static void show_object(struct object_array_entry=
 *p)
 	add_preferred_base_object(p->name);
 	add_object_entry(p->item->sha1, p->item->type, p->name, 0);
 	p->item->flags |=3D OBJECT_ADDED;
+	free(p->name);
+	p->name =3D NULL;
 }
=20
 static void show_edge(struct commit *commit)
