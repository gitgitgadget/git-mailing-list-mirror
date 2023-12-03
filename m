Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kySDCokO"
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6629A1
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:39:28 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b8b5f54ba1so562819b6e.0
        for <git@vger.kernel.org>; Sun, 03 Dec 2023 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701610767; x=1702215567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1AT2OIsrXycQl4aHQAwKNZ0NUGOGDU/1vmP5aDNm0Q=;
        b=kySDCokO3q05qhNWBUcIbg+XAr0LuN3WZWU5Cmbj6Ock0XJ/XqHHLKNqz2jbCo7WCj
         NKmFj3jmiRPjsPT0/7mvpn0vlPpHy9EFeduuPocN4rB233x5Wy6Eiupa5xJaPPuc75NN
         fog6lDSZwhKUGgppZsvgHg9to17M7KMSe95qe7htJczrtv22v2aNrv6w1fJlNSYwe9+Y
         MKGz4P6tKELLeq8Nyzl6n7weiFxXWuW2CN1gMhA9SFLux8rh6oibzKUry1+4eqm+TrJd
         88yxlVupltaHy/JM8RZnKk6lIPMXxc8o8oAs7o4UY+i9/+5tTYo9dqlxD+phb9UA3/c3
         kwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701610767; x=1702215567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1AT2OIsrXycQl4aHQAwKNZ0NUGOGDU/1vmP5aDNm0Q=;
        b=AfiPTCpUv84rrxncoSmFaTO1aBek9kGUn0I5jsfO31IaNCLKskjy+kysmTMPWrFZl4
         /c/B8i/PaC0l62wOfnYcy1cAHh9S13MoRCxWpeTjkWQhnGEacC6mUSiq20hVXv+iPj9O
         XnvSD23CbErwSpAqxJsuKcH9H9p4s5p+MwmtDMxVFs305/1EKw0PTnPSvhfqyDqBm24b
         Z7mQGsNxK/TZrfIwJYbWzv1+c4mRoIoMJP3xEalP76FEPDFyKWXDpR5wfmnXiS8LfYI2
         nFFdTaexuVLjPXAsAxnSQP8yhY2F4L8WEz+eSFL7bVLMzaryfRKUaYUW+ys7Nuveio7w
         cwTw==
X-Gm-Message-State: AOJu0YyFamHmn1N/ANfWMagZXbjyYDRWdv7cSY4Lpolyuk+eJdp742WM
	J5J9GkY9E4pvq2Sjl2xOJwdydSfie+CNyq2SYZk=
X-Google-Smtp-Source: AGHT+IExswVtY8k0qg65flpJsXvsb++RhXqTJgSbqknARPsYzfmoN2Ro4vyBaS2En5mYt9EjgbIKKA==
X-Received: by 2002:a05:6808:f8a:b0:3b8:643f:934b with SMTP id o10-20020a0568080f8a00b003b8643f934bmr3809811oiw.46.1701610767712;
        Sun, 03 Dec 2023 05:39:27 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id s4-20020a637704000000b005c65e82a0cbsm2515110pgc.17.2023.12.03.05.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 05:39:27 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
X-Google-Original-From: Han Young <hanyoung@protonmail.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [RFC PATCH 2/4] entry: add threaded_unlink_entry function
Date: Sun,  3 Dec 2023 21:39:09 +0800
Message-ID: <20231203133911.41594-3-hanyoung@protonmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231203133911.41594-1-hanyoung@protonmail.com>
References: <20231203133911.41594-1-hanyoung@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Young <hanyang.tony@bytedance.com>

Add threaded_unlink_entry function, the threaded function uses cache passed by arguments instead of the default cache. It also calls threaded variant of schedule_dir_for_removal to ensure dirs are removed in multithreaded unlink.
---
Another duplicated function. Because default removal cache and default lstat cache live in different source files,
threaded variant of check_leading_path and schedule_dir_for_removal must be called here
instead of choosing to pass explicit or default cache.

 entry.c | 16 ++++++++++++++++
 entry.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/entry.c b/entry.c
index 076e97eb89..04440beb2b 100644
--- a/entry.c
+++ b/entry.c
@@ -567,6 +567,22 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 	return write_entry(ce, path.buf, ca, state, 0, nr_checkouts);
 }
 
+void threaded_unlink_entry(const struct cache_entry *ce, const char *super_prefix,
+			   struct strbuf *removal, struct cache_def *cache)
+{
+	const struct submodule *sub = submodule_from_ce(ce);
+	if (sub) {
+		/* state.force is set at the caller. */
+		submodule_move_head(ce->name, super_prefix, "HEAD", NULL,
+				    SUBMODULE_MOVE_HEAD_FORCE);
+	}
+	if (threaded_check_leading_path(cache, ce->name, ce_namelen(ce), 1) >= 0)
+		return;
+	if (remove_or_warn(ce->ce_mode, ce->name))
+		return;
+	threaded_schedule_dir_for_removal(ce->name, ce_namelen(ce), removal);
+}
+
 void unlink_entry(const struct cache_entry *ce, const char *super_prefix)
 {
 	const struct submodule *sub = submodule_from_ce(ce);
diff --git a/entry.h b/entry.h
index ca3ed35bc0..413ca3822d 100644
--- a/entry.h
+++ b/entry.h
@@ -2,6 +2,7 @@
 #define ENTRY_H
 
 #include "convert.h"
+#include "symlinks.h"
 
 struct cache_entry;
 struct index_state;
@@ -56,6 +57,8 @@ int finish_delayed_checkout(struct checkout *state, int show_progress);
  * down from "read-tree" et al.
  */
 void unlink_entry(const struct cache_entry *ce, const char *super_prefix);
+void threaded_unlink_entry(const struct cache_entry *ce, const char *super_prefix,
+			   struct strbuf *removal, struct cache_def *cache);
 
 void *read_blob_entry(const struct cache_entry *ce, size_t *size);
 int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
-- 
2.43.0

