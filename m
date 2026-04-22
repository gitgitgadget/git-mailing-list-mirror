Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6828DC4
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898824; cv=none; b=kc1TjOVVLzUmvmTnB1R5fbNsYKbAHcAgwE/+YVwIdBhhFXE2+KMYehhWABdqNtozz0zPJEMorzcB9Q0rEQg+YqspnO3zxIf0EjU6b/whtBD8LrVHaUxi/dsmGqsChVvEInBhUOWr1eotocpsEfHqT7BHD3jgwCYcxg45utz10zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898824; c=relaxed/simple;
	bh=d02/Udrljvy2frer11PaWhPdk4tdQlLmtONr3Ob/F2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB1b1n7VyHWBj2moz1OBoyHp5IlIsvnFrV1uAEUlQgRMMavNXhghS5C5HDFn2mdCmukvOsILg386dYTEmF2HJxYawmdJx2qve9YDp7jg5yMdXbHuVzB3wOHniULN/Nls5VJq4lgHX2VzKLP3GuLuUd5YJnMQCJDovk/SZtzLtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Wx9pie9g; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Wx9pie9g"
Received: (qmail 428662 invoked by uid 106); 22 Apr 2026 23:00:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=d02/Udrljvy2frer11PaWhPdk4tdQlLmtONr3Ob/F2g=; b=Wx9pie9gbcyiSbE9LYXAxlYVLY6O+Ue/gj2hYyztcuyRKcmm8hp8sWibBcFCcp6r+SO5XzL60IdsDGWSs9+cy4HIAnZJ0zW9Oqik/3imcv0tR06uiEw/+e9Q/8HabuPjm5bs4tNZWdHxIm7jnhFKmdS4hRQ0FpVZ0d7MCelGa+k0iys2oeaIOJz9o17yMlezHRuvz/j+aWx2RYH/rpYic26MW65Ji7WE2x57s/uRIAydhJ2GAQNf8eNDQFv4S28hVFvIqrDz2dEth4pU+087HnZkO0IZFP/6434hKodhQaO6eTgOhiAQY+tkifi+z8KayEMNkAHrqsKSVrcibnQw6g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Apr 2026 23:00:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 977951 invoked by uid 111); 22 Apr 2026 23:00:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2026 19:00:21 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 22 Apr 2026 19:00:20 -0400
From: Jeff King <peff@peff.net>
To: Jan Palus <jpalus@fastmail.com>
Cc: git@vger.kernel.org, Andrew Au <cshung@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Revert "transport-helper, connect: use clean_on_exit to reap
 children on abnormal exit"
Message-ID: <20260422230020.GA1839627@coredump.intra.peff.net>
References: <aekVSi4iu9YLaPLQ@rock.grzadka>
 <20260422223542.GA110382@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422223542.GA110382@coredump.intra.peff.net>

On Wed, Apr 22, 2026 at 06:35:43PM -0400, Jeff King wrote:

> So I think just reverting dd3693eb08 is probably the most immediate fix.

Here it is in patch form.

-- >8 --
Subject: Revert "transport-helper, connect: use clean_on_exit to reap children on abnormal exit"

This reverts commit dd3693eb0859274d62feac8047e1d486b3beaf31.

The goal of that commit was to avoid zombie child processes hanging
around when the parent git process is killed. But it doesn't quite work
when the child command is run by the shell:

  1. If there is a shell, then we kill and wait for the shell, not the
     process spawned by the shell. And so the child process, even if it
     eventually exits, will hang around as a zombie forever. And this is
     true of most (all?) shells: bash, dash, etc.

     So we are not really accomplishing our goal in the first place.

  2. Not all shells will exit immediately upon receiving a signal. In
     particular, mksh will wait for its children to exit (but not
     actually propagate the signal to them!) leaving us with a potential
     deadlock: git is wait()ing on mksh, which is wait()ing on a child
     process, but that child process is waiting on git to produce more
     input (or EOF) over a pipe.

     You can see several examples of this deadlock in the test suite,
     for example by running:

       make SHELL_PATH=/bin/mksh
       cd t
       ./t5702-protocol-v2.sh

Because this is a regression for mksh users, and because we did not
achieve our goal even with other shells, let's revert the commit for
now. If there is a more clever way of doing the same thing, we can
consider applying it separately on top (or do nothing and just accept
the zombies and rely on PID 1 to reap them).

Reported-by: Jan Palus <jpalus@fastmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 connect.c          | 4 ----
 transport-helper.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/connect.c b/connect.c
index fcd35c5539..a02583a102 100644
--- a/connect.c
+++ b/connect.c
@@ -1054,8 +1054,6 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	strvec_push(&proxy->args, port);
 	proxy->in = -1;
 	proxy->out = -1;
-	proxy->clean_on_exit = 1;
-	proxy->wait_after_clean = 1;
 	if (start_command(proxy))
 		die(_("cannot start proxy %s"), git_proxy_command);
 	fd[0] = proxy->out; /* read from proxy stdout */
@@ -1517,8 +1515,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 		}
 		strvec_push(&conn->args, cmd.buf);
 
-		conn->clean_on_exit = 1;
-		conn->wait_after_clean = 1;
 		if (start_command(conn))
 			die(_("unable to fork"));
 
diff --git a/transport-helper.c b/transport-helper.c
index 4e5d1d914f..4614036c99 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -154,8 +154,6 @@ static struct child_process *get_helper(struct transport *transport)
 
 	helper->trace2_child_class = helper->args.v[0]; /* "remote-<name>" */
 
-	helper->clean_on_exit = 1;
-	helper->wait_after_clean = 1;
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
 		die(_("unable to find remote helper for '%s'"), data->name);
-- 
2.54.0.232.gea82d9008b

