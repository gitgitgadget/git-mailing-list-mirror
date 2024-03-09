Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6748CE0
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008454; cv=none; b=VCjyvXoItrYSUnNqgRXUpWrg84/WDMkI8DpMarVUC40aRkEahPvYZ0WM3CjBQSqviQJEfJxypSjhrmaQMSxPlgtJKa6ErSHbzNht16yVDY6qPEpBImzXvqSRg6/NJOottONBNye5MwyE4XpXLeTPeOhM1GAZMpgBtYdnlu7aqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008454; c=relaxed/simple;
	bh=ZeLkT4FFNcnDkSB6cBbdAMLiURFmtXANYyc3dNIA584=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkH01iKZAGFTBqqd5fmw3tWf/ZJIONa7FRoxs8vo7cV4fHQszlo8+GUZjckslwoSYQV2I8oYsb5vmYpfXijaEltnRsMi3Sd5HdGJqQ4WW6uy81aiskQOKhvbz79El1lRJ2F7B3d1lGvb80RYk69YVzT4441wqNDSeD7H3TyykZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=qJ3SG91l; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="qJ3SG91l"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710008449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtBq1w+PXwmoKQzMbVLHrHl4V31TJqt/dVCmCF00iKQ=;
	b=qJ3SG91lJhfDSX416ObKMWOlu/wj+hGoAbPeIrNAFYYT7xOotk8+BruqitxpDSxBmLW+p8
	K3w/EjLIkCF1mf5RhIVnISGdeY1gRAhjOcD7XeXLNorfUE9Vk49fPT6J/3RnW6CBdAga7m
	dDokqW9SEtghcWT9PWhqk8doeuSO4NtviS0wA6VYa1+qPMDU6cnCiBObWQUAO5XdyebrD9
	lFfIOWHg4jV1tksMR0TmB7PSuhhmbVWV4xCvTecr3iO/u3q8Br/e1AAtWnM00ge13oJjA+
	8twZcE9PrhQy/H2JtldN6UGETdx59OBOb1yrBpHSvhFpm5qq4Jx4VpYO/DNSyg==
From: Ignacio Encinas <ignacio@iencinas.com>
To: git@vger.kernel.org
Cc: Ignacio Encinas <ignacio@iencinas.com>
Subject: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
Date: Sat,  9 Mar 2024 19:18:28 +0100
Message-ID: <20240309181828.45496-2-ignacio@iencinas.com>
In-Reply-To: <20240309181828.45496-1-ignacio@iencinas.com>
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240309181828.45496-1-ignacio@iencinas.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, customizing the configuration depending on the machine running
git has to be done manually.

Add support for a new includeIf keyword "hostname:" to conditionally
include configuration files depending on the hostname.

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
 Documentation/config.txt  |  9 +++++++++
 config.c                  | 17 ++++++++++++++++
 t/t1305-config-include.sh | 42 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e3a74dd1c19d..9a22fd260935 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -186,6 +186,11 @@ As for the naming of this keyword, it is for forwards compatibility with
 a naming scheme that supports more variable-based include conditions,
 but currently Git only supports the exact keyword described above.
 
+`hostname`::
+	The data that follows the keyword `hostname:` is taken to be a
+	pattern with standard globbing wildcards. If the current
+	hostname matches the pattern, the include condition is met.
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
@@ -261,6 +266,10 @@ Example
 	path = foo.inc
 [remote "origin"]
 	url = https://example.com/git
+
+; include only if the hostname of the machine matches some-hostname
+[includeIf "hostname:some-hostname"]
+	path = foo.inc
 ----
 
 Values
diff --git a/config.c b/config.c
index 3cfeb3d8bd99..50b3f6d24c50 100644
--- a/config.c
+++ b/config.c
@@ -317,6 +317,21 @@ static int include_by_branch(const char *cond, size_t cond_len)
 	return ret;
 }
 
+static int include_by_hostname(const char *cond, size_t cond_len)
+{
+	int ret;
+	char my_host[HOST_NAME_MAX + 1];
+	struct strbuf pattern = STRBUF_INIT;
+
+	if (xgethostname(my_host, sizeof(my_host)))
+		return 0;
+
+	strbuf_add(&pattern, cond, cond_len);
+	ret = !wildmatch(pattern.buf, my_host, 0);
+	strbuf_release(&pattern);
+	return ret;
+}
+
 static int add_remote_url(const char *var, const char *value,
 			  const struct config_context *ctx UNUSED, void *data)
 {
@@ -406,6 +421,8 @@ static int include_condition_is_true(const struct key_value_info *kvi,
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
 				   &cond_len))
 		return include_by_remote_url(inc, cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "hostname:", &cond, &cond_len))
+		return include_by_hostname(cond, cond_len);
 
 	/* unknown conditionals are always false */
 	return 0;
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 5cde79ef8c4f..e0a1d51d50ad 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -357,4 +357,46 @@ test_expect_success 'include cycles are detected' '
 	grep "exceeded maximum include depth" stderr
 '
 
+test_expect_success 'conditional include, hostname' '
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:$(hostname)a"]
+		path = bar12
+	EOF
+	cat >>.git/bar12 <<-EOF &&
+	[test]
+		twelve=12
+	EOF
+
+	test_must_fail git config test.twelve &&
+
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:$(hostname)"]
+		path = bar12
+	EOF
+	echo 12 >expect &&
+	git config test.twelve >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'conditional include, hostname, wildcard' '
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:$(hostname)a*"]
+		path = bar13
+	EOF
+	cat >>.git/bar13 <<-EOF &&
+	[test]
+		thirteen = 13
+	EOF
+
+	test_must_fail git config test.thirteen &&
+
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:$(hostname)*"]
+		path = bar13
+	EOF
+	echo 13 >expect &&
+	git config test.thirteen >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.44.0

