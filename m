Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3943D20951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbdCQXJf (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:09:35 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36456 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdCQXJe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:09:34 -0400
Received: by mail-pf0-f178.google.com with SMTP id o126so43369912pfb.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 16:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g5UBIwJuaFE92+VZfLWnQO40IsdGpHY1zas05c58m3Q=;
        b=uon+yp6CfW6blirx+IRBlQCX11QmyTWN2h1R2qPjwX1v9YbJGvtUnVUXKRTFpdIeds
         qWjEdWAgmQ0CyVmc3yt4yKEy7CukxJOnOcqmmoUN0x0l/Lwcs/Y0lennXek3uR97dnXW
         1vpSzhvZ12vknGlVyEtWL0mWtUadkAlsnxCo0VUKQLb2lW+qysJeR+BiEaGvQTezCsa3
         woYr5yUgjHA2x2NnGEDV/2mk3DNXTCOrSHza3t8wvpMgoupVxSq/0B0tRSHfMv6+QQYU
         87L1SZzi5vlSJBONbIJU7WjYmLiycQpJAl0N3/R382bIuzh+Pym5idAWnvhMixCTu8GW
         n4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g5UBIwJuaFE92+VZfLWnQO40IsdGpHY1zas05c58m3Q=;
        b=karJJ2UCGHR52TaDp0rVqCi3ABu/SblCK7xeSIMfG6ZA61DnAzfyAaLd0iq6MziABj
         w16CLBdqzQzSQ6NrA63VNYbPJFncWqWdZLtIekpx6V9OJ4KCg/ASh1blX4xCEiY2OWsD
         9QV1vhKoRMAQYdp8TbWRHubMy/eGRkNIy6UV5uPMfhKW5JBCtsb5avAN6GRLfe70D7Ln
         QCnK5CKoqm6irJKREANG1+wG4Mf5ElCikJt3uPuPAT7ghraqnzgtUkBEI/h8m/OMr+2N
         i71BzjMXM0rbLGkhVLUY/DrSrNGQAEPdccm0HGYt1y3VfycjE/Rsd+TwhqXjONXQiIE5
         gSvA==
X-Gm-Message-State: AFeK/H3wrdvBaAkB+3lxH4X70fitkjibuH0UnTkwhr5PgdgyRsgyV4aHEFeQvse0n5KKXr8T
X-Received: by 10.99.189.9 with SMTP id a9mr18552194pgf.190.1489790299251;
        Fri, 17 Mar 2017 15:38:19 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id d3sm18699763pfc.51.2017.03.17.15.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:38:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 03/10] submodule sync: skip work for inactive submodules
Date:   Fri, 17 Mar 2017 15:37:58 -0700
Message-Id: <20170317223805.95271-4-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317223805.95271-1-bmwill@google.com>
References: <20170316222952.53801-1-bmwill@google.com>
 <20170317223805.95271-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sync does some work determining what URLs should be used for a submodule
but then throws this work away if the submodule isn't active.  Instead
perform the activity check earlier and skip inactive submodule in order
to avoid doing unnecessary work.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab233712d..577136148 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1090,6 +1090,13 @@ cmd_sync()
 	do
 		die_if_unmatched "$mode" "$sha1"
 		name=$(git submodule--helper name "$sm_path")
+
+		# skip inactive submodules
+		if ! git config "submodule.$name.url" >/dev/null 2>/dev/null
+		then
+			continue
+		fi
+
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
 		# Possibly a url relative to parent
@@ -1111,27 +1118,24 @@ cmd_sync()
 			;;
 		esac
 
-		if git config "submodule.$name.url" >/dev/null 2>/dev/null
+		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
+		say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
+		git config submodule."$name".url "$super_config_url"
+
+		if test -e "$sm_path"/.git
 		then
-			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
-			git config submodule."$name".url "$super_config_url"
+		(
+			sanitize_submodule_env
+			cd "$sm_path"
+			remote=$(get_default_remote)
+			git config remote."$remote".url "$sub_origin_url"
 
-			if test -e "$sm_path"/.git
+			if test -n "$recursive"
 			then
-			(
-				sanitize_submodule_env
-				cd "$sm_path"
-				remote=$(get_default_remote)
-				git config remote."$remote".url "$sub_origin_url"
-
-				if test -n "$recursive"
-				then
-					prefix="$prefix$sm_path/"
-					eval cmd_sync
-				fi
-			)
+				prefix="$prefix$sm_path/"
+				eval cmd_sync
 			fi
+		)
 		fi
 	done
 }
-- 
2.12.0.367.g23dc2f6d3c-goog

