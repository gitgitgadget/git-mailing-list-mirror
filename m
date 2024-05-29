Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1A18412E
	for <git@vger.kernel.org>; Wed, 29 May 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998548; cv=none; b=ZSVAQCU4i2H0jTfhucJwK8QYrD8ydkOGNSngQlKUiVoJiLtLHDqlv/L8eoSFVNE6VbtblHMsJAnMlf6yEGn7YJskVhqi75fM1pS6o3WudxtCOlSGpD5ZEpq/WpfmYLfFJlul5YKQApHx8S+J2NkKsPAhuLPrgVFuJ7JUtCGl19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998548; c=relaxed/simple;
	bh=EtwsCP9RJ9gXs5/qXzyIeg4Cmn7pbYnzYF/Pw1/qD2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cKCQoWnxVWwMv2F0ZGsXLfROA0k/THKsqWtj1GtGXpItMIY7CBtNQRoC6kvnBEr2j+oyQ4/BOOUefMwUG0LeAYQ67H088fmb4BkhnPajRR9ZSRUA32rG/W/7owWCKXUBqIt0kyHrxpgfQMtQt7S+jdDON33Q2gA3gNpNcVxpdfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UyKWqXcy; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UyKWqXcy"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B4E832A2EE;
	Wed, 29 May 2024 12:02:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EtwsCP9RJ9gXs5/qXzyIeg4Cmn7pbYnzYF/Pw1
	/qD2Y=; b=UyKWqXcyZRNT23AIWt/W8dPsKgrpxPZ9EFjQJCMgKy1TbUi7ZvQBh/
	PYaa1LsKJKCzIwiNUr0tTjkUYsX+j9ONvG9xHyYB58733IgIidsW2bWcJpfzhcIa
	ET5cYckZI8dGxaku/N5Lfgp6n7G/PUCw2wlxraWlWJq9CfBpdjFiE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AE3482A2ED;
	Wed, 29 May 2024 12:02:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C2B222A2EC;
	Wed, 29 May 2024 12:02:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: safe.directory wildcards
In-Reply-To: <715163c3-8d59-46ef-81bf-1dda10e6570c@samba.org> (Stefan
	Metzmacher's message of "Wed, 29 May 2024 11:08:50 +0200")
References: <715163c3-8d59-46ef-81bf-1dda10e6570c@samba.org>
Date: Wed, 29 May 2024 09:02:16 -0700
Message-ID: <xmqqplt4zjw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D2C3F838-1DD4-11EF-A47C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Stefan Metzmacher <metze@samba.org> writes:

> given the recent importance of safe.directory, it would be great to
> have something like '/data/git/*' to be supported, not just a single '*'
> for a server that serves a lot of public git repositories owned by different owners.

Interesting.

The original commit that introduced the '*' opt-out, 0f85c4a3
(setup: opt-out of check with safe.directory=*, 2022-04-13), was
done to specifically help those who have a large list of shared
repositories.  We could have moved all the way to allow globs back
then, and the possibility certainly was brought up.

  https://lore.kernel.org/git/xmqqk0bt9bsb.fsf@gitster.g/

But the loosening was done in a context of "brown paper bag fix"
so it is very much understandable that we did the simplest and most
obvious thing to avoid making silly mistakes in a haste.

I am reluctant to use wildmatch() but I would expect that in
practice "leading path matches" (in other words, "everything under
this directory is OK") is sufficient, perhaps?

------- >8 ------------- >8 ------------- >8 -------
Subject: safe.directory: allow "lead/ing/path/*" match

When safe.directory was introduced in v2.30.3 timeframe, 8959555c
(setup_git_directory(): add an owner check for the top-level
directory, 2022-03-02), it only allowed specific opt-out
directories.  Immediately after an embargoed release that included
the change, 0f85c4a3 (setup: opt-out of check with safe.directory=*,
2022-04-13) was done as a response to loosen the check so that a
single '*' can be used to say "I trust all repositories" for folks
who host too many repositories to list individually.

Let's further allow people to say "everything under this hierarchy
is deemed safe" by specifying such a leading directory with "/*"
appended to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/safe.txt |  3 ++-
 setup.c                       | 24 +++++++++++++++++-------
 t/t0033-safe-directory.sh     | 15 +++++++++++++++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git c/Documentation/config/safe.txt w/Documentation/config/safe.txt
index 577df40223..2d45c98b12 100644
--- c/Documentation/config/safe.txt
+++ w/Documentation/config/safe.txt
@@ -44,7 +44,8 @@ string `*`. This will allow all repositories to be treated as if their
 directory was listed in the `safe.directory` list. If `safe.directory=*`
 is set in system config and you want to re-enable this protection, then
 initialize your list with an empty value before listing the repositories
-that you deem safe.
+that you deem safe.  Giving a directory with `/*` appended to it will
+allow access to all repositories under the named directory.
 +
 As explained, Git only allows you to access repositories owned by
 yourself, i.e. the user who is running Git, by default.  When Git
diff --git c/setup.c w/setup.c
index 9247cded6a..83c4ea44cd 100644
--- c/setup.c
+++ w/setup.c
@@ -1177,13 +1177,23 @@ static int safe_directory_cb(const char *key, const char *value,
 	} else if (!strcmp(value, "*")) {
 		data->is_safe = 1;
 	} else {
-		const char *interpolated = NULL;
-
-		if (!git_config_pathname(&interpolated, key, value) &&
-		    !fspathcmp(data->path, interpolated ? interpolated : value))
-			data->is_safe = 1;
-
-		free((char *)interpolated);
+		const char *allowed = NULL;
+
+		if (!git_config_pathname(&allowed, key, value)) {
+			size_t len;
+
+			if (!allowed)
+				allowed = value;
+			if (ends_with(allowed, "/*")) {
+				len = strlen(allowed);
+				if (!fspathncmp(allowed, data->path, len - 1))
+					data->is_safe = 1;
+			} else if (!fspathcmp(data->path, allowed)) {
+				data->is_safe = 1;
+			}
+		}
+		if (allowed != value)
+			free((char *)allowed);
 	}
 
 	return 0;
diff --git c/t/t0033-safe-directory.sh w/t/t0033-safe-directory.sh
index 11c3e8f28e..5fe61f1291 100755
--- c/t/t0033-safe-directory.sh
+++ w/t/t0033-safe-directory.sh
@@ -71,7 +71,22 @@ test_expect_success 'safe.directory=*, but is reset' '
 	expect_rejected_dir
 '
 
+test_expect_success 'safe.directory with matching glob' '
+	git config --global --unset-all safe.directory &&
+	p=$(pwd) &&
+	git config --global safe.directory "${p%/*}/*" &&
+	git status
+'
+
+test_expect_success 'safe.directory with unmatching glob' '
+	git config --global --unset-all safe.directory &&
+	p=$(pwd) &&
+	git config --global safe.directory "${p%/*}no/*" &&
+	expect_rejected_dir
+'
+
 test_expect_success 'safe.directory in included file' '
+	git config --global --unset-all safe.directory &&
 	cat >gitconfig-include <<-EOF &&
 	[safe]
 		directory = "$(pwd)"
