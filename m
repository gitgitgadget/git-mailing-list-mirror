Received: from renault.us.lt (renault.us.lt [79.98.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08A131E30
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.98.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006876; cv=none; b=RT+1Mb3dvWd3+TJ3qHSXz2ujw2lQTxjO8eUvlRIIXSFnGpl4Z97Ra52+8E/pfIeu4MGh5WlTB1UMp2rDdMeT4Q7VMiHuOURETO5tRMzVlzG5G/XPoG8F6tR0XlSYFrDqRYwKhiyqULdnk0ogLRSByj0pHJ51yRHTUzi+dan4iPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006876; c=relaxed/simple;
	bh=wUHU1IeVi/UH/oOjk1wtrYljk2bIPNlXZQN6nl0rGcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGg9vX6aEuW8VOh3Oezmrit1N3yh8eRkmAKbcM2PkTz3MM2j2W9GD8mXxPzkLZ3UnyWdePGp2cDnsWu0LnApmbwg0UCkvO21EvFHJ2zzFSVPi+iJ5Vh7o+ciYz/Ofi0jIZHYeHLkbVQI5wgzMV3SFs/mWTJGkxZVEIhpVh2XUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org; spf=pass smtp.mailfrom=kipras.org; arc=none smtp.client-ip=79.98.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kipras.org
Received: from [157.230.0.129] (helo=localhost.localdomain)
	by renault.us.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <kipras@kipras.org>)
	id 1racbo-0004zI-UB; Thu, 15 Feb 2024 16:21:05 +0200
From: Kipras Melnikovas <kipras@kipras.org>
To: git@vger.kernel.org
Cc: greenfoo@u92.eu,
	Kipras Melnikovas <kipras@kipras.org>
Subject: [PATCH v2] mergetools: vimdiff: use correct tool's name when reading mergetool config
Date: Thu, 15 Feb 2024 16:20:02 +0200
Message-ID: <20240215142002.36870-1-kipras@kipras.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240215083917.98218-2-kipras@kipras.org>
References: <20240215083917.98218-2-kipras@kipras.org>
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

---
mergetool.vimdiff.layout::
	The vimdiff backend uses this variable to control how its split
	windows look like. Applies even if you are using Neovim (`nvim`) or
	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
---

which makes sense why it's explained this way - the vimdiff backend is used by
gvim and nvim. But the mergetool's configuration should be separate for each tool,
and indeed that's confirmed in same commit at Documentation/mergetools/vimdiff.txt:

---
Variants

Instead of `--tool=vimdiff`, you can also use one of these other variants:
  * `--tool=gvimdiff`, to open gVim instead of Vim.
  * `--tool=nvimdiff`, to open Neovim instead of Vim.

When using these variants, in order to specify a custom layout you will have to
set configuration variables `mergetool.gvimdiff.layout` and
`mergetool.nvimdiff.layout` instead of `mergetool.vimdiff.layout`
---

So it looks like we just forgot to update the 1 part of the vimdiff script
that read the config variable. Cheers.

Though, for backwards-compatibility, I've kept the mergetool.vimdiff
fallback, so that people who unknowingly relied on it, won't have their
setup broken now.

Signed-off-by: Kipras Melnikovas <kipras@kipras.org>
---
Range-diff against v1:
1:  197e42deef ! 1:  070280d95d mergetools: vimdiff: use correct tool's name when reading mergetool config
    @@ Metadata
      ## Commit message ##
         So it looks like we just forgot to update the 1 part of the vimdiff script
         that read the config variable. Cheers.
     
    +    Though, for backwards-compatibility, I've kept the mergetool.vimdiff
    +    fallback, so that people who unknowingly relied on it, won't have their
    +    setup broken now.
    +
         Signed-off-by: Kipras Melnikovas <kipras@kipras.org>
     
    @@ mergetools/vimdiff: diff_cmd_help () {
     -	case "$1" in
     +	layout=$(git config mergetool.$TOOL.layout)
     +
    ++	# backwards-compatibility:
    ++	if test -z "$layout"
    ++	then
    ++		layout=$(git config mergetool.vimdiff.layout)
    ++	fi
    ++
     +	case "$TOOL" in
      	*vimdiff)
      		if test -z "$layout"

 Documentation/config/mergetool.txt |  9 +++++----
 mergetools/vimdiff                 | 12 ++++++++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 294f61efd1..8e3d321a57 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -45,10 +45,11 @@ mergetool.meld.useAutoMerge::
 	value of `false` avoids using `--auto-merge` altogether, and is the
 	default value.
 
-mergetool.vimdiff.layout::
-	The vimdiff backend uses this variable to control how its split
-	windows appear. Applies even if you are using Neovim (`nvim`) or
-	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
+mergetool.{g,n,}vimdiff.layout::
+	The vimdiff backend uses this variable to control how its split windows
+	appear. Use `mergetool.vimdiff` for regular Vim, `mergetool.nvimdiff` for
+	Neovim and `mergetool.gvimdiff` for gVim to configure the merge tool. See
+	BACKEND SPECIFIC HINTS section
 ifndef::git-mergetool[]
 	in linkgit:git-mergetool[1].
 endif::[]
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 06937acbf5..0e3058868a 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -371,9 +371,17 @@ diff_cmd_help () {
 
 
 merge_cmd () {
-	layout=$(git config mergetool.vimdiff.layout)
+	TOOL=$1
 
-	case "$1" in
+	layout=$(git config mergetool.$TOOL.layout)
+
+	# backwards-compatibility:
+	if test -z "$layout"
+	then
+		layout=$(git config mergetool.vimdiff.layout)
+	fi
+
+	case "$TOOL" in
 	*vimdiff)
 		if test -z "$layout"
 		then

base-commit: 4fc51f00ef18d2c0174ab2fd39d0ee473fd144bd
-- 
2.43.1

