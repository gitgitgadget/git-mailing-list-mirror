Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8F464CD0
	for <git@vger.kernel.org>; Fri, 17 May 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956986; cv=none; b=qEFIVwEWagPC/WHe68qNoV2wRLqL70PTWhfCnjOxWafUNyYLHsw9L8ZvYz0nAscZRyG4yWR/hYnzuDpNXz2QZ99cu9a9Fcv/sc5VxEBkOypTmRnFQ0U65dOhM57VqU2LKCFfybyg21HevrFFK+V3qLQIxMVXxEmAGqf4rRA+B9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956986; c=relaxed/simple;
	bh=yfaOEt0G9cBrWJdW5p5MzgLHOwtb6MxAAVT4VBOzEwE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sWhiTDSGYwEIRMwTfrhWl4XmDR8QTFqSdz7uxzZPhU9xfOXE8Fr6P2QKzDooV7wwL6DoWJs8wzqe05q0Nti8f+MxNQvrzGoUZrGhK+eX6AUoxvnd8FL9ZS7flo04urZH9DPzDzeVeng/3mc9aMWEmSWNew7PAmTDDJHRtbaYvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 18415 invoked from network); 17 May 2024 14:43:00 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 May 2024 14:43:00 -0000
Date: Fri, 17 May 2024 16:42:59 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: [PATCH] scalar: make enlistment delete to work on all POSIX platforms
Message-ID: <Zkds81OB7C5bTCl_@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The ability to remove the current working directory is not guaranteed by
POSIX so it is better to go out of the directory we want to delete on
all platforms unconditionally.

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 scalar.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scalar.c b/scalar.c
index 7234049a1b..331b91dbdb 100644
--- a/scalar.c
+++ b/scalar.c
@@ -361,16 +361,13 @@ static char *remote_default_branch(const char *url)
 
 static int delete_enlistment(struct strbuf *enlistment)
 {
-#ifdef WIN32
 	struct strbuf parent = STRBUF_INIT;
 	size_t offset;
 	char *path_sep;
-#endif
 
 	if (unregister_dir())
 		return error(_("failed to unregister repository"));
 
-#ifdef WIN32
 	/*
 	 * Change the current directory to one outside of the enlistment so
 	 * that we may delete everything underneath it.
@@ -385,7 +382,6 @@ static int delete_enlistment(struct strbuf *enlistment)
 		return res;
 	}
 	strbuf_release(&parent);
-#endif
 
 	if (have_fsmonitor_support() && stop_fsmonitor_daemon())
 		return error(_("failed to stop the FSMonitor daemon"));
