Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB19410D13
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236695; cv=none; b=iUSUbrPYvntd4ZK/zGur0JHrYM1hV8AaLfbtEUChq3DI8MBPuDRea7hXtzW+CDEz4QMGWTgBFHd78306x1vsw4W2/qU9wLKo9zPZeK9xrIcsEDULA/wFLu9HthuG3mqkX1Q0mvadBkFtPabm4am0d314nt8ZL34mzoXrpa2hikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236695; c=relaxed/simple;
	bh=gNFhs7H5aCSC67KRcau7OOCjFy0n01++oYv+hKsZCrE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=HPVt80JM2ej1s5IwEtg+dhUS1wcEwUxd0tCwEEZZaejjVr2MjjjtsVchGk8iVCNNpGHa8TjQGfi35wPXda7YEIRttlBVz4f2uOIPEwCNgsHwIUe30IY7FVnMGnuLY8C/kEbXmLKmQYuqPwcTRIXBu4QlZgJjp2IvbQofkQ0/PNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=f9X+a735; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="f9X+a735"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1790236212; bh=gNFhs7H5aCSC67KRcau7OOCjFy0n01++oYv+hKsZCrE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=f9X+a735uXVqHHHLAsulO6Xig+yJiRkf5T5NL93oDrNpvLS2dvv5g2RtFeJdm5Jrq
	 5tGggRM5gxiKm5T/IyBMTEYj6kRjPUxI/mk6CMOR8DdDwm5mzmhYROvmP1hhCcRNOZ
	 QqAfMPw+eyoQNqk3a/C2VcfHjKbcwgufKAmuIcws=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 2131062402;
	Thu, 24 Sep 2026 07:50:12 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 03:50:12 -0400
Message-Id: <DLNDRU6GIB30.1F5G8Z3JIR67W@lfurio.us>
Subject: Re: [PATCH] fetch.c: defer fetch.followRemoteHEAD validation
Cc: <git@vger.kernel.org>
To: "Colin Hinton" <colinlewishinton@gmail.com>, "Junio C Hamano"
 <gitster@pobox.com>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260922040047.2567-1-colinlewishinton@gmail.com>
 <xmqqwlsdhmvk.fsf@gitster.g>
 <CAHeTm9OMLba_h0B2jRh_-GhogQXuwROBpX2jE__BPJ0GHq9P1A@mail.gmail.com>
In-Reply-To: <CAHeTm9OMLba_h0B2jRh_-GhogQXuwROBpX2jE__BPJ0GHq9P1A@mail.gmail.com>

