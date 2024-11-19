Received: from smtp.onerussian.com (washoe.dartmouth.edu [129.170.30.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA321CBE9C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.170.30.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033563; cv=none; b=m7gnvHRxlPSiO84Sgi88PNNTVmEshu9gShWMTaGDDoq4fmTg4+gU98uHD8HFXPrNwYDBkVeiaZH/V+iwQg1XLolfkPDDUjqpnZJm8ZXqKO7UPJe8C0QsXcKopbJGSzkc0ZTC5EiNzJsdMPPOTEhPWquNVZnItTlQpwNLf7LrEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033563; c=relaxed/simple;
	bh=aXZ+LKlWiQSmk6VXUzJaTR1gdocZEmJ0l75YKvdusZM=;
	h=Date:From:To:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Subject; b=fm0AzDLQDtGoqeV3VMHoFNMGcYaIdi8eGtH/+laTL/SIyxFBeEr428pKo74QMSroV4kIItN5YA3LS7ibEg7OxVfH/kofN0chJ5v68BBteulRrlAS+Xrgu/ykCnzSQZHP9ku9HgtGve93ryuYzB9YWWD9+TdP09rrwcNmX72drfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onerussian.com; spf=pass smtp.mailfrom=onerussian.com; arc=none smtp.client-ip=129.170.30.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onerussian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onerussian.com
Received: from c-73-218-136-210.hsd1.vt.comcast.net ([73.218.136.210] helo=localhost)
	by smtp.onerussian.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <yoh@onerussian.com>)
	id 1tDQOY-0000q8-Uq
	for git@vger.kernel.org; Tue, 19 Nov 2024 10:44:03 -0500
Date: Tue, 19 Nov 2024 10:44:02 -0500
From: Yaroslav Halchenko <yoh@onerussian.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <ZzyyQpJw-kxJA7IS@bilena>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 73.218.136.210
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-Spam-Level: 
X-Spam-Report: 
	* -0.0 SHORTCIRCUIT Not all rules were run, due to a shortcircuited
	*      rule
	* -4.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: fresh ls-files looks inside submodules even when not asked to or
 asked not to
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)

Dear Git Gurus,

Here is a report prepared with a new glorious "git bugreport" which I
hoped would also automagically send it out.

What did you do before the bug happened? (Steps to reproduce your issue)

	Prior version (e.g. 2.45.2) had this issue "hidden": ls-files was
	just reporting error to stderr but exiting with exit code 0.  So our test in
	DataLad which creates an artificial situation with permissions to .git/config
	within submodule did not trigger error.

What did you expect to happen? (Expected behavior)

	Ideally -- 'git ls-files -m -d --no-recurse-submodules'
	should not even consult submodules' .git/config . I am not yet 100% certain that it should without explicit '--recurse-submodules'.

What happened instead? (Actual behavior)

    regardless which options (-x sub3  or --no-recurse-submodules) I add,
    git ls-files does try to access submodules .git/config:

    ❯ pwd
    /home/yoh/.tmp/datalad_temp_test_subsuperdataset_savechl3cwws/sub1/sub2
	❯ ls -ld .git/config
	-rw-rw-r-- 1 yoh yoh 333 Nov 19 10:11 .git/config
	❯ ls -ld sub3/.git/config
	---------- 1 yoh yoh 285 Nov 19 10:11 sub3/.git/config
    ❯ git --version
    git version 2.47.0.288.g090d24e9af

    ❯ git ls-files  -m -d
    warning: unable to access '/home/yoh/.tmp/datalad_temp_test_subsuperdataset_savechl3cwws/sub1/sub2/sub3/.git/config': Permission denied
    fatal: unable to access '/home/yoh/.tmp/datalad_temp_test_subsuperdataset_savechl3cwws/sub1/sub2/sub3/.git/config': Permission denied
    ❯ echo $?
    128
   
    ❯ git ls-files -m -d --no-recurse-submodules -x sub3
    warning: unable to access '/home/yoh/.tmp/datalad_temp_test_subsuperdataset_savechl3cwws/sub1/sub2/sub3/.git/config': Permission denied
    fatal: unable to access '/home/yoh/.tmp/datalad_temp_test_subsuperdataset_savechl3cwws/sub1/sub2/sub3/.git/config': Permission denied
    ❯ echo $?
    128

	NB then also tried with "next" 2.47.0.376.g95f8e04e20 to the same effect.

What's different between what you expected and what actually happened?

    git ls-files did descend into submodule to check its .git/config for no
    reason IMHO.

Anything else you want to add:

    Thank you for creating this helper to file issues!  Note that a
    slight mental dichotomy was caused by the fact that you named it "git
    bugreport" whenever debian has "reportbug" so now it would take extra
    mental effort to remember who has what


[System Info]
git version:
git version 2.47.0.288.g090d24e9af
cpu: x86_64
built from commit: 090d24e9af6e9f59c3f7bee97c42bb1ae3c7f559
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.11.0
OpenSSL: OpenSSL 3.3.2 3 Sep 2024
zlib: 1.3.1
uname: Linux 6.11.5-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.11.5-1 (2024-10-27) x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
post-checkout
post-merge
post-receive
pre-commit


Thank you in advance!
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
WWW:   http://www.linkedin.com/in/yarik        

