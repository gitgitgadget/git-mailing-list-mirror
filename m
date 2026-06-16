Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1448B3ACA64
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648795; cv=none; b=cMaRBbz8k7uIC9mEEaFpIKLBw+copHqv1AflNotObu3DuezerNOYSLUcLs81f53qeqbuMoCiN2NAzOm6gFOi6IHvtOvBjHGRi83oXI8fe+Y8z9z690LhHmVnHBj3M+qVQLtybU0KwXu/erUpOhy1mIeo7KLnogi4/boP78r17Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648795; c=relaxed/simple;
	bh=PLebOYd1G6D+y7Wd6cx7HjquBZWdtvrEjMUQaL9DZK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mheK0UvKH0IyfONbcA2zST7e6vXtw9jItP9NtdKnm4NEmCa35AycWQRVlnxIgVhdEOKytFG351RIQOooFJ5BW7vbMScUKK3wqnRqPuPKtDTArt+K1fXHfiSL1nx8ZlRqaznpcoN+FhC8wbUv6+wYchAYs4hGAPyXcSUm5vIDio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=IWa++xUK; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="IWa++xUK"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id C422C600E8;
	Tue, 16 Jun 2026 22:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781648792; bh=PLebOYd1G6D+y7Wd6cx7HjquBZWdtvrEjMUQaL9DZK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWa++xUKiFKaIvxIKZpEZxqPw2irbN7nLQBKluocIfDNXWQGtUybjvDreUt+o1BLc
	 pi2MHOr+Q3Q6utH4RRdSHSfMc7pR54/Ostzar6aWlsvapTdK88KqFVmEWlOZO8QBTg
	 G2sbSqwUjuqgURXmWWN9ACA4WXomyChpvOLkHnmY=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] Introduce fetch.followRemoteHEAD config variable