On Wed Sep 23, 2026 at 1:03 AM EDT, Colin Hinton wrote:
>> > @@ -1962,6 +1953,14 @@ static int do_fetch(struct transport *transport=
,
>> >               if (transport->remote->fetch.nr) {
>> >                       refspec_ref_prefixes(&transport->remote->fetch,
>> >                                            &transport_ls_refs_options.=
ref_prefixes);
>> > +
>> > +                     if (transport->remote->follow_remote_head)
>> > +                             follow_remote_head =3D transport->remote=
->follow_remote_head;
>>
>> The code assumes that remote.*.followRemoteHEAD has been pre-parsed.
>> Doesn't the code to do so in remote.c::handle_config() share exactly
>> the same problem as you are fixing here?
>>
> I agree that the same problem that is being addressed here is present
> in remote.c as well. The only difference being, that there is no
> return call in the followremotehead block in remote.c,

I'm not exactly sure why the config parsing in remote.c doesn't end with
a fallback 'return git_default_config(...)', though the followremotehead
case piggybacking the common 'return 0' at the end should be no problem.

> and it at most only throws a warning if no valid value is present.

which _was_ the case for fetch.followRemoteHEAD as well.  So, we should
keep the two in sync right?

> I think this
> should be addressed, but I am uncertain if this is within the scope of
> this issue and should be resolved now, or if this requires its own
> investigation and should be resolved in a future patch. Regardless I
> am eager to work on it, but would like some guidance as to what is
> most appropriate for a change in remote.c.

I spent some time drafting up what changes to remote.c could look like,
based on your work so far.  This follow-up patch also has extra changes
to builtin/fetch.c to accommodate the same allowed functionality as
before.  There are two awkward bits to this patch as-is, though:

builtin/remote.c::set_head()

012bc566bad7 (remote set-head: set followRemoteHEAD to "warn" if "always")
added this behavior to overrule a remote's "always" setting if the user
ever modified their HEAD manually.  So, this file needs to know about the
followRemoteHEAD values, but parsing into the enums is currently confined
to fetch.c.  This just adds another bit of string parsing.

builtin/fetch.c::get_follow_remote_head()

is updated to serve double-duty for both the fetch and remote configs,
and needs a better warning message if a bad value is detected.  Perhaps
add another parameter to the function?

With this patch below, it's arguable whether the enum definition for the
followRemoteHEAD values now better fits in fetch.c instead of remote.h.


Signed-off-by: Matt Hunter <m@lfurio.us>
---
 builtin/fetch.c  | 54 ++++++++++++++++++++++++++++++++----------------
 builtin/remote.c |  3 ++-
 remote.c         | 19 ++---------------
 remote.h         |  3 +--
 4 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 83074c48150b..5a4c9fb9309c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -187,18 +187,34 @@ static int git_fetch_config(const char *k, const char=
 *v,
 	return git_default_config(k, v, ctx, cb);
 }
=20
-static enum follow_remote_head_settings get_follow_remote_head(const char =
*setting)
+/* TODO might be worth considering a better name for this */
+struct follow_remote_head_target {
+	enum follow_remote_head_settings mode;
+	const char *no_warn_branch;
+};
+
+static struct follow_remote_head_target get_follow_remote_head(const char =
*setting,
+		int allow_warn_if_not_branch)
 {
+	struct follow_remote_head_target frh =3D { 0 };
+
 	if (!strcmp(setting, "never"))
-		return FOLLOW_REMOTE_NEVER;
+		frh.mode =3D FOLLOW_REMOTE_NEVER;
 	else if (!strcmp(setting, "create"))
-		return FOLLOW_REMOTE_CREATE;
+		frh.mode =3D FOLLOW_REMOTE_CREATE;
 	else if (!strcmp(setting, "warn"))
-		return FOLLOW_REMOTE_WARN;
+		frh.mode =3D FOLLOW_REMOTE_WARN;
+	else if (skip_prefix(setting, "warn-if-not-", &frh.no_warn_branch)
+			&& allow_warn_if_not_branch)
+		frh.mode =3D FOLLOW_REMOTE_WARN;
 	else if (!strcmp(setting, "always"))
-		return FOLLOW_REMOTE_ALWAYS;
-	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), sett=
ing);
-	return FOLLOW_REMOTE_UNCONFIGURED;
+		frh.mode =3D FOLLOW_REMOTE_ALWAYS;
+	else
+		warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), set=
ting);
+		/* TODO this also parses remote.<name>.followRemoteHEAD,
+		 * but the warning string says fetch.followRemoteHEAD */
+
+	return frh;
 }
=20
 static int parse_refmap_arg(const struct option *opt, const char *arg, int=
 unset)
@@ -1758,12 +1774,11 @@ static void warn_set_head(const char *remote, const=
 char *head_name,
 }
