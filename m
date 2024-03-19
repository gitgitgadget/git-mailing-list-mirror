Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CEA54FAB
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847463; cv=none; b=OAIFh46GqmbW+DxMbLYaSBB7iOmD4ICFzgyOTmqpP+y5GwLV/RbewcgS76WfOTzNW1d2wIhMdmkZ+MEmGz5f0e64JoM1xqFSpXCRKNe3C9Ap2Yr8kh9JoEraYzLz1rndTnQGgMlhg3GjnpWYmKA587kgoo4JjzUYgjPN9D8H17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847463; c=relaxed/simple;
	bh=9uC3WSBZkx5lJMcx9kg2PA0EIpkw/TmOx4kpx9xQTVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDrDRBJrrXrm41HQcBDZ9YTg9XFbUXVVKaY8tOJfS2XjeP/01biy2Gxgwiy8M1DoLMM5ZRQunQhG4FMorD2xXEA/gS440jmQJFrgKCD+ifYmEFOGYmz7zuD9Mf0gKL6NbmwptspAZuGIsKF3Z6X6bvy1rGMdFopzSXF5WwANRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=SlI3iBJe; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="SlI3iBJe"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42JBODk9017024
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 19 Mar 2024 12:24:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710847453; bh=9uC3WSBZkx5lJMcx9kg2PA0EIpkw/TmOx4kpx9xQTVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SlI3iBJeE1O3g4sfe+W9k/X/ZRNGTc3K16sn3cI3mflpLo+pqqYJCJG0rprxdxUsm
	 1l3v8K4qFue5sgjhjceOrRlZ1WOcnASJ71S3wMAd+JkUNC1M1oDdiVmtSmxJ1PegKy
	 G09VLeWqz8h2VHyousCz3YcRVu6qE9gcvsRkZrBQ=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 3/5] MyFirstObjectWalk: fix filtered object walk
Date: Tue, 19 Mar 2024 12:23:13 +0100
Message-ID: <fac6886af36c3b99e8e590dd916c09beb7f397cd.1710840596.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710840596.git.dirk@gouders.net>
References: <cover.1710840596.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f0d2f849 (MyFirstObjectWalk: update recommended usage)
changed a call of parse_list_objects_filter() in a way that
probably never worked: parse_list_objects_filter() always needed a
pointer as its first argument.

Fix this by removing the CALLOC_ARRAY and passing the address of
rev->filter to parse_list_objects_filter() in accordance to
such a call in revisions.c, for example.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/MyFirstObjectWalk.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index c33d22ae99..a06c712e46 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -734,8 +734,8 @@ walk we've just performed:
 	} else {
 		trace_printf(
 			_("Filtered object walk with filterspec 'tree:1'.\n"));
-		CALLOC_ARRAY(rev->filter, 1);
-		parse_list_objects_filter(rev->filter, "tree:1");
+
+		parse_list_objects_filter(&rev->filter, "tree:1");
 	}
 	traverse_commit_list(rev, walken_show_commit,
 			     walken_show_object, NULL);
-- 
2.43.0

