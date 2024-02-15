Received: from renault.us.lt (renault.us.lt [79.98.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE15182BF
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.98.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987668; cv=none; b=BEkei0naSL23GGk8IcY/XOxTjUDUvl/e8wJ4pjcK8gPQu5TmysKmpYLeZ46zVTmXptfrzjLO1K/wE8IDFsmota7hpqXslWY10zullayhczvPOQJY4TSnT4MVupjyymsSYdN39EJBMqw8+rVbRBrU1z+9jdNIljB9dcUT6zE/0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987668; c=relaxed/simple;
	bh=N/V3c344thzzwzeIl1i2y3U4Qhbf4TDaY3Kd47GA4Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lm811XoOL2FORGumFzVyg9bMwTJTAh/WG1Jpkcdlun2xwrvwJNvq+6kewtBzcMTlzcsjzbeJNiCVnA201t++GZFJJSqwpMbCUkOSk3w0qg0zf2/PaV0sRM89YdOW+Lt9Ohqu6Vz90ZjMNu7UvmaAcyERyyZFdXSah/LlwgsFl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org; spf=pass smtp.mailfrom=kipras.org; arc=none smtp.client-ip=79.98.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kipras.org
Received: from [157.230.0.129] (helo=localhost.localdomain)
	by renault.us.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <kipras@kipras.org>)
	id 1raXHY-0008EE-2q; Thu, 15 Feb 2024 10:39:48 +0200
From: Kipras Melnikovas <kipras@kipras.org>
To: git@vger.kernel.org
Cc: greenfoo@u92.eu,
	Kipras Melnikovas <kipras@kipras.org>
Subject: [PATCH] mergetools: vimdiff: use correct tool's name when reading mergetool config
Date: Thu, 15 Feb 2024 10:39:18 +0200
Message-ID: <20240215083917.98218-2-kipras@kipras.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: kipras

I was curious why layout customizations, such as the multi-tab layout,
worked fine with vimdiff, but when changing to nvimdiff, it wouldn't anymore,
and instead showed the default view.

I was testing with the following config, everything was fine:

```conf
[merge]
	tool = vimdiff

[mergetool "vimdiff"]
	layout = local,base,remote / merged + base,local + base,remote + (local/base/remote),merged
```

```sh
git mergetool # opens vim w/ the custom 4-tab layout
```

But then I'd swap the tool to nvimdiff:

```diff
[merge]
-	tool = vimdiff
+	tool = nvimdiff

-[mergetool "vimdiff"]
+[mergetool "nvimdiff"]
	layout = local,base,remote / merged + base,local + base,remote + (local/base/remote),merged
```

and I'd get only the default 1-tab layout in neovim.

At first I thought that unlike vim,
neovim was somehow unable to launch multiple tabs.. Not the case.

Turns out, the /mergetools/vimdiff script, which handles both vimdiff, nvimdiff
and gvimdiff mergetools (the latter 2 simply source the vimdiff script), had a
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

Signed-off-by: Kipras Melnikovas <kipras@kipras.org>
---
 Documentation/config/mergetool.txt | 9 +++++----
 mergetools/vimdiff                 | 6 ++++--
 2 files changed, 9 insertions(+), 6 deletions(-)

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
index 06937acbf5..dd6bc411d9 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -371,9 +371,11 @@ diff_cmd_help () {
 
 
 merge_cmd () {
-	layout=$(git config mergetool.vimdiff.layout)
+	TOOL=$1
 
-	case "$1" in
+	layout=$(git config mergetool.$TOOL.layout)
+
+	case "$TOOL" in
 	*vimdiff)
 		if test -z "$layout"
 		then
-- 
2.43.1

