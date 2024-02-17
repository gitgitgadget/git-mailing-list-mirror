Received: from renault.us.lt (renault.us.lt [79.98.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3D7CF1C
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.98.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187295; cv=none; b=ajyeOqtjQ/AV6N9inyADbDhpXtDzHnDm4PyaLOBd8szkGXJ8jxVKvf751DIPnVs7fcNuGxxyBnkDeUbuJyKeD23IcASkWS1M7QxpebEofJu5QMQ6jYhQx0eDx5ORXd03VY4wPFgzwUeaE0tt7gxDdHY5TuQpg1WAjPG5TUJ8eSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187295; c=relaxed/simple;
	bh=ykNg4+ezS9cxEYFqPjyv6th2ccJH+TV/suXNzh8e5E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oy6BrTukH1Wu01ipOcvQHPu7wU1HEqiOF9WgjDS9LodVC9LFTqqnZqtxlhJ5i+MO342/+nb0AjmNYs3b1DcgbnclfoIDsFm6Hn9lfJZL9zC0qRlhS03eLzof/X5gJz6/lUUZNhj77oUKanAe5o+owNrX/uTpqoFmKzRvkkKTunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org; spf=pass smtp.mailfrom=kipras.org; arc=none smtp.client-ip=79.98.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kipras.org
Received: from [157.230.0.129] (helo=localhost.localdomain)
	by renault.us.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <kipras@kipras.org>)
	id 1rbNXm-0002jX-JL; Sat, 17 Feb 2024 18:28:03 +0200
From: Kipras Melnikovas <kipras@kipras.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	greenfoo@u92.eu,
	Kipras Melnikovas <kipras@kipras.org>
Subject: [PATCH v4] mergetools: vimdiff: use correct tool's name when reading mergetool config
Date: Sat, 17 Feb 2024 18:27:18 +0200
Message-ID: <20240217162718.21272-1-kipras@kipras.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240217074343.12608-1-kipras@kipras.org>
References: <20240217074343.12608-1-kipras@kipras.org>
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

Okay I've finalised the documentation, should be the last patch.
Also I realise I've forgotten to cc the mailing list on my replies to
Junio and Fernando - sorry! First time..

Range-diff against v3:
1:  0018c7e18c = 1:  0018c7e18c mergetools: vimdiff: use correct tool's name when reading mergetool config

 Documentation/config/mergetool.txt   | 21 ++++++++++++++-------
 Documentation/mergetools/vimdiff.txt |  3 ++-
 mergetools/vimdiff                   | 12 ++++++++++--
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 294f61efd1..00bf665aa0 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -45,14 +45,21 @@ mergetool.meld.useAutoMerge::
 	value of `false` avoids using `--auto-merge` altogether, and is the
 	default value.
 
-mergetool.vimdiff.layout::
-	The vimdiff backend uses this variable to control how its split
-	windows appear. Applies even if you are using Neovim (`nvim`) or
-	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
-ifndef::git-mergetool[]
-	in linkgit:git-mergetool[1].
+mergetool.<vimdiff variant>.layout::
+	Configure the split window layout for vimdiff's `<variant>`, which is any of `vimdiff`,
+	`nvimdiff`, `gvimdiff`.
+	Upon launching `git mergetool` with `--tool=<variant>` (or without `--tool`
+	if `merge.tool` is configured as `<variant>`), Git will consult
+	`mergetool.<variant>.layout` to determine the tool's layout. If the
+	variant-specific configuration is not available, `vimdiff`'s is used as
+	fallback.  If that too is not available, a default layout with 4 windows
+	will be used.  To configure the layout, see the `BACKEND SPECIFIC HINTS`
+ifdef::git-mergetool[]
+	section.
+endif::[]
+ifndef::git-mergetool[]
+	section in linkgit:git-mergetool[1].
 endif::[]
-	for details.
 
 mergetool.hideResolved::
 	During a merge, Git will automatically resolve as many conflicts as
diff --git a/Documentation/mergetools/vimdiff.txt b/Documentation/mergetools/vimdiff.txt
index d1a4c468e6..befa86d692 100644
--- a/Documentation/mergetools/vimdiff.txt
+++ b/Documentation/mergetools/vimdiff.txt
@@ -177,7 +177,8 @@ Instead of `--tool=vimdiff`, you can also use one of these other variants:
 
 When using these variants, in order to specify a custom layout you will have to
 set configuration variables `mergetool.gvimdiff.layout` and
-`mergetool.nvimdiff.layout` instead of `mergetool.vimdiff.layout`
+`mergetool.nvimdiff.layout` instead of `mergetool.vimdiff.layout` (though the
+latter will be used as fallback if the variant-specific one is not set).
 
 In addition, for backwards compatibility with previous Git versions, you can
 also append `1`, `2` or `3` to either `vimdiff` or any of the variants (ex:
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

