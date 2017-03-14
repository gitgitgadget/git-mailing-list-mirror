Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0208201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 17:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbdCNRxs (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 13:53:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55726 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750960AbdCNRxr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 13:53:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB5A369A42;
        Tue, 14 Mar 2017 13:53:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R6mf/nolXGBvJ5jQLoWrv5ZIyo8=; b=nWjFrz
        Hpy131t7IFP2VHDLdBM9NMJ2nAXvyq+8Tw6iPtSoX7WWXzrV9jC9zByRb/5a3Zzp
        uqjxBgZacVYWKbV31Dtniufv2J6ZhfRvj5p/H2Ba/0pS12/PK5MuI9Qkb6CxiW9Z
        YZ6bkmukzztRWeQx9OEn1BLyq6Fb/ID4npuvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A72uW0lEk/1C6s1A8VruLxGzcNajbFJG
        IqRRfO+1siLU55XDiUUktmzMivcUxr23jSEGKG5TrlDBrzjnHQktRE6Jo88x9iuZ
        Y1TYGQ4pybEA2qfnVxaTNr+8iyqKgpMao2LRVnBsZLrrwH1t+I/jFuVNRfRUA10w
        vUP295HEK7w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC63169A41;
        Tue, 14 Mar 2017 13:53:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D94D69A40;
        Tue, 14 Mar 2017 13:53:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 03/10] submodule sync: use submodule--helper is-active
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-4-bmwill@google.com>
Date:   Tue, 14 Mar 2017 10:53:44 -0700
In-Reply-To: <20170313214341.172676-4-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 14:43:34 -0700")
Message-ID: <xmqq8to7kamv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B2E984C-08DF-11E7-A100-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ab233712d..e2d08595f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1111,7 +1111,7 @@ cmd_sync()
>  			;;
>  		esac
>  
> -		if git config "submodule.$name.url" >/dev/null 2>/dev/null
> +		if git submodule--helper is-active "$sm_path"
>  		then
>  			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
>  			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"

This is not a problem this patch introduces, but the loop this hunk
is in seems a bit inefficient.  It maps the sm_path to its name and
then asks .gitmodules the URL the upstream suggests to clone it from,
munges it with a large case statement and discards all of that if
the module is not active.

Adding this patch on top would be a way to remove the inefficiency
and one level of nesting while at it, I think, but I may have missed
something, so please double check, and if you agree that this is a
good way to go, please do so as a preparatory clean-up.

Thanks.

 git-submodule.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index e2d08595f0..dcdd36fa64 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1089,6 +1089,12 @@ cmd_sync()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode" "$sha1"
+
+		if ! git submodule--helper is-active "$sm_path"
+		then
+			continue
+		fi
+
 		name=$(git submodule--helper name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
@@ -1111,14 +1117,12 @@ cmd_sync()
 			;;
 		esac
 
-		if git submodule--helper is-active "$sm_path"
-		then
-			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
-			git config submodule."$name".url "$super_config_url"
+		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
+		say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
+		git config submodule."$name".url "$super_config_url"
 
-			if test -e "$sm_path"/.git
-			then
+		if test -e "$sm_path"/.git
+		then
 			(
 				sanitize_submodule_env
 				cd "$sm_path"
@@ -1131,7 +1135,6 @@ cmd_sync()
 					eval cmd_sync
 				fi
 			)
-			fi
 		fi
 	done
 }
