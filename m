Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C212BE96
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130639; cv=none; b=DPqPoVbKTQT7fbYmhpbFq5gvf5LsdcbNBWdg9u3DW+ULdBChpnshXedY797H0nUeJCOEzTf5+jx0Hs0GQRvAJi0HdXBT4m+lMluzBL+yArSTJae6vBMqZ0sRSwu0KBs4Xg3jfcXThjsmnqctcs2ipEnu1q+XYCBQEoAlAwowqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130639; c=relaxed/simple;
	bh=9P4YkFyGHo0/DszuhDRw/kZnz53uWSwKO9V6452fiLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pWuEgBku1B8f9VKPrp5P3TEviOUXc8F/zRhKfLB2nI4FsskeP/rZkbOOE4e32VcTBgHH0NUC41heZiMoDqzOlfivyV7BrMUZ91/+WOmmoYvLuxvZrMTNI/pj2syIQpyebDdYZyKj93ypSE8eEYSrMeT5fGj92smq5FkbbBY8wkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U1MYlx4c; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U1MYlx4c"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 18BD825682;
	Wed, 24 Jan 2024 16:10:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	P4YkFyGHo0/DszuhDRw/kZnz53uWSwKO9V6452fiLc=; b=U1MYlx4catAbWWKwT
	XAXWFCIcdi8iau+As3u9K0W2aQJnxDWzgrxQgghwznfjsnVmf1BKz29EPFM43Svy
	qlePkAUY3hhhxTVMR76dNbqgqS8nf8bOIBmGT9Wo9v8Wl7B02xok+A5BqZ8F4rDF
	GfU0sSfLVnxGfcBuf8j9728nrY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1065B25681;
	Wed, 24 Jan 2024 16:10:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 24E0425680;
	Wed, 24 Jan 2024 16:10:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    =?utf-8?B?UmHDumwgTsO6w7Fleg==?= de Arenas Coronado <raulnac@gmail.com> 
Subject: [PATCH] ls-files: avoid the verb "deprecate" for individual options
Date: Wed, 24 Jan 2024 13:10:31 -0800
Message-ID: <xmqqjznybfp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 02CEE3A2-BAFD-11EE-8456-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

When e750951e (ls-files: guide folks to --exclude-standard over
other --exclude* options, 2023-01-13) updated the documentation to
give greater visibility to the `--exclude-standard` option, it marked
the `--exclude-per-directory` option as "deprecated".

While it is technically correct that being deprecated does not
necessarily mean it is planned to be removed later, it seems to
cause confusion to readers, especially when we merely mean

    The option Y can be used to achieve the same thing as the option
    X much simpler. To those of you who aren't familiar with either
    X or Y, we would recommend to use Y when appropriate.

This is especially true for `--exclude-standard` vs the combination
of more granular `--exclude-from` and `--exclude-per-directory`
options.  It is true that one common combination of the granular
options can be obtained by just giving the former, but that does not
necessarily mean a more granular control is not necessary.

State the reason why we recommend readers `--exclude-standard` in
the description of `--exclude-per-directory`, instead of saying that
the option is deprecated.  Also, spell out the recipe to emulate
what `--exclude-standard` does, so that the users can give it minute
tweaks (like "do the same as Git Porcelain, except I do not want to
read the global exclusion file from core.excludes").

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * With the grammofix by Peff squashed in and with minor tweaks to
   the proposed log message.

 Documentation/git-ls-files.txt | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index f65a8cd91d..9447f2d8f4 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -119,8 +119,10 @@ OPTIONS
 
 --exclude-per-directory=<file>::
 	Read additional exclude patterns that apply only to the
-	directory and its subdirectories in <file>.  Deprecated; use
-	--exclude-standard instead.
+	directory and its subdirectories in <file>.  If you are
+	trying to emulate the way Porcelain commands work, using
+	the `--exclude-standard` instead is easier and more
+	thorough.
 
 --exclude-standard::
 	Add the standard Git exclusions: .git/info/exclude, .gitignore
@@ -298,9 +300,8 @@ traversing the directory tree and finding files to show when the
 flags --others or --ignored are specified.  linkgit:gitignore[5]
 specifies the format of exclude patterns.
 
-Generally, you should just use --exclude-standard, but for historical
-reasons the exclude patterns can be specified from the following
-places, in order:
+These exclude patterns can be specified from the following places,
+in order:
 
   1. The command-line flag --exclude=<pattern> specifies a
      single pattern.  Patterns are ordered in the same order
@@ -322,6 +323,18 @@ top of the directory tree.  A pattern read from a file specified
 by --exclude-per-directory is relative to the directory that the
 pattern file appears in.
 
+Generally, you should be able to use `--exclude-standard` when you
+want the exclude rules applied the same way as what Porcelain
+commands do.  To emulate what `--exclude-standard` specifies, you
+can give `--exclude-per-directory=.gitignore`, and then specify:
+
+  1. The file specified by the `core.excludesfile` configuration
+     variable, if exists, or the `$XDG_CONFIG_HOME/git/ignore` file.
+
+  2. The `$GIT_DIR/info/exclude` file.
+
+via the `--exclude-from=` option.
+
 SEE ALSO
 --------
 linkgit:git-read-tree[1], linkgit:gitignore[5]
-- 
2.43.0-386-ge02ecfcc53

