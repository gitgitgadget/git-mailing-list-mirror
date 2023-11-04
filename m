Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106BB187E
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpK32Nlj"
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E784D54
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 17:02:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5406c099cebso4200169a12.2
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 17:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699056164; x=1699660964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6na/rRoZzMK+KP+unkUOnxukNnFblVxLV8SsWvpUJ3g=;
        b=jpK32Nlj+0tBaretK+O4BIym9yiisHVHksXcKI66FEeWDt4XkTmwYqTE+l79UEiJBd
         8sDUrxHKE0UmyypmCl6ttJATto1ABH7teDcr959o8c34ni3eO+vOGT/EdYfjePg8wddL
         z3ahVQim1VCSOstePdvdll93ZZ2LNrH/h/bOo/XwrTH5JwViw6LGuarpC12yZaNA3Fli
         +tMRXsNsEooc9bKW+Cz3rtzvS1MD4KSTnLzo6xF3ZagtRIiZA3zaM/KFBGyBMD+fcLCQ
         FOdWb0rSSAaYraKmozDnMWLtFsqv4St2s89IHQWAJxojbpoKLQ+yMTe4k/iORA7xd8gh
         mT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056164; x=1699660964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6na/rRoZzMK+KP+unkUOnxukNnFblVxLV8SsWvpUJ3g=;
        b=R9nP0Db7tevqa4yVTQQzk7/4PpN/oEwJQGDRYov1Kme4n11gO3Ygbls3C4oK72NxgC
         ua0Ti8hRmlUE6l3LBFUbjxkNtHZA88CtMngwcOhKaLWwlO2fBFIlAkLMZkktmYO1A4Sx
         w0hFL1iDsHxyZ2JuJGPDVYTnu/eDk7pe0M/TVQ/F8YnpZsp8xQZB5hEInOrrGO2sWv2z
         fZPSPfcFvyDQmlithWgYZ9QtazvNCl2vP/2jDDEd9Vvm/4PshhGy1JH9BMpaMhJBSWsn
         UxtMRXdOEaCVALma0DoEu2kGD6GS9KnX2w5huZ5Pw9goz4ifqEUhh8BMJGTD0MBNszVo
         GEIA==
X-Gm-Message-State: AOJu0YyqyPWr9BpXilKdCj+tsqxoshDZnAKQf0bKoXwqlqeK/4eATPe5
	4NchDnpjKEpgf7gDzWwvkjPiHNhayVc=
X-Google-Smtp-Source: AGHT+IEO+JyskbveQVEaFmdrXF8WF8I3JV+Z0MOfIC3q6eT2CDhvMNI+UygkVbEWnWjSS8+VKz72sQ==
X-Received: by 2002:a17:907:843:b0:9be:85c9:43ef with SMTP id ww3-20020a170907084300b009be85c943efmr7732275ejb.62.1699056163922;
        Fri, 03 Nov 2023 17:02:43 -0700 (PDT)
Received: from linuxerio.localdomain (j149130.upc-j.chello.nl. [24.132.149.130])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090655cf00b0098ec690e6d7sm1407492ejp.73.2023.11.03.17.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 17:02:43 -0700 (PDT)
From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [RFC PATCH] status: avoid reporting worktrees as "Untracked files"
Date: Sat,  4 Nov 2023 01:02:08 +0100
Message-ID: <20231104000209.916189-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given that worktrees are tracked in their own special fashion separately,
it makes sense to _not_ report them as "untracked". Also, when seeing the
directory of a worktree listed as Untracked, it might be tempting to try
to do operations (like 'git add') on them from the parent worktree which,
at the moment, will silently do nothing.

With this patch, we check items against the list of worktrees to add
them into the untracked items list effectively hiding them.

END OF PATCH

Here are a few questions more inline with the "RFC" part of the patch.

About UI
- Would it make more sense to separate them from Untracked files instead
  of hiding them (perhaps add a --worktrees option to display them)?
- Follow-up if the previous answer is 'yes': List a worktree only if it
  is not clean?

About code:
- If keeping the idea/patch, Would it make more sense (performance-wise) to
  fist check an item in the list of worktrees before checking it in the
  index? In other words, reverse the conditions to add an item to the
  untracked list?
---
 wt-status.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 9f45bf6949..5fd1e6007a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -775,6 +775,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	struct dir_struct dir = DIR_INIT;
 	uint64_t t_begin = getnanotime();
 	struct index_state *istate = s->repo->index;
+	struct worktree **worktrees;
 
 	if (!s->show_untracked_files)
 		return;
@@ -795,9 +796,12 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 	fill_directory(&dir, istate, &s->pathspec);
 
+	worktrees = get_worktrees();
+
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		if (index_name_is_other(istate, ent->name, ent->len))
+		if (index_name_is_other(istate, ent->name, ent->len) &&
+		    !find_worktree_by_path(worktrees, ent->name))
 			string_list_insert(&s->untracked, ent->name);
 	}
 
@@ -809,6 +813,9 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 	dir_clear(&dir);
 
+	if (worktrees)
+		free_worktrees(worktrees);
+
 	if (advice_enabled(ADVICE_STATUS_U_OPTION))
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
 }
-- 
2.42.0