=20
 static int set_head(const struct ref *remote_refs, struct remote *remote,
-			int follow_remote_head)
+			struct follow_remote_head_target follow_remote_head)
 {
 	int result =3D 0, create_only, baremirror, was_detached;
 	struct strbuf b_head =3D STRBUF_INIT, b_remote_head =3D STRBUF_INIT,
 		      b_local_head =3D STRBUF_INIT;
-	const char *no_warn_branch =3D remote->no_warn_branch;
 	char *head_name =3D NULL;
 	struct ref *ref, *matches;
 	struct ref *fetch_map =3D NULL, **fetch_map_tail =3D &fetch_map;
@@ -1793,7 +1808,7 @@ static int set_head(const struct ref *remote_refs, st=
ruct remote *remote,
 	if (!head_name)
 		goto cleanup;
 	baremirror =3D is_bare_repository(the_repository) && remote->mirror;
-	create_only =3D follow_remote_head =3D=3D FOLLOW_REMOTE_ALWAYS ? 0 : !bar=
emirror;
+	create_only =3D follow_remote_head.mode =3D=3D FOLLOW_REMOTE_ALWAYS ? 0 :=
 !baremirror;
 	if (baremirror) {
 		strbuf_addstr(&b_head, "HEAD");
 		strbuf_addf(&b_remote_head, "refs/heads/%s", head_name);
@@ -1813,8 +1828,9 @@ static int set_head(const struct ref *remote_refs, st=
ruct remote *remote,
 		goto cleanup;
 	}
 	if (verbosity >=3D 0 &&
-		follow_remote_head =3D=3D FOLLOW_REMOTE_WARN &&
-		(!no_warn_branch || strcmp(no_warn_branch, head_name)))
+		follow_remote_head.mode =3D=3D FOLLOW_REMOTE_WARN &&
+		(!follow_remote_head.no_warn_branch ||
+		 strcmp(follow_remote_head.no_warn_branch, head_name)))
 		warn_set_head(remote->name, head_name, &b_local_head, was_detached);
=20
 cleanup:
@@ -1929,7 +1945,7 @@ static int do_fetch(struct transport *transport,
 	struct ref_update_display_info_array display_array =3D { 0 };
 	struct strmap rejected_refs =3D STRMAP_INIT;
 	int summary_width =3D 0;
-	int follow_remote_head =3D 0;
+	struct follow_remote_head_target follow_remote_head =3D { 0 };
=20
 	if (tags =3D=3D TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags =3D=3D 2)
@@ -1954,14 +1970,16 @@ static int do_fetch(struct transport *transport,
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
=20
-			if (transport->remote->follow_remote_head)
-				follow_remote_head =3D transport->remote->follow_remote_head;
+			if (transport->remote->follow_remote_head_raw)
+				follow_remote_head =3D get_follow_remote_head(
+						transport->remote->follow_remote_head_raw, 1);
 			else if (config->follow_remote_head_raw)
-				follow_remote_head =3D get_follow_remote_head(config->follow_remote_he=
ad_raw);
+				follow_remote_head =3D get_follow_remote_head(
+						config->follow_remote_head_raw, 0);
 			else
-				follow_remote_head =3D BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
+				follow_remote_head.mode =3D BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 		=09
-			if (follow_remote_head !=3D FOLLOW_REMOTE_NEVER)
+			if (follow_remote_head.mode !=3D FOLLOW_REMOTE_NEVER)
 				do_set_head =3D 1;
 		}
 		if (branch && branch_has_merge_config(branch) &&
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3ba96..89ac1f0daa82 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1606,7 +1606,8 @@ static int set_head(int argc, const char **argv, cons=
t char *prefix,
 	}
 	if (opt_a)
 		report_set_head_auto(argv[0], head_name, &b_local_head, was_detached);
-	if (remote->follow_remote_head =3D=3D FOLLOW_REMOTE_ALWAYS) {
+	if (remote->follow_remote_head_raw &&
+			!strcmp(remote->follow_remote_head_raw, "always")) {
 		struct strbuf config_name =3D STRBUF_INIT;
 		strbuf_addf(&config_name,
 			"remote.%s.followremotehead", remote->name);
diff --git a/remote.c b/remote.c
index fe6206846356..5fdcadfbdbf0 100644
--- a/remote.c
+++ b/remote.c
@@ -581,23 +581,8 @@ static int handle_config(const char *key, const char *=
value,
 		return parse_transport_option(key, value,
 					      &remote->negotiation_include);
 	} else if (!strcmp(subkey, "followremotehead")) {
-		const char *no_warn_branch;
-		if (!strcmp(value, "never"))
-			remote->follow_remote_head =3D FOLLOW_REMOTE_NEVER;
-		else if (!strcmp(value, "create"))
-			remote->follow_remote_head =3D FOLLOW_REMOTE_CREATE;
-		else if (!strcmp(value, "warn")) {
-			remote->follow_remote_head =3D FOLLOW_REMOTE_WARN;
-			remote->no_warn_branch =3D NULL;
-		} else if (skip_prefix(value, "warn-if-not-", &no_warn_branch)) {
-			remote->follow_remote_head =3D FOLLOW_REMOTE_WARN;
-			remote->no_warn_branch =3D no_warn_branch;
-		} else if (!strcmp(value, "always")) {
-			remote->follow_remote_head =3D FOLLOW_REMOTE_ALWAYS;
-		} else {
-			warning(_("unrecognized followRemoteHEAD value '%s' ignored"),
-				value);
-		}
+		free(remote->follow_remote_head_raw);
+		remote->follow_remote_head_raw =3D xstrdup(value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index cca02033b9d7..cd97df017454 100644
--- a/remote.h
+++ b/remote.h
@@ -122,8 +122,7 @@ struct remote {
 	struct string_list negotiation_restrict;
 	struct string_list negotiation_include;
=20
-	enum follow_remote_head_settings follow_remote_head;
-	const char *no_warn_branch;
+	char *follow_remote_head_raw;
 };
=20
 /**
--=20
2.55.0

