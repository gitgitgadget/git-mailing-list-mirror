Received: from renault.us.lt (renault.us.lt [79.98.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637F1CD15
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.98.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155872; cv=none; b=nT0e3RyDwb00bgcB7hZbaK2hqXL+0zsrnASbLWm8WBtFtfo9RkP2ld5hyB3Sl1KIp/JSjD4p34YvpUJEdRYtmdFltkPHdIrDQ9dh0tEEkRuD1+JuvmLMw7hWys++bePgRaxxUL6nlFaX37PSwQb1BOu6h/WeDvxjs3tCcmUVMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155872; c=relaxed/simple;
	bh=q01T5+JXuB2fq6CXFmOWWJM2dHTX7xyKFwGP2gDcYrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJx6fDk5kU1Lxr1DrwCQ25i18AnYHk691A4OEPZ2NRsNAeXALonzElUR9Q70ow6jQpY/hrYxEOTOKwY4ZgAI81/Xie4m7cuOsA/vvQpfB+dPsnZe5BRBct+Gb42bit518Byv8dju/RuER0J9x7+DryUK9yMk/opLmFIBsMRvpaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org; spf=pass smtp.mailfrom=kipras.org; arc=none smtp.client-ip=79.98.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kipras.org
Received: from [157.230.0.129] (helo=localhost.localdomain)
	by renault.us.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <kipras@kipras.org>)
	id 1rbFMs-0002Rr-E9; Sat, 17 Feb 2024 09:44:15 +0200
From: Kipras Melnikovas <kipras@kipras.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	greenfoo@u92.eu,
	Kipras Melnikovas <kipras@kipras.org>
Subject: [PATCH v3] mergetools: vimdiff: use correct tool's name when reading mergetool config
Date: Sat, 17 Feb 2024 09:43:43 +0200
Message-ID: <20240217074343.12608-1-kipras@kipras.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240215142002.36870-1-kipras@kipras.org>
References: <20240215142002.36870-1-kipras@kipras.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: kipras

The /mergetools/vimdiff script, which handles both vimdiff, nvimdiff
and gvimdiff mergetools (the latter 2 simply source the vimdiff script), has a
function merge_cmd() which read the layout variable from git config, and it
would always read the value of mergetool.**vimdiff**.layout, instead of the
mergetool being currently used (vimdiff or nvimdiff or gvimdiff).

It looks like in 7b5cf8be18 (vimdiff: add tool documentation, 2022-03-30),
we explained the current behavior in Documentation/config/mergetool.txt:

```
mergetool.vimdiff.layout::
	The vimdiff backend uses this variable to control how its split
	windows look like. Applies even if you are using Neovim (`nvim`) or
	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
```

which makes sense why it's explained this way - the vimdiff backend is used by
gvim and nvim. But the mergetool's configuration should be separate for each tool,
and indeed that's confirmed in same commit at Documentation/mergetools/vimdiff.txt:

```
Variants

Instead of `--tool=vimdiff`, you can also use one of these other variants:
  * `--tool=gvimdiff`, to open gVim instead of Vim.
  * `--tool=nvimdiff`, to open Neovim instead of Vim.

When using these variants, in order to specify a custom layout you will have to
set configuration variables `mergetool.gvimdiff.layout` and
`mergetool.nvimdiff.layout` instead of `mergetool.vimdiff.layout`
```

So it looks like we just forgot to update the 1 part of the vimdiff script
that read the config variable. Cheers.

Though, for backward compatibility, I've kept the mergetool.vimdiff
fallback, so that people who unknowingly relied on it, won't have their
setup broken now.

Signed-off-by: Kipras Melnikovas <kipras@kipras.org>
---

Here's some variants I considered for mergetool.<vimdiff variant>.layout
in Documentation/config/mergetool.txt, but discarded for a shorter
version. Feel free to pick & edit the final.

a)
	The `<vimdiff variant>` is any of `vimdiff`, `nvimdiff`, `gvimdiff`. When
	you run `git mergetool` with `--tool=<vimdiff variant>`, Git will consult
	`mergetool.<vimdiff variant>.layout` to determine the tool's layout. If it's
	not specified, `vimdiff`'s is used as fallback. If that too is not available,
	a default layout with 4 windows is used. See BACKEND SPECIFIC HINTS section
ifndef::git-mergetool[]
	in linkgit:git-mergetool[1]
endif::[]
	for details.

