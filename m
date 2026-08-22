Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E1380FE7
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787415017; cv=none; b=IOeARX1X8xBaEOzVGNfOAWUn+/JELacnsQurQrXohrZlwQEtoxitJff9T7vBhILeHqnMaDPqsimdvIpN1Q2bH7j55CW70NbAVZbUgHP0egOzKV2ekq0fW+8O4IrpfjZ/bD2chL3se3mrUCPiYaO8asrsmXzDTlErWbBypThk7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787415017; c=relaxed/simple;
	bh=rUBnbo6i2iuXCCAmuodTYI7ZBKAVV2jzL0xtivOAdS0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=KcVb7J9yua5bg8NBJrTI5Og+xNRhR4tapuwpOWpyCNegHPag1PpqiR8/W1m8Zb9Cx6GWxDb1MApsLDSK9N9V1+k2ugVAom18P/Cttlamhmr8Pfzb0K3qFYsUhQODLLc2CKVEwyj15Qbn5RQEhj1X90ploBHI5bGXTYmxgUiAaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fordltc.net; spf=pass smtp.mailfrom=fordltc.net; dkim=pass (2048-bit key) header.d=fordltc.net header.i=@fordltc.net header.b=Vv5BuvX0; arc=none smtp.client-ip=95.215.58.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fordltc.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fordltc.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fordltc.net header.i=@fordltc.net header.b="Vv5BuvX0"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rUBnbo6i2iuXCCAmuodTYI7ZBKAVV2jzL0xtivOAdS0=;
 c=simple/simple; d=fordltc.net;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787415010; v=1; x=1788019810;
 b=Vv5BuvX0iTRJkIcLjoGiM3kCEPzSUlh5g1vnjLXOd7/eon7c4j9WEZ9iseNgus/bMqAOHwrG
 zNdID5cifkjaDKJKf5nIeds75NLG5K5RoaCwd7miS2klKyltVLVGKQoLPjC9SdVaA3zLdT8U9dZ
 uK2nboagaqiiv/wlxsOq0bqWIomKmIUNZiJocI50LRMjrG9CcqPeMrd5xMBgv7tuzg4ChpJZXJ4
 Yqd0JWLqGTtGqgj8AdMnhIwI197vc7Pad7VL8NDAaQ3PnbaJ/fz9E/43+UoIB00ybfAwo9WvFh+
 178JebUvWjWxtc2cfaIH2PZ9DbBBYdFLwzVnMCVLbjURg==
X-Envelope-To: git@vger.kernel.org
Received: from localhost (70.23.216.172)
	by smtp.migadu.com with ESMTPS id 40594fbfb52505b7;
	Sat, 22 Aug 2026 16:10:09 +0000
X-Mizu-Trace-ID: 40594fbfb52505b7
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 22 Aug 2026 12:10:04 -0400
Message-Id: <DKVLQLCHHBM4.WCEIQ0I73YOA@fordltc.net>
Subject: Bug Report: subtree then rebase causes unrelated history to
 conflict
From: "Gabriel Ford" <gabe@fordltc.net>
To: <git@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2

I created this report from the git bugreport template following
https://git-scm.com/community. Thanks to anyone who takes the time to
read and look into this! Please let me know if there are any follow up
questions or if anything is unclear. This is my first bug report to git
so please let me know if I should have written anything different!

What did you do before the bug happened? (Steps to reproduce your issue)

  I found this when using git subtree to vendor this library
  (https://github.com/htfy96/dollar), I believe this will also happen in an=
y
  similar cases where the subtree has a file with an identical path as one =
of the
  files in your repo.
 =20
  I was able to repro this from a brand new repository as follows:
 =20
  ```sh
  mkdir ./test_repo=20
  cd ./test_repo
  touch .clang-format
  echo 'Any text in this file should work' > .clang-format
  git commit -m "create .clang-format in main repo"
 =20
  git checkout -b feat_branch
  git subtree add --prefix dollar_subtree git@github.com:htfy96/dollar.git =
master --squash
 =20
  git checkout master
  touch foo.txt
  git commit -m "commit anything so that we have something to rebase onto"
 =20
  git checkout feat_branch
  git rebase master
  ```
 =20
  You should see that there is a conflict that needs resolution between the=
 main
  .clang-format file we created, and the subprojects .clang-format even tho=
ugh
  the files are in seperate dirs.


What did you expect to happen? (Expected behavior)
  I did not expect a conflict since the .clang-format file we created didn'=
t change.


What happened instead? (Actual behavior)
  There was a conflict between the two files in seperate dirs.=20


What's different between what you expected and what actually happened?
  The rebase conflict that occured.


Anything else you want to add:
  I think this is happening due to the way git subtree is squash merging in=
 the
  subproject, even though a git blame on the .clang-format we created doesn=
't
  show any changes, it appears that the history conflicts since the path
  relative to the root is the same in the subproject.


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.55.0
cpu: x86_64
built from commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.21.0
OpenSSL: OpenSSL 3.6.3 9 Jun 2026
zlib-ng: 2.3.3
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.1.8-arch1-3 #1 SMP PREEMPT_DYNAMIC Tue, 11 Aug 2026 09:16:08=
 +0000 x86_64
compiler info: gnuc: 16.1
libc info: glibc: 2.44
$SHELL (typically, interactive shell): /usr/bin/fish


[Enabled Hooks]

