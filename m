Received: from kitenet.net (kitenet.net [66.228.36.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79813BAF1
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.36.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747941535; cv=none; b=jfT81RPqzyrfcjIK/AOhyD3iZz+Ba3QPlpgs6280o2ShI1QUynbinWyiytUKRpjcMEQ+WO/DgOk2JltBsYOKTWxlM1mihby53/l3BtuyCAmemyHPdqBp9bvwgamty4mRm4okt+1ccQ6KMn+AQ+HRpBl6BXm6Eh6gPUzz3l0B//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747941535; c=relaxed/simple;
	bh=AVZrpRBJsac81DOR2H6ZycvI1RoZE6YYUaNQdkQSbE4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ia//lGFAgAYkNfw1o1rihvPzzDGkOOdm5kQCwARVGI3LfTo1qlAP3YnoGhfBW8tblZE6CIz3Tr/gY8ZtKBdvxt9Nr7A2cLxm7Eu/qmlTFkjZuJ2PdlBudtdKDBJUkJEb5699DG4OiAHtFRttI+r7uhG1uX+MwMqSR/yBTGMfr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name; spf=pass smtp.mailfrom=kitenet.net; dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b=lHTtdvBe; arc=none smtp.client-ip=66.228.36.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kitenet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b="lHTtdvBe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=joeyh.name; s=mail;
	t=1747940498; bh=AVZrpRBJsac81DOR2H6ZycvI1RoZE6YYUaNQdkQSbE4=;
	h=Date:From:To:Subject:From;
	b=lHTtdvBeM+wwTaS/E/aQ7SnPZyvEh3KreD/SAalZ+ATjUv82U3ksEUXKfAhtcvVDf
	 aSmCJzLViGMfONSEYJaS+5/l60MeLRHP/6vUb9duRSctPxsNPEr2hcVgd7zZZpSd2F
	 qgedal3oHs1si0EKcCO0W4Xoj99xqmrXrixYwlno=
X-Question: 42
Date: Thu, 22 May 2025 15:01:38 -0400
From: Joey Hess <id@joeyh.name>
To: git@vger.kernel.org
Subject: buggy smudge/clean of empty files
Message-ID: <aC90kn2mE93DCJEH@kitenet.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sIipg8AFUGUMaXoK"
Content-Disposition: inline


--sIipg8AFUGUMaXoK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

git seems to be buggy in its handling of empty files when smudge/clean filters
are used.

I've attached a script setup_smudge_clean.sh, which configures a git
repository to use a very simple smudge and clean filter pair for all
files. The clean filter prepends a line "hi" to the file content, and the
smudge filter removes the line. There is nothing very special about this
smudge/clean, it's just a simple one for the sake of an example.

Here's the bug:

# git init repo
# cd repo
# sh ~/setup_smudge_clean.sh
# echo foo > foofile
# git add foofile
# git diff
# touch emptyfile
# git add emptyfile
# git commit -m added
# git status
On branch master
nothing to commit, working tree clean
# git diff
diff --git a/emptyfile b/emptyfile
--- a/emptyfile
+++ b/emptyfile
@@ -1 +0,0 @@
-hi

emptyfile is unchanged, as git status shows, so why is git diff displaying
a change?

It seems that git diff runs the clean filter (GIT_TRACE shows it does),
but it must ignore its output when the file is empty, and always use an empty
file as the current content for the diff. Which differs from what was staged.

-- 
see shy jo

--sIipg8AFUGUMaXoK
Content-Type: application/x-sh
Content-Disposition: attachment; filename="setup_smudge_clean.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0Acat <<'EOF' > .git/test-clean=0A#!/bin/sh=0Aecho hi=0Acat=0AEOF=
=0Acat <<'EOF' > .git/test-smudge=0A#!/bin/sh=0Atail -n +2=0AEOF=0Achmod +x=
 .git/test-clean=0Achmod +x .git/test-smudge=0Agit config filter.foo.smudge=
 .git/test-smudge=0Agit config filter.foo.clean .git/test-clean=0Aecho "* f=
ilter=3Dfoo" > .git/info/attributes=0A
--sIipg8AFUGUMaXoK--
