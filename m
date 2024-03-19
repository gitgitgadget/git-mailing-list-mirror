Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9E3771E
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873497; cv=none; b=oJV3rho9nETfUYZLMgADJOQcHg3h6FmYFJrKKBAOS06x9mxU6PaQZpLg/8mucr10Bw7jj4txC0mhp4h810/kWTOFBbrqYtYHVGdQD1iXkorShLpge5Pf7ouzfcLRCcrU4fX/bkV9StfIKxMmrFoGhU5nwxiwEs2y3bxSDtH6pok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873497; c=relaxed/simple;
	bh=h77oh4mlXyKk1FmcaFjVT+YNEESnAZaU6xBiHepzUuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1MTD40GnpcmbaoKkYKqpOIeEbeQBeS4a4AZ1RPDfNy6pIN9DqExWUNLeyXNt0kOWk10L+KKP/n/F8p2i+Nb93RCC18RqPOgsJIYOTjknQDeKC6AtwW4WhotJ490Qxd+ZHzKIujfClgYrwhA1J2qrMONfka+N0saJoDIUDMoItw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=Bpstm3Z/; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="Bpstm3Z/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710873487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MyQoB8Lj2y052fYCUAZMzYifbW3I7ZJMY415eFgF8s=;
	b=Bpstm3Z/+j6H25a6/aKtHjJxBl1t/flnZMAXKKjKP9FH1EI7cPaNaQ7zZB4TcMI5xmorWw
	QYN2Ycm4c0XOPXZtbB77n0y5l0hs3UxemhCExejH1o3wm2C+Qj3rVWxWQ+CszGfQv4PDIW
	39LpsulAyWWosQGW+kx9BTiko+xrUdN3hdyeI1h2coaQz3s8iEut7FrXlNI0jB1GTEqZ2x
	gsY8exsxSNPHtXID/lswczm+K8dmyuHze3Ldo2Q/VU/xOPdEbzpNyOZL2YsY9p3ukYGpAG
	HtbQiAqbdMWycG51obZFoUJqD2KKcaoWgPw3aBqOPBaxTfAIGUPH4Od8JDATkA==
From: Ignacio Encinas <ignacio@iencinas.com>
To: git@vger.kernel.org
Cc: Ignacio Encinas <ignacio@iencinas.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	rsbecker@nexbridge.com
Subject: [PATCH v3 0/2] Add hostname condition to includeIf
Date: Tue, 19 Mar 2024 19:37:20 +0100
Message-ID: <20240319183722.211300-1-ignacio@iencinas.com>
In-Reply-To: <20240309181828.45496-1-ignacio@iencinas.com>
References: <20240309181828.45496-1-ignacio@iencinas.com>
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

A lot of feedback was given to the v2 of this patch.

It was pointed out that it wasn't particularly obvious what it was meant by 

  "If the current hostname matches the pattern, the include condition is met."

which is definitely true. Despite this, to my knowledge, there isn't a
way to precisely define what we mean by "hostname" other than saying 
that we mean whatever is returned by gethostname(2). 

In my opinion, terms like "short hostname" can be confusing in some 
cases, and I'm not even sure we can rely on $hostname to agree with 
gethostname(2) in every platform.

I still think the documentation isn't great, but I don't see a way to
improve it further.

Thanks everyone for the feedback!

Changes since v2:
* Expose the result of xgethostname through test-tool
* Rewrite test to rely on test-tool xgethostname rather than using
  $hostname
* Clarify documentation, specifying that by "hostname" we mean output of
  gethostname(2)

Changes since v1:
* Add blank line between declarations and code in `include_by_branch`.
* Rewrite "echo"s used in tests to make them more readable. 

Ignacio Encinas (2):
  t: add a test helper for getting hostname
  config: learn the "hostname:" includeIf condition

 Documentation/config.txt     | 10 +++++++++
 Makefile                     |  1 +
 config.c                     | 17 +++++++++++++++
 t/helper/test-tool.c         |  1 +
 t/helper/test-tool.h         |  1 +
 t/helper/test-xgethostname.c | 12 +++++++++++
 t/t1305-config-include.sh    | 42 ++++++++++++++++++++++++++++++++++++
 t/t6500-gc.sh                |  3 +--
 8 files changed, 85 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-xgethostname.c

Range-diff against v2:
-:  ------------ > 1:  ee1f9b1da037 t: add a test helper for getting hostname
1:  cf175154109e ! 2:  dec622c38916 config: learn the "hostname:" includeIf condition
    @@ Documentation/config.txt: As for the naming of this keyword, it is for forwards
     +`hostname`::
     +	The data that follows the keyword `hostname:` is taken to be a
     +	pattern with standard globbing wildcards. If the current
    -+	hostname matches the pattern, the include condition is met.
    ++	hostname (output of gethostname(2)) matches the
    ++	pattern, the include condition is met.
     +
      A few more notes on matching via `gitdir` and `gitdir/i`:
      
    @@ t/t1305-config-include.sh: test_expect_success 'include cycles are detected' '
      
     +test_expect_success 'conditional include, hostname' '
     +	cat >>.git/config <<-EOF &&
    -+	[includeIf "hostname:$(hostname)a"]
    ++	[includeIf "hostname:$(test-tool xgethostname)a"]
     +		path = bar12
     +	EOF
     +	cat >>.git/bar12 <<-EOF &&
    @@ t/t1305-config-include.sh: test_expect_success 'include cycles are detected' '
     +	test_must_fail git config test.twelve &&
     +
     +	cat >>.git/config <<-EOF &&
    -+	[includeIf "hostname:$(hostname)"]
    ++	[includeIf "hostname:$(test-tool xgethostname)"]
     +		path = bar12
     +	EOF
     +	echo 12 >expect &&
    @@ t/t1305-config-include.sh: test_expect_success 'include cycles are detected' '
     +
     +test_expect_success 'conditional include, hostname, wildcard' '
     +	cat >>.git/config <<-EOF &&
    -+	[includeIf "hostname:$(hostname)a*"]
    ++	[includeIf "hostname:$(test-tool xgethostname)a*"]
     +		path = bar13
     +	EOF
     +	cat >>.git/bar13 <<-EOF &&
    @@ t/t1305-config-include.sh: test_expect_success 'include cycles are detected' '
     +	test_must_fail git config test.thirteen &&
     +
     +	cat >>.git/config <<-EOF &&
    -+	[includeIf "hostname:$(hostname)*"]
    ++	[includeIf "hostname:$(test-tool xgethostname)*"]
     +		path = bar13
     +	EOF
     +	echo 13 >expect &&

base-commit: e09f1254c54329773904fe25d7c545a1fb4fa920
-- 
2.44.0

