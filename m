From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] vcs-svn: Fix 'fa/remote-svn' and 'fa/vcs-svn' in pu
Date: Thu, 23 Aug 2012 18:55:39 +0100
Message-ID: <50366E9B.7040803@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: florian.achleitner.2.6.31@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 23 19:59:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4bgO-00036S-3Z
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 19:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759157Ab2HWR66 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Aug 2012 13:58:58 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:33438 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756161Ab2HWR64 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 13:58:56 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 8FC12AC406D;
	Thu, 23 Aug 2012 18:58:54 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])	by mdfmta004.tch.inty.net (Postfix) with ESMTP id D21D2AC406C;	Thu, 23 Aug 2012 18:58:52 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tch.inty.net (Postfix) with ESMTP;	Thu, 23 Aug 2012 18:58:51 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204162>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Florian,

The build on pu is currently broken:

        CC remote-testsvn.o
        LINK git-remote-testsvn
    cc: vcs-svn/lib.a: No such file or directory
    make: *** [git-remote-testsvn] Error 1

This is caused by a dependency missing from the git-remote-testsvn
link rule. The addition of the $(VCSSVN_LIB) dependency, which should
be squashed into commit ea1f4afb ("Add git-remote-testsvn to Makefile",
20-08-2012), fixes the build.

However, this leads to a failure of test t9020.5 and (not unrelated)
compiler warnings:

        CC vcs-svn/svndump.o
    vcs-svn/svndump.c: In function =91handle_node=92:
    vcs-svn/svndump.c:246: warning: left shift count >=3D width of type
    vcs-svn/svndump.c:345: warning: format =91%lu=92 expects type =91lo=
ng \
        unsigned int=92, but argument 3 has type =91uintmax_t=92

The fix for the shift count warning is to cast the lhs of the shift
expression to uintmax_t. The format warning is fixed by using the
PRIuMAX format macro. These fixes should be squashed into commit
78d9d4138 ("vcs-svn/svndump: rewrite handle_node(), begin|end_revision(=
)",
20-08-2012).

HTH

ATB,
Ramsay Jones

 Makefile          | 2 +-
 vcs-svn/svndump.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 9cede84..761ae05 100644
--- a/Makefile
+++ b/Makefile
@@ -2356,7 +2356,7 @@ git-http-push$X: revision.o http.o http-push.o GI=
T-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
=20
-git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS)
+git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN=
_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(LIBS) \
 	$(VCSSVN_LIB)
=20
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 28ce2aa..eb97e8e 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -243,7 +243,7 @@ static void handle_node(struct node_ctx_t *node)
 	const char *old_data =3D NULL;
 	uint32_t old_mode =3D REPO_MODE_BLB;
 	struct strbuf sb =3D STRBUF_INIT;
-	static uintmax_t blobmark =3D 1UL << (bitsizeof(uintmax_t) - 1);
+	static uintmax_t blobmark =3D (uintmax_t) 1UL << (bitsizeof(uintmax_t=
) - 1);
=20
=20
 	if (have_text && type =3D=3D REPO_MODE_DIR)
@@ -342,7 +342,7 @@ static void handle_node(struct node_ctx_t *node)
 						node->text_length, &input);
 			}
=20
-			strbuf_addf(&sb, ":%lu", blobmark);
+			strbuf_addf(&sb, ":%"PRIuMAX, blobmark);
 			node->dataref =3D sb.buf;
 		}
 	}
--=20
1.7.12
