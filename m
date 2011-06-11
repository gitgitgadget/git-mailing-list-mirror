From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/4] tag: speed up --contains calculation
Date: Sat, 11 Jun 2011 19:04:08 +0000
Message-ID: <1307819051-25748-2-git-send-email-avarab@gmail.com>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 21:05:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVTUy-0005hG-6B
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 21:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab1FKTF1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jun 2011 15:05:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41065 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab1FKTFX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 15:05:23 -0400
Received: by eyx24 with SMTP id 24so1229620eyx.19
        for <git@vger.kernel.org>; Sat, 11 Jun 2011 12:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=pJ0D2vExbW4RorQIrhVBgu+JD7ynPxSwwInddN8c1mI=;
        b=YnOopLSSRGGlag6HLlDGw0uzlF/knVzf/zvLmLhR/BDeei8cOE1kXVtN7liO7lf09s
         PZZFcvz+mqY0WxYMPuglkeUaOYeYlTrN9+4wI/Cz79r1hH2vJF2CJ8FZpMoG8I6jMJae
         MtbobvN6xFQyfGrWE4ZHqFOL/NQF2aTdV4hRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=b2gUVkX8nXNZLdAvHeucWcI+komlFAQ51ggw3WKxx/RD/5tCCFIPp8MXMqzlyWrEt/
         8EXHcvi1GTepjEZUUKYe+NBja/FNYN6wmOxD0ceARwv9U2ong4PXSIbXj/D3u1YomZcC
         zL1Y4j7vOw/FjkXIwfGSScWSUbUxBR+usoC7o=
Received: by 10.213.104.145 with SMTP id p17mr401220ebo.58.1307819122208;
        Sat, 11 Jun 2011 12:05:22 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id v76sm477161eea.17.2011.06.11.12.05.20
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Jun 2011 12:05:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <1307819051-25748-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175644>

=46rom: Jeff King <peff@peff.net>

When we want to know if commit A contains commit B (or any
one of a set of commits, B through Z), we generally
calculate the merge bases and see if B is a merge base of A
(or for a set, if any of the commits B through Z have that
property).

When we are going to check a series of commits A1 through An
to see whether each contains B (e.g., because we are
deciding which tags to show with "git tag --contains"), we
do a series of merge base calculations. This can be very
expensive, as we repeat a lot of traversal work.

Instead, let's leverage the fact that we are going to use
the same --contains list for each tag, and mark areas of the
commit graph is definitely containing those commits, or
definitely not containing those commits. Later tags can then
stop traversing as soon as they see a previously calculated
answer.

This sped up "git tag --contains HEAD~200" in the linux-2.6
repository from:

  real    0m15.417s
  user    0m15.197s
  sys     0m0.220s

to:

  real    0m5.329s
  user    0m5.144s
  sys     0m0.184s

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/tag.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index ec926fc..575a03c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -12,6 +12,8 @@
 #include "tag.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "diff.h"
+#include "revision.h"
=20
 static const char * const git_tag_usage[] =3D {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<he=
ad>]",
@@ -29,6 +31,48 @@ struct tag_filter {
 	struct commit_list *with_commit;
 };
=20
+static int in_commit_list(const struct commit_list *want, struct commi=
t *c)
+{
+	for (; want; want =3D want->next)
+		if (!hashcmp(want->item->object.sha1, c->object.sha1))
+			return 1;
+	return 0;
+}
+
+static int contains_recurse(struct commit *candidate,
+			    const struct commit_list *want)
+{
+	struct commit_list *p;
+
+	/* was it previously marked as containing a want commit? */
+	if (candidate->object.flags & TMP_MARK)
+		return 1;
+	/* or marked as not possibly containing a want commit? */
+	if (candidate->object.flags & UNINTERESTING)
+		return 0;
+	/* or are we it? */
+	if (in_commit_list(want, candidate))
+		return 1;
+
+	if (parse_commit(candidate) < 0)
+		return 0;
+
+	/* Otherwise recurse and mark ourselves for future traversals. */
+	for (p =3D candidate->parents; p; p =3D p->next) {
+		if (contains_recurse(p->item, want)) {
+			candidate->object.flags |=3D TMP_MARK;
+			return 1;
+		}
+	}
+	candidate->object.flags |=3D UNINTERESTING;
+	return 0;
+}
+
+int contains(struct commit *candidate, const struct commit_list *want)
+{
+	return contains_recurse(candidate, want);
+}
+
 static int show_reference(const char *refname, const unsigned char *sh=
a1,
 			  int flag, void *cb_data)
 {
@@ -47,7 +91,7 @@ static int show_reference(const char *refname, const =
unsigned char *sha1,
 			commit =3D lookup_commit_reference_gently(sha1, 1);
 			if (!commit)
 				return 0;
-			if (!is_descendant_of(commit, filter->with_commit))
+			if (!contains(commit, filter->with_commit))
 				return 0;
 		}
=20
--=20
1.7.5.3
