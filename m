Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2718AE3
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771905861; cv=none; b=Gw7jB27CH0Fgf8yhDCipzQDqZlDaYfT+20W7zp59PGR3ce/o1lFuM7OhfE+iXPzcdyDxuUvtz6rMBTDqUy6dPn29TX3bD7l2R2GugSgqHXC6KRyGqZp/cYw9TDrFWY+HjqDz6iU1d5RE+5PT0cv74rYsKUGvlpl1diOjW0nsHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771905861; c=relaxed/simple;
	bh=ETSdkdW3OEriaVrNAvB9N4miiGrNWvpbI4qpuEuUeM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvZ4dBbgSzREhFnl6zJl/b1E7x3lyrPVpQIEL330NIkgKabZ5LMxWQoFtmTeN5GKgHWhsDUPeOEzTQd9YXzhNT1m21575UIy2efGAOxs8tT40+rsWrp+cOOaVnth8t4/rTYDaiDpxpxl4sxdb2E+KAVvRPUfrfDjDAQ7WhsDhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=aCWs2pN9; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="aCWs2pN9"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771905856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28Gr8ZqCXRS5KpJZrTTXBtOr56JweqhGEkbVFHgfN8A=;
	b=aCWs2pN99/KYEiMya5RSbcVYwr2u1PdllbQw5j0Zx4NuAkPgXRIFa9lNZVkfRsM0XxVO+J
	dlBtVmZnAxKFvgBYQLd9mkbHAwBB8faNT9vW3BMvDKV1YdUuI0jPA0hAVJ24s+U/xnMBV1
	W6ZLLnDmcuAfl1tjdZAHmtKJCueTyEDno/7WqIohij4SOXCXnlm+uuTa8VyMrEr8KjVTya
	pSNtX2YCupDragiNMy7Fhs/LwbrdmSKO3BiKsCD3krhV8JjO6WE3Cs2u51SbNWouVQZ/kA
	Hn9og0sLC3+rqeiaQwow6Zb55FjIEx+wDFcJR4Gd5v6Mqn3m0zb2ta8wcFfF4A==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] pretty.c: fix null pointer dereference
Date: Tue, 24 Feb 2026 05:03:56 +0100
Message-ID: <20260224040400.751247-2-mroik@delayed.space>
In-Reply-To: <20260220230633.132213-1-mroik@delayed.space>
References: <20260220230633.132213-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=960; i=mroik@delayed.space; h=from:subject; bh=ETSdkdW3OEriaVrNAvB9N4miiGrNWvpbI4qpuEuUeM8=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnSLdxhHBuRndCvDZn4HZcumwF5jraSiBLbl0K i7QyYfV12yJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ0i3QAKCRBIeX6hnBm+ 0W3GEACh7JN5iEgt/2HE1vfKlsIjXpcT1f5mhlai8n+3erq5YIhwcp3ENqilS7hqZKRBwFl8qow W0U9ef4liktuqup0Ur4To3RIEo0PrvqdbEYtBNLnq3yRGlQcR6ajIm2tRy2NBmQD+iXU5NNrHTj vKAru0hQ5jNmc8ZSLaUbYP6IVf7wIMnJ6GQhJoaHY5tAsfIqeZ2qOVJ4CJSkkIDu9nexfUlTRuv UfqRsjCZG9RMD+ap7v9dyOdEQeXVUGNYPQhoRC1aKhS+i1FpDplvN3X+WXBM1MyQ0Yx+YDjeNix mHZ25ZHaM1edBLTDz2tdWRefwnPuziJUIZRNIhdyzGtGYBml83o+3tnt/9qG2K7dVToR3O1qs5g nuXTzHEGU529wSVaJaFXTsM681KU2be87CyIFsOPs5AapMDB1JjEs5dElvOHU/4DYU+NJNR0QIi wcz+FrQ+cQJqZtwzlHt3NazV+66rOLlie/0nw4+uyuRpfvx14nOyDJDLqYllGLlVlH4gPgxUbVe 3RovFKUZhCckmWJqT/Nerr9LphAblV/d/jY/5QKvCNMdenGd1qWVQV6keExz5IOlQDCKQgvq6fz Jm3SAITK9FwALhFQjj65X1NSa18SOZs9b8y6AgjivMtgwuNDEpX1osOLWXu+M/NCqjq49db3R9+ 5va9Pg63+TlOk2Q==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

commit_format_is_empty() is used to check whether "user_format" is set
to a value. Unfortunately this function crashes the program if no
user_format is set. This is because instead of checking for the pointer
value it checks for its dereferenced value, this being NULL if
user_format is not set.

Teach the proper condition to check if user_format is set.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 pretty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index e0646bbc5d..cdb8bf559d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -47,7 +47,7 @@ static struct cmt_fmt_map *find_commit_format(const char *sought);
 
 int commit_format_is_empty(enum cmit_fmt fmt)
 {
-	return fmt == CMIT_FMT_USERFORMAT && !*user_format;
+	return fmt == CMIT_FMT_USERFORMAT && !user_format;
 }
 
 static void save_user_format(struct rev_info *rev, const char *cp, int is_tformat)
-- 
2.53.0.4.geaa3cc5f7e

