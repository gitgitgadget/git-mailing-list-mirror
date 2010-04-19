From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] fix "bundle --stdin" segfault
Date: Mon, 19 Apr 2010 03:03:40 -0500
Message-ID: <20100419080340.GB23609@progeny.tock>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100419071449.GA23166@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 10:03:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3lxK-0006hj-K2
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 10:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab0DSIDf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 04:03:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63625 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab0DSIDb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 04:03:31 -0400
Received: by pwj9 with SMTP id 9so3122183pwj.19
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WaN2YxSGA8/5zcSdHkVHypakE4kaYCY9wsBgDCKrTr0=;
        b=hViEzhnvNwJubtHaE0I9+S9BU/rI4W9l5Z9rp2BoxmivACE4uBBNtw+7W0iMqt+t2o
         oEzO2dPyQ7RVWqYZn6Xd2tBjAkrZvn6N10KLjbz0HTFjLpo+ObJFXaxkMQBwlZjABikX
         WA0W2wODzMLQxpzZZbEgZb9xfaYaM4Q7BVg5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LccV4VnasKnil4/Ck6aInpv67Z1JB3gSb6M8z1xjseK+P7LMrUno/r0OH05jZ9w66c
         O6e5ll+rTyi22bndlx+eEpc/8X3FxAUNtdtBIFWTc0/JbWPpoLixpQOeip2jKTRRg8Sl
         Ua446c319GEhbKOp9Ic7+faFfgl6mOHNF9D4s=
Received: by 10.141.14.12 with SMTP id r12mr2412716rvi.94.1271664210465;
        Mon, 19 Apr 2010 01:03:30 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4756247iwn.14.2010.04.19.01.03.29
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 01:03:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100419071449.GA23166@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145276>

When passed an empty list, objects_array_remove_duplicates() corrupts
it by changing the number of entries from 0 to 1.

The problem lies in the condition of its main loop:

	for (ref =3D 0; ref < array->nr - 1; ref++) {

The loop body manipulates the supplied object array.  In the case of
an empty array, it should not be doing anything at all.  But array->nr
is an unsigned quantity, so the code enters the loop, in particular
increasing array->nr.  Fix this by comparing (ref + 1 < array->nr)
instead.

This bug can be triggered by git bundle --stdin:

	$ echo HEAD | git bundle create some.bundle --stdin=E2=80=99
	Segmentation fault (core dumped)

The list of commits to bundle appears to be empty because of another
bug: by the time the revision-walking machinery gets to look at it,
standard input has already been consumed by rev-list, so
=2E..remove_duplicates() gets an empty list of revisions.

After this patch, git bundle --stdin still does not work; it just
doesn=E2=80=99t segfault any more.

Reported-by: Joey Hess <joey@kitenet.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 3ca92c4..277b3dd 100644
--- a/object.c
+++ b/object.c
@@ -252,10 +252,10 @@ void add_object_array_with_mode(struct object *ob=
j, const char *name, struct obj
=20
 void object_array_remove_duplicates(struct object_array *array)
 {
-	int ref, src, dst;
+	unsigned int ref, src, dst;
 	struct object_array_entry *objects =3D array->objects;
=20
-	for (ref =3D 0; ref < array->nr - 1; ref++) {
+	for (ref =3D 0; ref + 1 < array->nr; ref++) {
 		for (src =3D ref + 1, dst =3D src;
 		     src < array->nr;
 		     src++) {
--=20
1.7.1.rc1
