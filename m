From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: =?UTF-8?q?=5BPATCH=5D=20config=3A=20don=27t=20segfault=20when=20given=20--path=20with=20a=20missing=20value?=
Date: Thu, 15 Nov 2012 10:10:01 -0800
Message-ID: <1353003001-22600-1-git-send-email-cmn@elego.de>
References: <20121115161758.GC6157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 19:10:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ3tu-0002fr-8i
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 19:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768636Ab2KOSKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 13:10:40 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:60536 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1768597Ab2KOSKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 13:10:40 -0500
Received: from cmartin.tk (204-16-157-26-static.ipnetworksinc.net [204.16.157.26])
	by hessy.dwim.me (Postfix) with ESMTPA id C180681546;
	Thu, 15 Nov 2012 19:10:36 +0100 (CET)
Received: (nullmailer pid 22635 invoked by uid 1000);
	Thu, 15 Nov 2012 18:10:01 -0000
X-Mailer: git-send-email 1.8.0.316.g291341c
In-Reply-To: <20121115161758.GC6157@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209837>

When given a variable without a value, such as '[section] var' and
asking git-config to treat it as a path, git_config_pathname returns
an error and doesn't modify its output parameter. show_config assumes
that the call is always successful and sets a variable to indicate
that vptr should be freed. In case of an error however, trying to do
this will cause the program to be killed, as it's pointing to memory
in the stack.

Detect the error and return immediately to avoid freeing or accessing
the uninitialed memory in the stack.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

---

On Thu, Nov 15, 2012 at 08:11:50AM -0800, Jeff King wrote:

> Hmm, actually, we should probably propagate the error (I was thinking
> for some reason this was in the listing code, but it is really about
> getting a specific variable, and that variable does not have a sane
> format. We'll already have printed the non-bool error, so we should
> probably die. So more like:
>=20
>   if (git_config_pathname(&vptr, key_, value_) < 0)
>           return -1;
>   must_free_vptr =3D 1;

Yeah, that's more sensible. I didn't notice that the buffer never gets
written to in this codepath, and the trying to print it out is silly
when we know that there is nothing valid to print. Thanks for the
review. I've included your test as well, which really makes all of
this your code. Do we have some equivalent of a Basically-writen-by
line?

 builtin/config.c       | 3 ++-
 t/t1300-repo-config.sh | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 442ccc2..4dc5ffa 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -129,7 +129,8 @@ static int show_config(const char *key_, const char=
 *value_, void *cb)
 		else
 			sprintf(value, "%d", v);
 	} else if (types =3D=3D TYPE_PATH) {
-		git_config_pathname(&vptr, key_, value_);
+		if (git_config_pathname(&vptr, key_, value_) < 0)
+			return -1;
 		must_free_vptr =3D 1;
 	} else if (value_) {
 		vptr =3D value_;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index a477453..17272e0 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -803,6 +803,11 @@ test_expect_success NOT_MINGW 'get --path copes wi=
th unset $HOME' '
 	test_cmp expect result
 '
=20
+test_expect_success 'get --path barfs on boolean variable' '
+	echo "[path]bool" >.git/config &&
+	test_must_fail git config --get --path path.bool
+'
+
 cat > expect << EOF
 [quote]
 	leading =3D " test"
--=20
1.8.0.316.g291341c
