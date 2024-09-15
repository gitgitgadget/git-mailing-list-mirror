Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D622334
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726438635; cv=none; b=AevsQAeuX7rdlj1gH8/0l6k48SkTIT0x4Ypn3fyi98vG+9M6yvoLYagdDZg91D+dtqK9ItO//okS9BLKQOO2Lpt4pYn1Ct04cL8WUldSV7xY0p3KQ5o3uDnr+ejVc8r8gjaPdLs1S+D6glMkttqKrfxcvGDsatUq5FqsRwtxR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726438635; c=relaxed/simple;
	bh=MdBKKEFRZz6FqCgUgiZDREwHJT5dcAZX4+sshJO+PU0=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=uWSJh5LyglTZdObkJ9/mFckkfJ7FNI5eJL0A6s/sJ/CppVBkgZouvkUnT8Wx+qsbxQshfxQ1dj65rEp1U6h9UtLgueENK8ycPfGBgLGnZF7cUOjDtjQhX0MBwMSMu8blac88Y/TR7SAXZ0lx0NQITe1mEVkFO0JoVMqj5RcE1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=eLAZo28m; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="eLAZo28m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=2CMemVOza8I3frPnQK7JPHh6baO/huG6ZNyRELkMFLA=;
 b=eLAZo28mienMwj94Zr537SuYJPu2LDyOnIQVdnReYSrfA8/N3oTL1IytKzO3tl6ZZi6JsVoXfs4S
   UxgtgN4p+FdmUjzeVQtSh9B7u1qejEUOqiCeQ4s5qN5TyuoMkZ9ltvKbSIF1RSm2bGIaV3UN57KO
   PDgUtOCXUp9GH4VJU3HiG8/LkCa4A2WKU6SrgC1wRCo/nJ2bHO3VE/vDVNENzKjb26EVQkLWrAVJ
   3yvyzIxxHyguWfIL5oaf1suaVexx4okLAIZeDXS55SN50dYY7k/3H2hBwl99nSgm11y/FZ2t11gE
   /kN3rwznsjv9yn/gx5yOImzfsM73FgXcLj85WQ==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJV00BS2KC48Y90@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 15 Sep 2024 22:12:04 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,	Christian Schlack <christian@backhub.co>,
	Jeff King <peff@peff.net>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v3] set-head: no update without change and better output for
 --auto
Date: Mon, 16 Sep 2024 00:09:54 +0200
Message-id: <20240915221055.904107-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFMVAX37FWqw6InH04EkN/ZoR9LNbOILQYs91DV/m+9UCvXTuMZAxlSt4ynbZjr
 /NFk0oyc9eInZjnypTOaHlhz/ICQkbxyjYluNucA4z7AooGc9NavAPiG0HQFjbv9
 BWGzoBpBOTi+V1C1z4bcjhHQcVRWJWJni5c3EJ2He3aMExW5rOqS3YTiAh1YXcEX
 QXiItSI355+O1ix7GxI8ZV9ghEd37CLqk3wCayqGUE9Ejeeym86shiocwFUe4FRP
 Jw2ToeO+kq1McK7b0MZ9hhUCQuO+SEXbo5d0OvGEPZrdTGKhEXFU5HIMSUhcmeoT
 0aW3j8KaHLGq+jGCOGE/I4/F8plB7rkZvskLyRCk5oA6ANGEQWsA6r5KLizbztKk
 hrISGzUWp+bUBRhK/jbQglrSO5b0yWd/VcJMXnuObqynJNRcHKR3+elJT+S/GzJ1
 3HuXO5Gl+DymjHpLc3fs6TIxyblAF/QcyNsNVoFDIAqS8YQ8DCKlWv9m

Currently, even if there is no actual change to remote/HEAD calling
remote set-head will overwrite the appropriate file and if set to --auto
will also print a message saying "remote/HEAD set to branch", which
implies something was changed.

Change the behaviour of remote set-head so that the reference is only
updated if it actually needs to change.

Change the output of --auto, so the output actually reflects what was
done: a) set a previously unset HEAD, b) change HEAD because remote
changed or c) no updates. Make the output easily parsable, by using
a slightly clunky wording that allows all three outputs to have the same
structure and number of words.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v1-v2:
    
        was RFC in https://lore.kernel.org/git/20240910203835.2288291-1-bence@ferdinandy.com/
    
    v3:
    
        This patch was originally sent along when I thought set-head was
        going to be invoked by fetch, but the discussion on the RFC
        concluded that it should be not. This opened the possibility to make
        it more explicit.
    
        Note: although I feel both things the patch does are really just
        cosmetic, an argument could be made for breaking it into two, one
        for the no-op part and one for the --auto print update.

 builtin/remote.c  | 14 ++++++++++----
 t/t5505-remote.sh |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 0acc547d69..4b116dfc19 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1400,8 +1400,8 @@ static int show(int argc, const char **argv, const char *prefix)
 
 static int set_head(int argc, const char **argv, const char *prefix)
 {
-	int i, opt_a = 0, opt_d = 0, result = 0;
-	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	int i, opt_a = 0, opt_d = 0, is_ref_changed = 0, result = 0;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
 	char *head_name = NULL;
 
 	struct option options[] = {
@@ -1440,13 +1440,19 @@ static int set_head(int argc, const char **argv, const char *prefix)
 
 	if (head_name) {
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
+		refs_read_symbolic_ref(get_main_ref_store(the_repository),buf.buf,&buf3);
+		is_ref_changed = strcmp(buf2.buf,buf3.buf);
 		/* make sure it's valid */
 		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
+		else if (is_ref_changed && refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
 			result |= error(_("Could not setup %s"), buf.buf);
+		else if (opt_a && !strcmp(buf3.buf,""))
+			printf("%s/HEAD was unset: set to %s\n", argv[0], head_name);
+		else if (opt_a && is_ref_changed)
+			printf("%s/HEAD was changed: set to %s\n", argv[0], head_name);
 		else if (opt_a)
-			printf("%s/HEAD set to %s\n", argv[0], head_name);
+			printf("%s/HEAD was unchanged: set to %s\n", argv[0], head_name);
 		free(head_name);
 	}
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 532035933f..6b61f043d3 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -434,7 +434,7 @@ test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
-		echo "two/HEAD set to main" >expect &&
+		echo "two/HEAD was unset: set to main" >expect &&
 		test_cmp expect output
 	)
 '
-- 
2.46.1.507.g531a0ea24e.dirty

