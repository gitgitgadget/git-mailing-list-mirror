Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693DD481A7
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008451; cv=none; b=O8D/L9aoKhR0C9aAb5uAXKTEi1kJMUY/4/790rCKgef3rJzE12AnofNbXmvAAoMjnqH7PDZHixhJiv/tYXHFCjqzfRa6U7lYgNzHHm0jk8308vItGhjOJLpTZWq82mHnIlnab6KBe0s78p03LrhNdzXjJTeGcxn7AgOb7aC9/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008451; c=relaxed/simple;
	bh=y50Vs0KDYO8NAz0sV7QkG+fSUe6ewd8Pwj1kgSniyJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBt2woncUAVnUabG+CeIMgkabcKHCwdK7mYmBXbmAlgNyzyNlaGF1jvd4wg9ELzyKeTafmaM4/XQrCXqgIc9DlTl9MZsaLKN/JGol/NO7C0vzCxxLdICl0zO0KzXcHVpe3ebE5+3C+zdr6hwt8ADkwCtzt6LLAgsY7hxNhBlT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=K7/wxi96; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="K7/wxi96"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710008445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9kapIwhlzPp8J9XuFO/P/JATRYI5kTjK4NZ11dLEXE=;
	b=K7/wxi96ftdW/+lzmgZ7C5h8806LDxs0BRJEmuE6Cn6FSJLnhMHafgJqRZFQWGaBKNLPqf
	dAvGKumQNMZqJyHFjdYSAbhkd3EEqsVDIEyyT8nwUp/L2uELnP9u5EN3H5jWfjuZQxS2Y8
	90iEyFYK3zOnPPAieELBAhO1SAvOrdcF824C0/df+Jq5a21xbFS4NLBuAy1M7+MsdwS1bV
	1IWHbby2tcktFIGApLOI2e3MOy9PHkgxHmYwBeDdMxTpDuzDbpWtarK1y0I7yAPREOD6Nu
	qyPh5p80cEDSduD7d8LwHWZDddDaOmvHUkZMmiLNVDhQrpfUWnw1SHAHWQz8Zw==
From: Ignacio Encinas <ignacio@iencinas.com>
To: git@vger.kernel.org
Cc: Ignacio Encinas <ignacio@iencinas.com>
Subject: [PATCH v2 0/1] Add hostname condition to includeIf
Date: Sat,  9 Mar 2024 19:18:27 +0100
Message-ID: <20240309181828.45496-1-ignacio@iencinas.com>
In-Reply-To: <20240307205006.467443-1-ignacio@iencinas.com>
References: <20240307205006.467443-1-ignacio@iencinas.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extend includeIf to take hostname into account. Motivating request can
be found here [1].

[1] https://github.com/gitgitgadget/git/issues/1665

Changes since v1:
* Add blank line between declarations and code in `include_by_branch`.
* Rewrite "echo"s used in tests to make them more readable. 

  config: learn the "hostname:" includeIf condition

 Documentation/config.txt  |  9 +++++++++
 config.c                  | 17 ++++++++++++++++
 t/t1305-config-include.sh | 42 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

Range-diff against v1:
1:  10a9bca68753 ! 1:  cf175154109e config: learn the "hostname:" includeIf condition
    @@ config.c: static int include_by_branch(const char *cond, size_t cond_len)
     +	int ret;
     +	char my_host[HOST_NAME_MAX + 1];
     +	struct strbuf pattern = STRBUF_INIT;
    ++
     +	if (xgethostname(my_host, sizeof(my_host)))
     +		return 0;
     +
    @@ t/t1305-config-include.sh: test_expect_success 'include cycles are detected' '
      '
      
     +test_expect_success 'conditional include, hostname' '
    -+	echo "[includeIf \"hostname:$(hostname)a\"]path=bar12" >>.git/config &&
    -+	echo "[test]twelve=12" >.git/bar12 &&
    ++	cat >>.git/config <<-EOF &&
    ++	[includeIf "hostname:$(hostname)a"]
    ++		path = bar12
    ++	EOF
    ++	cat >>.git/bar12 <<-EOF &&
    ++	[test]
    ++		twelve=12
    ++	EOF
    ++
     +	test_must_fail git config test.twelve &&
     +
    -+	echo "[includeIf \"hostname:$(hostname)\"]path=bar12" >>.git/config &&
    ++	cat >>.git/config <<-EOF &&
    ++	[includeIf "hostname:$(hostname)"]
    ++		path = bar12
    ++	EOF
     +	echo 12 >expect &&
     +	git config test.twelve >actual &&
     +	test_cmp expect actual
     +'
     +
     +test_expect_success 'conditional include, hostname, wildcard' '
    -+	echo "[includeIf \"hostname:$(hostname)a*\"]path=bar13" >>.git/config &&
    -+	echo "[test]thirteen=13" >.git/bar13 &&
    ++	cat >>.git/config <<-EOF &&
    ++	[includeIf "hostname:$(hostname)a*"]
    ++		path = bar13
    ++	EOF
    ++	cat >>.git/bar13 <<-EOF &&
    ++	[test]
    ++		thirteen = 13
    ++	EOF
    ++
     +	test_must_fail git config test.thirteen &&
     +
    -+	echo "[includeIf \"hostname:$(hostname)*\"]path=bar13" >>.git/config &&
    ++	cat >>.git/config <<-EOF &&
    ++	[includeIf "hostname:$(hostname)*"]
    ++		path = bar13
    ++	EOF
     +	echo 13 >expect &&
     +	git config test.thirteen >actual &&
     +	test_cmp expect actual

base-commit: e09f1254c54329773904fe25d7c545a1fb4fa920
-- 
2.44.0

