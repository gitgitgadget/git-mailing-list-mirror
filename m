Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189B2F34
	for <git@vger.kernel.org>; Sat, 22 Jun 2024 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719031017; cv=none; b=fmyNuhrbSiRea2EJRuGTmH2MZ35QKHbUkiI/7+usLEMCblVXtN310a1QQ+mvgxX2Py7BfbrVkh0fe+v78Au9fwYa5rqmTdGAhSg4p4gt33oWq7VEXi/JUcRnzllKugIvEyYNMLfL3hthO5dlUL+/TfCKD/JRKUgPx++/+ISMzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719031017; c=relaxed/simple;
	bh=oc935lFVkoC0itx/ZCsoGIKJbfGQ++qxjM/3yxsynWs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FdN9CzAYt4DmHIhk5VrkfUb34shEey0N84qEPyz7JncnTozBwiSPre0f2CmeLaa2UMS3A5ZGgdIrLy75n/+ATbotiZSUvmGF/TqRkLgOGQLKAuwOMyPn/5X6Ll6QJDxbWfstn11ksve2DOyF1DUWXLHlEyaTw3jGlGzi75VJFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=gD6qExAb; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="gD6qExAb"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FEF1F7BE;
	Sat, 22 Jun 2024 04:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1719031008;
	bh=oc935lFVkoC0itx/ZCsoGIKJbfGQ++qxjM/3yxsynWs=;
	h=Date:From:To:Subject:From;
	b=gD6qExAbLQwqr5eRJs1tzjXkZpUBs/D4NP6nDR1sWxd8HUqzaKXLQoiNDwIzlr7qV
	 jvv7QYbvXZi9g98aAiFbAVsZ2seaNNlWwNJmrwxTKlSxLEABGDAJmlUTlGwE6lT+Lw
	 6BxcB0WgVGD3TEBzjSZvnwr26K6Mhpk0JXOGwpqQ=
Date: Sat, 22 Jun 2024 04:36:48 +0000
From: Eric Wong <e@80x24.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org
Subject: [PATCH] object-file: fix leak on conversion failure
Message-ID: <20240622043648.M78681@dcvr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I'm not sure exactly how to trigger the leak, but it seems fairly
obvious that the `content' buffer should be freed even if
convert_object_file() fails.  Noticed while working in this area
on unrelated things.

Signed-off-by: Eric Wong <e@80x24.org>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index d3cf4b8b2e..00c8f1039b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1711,9 +1711,9 @@ static int oid_object_info_convert(struct repository *r,
 			ret = convert_object_file(&outbuf,
 						  the_hash_algo, input_algo,
 						  content, size, type, !do_die);
+			free(content);
 			if (ret == -1)
 				return -1;
-			free(content);
 			size = outbuf.len;
 			content = strbuf_detach(&outbuf, NULL);
 		}
