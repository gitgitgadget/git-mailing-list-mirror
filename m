Received: from 9.mo550.mail-out.ovh.net (9.mo550.mail-out.ovh.net [178.32.108.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A62C68D
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.108.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707083966; cv=none; b=GP9xeTmgpwsDGPFAgsabalN5Pc5OaCztUTHVIGvWKtPAqCLEVe0TRKkYvIrXZKHQw38SMg6Hjz0huZAbyIDKL2UYsQ7hkw82JzDTzVNqI/0E1UBJ/N8urTB6JH/UfsRoFgWQbCI+SQ7xgToe1SZLtrSf+i08/LBURWAwiIFSlJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707083966; c=relaxed/simple;
	bh=ZbW0XBpXgAowPyaT9yOwoFzX1r1BPzgzsjU18I1tZjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ul2F35/EApxUqQh/KIyFksiBrcyHnxNkBlzk6Wo7L6HP64ekiXrsWTTDARQGihi6gT2eSKYJrzRL+x7fPEfhdNVvUPe7JcZk1lh1SZQ5v6sE3SIyrvSNMWNOW62B8+SQVCH6JFtzNtbvaek6vqa0/NxZVLs/OF5io0xtPDxbbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org; spf=pass smtp.mailfrom=devyard.org; arc=none smtp.client-ip=178.32.108.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devyard.org
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.25.166])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 37E0C2668F
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 18:54:33 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-z4d9m (unknown [10.108.54.55])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id EC8671FD65;
	Sun,  4 Feb 2024 18:54:32 +0000 (UTC)
Received: from devyard.org ([37.59.142.107])
	by ghost-submission-6684bf9d7b-z4d9m with ESMTPSA
	id UDPCN2jdv2XGEgAAbck5jQ
	(envelope-from <ypsah@devyard.org>); Sun, 04 Feb 2024 18:54:32 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-107S00188968416-08b6-4ec3-8d22-14fa806dc18e,
                    2F615BA836ACE59B185ACC479DFD3D80C8A04DFC) smtp.auth=ashpy@devyard.org
X-OVh-ClientIp:213.10.167.74
From: Quentin Bouget <ypsah@devyard.org>
To: git@vger.kernel.org
Cc: Quentin Bouget <ypsah@devyard.org>
Subject: [PATCH 2/2] http: prevent redirect from dropping credentials during reauth
Date: Sun,  4 Feb 2024 19:54:27 +0100
Message-ID: <20240204185427.39664-3-ypsah@devyard.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204185427.39664-1-ypsah@devyard.org>
References: <20240204185427.39664-1-ypsah@devyard.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 15954283154963412405
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepsfhuvghnthhinhcuuehouhhgvghtuceohihpshgrhhesuggvvhihrghrugdrohhrgheqnecuggftrfgrthhtvghrnhepveelgefhtdekffejtdeiffevheehgfefjedtffdvkefgudeghfeigeeugeehfffhnecukfhppeduvdejrddtrddtrddupddvudefrddutddrudeijedrjeegpdefjedrheelrddugedvrddutdejnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeohihpshgrhhesuggvvhihrghrugdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht

During a re-authentication (second attempt at authenticating with a
remote, e.g. after a failed GSSAPI attempt), git allows the remote to
provide credential overrides in the redirect URL and unconditionnaly
drops the current HTTP credentials in favors of those, even when there
aren't any.

This commit makes it so HTTP credentials are only overridden when the
redirect URL actually contains credentials itself.

Signed-off-by: Quentin Bouget <ypsah@devyard.org>
---
 http.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/http.c b/http.c
index ccea19ac47..caba9cac1e 100644
--- a/http.c
+++ b/http.c
@@ -2160,7 +2160,25 @@ static int http_request_reauth(const char *url,
 	if (options && options->effective_url && options->base_url) {
 		if (update_url_from_redirect(options->base_url,
 					     url, options->effective_url)) {
+			char *username = NULL, *password = NULL;
+
+			if (http_auth.username)
+				username = xstrdup(http_auth.username);
+			if (http_auth.password)
+				password = xstrdup(http_auth.password);
+
 			credential_from_url(&http_auth, options->base_url->buf);
+
+			if (http_auth.username)
+				free(username);
+			else if (username)
+				http_auth.username = username;
+
+			if (http_auth.password)
+				free(password);
+			else if (password)
+				http_auth.password = password;
+
 			url = options->effective_url->buf;
 		}
 	}
-- 
2.43.0