Date: Tue, 16 Jun 2026 18:25:14 -0400
Message-ID: <20260616222606.1003521-1-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612055947.1499497-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-fetch presently offers some useful ways to control how remote HEAD
symbolic-refs are (or aren't) updated when fetching from remote
repositories.  Namely this is done via the
'remote.<name>.followRemoteHEAD' configuration variable.

However, this setting can be somewhat painful to use if you prefer a
default other than "create" and often work with multiple different
remote repositories.

This series introduces the variable 'fetch.followRemoteHEAD', which
provides a configurable default in place of per-remote settings.

'fetch.followRemoteHEAD' functions exactly the same as the original
variable, except that it doesn't allow warning suppression via
'warn-if-not-$branch'.  Given that different remotes will vary their
HEAD and set of branches independently, setting a false-positive
globally in this way doesn't make logical sense.

While it is not mentioned by any of the patches in this series, note
also that the behavior introduced by 012bc566bad7 (remote set-head: set
followRemoteHEAD to "warn" if "always") is unaffected by this series,
and this feature continues to work for only the
'remote.<name>.followRemoteHEAD' variable.

--- 

Changes in v2:
  - Don't die() if the value of fetch.followRemoteHEAD is unrecognized.
  - Use case-sensitive matching for fetch.followRemoteHEAD values.
  - Avoid the phrase "configuration option".
  - Minor documentation wording changes.
  - Link to v1: https://patch.msgid.link/20260612055947.1499497-1-m@lfurio.us

Matt Hunter (7):
  fetch: fixup set_head advice for warn-if-not-branch
  doc: explain fetchRemoteHEADWarn advice
  t5510: cleanup remote in followRemoteHEAD dangling ref test
  fetch: rename function report_set_head
  fetch: refactor do_fetch handling of followRemoteHEAD
  fetch: add configuration variable fetch.followRemoteHEAD
  fetch: fixup a misaligned comment

 Documentation/config/advice.adoc |   4 ++
 Documentation/config/fetch.adoc  |  19 ++++++
 Documentation/config/remote.adoc |  21 +++---
 builtin/fetch.c                  |  49 ++++++++++----
 remote.h                         |  14 ++--
 t/t5510-fetch.sh                 | 106 +++++++++++++++++++++++++++++++
 6 files changed, 183 insertions(+), 30 deletions(-)

Range-diff against v1:
1:  779fb9bfc59f = 1:  2106228f7b98 fetch: fixup set_head advice for warn-if-not-branch
2:  aacc2856bc77 = 2:  b1c58c06e0c7 doc: explain fetchRemoteHEADWarn advice
3:  f5272eaafbcc = 3:  c1d11e8883e6 t5510: cleanup remote in followRemoteHEAD dangling ref test
4:  43a17027c13e = 4:  6306c8212fc0 fetch: rename function report_set_head
5:  c719435d9675 ! 5:  3c7257094686 fetch: refactor do_fetch handling of followRemoteHEAD
    @@ Commit message
     
         Update enum follow_remote_head_settings to include the value
         FOLLOW_REMOTE_UNCONFIGURED as the new zero-initialized value for
    -    followRemoteHEAD.  This will allow us to distinguish between the option
    -    being unset vs. explicitly set to 'create', which is ultimately the
    -    system default.  The unnecessary indentation is removed.
    +    followRemoteHEAD.  This will allow us to distinguish between the
    +    variable being unset vs. explicitly set to 'create', which is ultimately
    +    the system default.  The unnecessary indentation is removed.
     
         The do_fetch function is likewise updated to perform its own decision
         making to determine the effective followRemoteHEAD mode, falling back to
         the system default if necessary.  This will enable the next patch to
    -    introduce a user-configurable fallback default option.
    +    introduce a user-configurable default.
     
    -    Function set_head now accepts this value as an argument rather than only
    +    Function set_head now accepts the mode as an argument rather than only
         considering the value defined by the remote.
     
         The use of the 'warn-if-not-$branch' value is awkward in the context of
    -    a global default option, since the branches will differ between
    -    individual remotes.  For this reason, it's left out of this scheme and
    -    handling of the no_warn_branch variable is untouched.  Since a
    -    remote-specific setting for followRemoteHEAD takes priority, we can
    -    assume that if remote->no_warn_branch is set, then the remote is also
    -    asserting FOLLOW_REMOTE_WARN as the effective operating mode, and it
    -    will be honored by do_fetch.
    +    a global default, since the branches will differ between individual
    +    remotes.  For this reason, it's left out of this scheme and handling of
    +    the no_warn_branch variable is untouched.  Since a remote-specific
    +    value for followRemoteHEAD takes priority, we can assume that if
    +    remote->no_warn_branch is set, then the remote is also asserting
    +    FOLLOW_REMOTE_WARN as the effective operating mode, and it will be
    +    honored by do_fetch.
     
         Signed-off-by: Matt Hunter <m@lfurio.us>
     
6:  56f6fc8ded2d ! 6:  af9f99b1ceb2 fetch: add configuration option fetch.followRemoteHEAD
    @@ Metadata
     Author: Matt Hunter <m@lfurio.us>
     
      ## Commit message ##
    -    fetch: add configuration option fetch.followRemoteHEAD
    +    fetch: add configuration variable fetch.followRemoteHEAD
     
    -    'fetch.followRemoteHEAD' is added as a generic option used by all
    +    'fetch.followRemoteHEAD' is added as a generic setting used by all
         remotes for which 'remote.<name>.followRemoteHEAD' is undefined.  If
    -    both options are undefined, a builtin default of "create" is in effect,
    -    matching the previous behavior.
    +    both variables are undefined, a builtin default of "create" is in
    +    effect, matching the previous behavior.
     
         As mentioned in the previous patch, 'fetch.followRemoteHEAD' supports
         all of the values that its 'remote' counterpart does _except_
    @@ Commit message
         repositories.
     
         Documentation and advice messages for both of the followRemoteHEAD
    -    options are reworded to better capture the relationship between the two.
    +    variables are reworded to better capture the relationship between the
    +    two.
     
         The added tests assert feature parity between the two followRemoteHEAD
    -    options, as well as the fact that 'remote.<name>.followRemoteHEAD'
    +    variables, as well as the fact that 'remote.<name>.followRemoteHEAD'
         always supersedes this new configurable default.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Matt Hunter <m@lfurio.us>
     
      ## Documentation/config/fetch.adoc ##
    @@ Documentation/config/fetch.adoc: the new bundle URI.
      remove the value for the `fetch.bundleCreationToken` value before fetching.
     +
     +`fetch.followRemoteHEAD`::
    -+	When fetching using a default refspec, this option determines how to handle
    ++	When fetching using a default refspec, this setting determines how to handle
     +	differences between a fetched remote's `HEAD` and the local
     +	`remotes/<name>/HEAD` symbolic-ref.  Its value is one of
     ++
    @@ Documentation/config/remote.adoc: Blank values signal to ignore all previous val
     -	Setting it to "always" will silently update `remotes/<name>/HEAD` to
     -	the value on the remote.  Finally, setting it to "never" will never
     -	change or create the local reference.
    -+	When fetching this remote using its default refspec, this option determines
    ++	When fetching this remote using its default refspec, this setting determines
     +	how to handle differences between the remote's `HEAD` and the local
    -+	`remotes/<name>/HEAD` symbolic-ref.  Overrides the setting for
    ++	`remotes/<name>/HEAD` symbolic-ref.  Overrides the value of
     +	`fetch.followRemoteHEAD`.  See `fetch.followRemoteHEAD` for a description of
     +	accepted values.
     ++
    -+In addition to the values supported by `fetch.followRemoteHEAD`, this option may
    -+also take on the value "warn-if-not-`$branch`", which behaves like "warn", but
    -+ignores the warning if the remote's `HEAD` is `remotes/<name>/$branch`.
    ++In addition to the values supported by `fetch.followRemoteHEAD`, this setting
    ++may also take on the value "warn-if-not-`$branch`", which behaves like "warn",
    ++but ignores the warning if the remote's `HEAD` is `remotes/<name>/$branch`.
     
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
    @@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
     +	if (!strcmp(k, "fetch.followremotehead")) {
     +		if (!v)
     +			return config_error_nonbool(k);
    -+		else if (!strcasecmp(v, "never"))
    ++		else if (!strcmp(v, "never"))
     +			fetch_config->follow_remote_head = FOLLOW_REMOTE_NEVER;
    -+		else if (!strcasecmp(v, "create"))
    ++		else if (!strcmp(v, "create"))
     +			fetch_config->follow_remote_head = FOLLOW_REMOTE_CREATE;
    -+		else if (!strcasecmp(v, "warn"))
    ++		else if (!strcmp(v, "warn"))
     +			fetch_config->follow_remote_head = FOLLOW_REMOTE_WARN;
    -+		else if (!strcasecmp(v, "always"))
    ++		else if (!strcmp(v, "always"))
     +			fetch_config->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
    -+		else
    -+			die(_("invalid value for '%s': '%s'"),
    -+				"fetch.followRemoteHEAD", v);
     +	}
     +
      	return git_default_config(k, v, ctx, cb);
    @@ builtin/fetch.c: static const char *strip_refshead(const char *name){
     -	   "will disable the warning until the remote changes HEAD to something else.");
     +	N_("Run 'git remote set-head %s %s' to follow the change, or modify\n"
     +	   "either of the 'remote.%s.followRemoteHEAD' or 'fetch.followRemoteHEAD'\n"
    -+	   "configuration options to handle the situation differently.\n\n"
    ++	   "configuration variables to handle the situation differently.\n\n"
     +
    -+	   "Using this specific option\n\n"
    ++	   "Using this specific setting\n\n"
     +	   "    git config set remote.%s.followRemoteHEAD warn-if-not-%s\n\n"
     +	   "will suppress the warning until the remote changes HEAD to something else.");
      
7:  5e0bdd0f00b4 = 7:  5c80107f6488 fetch: fixup a misaligned comment

base-commit: 0fae78c9d55efe705877ea537fe42c59164ccd94
-- 
2.54.0