b)
	Configure a custom layout for your mergetool. The `<variant>` is any
	of `vimdiff`, `nvimdiff`, `gvimdiff`.

	Upon launching `git mergetool` with `--tool=<variant>` (or without
	`--tool` if `merge.tool` is configured as `<variant>`), Git
	will consult `mergetool.<vimdiff variant>.layout` to determine the tool's
	layout.  If the variant-specific config is not available, `vimdiff`'s is
	used as fallback. If that too is not available, a default layout with 4
	windows will be used. See BACKEND SPECIFIC HINTS section
ifndef::git-mergetool[]
	in linkgit:git-mergetool[1]
endif::[]
	for details.


The ifdef + ifndef is used to avoid an extra space before the final "."


Range-diff against v2:
1:  070280d95d ! 1:  60be87c3d5 mergetools: vimdiff: use correct tool's name when reading mergetool config
    @@ Documentation/config/mergetool.txt: mergetool.meld.useAutoMerge::
     -	The vimdiff backend uses this variable to control how its split
     -	windows appear. Applies even if you are using Neovim (`nvim`) or
     -	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
    -+mergetool.{g,n,}vimdiff.layout::
    -+	The vimdiff backend uses this variable to control how its split windows
    -+	appear. Use `mergetool.vimdiff` for regular Vim, `mergetool.nvimdiff` for
    -+	Neovim and `mergetool.gvimdiff` for gVim to configure the merge tool. See
    -+	BACKEND SPECIFIC HINTS section
    - ifndef::git-mergetool[]
    - 	in linkgit:git-mergetool[1].
    +-ifndef::git-mergetool[]
    +-	in linkgit:git-mergetool[1].
    ++mergetool.<vimdiff variant>.layout::
    ++	Git's vimdiff backend uses this variable to control how the split windows of
    ++	`<vimdiff variant>` appear. Here `<vimdiff variant>` is any of `vimdiff`,
    ++	`nvimdiff`, `gvimdiff`. To configure the layout and use the tool, see the
    ++	`BACKEND SPECIFIC HINTS`
    ++ifdef::git-mergetool[]
    ++	section.
    ++endif::[]
    ++ifndef::git-mergetool[]
    ++	section in linkgit:git-mergetool[1].
      endif::[]
    +-	for details.
    + 
    + mergetool.hideResolved::
    + 	During a merge, Git will automatically resolve as many conflicts as
     
      ## mergetools/vimdiff ##
     @@ mergetools/vimdiff: diff_cmd_help () {
    @@ mergetools/vimdiff: diff_cmd_help () {
     +	TOOL=$1
      
     -	case "$1" in
    -+	layout=$(git config mergetool.$TOOL.layout)
    ++	layout=$(git config "mergetool.$TOOL.layout")
     +
    -+	# backwards-compatibility:
    ++	# backward compatibility:
     +	if test -z "$layout"
     +	then
     +		layout=$(git config mergetool.vimdiff.layout)

 Documentation/config/mergetool.txt | 17 ++++++++++-------
 mergetools/vimdiff                 | 12 ++++++++++--
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 294f61efd1..f79c798b74 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -45,14 +45,17 @@ mergetool.meld.useAutoMerge::
 	value of `false` avoids using `--auto-merge` altogether, and is the
 	default value.
 
-mergetool.vimdiff.layout::
-	The vimdiff backend uses this variable to control how its split
-	windows appear. Applies even if you are using Neovim (`nvim`) or
-	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
-ifndef::git-mergetool[]
-	in linkgit:git-mergetool[1].
+mergetool.<vimdiff variant>.layout::
+	Git's vimdiff backend uses this variable to control how the split windows of
+	`<vimdiff variant>` appear. Here `<vimdiff variant>` is any of `vimdiff`,
+	`nvimdiff`, `gvimdiff`. To configure the layout and use the tool, see the
+	`BACKEND SPECIFIC HINTS`
+ifdef::git-mergetool[]
+	section.
+endif::[]
+ifndef::git-mergetool[]
+	section in linkgit:git-mergetool[1].
 endif::[]
-	for details.
 
 mergetool.hideResolved::
 	During a merge, Git will automatically resolve as many conflicts as
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 06937acbf5..97e376329b 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -371,9 +371,17 @@ diff_cmd_help () {
 
 
 merge_cmd () {
-	layout=$(git config mergetool.vimdiff.layout)
+	TOOL=$1
 
-	case "$1" in
+	layout=$(git config "mergetool.$TOOL.layout")
+
+	# backward compatibility:
+	if test -z "$layout"
+	then
+		layout=$(git config mergetool.vimdiff.layout)
+	fi
+
+	case "$TOOL" in
 	*vimdiff)
 		if test -z "$layout"
 		then

base-commit: 3e0d3cd5c7def4808247caf168e17f2bbf47892b
-- 
2.43.1

