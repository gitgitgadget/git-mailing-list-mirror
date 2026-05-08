Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC4192B75
	for <git@vger.kernel.org>; Fri,  8 May 2026 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244342; cv=none; b=ruJveITE+lHM9nCSxzoLixxgLBz7EwN0PNELMpqIBbHWzPXPlFUxJwfyEflbBzIutsNB3I1k2fONCzKvffWq+rdPOVxdhEd0GH3I4B7Qol6ayxHnDuCI+jOR8UpzE03Gn8Bhkys7E6ehD+/S0nn3TxO0IDL1XZapfBX9ltYTzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244342; c=relaxed/simple;
	bh=VsbLUAGlg9oE2h/Jiw4qr6QqALj2KO9HGKdfwFGstzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nQcwK6DtQtMqTodsHNjE0GvKjBKZrRY+ABZLOFs0zGja7C99zQ0FiTSn2gEXLuiuRYA9c/KqLBeuWC8aEqmH6/L//rY/4FSSfxqyrqMRyJlfpMUKR2TQfYoY8TXc1nJ9EN4AdmRmFFO7926CaL2oem9nddFEfRPpMPAE5yLr/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=1G3NgUKN; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="1G3NgUKN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1778244335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4JHtxlGxPvesPcIFAQfsVLHA4/vS5w2QKwms88RswAA=;
	b=1G3NgUKNf1/f2x6zqPNJEMy0FGv5Nvu9YSNQgF+nXbbhJIPgI6CgjWgFBNzwqB6CBSe5LP
	mE6f5+cKXVnuoJopQhMClTy7mT2FatyM94D58TlQ4TMOc6AkTB+uR8XWyyoNdaMm0l2pHW
	Kq5U4ejxKMhjsjUhn7QTkhSf6vJhLdk=
From: Toon Claes <toon@iotcl.com>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>,
 Elijah Newren <newren@gmail.com>, Christian Couder
 <christian.couder@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 6/8] promisor-remote: trust known remotes matching
 acceptFromServerUrl
In-Reply-To: <20260427124108.3524129-7-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260427124108.3524129-7-christian.couder@gmail.com>
Date: Fri, 08 May 2026 14:45:30 +0200
Message-ID: <875x4yoys5.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Christian Couder <christian.couder@gmail.com> writes:

