Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD103387
	for <git@vger.kernel.org>; Wed,  8 May 2024 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128861; cv=none; b=M+k7cvpdk8EoMHDOoF+vStbe/7neEVVzDJu6HmM18zvzPGmSDG1RDpFOZOs9zh1CzMsn+8jkloV7+SqBbA0UTbnZ9f0trAwmIhhSoAfBfwoD7OZKimIX0N+VryMX+Y2Ps3Py6gv/pXWLXKy02XCy2doFmo+DO1SpiNmH8qKnYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128861; c=relaxed/simple;
	bh=7JX+u3SwqeVVeLvKu+oQM068BL20hEMz1QlRvFZAbDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZV5yz8e5Bg73I2vaEeLjBKqhgNwH6fHZ+aNSYQsHkhoWjl87eE52ILH0pivGz6pE+71DIBlZK5FOQggmNiw/dVpsclaDhC6lpwW1PC9UyGxmJrQUX+djogg49G6tQ4VT4Phe0JEdo6Q/fLO7nQDGr6FuFOeLnUcWJ/hNEnl5uE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xw9YDO2r; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xw9YDO2r"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F67322649;
	Tue,  7 May 2024 20:40:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7JX+u3SwqeVVeLvKu+oQM068BL20hEMz1QlRvF
	ZAbDQ=; b=xw9YDO2rlU2WDltbdbQuFGXLlYo5+Ds6BqkDDKpZomZsR2LXQxph8a
	upTMuzhiyD2FEBXZNw32pZ/8lPYi50HQfFsfw1LCwmNZAYz4ln29e+jHALpSZRMz
	J/BWt3GHKFY5fetZ1K8NcE3rJiQdsjlDytTU3udguDkNqsKYuYS74=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 581D322648;
	Tue,  7 May 2024 20:40:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BDD4922647;
	Tue,  7 May 2024 20:40:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH v4 4/3] t0018: two small fixes
In-Reply-To: <20240503071706.78109-4-james@jamesliu.io> (James Liu's message
	of "Fri, 3 May 2024 17:17:06 +1000")
References: <20240430014724.83813-1-james@jamesliu.io>
	<20240503071706.78109-1-james@jamesliu.io>
	<20240503071706.78109-4-james@jamesliu.io>
Date: Tue, 07 May 2024 17:40:51 -0700
Message-ID: <xmqqbk5hyw30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9FA6F142-0CD3-11EF-A276-25B3960A682E-77302942!pb-smtp2.pobox.com

Even though the three tests that were recently added started their
here-doc with "<<-\EOF", it did not take advantage of that and
instead wrote the here-doc payload abut to the left edge.  Use a tabs
to indent these lines.

More importantly, because these all hardcode the expected output,
which contains the current branch name, they break the CI job that
uses 'main' as the default branch name.

Use

    GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=trunk
    export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

between the test_description line and ". ./test-lib.sh" line to
force the initial branch name to 'trunk' and expect it to show in
the output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I should have noticed these before merging the series to 'next',
   so here is a fix-up patch on top of the three patches.

 t/t0018-advice.sh | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git c/t/t0018-advice.sh w/t/t0018-advice.sh
index b02448ea16..29306b367c 100755
--- c/t/t0018-advice.sh
+++ w/t/t0018-advice.sh
@@ -2,6 +2,9 @@
 
 test_description='Test advise_if_enabled functionality'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=trunk
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
@@ -31,15 +34,15 @@ test_expect_success 'advice should not be printed when config variable is set to
 
 test_expect_success 'advice should not be printed when --no-advice is used' '
 	q_to_tab >expect <<-\EOF &&
-On branch master
+	On branch trunk
 
-No commits yet
+	No commits yet
 
-Untracked files:
-QREADME
+	Untracked files:
+	QREADME
 
-nothing added to commit but untracked files present
-EOF
+	nothing added to commit but untracked files present
+	EOF
 
 	test_when_finished "rm -fr advice-test" &&
 	git init advice-test &&
@@ -53,15 +56,15 @@ EOF
 
 test_expect_success 'advice should not be printed when GIT_ADVICE is set to false' '
 	q_to_tab >expect <<-\EOF &&
-On branch master
+	On branch trunk
 
-No commits yet
+	No commits yet
 
-Untracked files:
-QREADME
+	Untracked files:
+	QREADME
 
-nothing added to commit but untracked files present
-EOF
+	nothing added to commit but untracked files present
+	EOF
 
 	test_when_finished "rm -fr advice-test" &&
 	git init advice-test &&
@@ -75,16 +78,16 @@ EOF
 
 test_expect_success 'advice should be printed when GIT_ADVICE is set to true' '
 	q_to_tab >expect <<-\EOF &&
-On branch master
+	On branch trunk
 
-No commits yet
+	No commits yet
 
-Untracked files:
-  (use "git add <file>..." to include in what will be committed)
-QREADME
+	Untracked files:
+	  (use "git add <file>..." to include in what will be committed)
+	QREADME
 
-nothing added to commit but untracked files present (use "git add" to track)
-EOF
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
 
 	test_when_finished "rm -fr advice-test" &&
 	git init advice-test &&



