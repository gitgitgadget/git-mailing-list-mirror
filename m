Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D31874BE8
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458584; cv=none; b=FopXitsjNFgPzNTdlWNkYWgSpO8sLC1QX6RTZsip9XjAlonbv/c2ksfLoPH5JBYgHuypQ2FzgXcPj/107bz0YHeSLCSij7bXZDbwgsraqifgnT/PNFA6OjZmj22o26bi7UH2FWBCxrdb4e/TOc8OdlQXDyxPEH7Aq3zeIHjoRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458584; c=relaxed/simple;
	bh=0fwatfWzHzvDwFm/9YzaaNSv6HPygBWP2jjc/WbXyls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roJER2IC8nSszctBr/mhbpXtCVnkUHf8k0+N31i4VFr40m/n2yxuFTuswaV8Ma84h3KFFVESFwGc7TrAEhjC95xlEtZvk24nPD2fR2M+3QWiuooprDP6QTCd9xEAGconEEE2Gwoodm+oye8qAdSBQR9V41D8++OF6I0IE3Hemz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=CDZb8V+C; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="CDZb8V+C"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42QD9V42006395
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 26 Mar 2024 14:09:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711458572; bh=0fwatfWzHzvDwFm/9YzaaNSv6HPygBWP2jjc/WbXyls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDZb8V+CTCDyD0on9bKMLnPbV1jK51HvTk5GrEooeK413+hxE3OBxq76kbVltB/9Z
	 1ECGvZlByrQMeZNrkHZBa2/oFh/m6lLu0zHYp5AIo3qbNozUu4sQJ/4Gg9cm4g7byn
	 0HTuKNaz8q00oklQFjPQ6ztk2fGr9oNlxI2UTh0g=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v4 4/5] MyFirstObjectWalk: fix description for counting omitted objects
Date: Tue, 26 Mar 2024 14:08:39 +0100
Message-ID: <20240326130902.7111-5-dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711368498.git.dirk@gouders.net>
References: <cover.1711368498.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the changes to count omitted objects, the function
traverse_commit_list() was used and its call cannot be changed to pass
a pointer to an oidset to record omitted objects.

Fix the text to clarify that we now use another traversal function to
be able to pass the pointer to the introduced oidset.

Helped-by: Kyle Lippincott <spectral@google.com>
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/MyFirstObjectWalk.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index a06c712e46..6901561263 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -754,10 +754,12 @@ points to the same tree object as its grandparent.)
 === Counting Omitted Objects
 
 We also have the capability to enumerate all objects which were omitted by a
-filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
-`traverse_commit_list_filtered()` to populate the `omitted` list means that our
-object walk does not perform any better than an unfiltered object walk; all
-reachable objects are walked in order to populate the list.
+filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
+change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
+able to populate an `omitted` list.  This list of filtered objects may have
+performance implications, however, because despite filtering objects, the possibly
+much larger set of all reachable objects must be processed in order to
+populate that list.
 
 First, add the `struct oidset` and related items we will use to iterate it:
 
@@ -778,8 +780,9 @@ static void walken_object_walk(
 	...
 ----
 
-Modify the call to `traverse_commit_list_filtered()` to include your `omitted`
-object:
+Replace the call to `traverse_commit_list()` with
+`traverse_commit_list_filtered()` and pass a pointer to the `omitted` oidset
+defined and initialized above:
 
 ----
 	...
-- 
2.43.0