> A previous commit introduced the `promisor.acceptFromServerUrl` config
> variable along with the machinery to parse and validate the URL glob
> patterns and optional remote name prefixes it contains. However, these
> URL patterns are not yet tied into the client's acceptance logic.
>
> When a promisor remote is already configured locally, its fields (like
> authentication tokens) may occasionally need to be refreshed by the
> server. If `promisor.acceptFromServer` is set to the secure default
> ("None"), these updates are rejected, potentially causing future
> fetches to fail.
>
> To enable such targeted updates for trusted URLs, let's use the URL
> patterns from `promisor.acceptFromServerUrl` as an additional URL
> based allowlist.
>
> Concretely, let's check the advertised URLs against the URL glob
> patterns by introducing a new small helper function called
> url_matches_accept_list(), which iterates over the glob patterns and
> returns the first matching allowed_url entry (or NULL).
>
> The URL matching is done component by component: scheme and port are
> compared exactly, the host is matched with wildmatch() using the
> WM_PATHNAME flag (so '*' cannot cross the '/' boundary into the path),
> and the path is matched with wildmatch() without WM_PATHNAME (so '*'
> can still match multi-level paths). Before matching, the advertised
> URL is passed through url_normalize() so that case variations in the
> scheme/host, percent-encoding tricks, and ".." path segments cannot
> bypass the allowlist.
>
> Let's then use this helper at the tail of should_accept_remote() so
> that, when `accept == ACCEPT_NONE`, a known remote whose URL matches
> the allowlist is still accepted.
>
> To prepare for this new logic, let's also:
>
>  - Add an 'accept_urls' parameter to should_accept_remote().
>
>  - Replace the BUG() guard in the ACCEPT_KNOWN_URL case with an
>    explicit 'if (accept == ACCEPT_KNOWN_URL) return' and a new
>    BUG() guard in the ACCEPT_NONE case, so url_matches_accept_list()
>    is only called in the ACCEPT_NONE case.
>
>  - Call accept_from_server_url() from filter_promisor_remote()
>    and relax its early return so that the function is entered when
>    `accept_urls` has entries even if `accept == ACCEPT_NONE`.
>
> With this, many organizations may only need something like:
>
>   git config set --global \
>           promisor.acceptFromServerUrl "https://my-org.com/*"
>
> to accept only their own remotes. And if they need to accept additional
> remotes in some specific repos, they can also set:
>
>   git config set promisor.acceptFromServer knownUrl
>
> and configure the additional remote manually only in the repos where
> they are needed.
>
> Let's then properly document `promisor.acceptFromServerUrl` in
> "promisor.adoc" as an additive security allowlist for known remotes,
> including the URL normalization behavior and the component-wise
> matching, and let's mention it in "gitprotocol-v2.adoc".
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config/promisor.adoc    | 52 ++++++++++++++
>  Documentation/gitprotocol-v2.adoc     |  9 +--
>  promisor-remote.c                     | 98 +++++++++++++++++++++++++--
>  t/t5710-promisor-remote-capability.sh | 71 +++++++++++++++++++
>  4 files changed, 220 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> index b0fa43b839..efc066c3f2 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -51,6 +51,58 @@ promisor.acceptFromServer::
>  	to "fetch" and "clone" requests from the client. Name and URL
>  	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
>  
> +promisor.acceptFromServerUrl::
> +	A glob pattern to specify which server-advertised URLs a
> +	client is allowed to act on. When a URL matches, the client
> +	will accept the advertised remote as a promisor remote and may
> +	automatically accept field updates (such as authentication
> +	tokens) from the server, even if `promisor.acceptFromServer`
> +	is set to `none` (the default).
> ++
> +This option can appear multiple times in config files. An advertised
> +URL will be accepted if it matches _ANY_ glob pattern specified by
> +this option in _ANY_ config file read by Git.
> ++
> +Be _VERY_ careful with these patterns: `*` matches any sequence of
> +characters within the 'host' and 'path' parts of a URL (but cannot
> +cross part boundaries). An overly broad pattern is a major security
> +risk, as a matching URL allows a server to update fields (such as
> +authentication tokens) on known remotes without further confirmation.
> +To minimize security risks, follow these guidelines:
> ++
> +1. Start with a secure protocol scheme, like `https://` or `ssh://`.
> ++
> +2. Only allow domain names or paths where you control and trust _ALL_
> +   the content. Be especially careful with shared hosting platforms
> +   like `github.com` or `gitlab.com`. A broad pattern like
> +   `https://gitlab.com/*` is dangerous because it trusts every
> +   repository on the entire platform. Always restrict such patterns to
> +   your specific organization or namespace (e.g.,
> +   `https://gitlab.com/your-org/*`).
> ++
> +3. Never use globs at the end of domain names. For example,
> +   `https://cdn.your-org.com/*` might be safe, but
> +   `https://cdn.your-org.com*/*` is a major security risk because
> +   the latter matches `https://cdn.your-org.com.hacker.net/repo`.
> ++
> +4. Be careful using globs at the beginning of domain names. While the
> +   code ensures a `*` in the host cannot cross into the path, a
> +   pattern like `https://*.example.com/*` will still match any
> +   subdomain. This is extremely dangerous on shared hosting platforms
> +   (e.g., `https://*.github.io/*` trusts every user's site on the
> +   entire platform).
> ++
> +Before matching, both the advertised URL and the pattern are
> +normalized: the scheme and host are lowercased, percent-encoded
> +characters are decoded where possible, and path segments like `..`
> +are resolved. The port must also match exactly (e.g.,
> +`https://example.com:8080/*` will not match a URL advertised on
> +port 9999).
> ++
> +For the security implications of accepting a promisor remote, see the
> +documentation of `promisor.acceptFromServer`. For details on the
> +protocol, see linkgit:gitprotocol-v2[5].
> +
>  promisor.checkFields::
>  	A comma or space separated list of additional remote related
>  	field names. A client checks if the values of these fields
> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> index befa697d21..2beb70595f 100644
> --- a/Documentation/gitprotocol-v2.adoc
> +++ b/Documentation/gitprotocol-v2.adoc
> @@ -866,10 +866,11 @@ the server advertised, the client shouldn't advertise the
>  
>  On the server side, the "promisor.advertise" and "promisor.sendFields"
>  configuration options can be used to control what it advertises. On
> -the client side, the "promisor.acceptFromServer" configuration option
> -can be used to control what it accepts, and the "promisor.storeFields"
> -option, to control what it stores. See the documentation of these
> -configuration options in linkgit:git-config[1] for more information.
> +the client side, the "promisor.acceptFromServer" and
> +"promisor.acceptFromServerUrl" configuration options can be used to
> +control what it accepts, and the "promisor.storeFields" option, to
> +control what it stores. See the documentation of these configuration
> +options in linkgit:git-config[1] for more information.
>  
>  Note that in the future it would be nice if the "promisor-remote"
>  protocol capability could be used by the server, when responding to
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 3f3924f587..72d5b94bf7 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -14,6 +14,7 @@
>  #include "url.h"
>  #include "urlmatch.h"
>  #include "version.h"
> +#include "wildmatch.h"
>  
>  struct promisor_remote_config {
>  	struct promisor_remote *promisors;
> @@ -742,8 +743,82 @@ static void load_accept_from_server_url(struct repository *repo,
>  	}
>  }
>  
> +static bool match_one_url(const struct url_info *pi, const struct url_info *ui)
> +{
> +	const char *pat = pi->url;
> +	const char *url = ui->url;
> +	char *p_str, *u_str;
> +	bool res;
> +
> +	/*
> +	 * Schemes must match exactly. They are case-folded by
> +	 * url_normalize(), so strncmp() suffices.
> +	 */
> +	if (pi->scheme_len != ui->scheme_len || strncmp(pat, url, pi->scheme_len))
> +		return false;
> +
> +	/*
> +	 * Ports must match exactly. url_normalize() strips default
> +	 * ports (like 443 for https), so length and content
> +	 * comparisons are sufficient.
> +	 */
> +	if (pi->port_len != ui->port_len ||
> +	    strncmp(pat + pi->port_off, url + ui->port_off, pi->port_len))
> +		return false;
> +
> +	/*
> +	 * Match host and path separately to prevent a '*' in the host
> +	 * portion of the pattern from matching across the '/'
> +	 * boundary into the path. Use WM_PATHNAME for the host so '*'
> +	 * cannot cross '/' there, and 0 for the path so '*' can still
> +	 * match multi-level paths.
> +	 */

Do we actually need WM_PATHNAME, because we only xstrndup() the host
part anyway?

> +
> +	p_str = xstrndup(pat + pi->host_off, pi->host_len);
> +	u_str = xstrndup(url + ui->host_off, ui->host_len);
> +	res = !wildmatch(p_str, u_str, WM_PATHNAME);
> +	free(p_str);
> +	free(u_str);
> +
> +	if (!res)
> +		return false;
> +
> +	p_str = xstrndup(pat + pi->path_off, pi->path_len);
> +	u_str = xstrndup(url + ui->path_off, ui->path_len);
> +	res = !wildmatch(p_str, u_str, 0);
> +	free(p_str);
> +	free(u_str);

Is it correct we intentionally do not compare the user and pass (at
`user_off` and `passwd_off`)? I assume so, because this allows the
server to update those?

> +
> +	return res;
> +}
> +
> +static struct allowed_url *url_matches_accept_list(
> +		struct string_list *accept_urls, const char *url)
> +{
> +	struct string_list_item *item;
> +	struct url_info url_info;
> +
> +	url_info.url = url_normalize(url, &url_info);
> +
> +	if (!url_info.url)
> +		return NULL;
> +
> +	for_each_string_list_item(item, accept_urls) {
> +		struct allowed_url *allowed = item->util;
> +
> +		if (match_one_url(&allowed->pattern_info, &url_info)) {
> +			free(url_info.url);
> +			return allowed;
> +		}
> +	}
> +
> +	free(url_info.url);
> +	return NULL;
> +}
> +
>  static int should_accept_remote(enum accept_promisor accept,
>  				struct promisor_info *advertised,
> +				struct string_list *accept_urls,
>  				struct string_list *config_info)
>  {
>  	struct promisor_info *p;
> @@ -771,9 +846,6 @@ static int should_accept_remote(enum accept_promisor accept,
>  	if (accept == ACCEPT_KNOWN_NAME)
>  		return all_fields_match(advertised, config_info, p);
>  
> -	if (accept != ACCEPT_KNOWN_URL)
> -		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
> -
>  	if (strcmp(p->url, remote_url)) {
>  		warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
>  			  "ignoring this remote"),
> @@ -781,7 +853,21 @@ static int should_accept_remote(enum accept_promisor accept,
>  		return 0;
>  	}
>  
> -	return all_fields_match(advertised, config_info, p);
> +	if (accept == ACCEPT_KNOWN_URL)
> +		return all_fields_match(advertised, config_info, p);
> +
> +	if (accept != ACCEPT_NONE)
> +		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
> +
> +	/*
> +	 * Even if accept == ACCEPT_NONE, we MUST trust this known
> +	 * remote to update its token or other such fields if its URL
> +	 * matches the acceptFromServerUrl allowlist!
> +	 */
> +	if (url_matches_accept_list(accept_urls, remote_url))
> +		return all_fields_match(advertised, config_info, p);

I should verify in the following patches, but it seems to me only when
promisor.AcceptFromServer is set to None it will store the advertised
servers to the local .git/config, or not?

> +
> +	return 0;
>  }
>  
>  static int skip_field_name_prefix(const char *elem, const char *field_name, const char **value)
> @@ -991,7 +1077,7 @@ static void filter_promisor_remote(struct repository *repo,
>  	/* Load and validate the acceptFromServerUrl config */
>  	load_accept_from_server_url(repo, &accept_urls);
>  
> -	if (accept == ACCEPT_NONE)
> +	if (accept == ACCEPT_NONE && !accept_urls.nr)
>  		return;
>  
>  	/* Parse remote info received */
> @@ -1011,7 +1097,7 @@ static void filter_promisor_remote(struct repository *repo,
>  			string_list_sort(&config_info);
>  		}
>  
> -		if (should_accept_remote(accept, advertised, &config_info)) {
> +		if (should_accept_remote(accept, advertised, &accept_urls, &config_info)) {
>  			if (!store_info)
>  				store_info = store_info_new(repo);
>  			if (promisor_store_advertised_fields(advertised, store_info))
> diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
> index 3b39505380..0659b2ac15 100755
> --- a/t/t5710-promisor-remote-capability.sh
> +++ b/t/t5710-promisor-remote-capability.sh
> @@ -387,6 +387,77 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
>  	check_missing_objects server 1 "$oid"
>  '
>  
> +test_expect_success "clone with 'None' but URL allowlisted" '
> +	git -C server config promisor.advertise true &&
> +	test_when_finished "rm -rf client" &&
> +
> +	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
> +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
> +		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
> +		-c promisor.acceptfromserver=None \
> +		-c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
> +		--no-local --filter="blob:limit=5k" server client &&
> +
> +	# Check that the largest object is still missing on the server
> +	check_missing_objects server 1 "$oid"
> +'

Why do some tests end with `initialize_server 1 "$oid"` and this one
not? Isn't it weird tests prepare for the next test?

> +
> +test_expect_success "clone with 'None' but URL not in allowlist" '
> +	git -C server config promisor.advertise true &&
> +	test_when_finished "rm -rf client" &&
> +
> +	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
> +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
> +		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
> +		-c promisor.acceptfromserver=None \
> +		-c promisor.acceptFromServerUrl="https://example.com/*" \
> +		--no-local --filter="blob:limit=5k" server client &&
> +
> +	# Check that the largest object is not missing on the server
> +	check_missing_objects server 0 "" &&
> +
> +	# Reinitialize server so that the largest object is missing again
> +	initialize_server 1 "$oid"
> +'
> +
> +test_expect_success "clone with 'None' but URL allowlisted in one pattern out of two" '
> +	git -C server config promisor.advertise true &&
> +	test_when_finished "rm -rf client" &&
> +
> +	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
> +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
> +		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
> +		-c promisor.acceptfromserver=None \
> +		-c promisor.acceptFromServerUrl="https://example.com/*" \
> +		-c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
> +		--no-local --filter="blob:limit=5k" server client &&
> +
> +	# Check that the largest object is still missing on the server
> +	check_missing_objects server 1 "$oid"
> +'
> +
> +test_expect_success "clone with 'None', URL allowlisted, but client has different URL" '
> +	git -C server config promisor.advertise true &&
> +	test_when_finished "rm -rf client" &&
> +
> +	# The client configures "lop" with a different URL (serverTwo) than
> +	# what the server advertises (lop). Even though the advertised URL
> +	# matches the allowlist, the remote is rejected because the
> +	# configured URL does not match the advertised one.
> +	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
> +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
> +		-c remote.lop.url="$TRASH_DIRECTORY_URL/serverTwo" \
> +		-c promisor.acceptfromserver=None \
> +		-c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
> +		--no-local --filter="blob:limit=5k" server client &&
> +
> +	# Check that the largest object is not missing on the server
> +	check_missing_objects server 0 "" &&
> +
> +	# Reinitialize server so that the largest object is missing again
> +	initialize_server 1 "$oid"
> +'
> +
>  test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
>  	git -C server config promisor.advertise true &&
>  	test_when_finished "rm -rf client" &&
> -- 
> 2.54.0.19.gb68b9497aa
>
>

-- 
Cheers,
Toon
