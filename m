From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] index-pack: correctly initialize appended objects
Date: Fri, 25 Jul 2008 19:13:15 +0200
Message-ID: <20080725171315.GA27285@atjola.homenet>
References: <alpine.DEB.1.00.0807251513240.11976@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	spearce@spearce.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 19:14:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQs0-0003gt-DQ
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 19:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbYGYRNT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 13:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYGYRNT
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 13:13:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:55128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751611AbYGYRNS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 13:13:18 -0400
Received: (qmail invoked by alias); 25 Jul 2008 17:13:17 -0000
Received: from i577BBE25.versanet.de (EHLO atjola.local) [87.123.190.37]
  by mail.gmx.net (mp064) with SMTP; 25 Jul 2008 19:13:17 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18xGX8oMAsxiRxBTb0ac8gsWxR/bWlbTqF5hRy2lZ
	GWZAFABKp9lAgN
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807251513240.11976@eeepc-johanness>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90075>

When index-pack completes a thin pack it appends objects to the pack.
Since the commit 92392b4(index-pack: Honor core.deltaBaseCacheLimit whe=
n
resolving deltas) such an object can be pruned in case of memory pressu=
re.

To be able to re-read the object later, a few more fields have to be se=
t.

Noticed by Pierre Habouzit.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
Acked-by: Nicolas Pitre <nico@cam.org>
---

    On 2008.07.25 15:15:48 +0200, Johannes Schindelin wrote:
    > So, let's add the comment as Nico suggested, and set real_type,
    > too?

    OK, I hope the comment is what was expected. My lack of knowledge
    made we wonder what to write... :-/

    > (And it would be smashing if you could verify that the type is
    > indeed correctly set to non-delta...)

    Hm, we get the object via read_sha1_file, can that return a delta? =
I
    would not expect it to.  Sorry, never looked at those code paths
    (and don't have the time to investigate at the moment).

 index-pack.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index ac20a46..d757b07 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -699,6 +699,12 @@ static struct object_entry *append_obj_to_pack(
 	write_or_die(output_fd, header, n);
 	obj[0].idx.crc32 =3D crc32(0, Z_NULL, 0);
 	obj[0].idx.crc32 =3D crc32(obj[0].idx.crc32, header, n);
+	// This object comes from outside the thin pack, so we need to
+	// initialize the size and type fields
+	obj[0].hdr_size =3D n;
+	obj[0].size =3D size;
+	obj[0].type =3D type;
+	obj[0].real_type =3D type;
 	obj[1].idx.offset =3D obj[0].idx.offset + n;
 	obj[1].idx.offset +=3D write_compressed(output_fd, buf, size, &obj[0]=
=2Eidx.crc32);
 	hashcpy(obj->idx.sha1, sha1);
--=20
1.6.0.rc0.14.g95f8.dirty
