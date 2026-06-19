Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7435AC1C
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862508; cv=none; b=PtG1Q9pdKj95lBS8aM+hPKfxemCYdiQOiClrCAm5aQqec8yGQRZhfr3evskiO0yyv65t7kO1dBgmACAgoAlynUZYE3qEB386TiFMz/n/KshUil8vfJ78s4hdMe5BePMNcI0JVLbL7qb/rWcDCAukp3rbHjXlH61QlVGUX9ySN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862508; c=relaxed/simple;
	bh=fRfWKDLkIW3eAfK/8WfEnfjeQGF+alrLN+qUgy7eo+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uphZnYhUjX51WIYwKwgFcwR9nUTYqKWaV6jWv+Sw4Qaz7P6tun5+iiQSoafQL/Eh0Tx9z57w/K589DjNppLbBAVwbEnF/7UURWHB3ok49TIOoMCv+HYjc63/UWLYpoBdbsrwCuQNTYKtuTm4sfk66iH7X0hHb5u4ZnCZYCw8Hi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=KrGEE96j; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="KrGEE96j"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 7EC10600DE;
	Fri, 19 Jun 2026 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781862497; bh=fRfWKDLkIW3eAfK/8WfEnfjeQGF+alrLN+qUgy7eo+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrGEE96jVIm6V4ElaX0Gj+7HHjkxZmN2eNi5UHc6wLke2pt9r6D1gFBWx69cTcYgx
	 QXhDosPLD1HeluF2GGXIrBvAAiY48zBNYKCRZkRsRXG0vUpixSzLfagQ/8tehxjzJG
	 rcaeKPppqNUtan8rt2V1sPI1Cae7YvTi6ckNmguU=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/8] Introduce fetch.followRemoteHEAD config variable
Date: Fri, 19 Jun 2026 05:44:19 -0400
Message-ID: <20260619094751.2996804-1-m@lfurio.us>
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

Hi Junio,

The changes we discussed are implemented, but I also included a last
second related fix to control flow of git-fetch config parsing.

See patch 5/8 (fetch: return 0 on known git_fetch_config),
as well as a similar line squashed into
7/8 (fetch: add configuration variable fetch.followRemoteHEAD)

Thanks.

Changes in v3:
  - Produce warning when fetch.followRemoteHEAD is set to a bogus value.
  - Leave NEEDSWORK comment detailing future improvements.
  - Avoid calling git_default_config unnecessarily in git-fetch.
  - Link to v2: https://patch.msgid.link/20260616222606.1003521-1-m@lfurio.us

Changes in v2:
  - Don't die() if the value of fetch.followRemoteHEAD is unrecognized.
  - Use case-sensitive matching for fetch.followRemoteHEAD values.
  - Avoid the phrase "configuration option".
  - Minor documentation wording changes.
  - Link to v1: https://patch.msgid.link/20260612055947.1499497-1-m@lfurio.us

Matt Hunter (8):
  fetch: fixup set_head advice for warn-if-not-branch
  doc: explain fetchRemoteHEADWarn advice
  t5510: cleanup remote in followRemoteHEAD dangling ref test
  fetch: rename function report_set_head
  fetch: return 0 on known git_fetch_config
  fetch: refactor do_fetch handling of followRemoteHEAD
  fetch: add configuration variable fetch.followRemoteHEAD
  fetch: fixup a misaligned comment

 Documentation/config/advice.adoc |   4 ++
 Documentation/config/fetch.adoc  |  19 ++++++
 Documentation/config/remote.adoc |  21 +++---
 builtin/fetch.c                  |  62 ++++++++++++++----
 remote.h                         |  14 ++--
 t/t5510-fetch.sh                 | 106 +++++++++++++++++++++++++++++++
 6 files changed, 196 insertions(+), 30 deletions(-)

Range-diff against v2:
1:  2106228f7b98 = 1:  48b23e0e2008 fetch: fixup set_head advice for warn-if-not-branch
2:  b1c58c06e0c7 = 2:  a68e5edf92b7 doc: explain fetchRemoteHEADWarn advice
3:  c1d11e8883e6 = 3:  bfe7891e6105 t5510: cleanup remote in followRemoteHEAD dangling ref test
4:  6306c8212fc0 = 4:  8bc1e56dafca fetch: rename function report_set_head
-:  ------------ > 5:  3568b03adc97 fetch: return 0 on known git_fetch_config
5:  3c7257094686 = 6:  b6c919d821d0 fetch: refactor do_fetch handling of followRemoteHEAD
6:  af9f99b1ceb2 ! 7:  dc1e05646887 fetch: add configuration variable fetch.followRemoteHEAD
    @@ Commit message
         warn-if-not-$branch, due to its tighter coupling to individual remote
         repositories.
     
    +    This setting interacts with the do_fetch mechanism in the same way as
    +    the previous does, but there are opportunities for improved
    +    user-experience discussed in [1].  See the included NEEDSWORK comment as
    +    well.
    +
         Documentation and advice messages for both of the followRemoteHEAD
         variables are reworded to better capture the relationship between the
         two.
    @@ Commit message
         variables, as well as the fact that 'remote.<name>.followRemoteHEAD'
         always supersedes this new configurable default.
     
    +    [1]: https://lore.kernel.org/git/xmqqh5n213bw.fsf@gitster.g/
    +
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Matt Hunter <m@lfurio.us>
     
    @@ builtin/fetch.c: static struct string_list negotiation_include = STRING_LIST_INI
      	int prune;
      	int prune_tags;
     @@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
    - 			    "fetch.output", v);
    + 		return 0;
      	}
      
     +	if (!strcmp(k, "fetch.followremotehead")) {
    @@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
     +			fetch_config->follow_remote_head = FOLLOW_REMOTE_WARN;
     +		else if (!strcmp(v, "always"))
     +			fetch_config->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
    ++		else
    ++			warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), v);
    ++		return 0;
     +	}
     +
      	return git_default_config(k, v, ctx, cb);
    @@ builtin/fetch.c: static const char *strip_refshead(const char *name){
      	advise_if_enabled(ADVICE_FETCH_SET_HEAD_WARN, _(message_advice_set_head),
      			remote, head_name, remote, remote, head_name);
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
    + 			goto cleanup;
    + 	}
      
    ++	/*
    ++	 * NEEDSWORK: By the time this function executes, we have already parsed
    ++	 * all such followRemoteHEAD values from the external configuration,
    ++	 * potentially emitting warning messages for bogus values.  Ideally, if
    ++	 * this fetch ends up not needing to consult these values, then git would
    ++	 * not ever output a value warning. (eg: when pulling from a URL directly -
    ++	 * rather than a configured remote, or when a remote's followRemoteHEAD
    ++	 * overrides the fallback fetch setting)
    ++	 */
      	if (transport->remote->follow_remote_head)
      		follow_remote_head = transport->remote->follow_remote_head;
     +	else if (config->follow_remote_head)
7:  5c80107f6488 = 8:  f9555a0d5cea fetch: fixup a misaligned comment

base-commit: 95e20213faefeb95df29277c58ac1980ab68f701
-- 
2.54.0

