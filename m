Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8389C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjBWJQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWJQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:16:32 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4278C4FC8D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:16:30 -0800 (PST)
Received: (qmail 22747 invoked by uid 109); 23 Feb 2023 09:16:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 09:16:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17350 invoked by uid 111); 23 Feb 2023 09:16:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 04:16:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 04:16:28 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v10 1/3] t5563: add tests for basic and anoymous HTTP
 access
Message-ID: <Y/cu7K5uFjvOMXLu@coredump.intra.peff.net>
References: <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
 <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
 <f3ccc53055acf5d5c25d0ad3eed3867ea8670e55.1676586881.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3ccc53055acf5d5c25d0ad3eed3867ea8670e55.1676586881.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 10:34:39PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> Leverage a no-parsed headers (NPH) CGI script so that we can directly
> control the HTTP responses to simulate a multitude of good, bad and ugly
> remote server implementations around auth.

Hmm, today I learned about NPH scripts.

Obviously it works here, but I have to wonder: is there a reason we need
this? AFAICT the only thing we do is set the HTTP response code, which
could also be done with a Status: header.

I.e., this passes your test:

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index ccd5f3cf82..1eadfa4bbc 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -140,7 +140,7 @@ prepare_httpd() {
 	install_script error-smart-http.sh
 	install_script error.sh
 	install_script apply-one-time-perl.sh
-	install_script nph-custom-auth.sh
+	install_script custom-auth.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 2aac922376..0f9083dd6c 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -139,7 +139,7 @@ ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error_smart/ error-smart-http.sh/
 ScriptAlias /error/ error.sh/
 ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
-ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
+ScriptAliasMatch /custom_auth/(.*) custom-auth.sh/$1
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
 </Directory>
diff --git a/t/lib-httpd/nph-custom-auth.sh b/t/lib-httpd/custom-auth.sh
similarity index 94%
rename from t/lib-httpd/nph-custom-auth.sh
rename to t/lib-httpd/custom-auth.sh
index f5345e775e..8bf07e9398 100755
--- a/t/lib-httpd/nph-custom-auth.sh
+++ b/t/lib-httpd/custom-auth.sh
@@ -27,11 +27,10 @@ then
 	# status line.
 	# This is only a test script, so we don't bother to check for
 	# the actual status from git-http-backend and always return 200.
-	echo 'HTTP/1.1 200 OK'
 	exec "$GIT_EXEC_PATH"/git-http-backend
 fi
 
-echo 'HTTP/1.1 401 Authorization Required'
+echo 'Status: 401'
 if test -f "$CHALLENGE_FILE"
 then
 	cat "$CHALLENGE_FILE"


The other, more invisible thing happening behind the scenes is that
Apache isn't adding any of its usual headers. But I don't know of any
that would interfere with our goal of doing auth here. Is there some
feature you're planning where it would?

I think you could argue that it's mostly a matter of personal preference
and doesn't matter much either way. But all things being equal, I'd
usually go with the thing that is simpler and closer to the rest of the
system (e.g., I think you kill the ability of http-backend to return a
non-200 status, though I doubt it matters much in practice).

So I dunno. We are on v10 and this is arguably a nit. Mostly I'm just
curious what led you in this direction in the first place.

> ---
>  t/lib-httpd.sh                 |  1 +
>  t/lib-httpd/apache.conf        |  6 +++
>  t/lib-httpd/nph-custom-auth.sh | 39 ++++++++++++++++
>  t/t5563-simple-http-auth.sh    | 82 ++++++++++++++++++++++++++++++++++
>  4 files changed, 128 insertions(+)
>  create mode 100755 t/lib-httpd/nph-custom-auth.sh

Most of the other scripts here don't have an execute bit. They get one
when they're copied by instal_script in lib-httpd.sh. The exception is
error.sh, but I don't think there's any good reason for it. So probably
not a big deal either way, but another nit. :)

The rest of it all looks quite nice to me.

-Peff
