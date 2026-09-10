Received: from send127.i.mail.ru (send127.i.mail.ru [89.221.237.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C08397958
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030456; cv=none; b=JmEf80fDaJZ1nLtptWAaXVIUi35BGTBULmmlK74hjC78M9KVvZCD6CubEGzwP6d89IWOQzURPYWZKpKnfjNw7t6ji7PornoH6ZzB85pfKc4+VGx4Pbs4H0lKE4uWHcDMZ0cGLWratGbBoPlc4qmF/eryLo3dF3jpEGy8gjADQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030456; c=relaxed/simple;
	bh=Fxu5lXICN/2fW6gO1hbO+pUkQqmX55s/xVMEBi+Mj/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXJY3pHtjZWO+vgpz265wAt0OI969ZA8G0cSt718JYUHLHhncatrdP+DRQcDbfNP3mnnQrZJ483Xb5G5phWzQutozD/7aJoozve3KjfLq9aWF4/NDWWf1+FdRBMm70xP+tERFzzknMvx0v3lOgeFw7k57TBQr1g8OprWskmqpbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=SC7+E0Xt; arc=none smtp.client-ip=89.221.237.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="SC7+E0Xt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=nw5acM3kb58GLQFP62ZgPhJRlRHHAlcChwonwVXPBbI=; t=1789030453; x=1789120453; 
	b=SC7+E0XtMM+PQq0pUb7Lc/WotFzPLLzLtHpvuyFT/kfAb6iODW5if5P2Sx/Nj768RNQx6Yo1Jtr
	2PbNoib8pt8+lFwu5bbL5suRT4CDvu5Yaoe1ssJWS7Q0nxTspFIdQqrOUjw/pVr2QWUeDj420cvPw
	x10Z3OY5ruSQusKL0h/X8RMgGg5QB3dw66vhLgqnHoTDp3syrwSFqNuWSA0sxBbyr4kJOU0ahq7bD
	9cyUWYoTlZseQwqLA+xw3E7bH4fFepIrfXUQoj5SeEfBeCufiP+rcZ83xX5MqbT1JLZYC7dM6jC+7
	40vfsQ6TMXrT43Eb9kmgKLYpEaEgs5qe8j4A==;
Received: by exim-smtp-569b45c49c-jnnrz with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x4aXk-00000000NGh-2pYF; Thu, 10 Sep 2026 11:54:05 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id E3CE99F60D;
	Thu, 10 Sep 2026 11:54:03 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: git@vger.kernel.org
Cc: ub4nal@mail.ru,
	ben.knoble@gmail.org,
	gitster@pobox.me,
	peff@peff.net
Subject: [PATCH v4 2/3] advice: introduce advice scoping mechanism
Date: Thu, 10 Sep 2026 11:53:52 +0300
Message-ID: <20260910085353.109373-3-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260910085353.109373-1-ub4nal@mail.ru>
References: <20270829004959.90983-1-ub4nal@mail.ru>
 <20260910085353.109373-1-ub4nal@mail.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-569b45c49c-jnnrz; auth=pass smtp.auth=ub4nal@mail.ru smtp.mailfrom=ub4nal@mail.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9E52C9190B278547F3E9EC0952131F526FBC1A4C679E9DA31182A05F5380850404C228DA9ACA6FE27E4C0CDCB46A5212A3DE06ABAFEAF6705781C72472C2EDF811964E60332344D73333BECB3000124C7
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE755BE8F535441E38CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566A08549CA5D964761D42379AD1C95F06F9089AB6642E4212F01E31807D95DE25A8EEF46B7454FC60B9742502CCDD46D0DD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249E232F00D8D26902CA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18BDFBBEFFF4125B51D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA94AAC223A686B1DECD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE362B3BD3CC35DA5882D242C3BD2E3F4C6C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006372BF47D31460A3964EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5EA87D2A8BAAEC2CA5002B1117B3ED6965D0EB24A19E8B9DAED71F038FC0469933610D81D389A125CDE35189EBF2DEA281E618B5D5F965AFD1BF51D96AE4B494FB2D1C9E48B6DC60AE2A7E19323554B12787CBDA4B9FA07ACC6EC20BF4CFA3F444EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34CAB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659F3D561E54C29ECAC15A2B825D0B20235A3160A59B1F61992CFD001C7669BDF94689EAF2EA6462E69B8341EE9D5BE9A0A0E473B2F1CC67542DC2AF3379F0A3F45D662C85EE5227C67C7CEAA0681F5848F4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWFpuP5d0Zh5am5/lFOSIJYM=
X-Mailru-Sender: 288943BA7BCC8BBA2C509D5366AED3E5B676C78F813EF362CC811723C208B41711A4D294405B80565615BDA9201AF9813B7E521F6A5800A996940349D467AF430D26F6DE3BAD3FFE4DFFA654C60F801316CD019DBEDFC45331DC91172AC7F52EF91D4A7208CD43CE3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok

The advice settings currently do not distinguish between configuration
scopes. Add a scope hint to advice_setting so that an advice can
recommend a specific configuration scope when disabling it.

Use the existing enum config_scope to represent the scope, with
CONFIG_SCOPE_UNKNOWN indicating that the default configuration scope
should be used.

Signed-off-by: Vsevolod Myalitsin <ub4nal@mail.ru>
---
 advice.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index b556c8b38e..12a68ea716 100644
--- a/advice.c
+++ b/advice.c
@@ -42,6 +42,7 @@ enum advice_level {
 
 struct advice_setting {
 	const char *key;
+	enum config_scope scope_hint;
 	enum advice_level level;
 };
 
@@ -96,9 +97,16 @@ static struct advice_setting advice_setting[] = {
 	[ADVICE_WORKTREE_ADD_ORPHAN]			= { "worktreeAddOrphan" },
 };
 
+/*
+ * TRANSLATORS: This is a command line that the user should run.
+ *              Do not translate the part inside double quotes.
+ *              The first %s is the config scope (e.g. " --global"),
+ *              the second %s is the advice key (e.g. "defaultBranchName").
+ */
+
 static const char turn_off_instructions[] =
 N_("\n"
-   "Disable this message with \"git config set advice.%s false\"");
+   "Disable this message with \"git config set%s advice.%s false\"");
 
 static void vadvise(const char *advice,
 	const struct advice_setting *setting, va_list params)
@@ -109,8 +117,21 @@ static void vadvise(const char *advice,
 	strbuf_vaddf(&buf, advice, params);
 
 	if (setting && setting->level == ADVICE_LEVEL_NONE) {
+		const char *scope = "";
+		switch (setting->scope_hint) {
+		case CONFIG_SCOPE_LOCAL:
+		case CONFIG_SCOPE_UNKNOWN:
+			break;
+		case CONFIG_SCOPE_GLOBAL:
+			scope = " --global";
+			break;
+		case CONFIG_SCOPE_SYSTEM:
+			scope = " --system";
+			break;
+		}
 		strbuf_addf(&buf, turn_off_instructions,
-					setting->key);
+				scope, setting->key);
+	}
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
-- 
2.50.1

