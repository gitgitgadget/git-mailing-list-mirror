Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443D146582
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361085; cv=none; b=iclu4Dg5zgqD+ttVir4kvfkHGqjBsGaPORUi/odzKIvYpWnoti5w/v77FNUg08jJJa42sehZzxSjUgciFuP3bRvhzw9uVoy7GjO6aZxFCDQERBNkDqD9bFz3MaIq0JXaA+6P3pCU8QpRfH3yd1msmHVHjb+Rt0OQpkufxSBZHwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361085; c=relaxed/simple;
	bh=p6rNIeEUpu2AJd/5HO07ON18CQmztacn1QULlWQdmJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/YcyQda87cI8ivZr9r9A4+LMS8yUicBBm3NDixUPeKtTKnjUBohs+48e1sNoqLPO/w1SJM8XG5oW0L3nGM8tOiymN5nXzrvmGQgmpCGqkDICvOxMJG1dkIuBqLX3LUZmaxybf8lHortUzelDpLKdAAHHEhnNJJoNkQQ8OPKxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16575 invoked by uid 109); 14 Jun 2024 10:31:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:31:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27223 invoked by uid 111); 14 Jun 2024 10:31:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:31:20 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:31:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 07/11] remote: allow resetting url list
Message-ID: <20240614103122.GG222445@coredump.intra.peff.net>
References: <20240614102439.GA222287@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614102439.GA222287@coredump.intra.peff.net>

Because remote.*.url is treated as a multi-valued key, there is no way
to override previous config. So for example if you have
remote.origin.url set to some wrong value, doing:

  git -c remote.origin.url=right fetch

would not work. It would append "right" to the list, which means we'd
still fetch from "wrong" (since subsequent values are used only as push
urls).

Let's provide a mechanism to reset the list, like we do for other
multi-valued keys (e.g., credential.helper, http.extraheaders, and
merge.suppressDest all use this "empty string means reset" pattern).

Reported-by: Mathew George <mathewegeorge@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
By the way, I think the nearby remote.*.fetch and remote.*.push could
learn the same trick. I left that out of this series, mostly because it
was getting long. But also because I had trouble imagining how a one-off
refspec change would be useful. We can revisit it on top if we want.

 Documentation/config/remote.txt |  5 ++++-
 remote.c                        | 10 +++++++--
 t/t5505-remote.sh               | 36 +++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index eef0bf4f62..8efc53e836 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -8,13 +8,16 @@ remote.<name>.url::
 	linkgit:git-push[1]. A configured remote can have multiple URLs;
 	in this case the first is used for fetching, and all are used
 	for pushing (assuming no `remote.<name>.pushurl` is defined).
+	Setting this key to the empty string clears the list of urls,
+	allowing you to override earlier config.
 
 remote.<name>.pushurl::
 	The push URL of a remote repository.  See linkgit:git-push[1].
 	If a `pushurl` option is present in a configured remote, it
 	is used for pushing instead of `remote.<name>.url`. A configured
 	remote can have multiple push URLs; in this case a push goes to
-	all of them.
+	all of them. Setting this key to the empty string clears the
+	list of urls, allowing you to override earlier config.
 
 remote.<name>.proxy::
 	For remotes that require curl (http, https and ftp), the URL to
diff --git a/remote.c b/remote.c
index 9417d83e51..b7262964fb 100644
--- a/remote.c
+++ b/remote.c
@@ -63,12 +63,18 @@ static char *alias_url(const char *url, struct rewrites *r)
 
 static void add_url(struct remote *remote, const char *url)
 {
-	strvec_push(&remote->url, url);
+	if (*url)
+		strvec_push(&remote->url, url);
+	else
+		strvec_clear(&remote->url);
 }
 
 static void add_pushurl(struct remote *remote, const char *pushurl)
 {
-	strvec_push(&remote->pushurl, pushurl);
+	if (*pushurl)
+		strvec_push(&remote->pushurl, pushurl);
+	else
+		strvec_clear(&remote->pushurl);
 }
 
 static void add_pushurl_alias(struct remote_state *remote_state,
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 7789ff12c4..08424e878e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1492,4 +1492,40 @@ test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and
 	)
 '
 
+test_expect_success 'empty config clears remote.*.url list' '
+	test_when_finished "git config --remove-section remote.multi" &&
+	git config --add remote.multi.url wrong-one &&
+	git config --add remote.multi.url wrong-two &&
+	git -c remote.multi.url= \
+	    -c remote.multi.url=right-one \
+	    -c remote.multi.url=right-two \
+	    remote show -n multi >actual.raw &&
+	grep URL actual.raw >actual &&
+	cat >expect <<-\EOF &&
+	  Fetch URL: right-one
+	  Push  URL: right-one
+	  Push  URL: right-two
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'empty config clears remote.*.pushurl list' '
+	test_when_finished "git config --remove-section remote.multi" &&
+	git config --add remote.multi.url right &&
+	git config --add remote.multi.url will-be-ignored &&
+	git config --add remote.multi.pushurl wrong-push-one &&
+	git config --add remote.multi.pushurl wrong-push-two &&
+	git -c remote.multi.pushurl= \
+	    -c remote.multi.pushurl=right-push-one \
+	    -c remote.multi.pushurl=right-push-two \
+	    remote show -n multi >actual.raw &&
+	grep URL actual.raw >actual &&
+	cat >expect <<-\EOF &&
+	  Fetch URL: right
+	  Push  URL: right-push-one
+	  Push  URL: right-push-two
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.45.2.937.g0bcb3c087a

