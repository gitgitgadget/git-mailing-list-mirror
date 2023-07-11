Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E89C001DD
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 13:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGKNbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 09:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGKNbj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 09:31:39 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE5134
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 06:31:38 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7659db6339eso257176685a.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689082297; x=1691674297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPYzoM17sHD3+wYIvOUeyntrh/VFb15Fp08NyNytHzo=;
        b=PH08nE/DraolQsEsYC1DUDITBXjROkD5XxM2Rgf0T5M/k4E2OhSFHsOiBPbwIzeK1U
         N35Xyl/0ynLCvdIBRJ7rf00fzqtg3lr9RwjIAs+v0KaxboGw+1hyoj3XslZS5tlvMyUx
         wIY2nHbuS+dRDBMT2BTtpoifYpzrp+8GHBnDXGK8EEPwBossq9gRz8U3jdEBUsB8TooG
         sgziWHpuWMtprrAH8Y9LM7m0HiFLH0uSO63Gy1QShCjs9CZhfvYCdONIvd2LDjOG8XVs
         hQIUGmI6qi3X44zc9pa/UxlFvoMub5vQFwBiqyhRQ9zyva+xvlxCwnmqbyqt5+mL3z4T
         oN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689082297; x=1691674297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPYzoM17sHD3+wYIvOUeyntrh/VFb15Fp08NyNytHzo=;
        b=Oc2ll5+IgFsa9w13aYLU+JotaxXIQouTPWHjnMqnd9Nu2ly7v2h0ZdVByaQgB6OQr4
         BhFMWQqcnBgpOajtwx6U3iLBDfe6bmTIdC4MjblEXiH9+sY1HJMY2tFcXvxUOISu4hNh
         qZ3fDn2jcyj7LczE7q1j+d85JOnbKC02yFJjiUcXbqHQGBeeDT7Wn7nKLV9aHG1+IM0S
         b81yLYua/gg8M9N2ISr7IL/abKqWwq2ltshub6IGgTe+lGP0cMMYiK85Uuv524JBC2Rl
         3e8wMLBIBDPbquX3LKdk4Ai+avseKoT4W8eolKM+mBTU+ItKV2kj/u3f+0zyDEY7RHDa
         lPiQ==
X-Gm-Message-State: ABy/qLZhjAifAD2knIjxoDCErYc1Sj4Y1nwm/JPg7bapNpLQx1BN38HW
        0dY7oOTxpefm8DXQFIF6gQEWdv6sdWpatQ==
X-Google-Smtp-Source: APBJJlG6QgkAh9TuanQHPk+wH2XZjk8A8oeIAvcN7le2KYmQo6A3qeZ7HzdgK8ZqL5W1XH985h9xng==
X-Received: by 2002:a05:620a:44c3:b0:765:890b:7586 with SMTP id y3-20020a05620a44c300b00765890b7586mr22112687qkp.29.1689082297137;
        Tue, 11 Jul 2023 06:31:37 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id oq5-20020a05620a610500b00766fbeb3e7csm966010qkn.132.2023.07.11.06.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:31:36 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v3 1/3] attr.c: read attributes in a sparse directory
Date:   Tue, 11 Jul 2023 09:30:33 -0400
Message-Id: <20230711133035.16916-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230711133035.16916-1-cheskaqiqi@gmail.com>
References: <20230707151839.504494-1-cheskaqiqi@gmail.com>
 <20230711133035.16916-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git check-attr' cannot currently find attributes of a file within a
sparse directory. This is due to .gitattributes files are irrelevant in
sparse-checkout cone mode, as the file is considered sparse only if all
paths within its parent directory are also sparse. In addition,
searching for a .gitattributes file causes expansion of the sparse
index, which is avoided to prevent potential performance degradation.

However, this behavior can lead to missing attributes for files inside
sparse directories, causing inconsistencies in file handling.

To resolve this, revise 'git check-attr' to allow attribute reading for
files in sparse directories from the corresponding .gitattributes files:

1.Utilize path_in_cone_mode_sparse_checkout() and index_name_pos_sparse
to check if a path falls within a sparse directory.

2.If path is inside a sparse directory, employ the value of
index_name_pos_sparse() to find the sparse directory containing path and
path relative to sparse directory. Proceed to read attributes from the
tree OID of the sparse directory using read_attr_from_blob().

3.If path is not inside a sparse directory，ensure that attributes are
fetched from the index blob with read_blob_data_from_index().

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 attr.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/attr.c b/attr.c
index 7d39ac4a29..be06747b0d 100644
--- a/attr.c
+++ b/attr.c
@@ -808,35 +808,44 @@ static struct attr_stack *read_attr_from_blob(struct index_state *istate,
 static struct attr_stack *read_attr_from_index(struct index_state *istate,
 					       const char *path, unsigned flags)
 {
+	struct attr_stack *stack = NULL;
 	char *buf;
 	unsigned long size;
+	int pos;
 
 	if (!istate)
 		return NULL;
 
 	/*
-	 * The .gitattributes file only applies to files within its
-	 * parent directory. In the case of cone-mode sparse-checkout,
-	 * the .gitattributes file is sparse if and only if all paths
-	 * within that directory are also sparse. Thus, don't load the
-	 * .gitattributes file since it will not matter.
-	 *
-	 * In the case of a sparse index, it is critical that we don't go
-	 * looking for a .gitattributes file, as doing so would cause the
-	 * index to expand.
+	 * If the pos value is negative, it means the path is not in the index. 
+	 * However, the absolute value of pos minus 1 gives us the position where the path 
+	 * would be inserted in lexicographic order. By subtracting another 1 from this 
+	 * value (pos = -pos - 2), we find the position of the last index entry 
+	 * which is lexicographically smaller than the provided path. This would be 
+	 * the sparse directory containing the path.
 	 */
-	if (!path_in_cone_mode_sparse_checkout(path, istate))
-		return NULL;
+	pos = index_name_pos_sparse(istate, path, strlen(path));
+	pos = - pos - 2;
 
-	buf = read_blob_data_from_index(istate, path, &size);
-	if (!buf)
-		return NULL;
-	if (size >= ATTR_MAX_FILE_SIZE) {
-		warning(_("ignoring overly large gitattributes blob '%s'"), path);
-		return NULL;
-	}
+	if (!path_in_cone_mode_sparse_checkout(path, istate) && 0 <= pos) {
+		if (!S_ISSPARSEDIR(istate->cache[pos]->ce_mode))
+			return NULL;
 
-	return read_attr_from_buf(buf, path, flags);
+		if (strncmp(istate->cache[pos]->name, path, ce_namelen(istate->cache[pos])) == 0) {
+			const char *relative_path = path + ce_namelen(istate->cache[pos]);  
+			stack = read_attr_from_blob(istate, &istate->cache[pos]->oid, relative_path, flags);
+		}
+	} else {
+		buf = read_blob_data_from_index(istate, path, &size);
+		if (!buf)
+			return NULL;
+		if (size >= ATTR_MAX_FILE_SIZE) {
+			warning(_("ignoring overly large gitattributes blob '%s'"), path);
+			return NULL;
+		}
+		stack = read_attr_from_buf(buf, path, flags);
+	}
+	return stack;
 }
 
 static struct attr_stack *read_attr(struct index_state *istate,
-- 
2.39.0

