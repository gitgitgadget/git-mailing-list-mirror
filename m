Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D54381AEF
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984760; cv=none; b=aX/mx734OGZnfqeD0FkfFCMX7je4Qgld5yZuxFqRDnwpeEREQezped5+737wpnTjlv3WYAzfBQ+wXvBvBa8qV9R7Lr3rBvy8clbg6Hr+omYRLGYo1f5JRXWYIQordEEnvh7nI/Ba9+cut4B8GCe6CRUKf0WzhjbyTvlf50UZHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984760; c=relaxed/simple;
	bh=r9Z+OKYKDi9xpx8W9sRLQT43xlC182RKE6N3CdmS0Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0RxuljXs74OP7rXVKy05lIoppjFWvurFxRxvM1+tdiBNcjFAWRVCryOF7LaJrMhreHp8aZce6x/6X8xQhudxc+Vsih5r6XC/3ERQS8L32YaJ7EWf25jst96F6EktaC0S7vPDjQXnS7u26Lngd5AiMH9d19UdVOiA/wkDmbayKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=aFbh2r8y; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="aFbh2r8y"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776984742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TvF8WmXumuxFVup7lpd7iSoPbUWACmsPwWKZR6yoxZU=;
	b=aFbh2r8y24ep9dbDymcyZNHKMxWeXoBQSFyd01PO7GGm2SKcgteVEIiPtTs+eT5yXEfWCO
	6MA1lHJXVEQAEQQEwP4aKRZYKuIWprtK0dgpr5RuBq203RfZXl1Ch7Wt0uMxC79Ou70ld/
	npd5fdgKUn3w8WtaP5TrzYczSr2Nn6z+p6Y6ah3Z3EQ3ZIAVNdl0kzGb5WlkaX1COAWnwd
	AGwC/Fq3bNxVBM3icY1cAyxqucLujufx/6UA7mI714Dap7aJUlDmG5c6SMoAPr0U9blnPu
	fploBCxYkwIx8tYZunCM8EaYuXNOoiws0s59af0fFbqcARGEJgAc07s5Zn05gw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v3 0/2] revision.c: implement --reverse=before for walks
Date: Fri, 24 Apr 2026 00:51:58 +0200
Message-ID: <cover.1776984666.git.mroik@delayed.space>
In-Reply-To: <20260422002840.303477-4-mroik@delayed.space>
References: <20260422002840.303477-4-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3057; i=mroik@delayed.space; h=from:subject:message-id; bh=r9Z+OKYKDi9xpx8W9sRLQT43xlC182RKE6N3CdmS0Zk=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp6qKOvnBS7Ju9vnV1vb9k5dCGeGGTi9WqJ6Fgb ZDbAO6ULTeJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaeqijgAKCRBIeX6hnBm+ 0UReD/9FCAv8ZGjwjMy8rLFSDfzINAWDUln1r/2/hQ9rdNlfbhP7tfWOyjjG/1T/DSFzMycOO/z T03/zS4cD0HQEtaSclBiJTEu3PCbdqEiTBG2sDtBVIJP8s0ad6GMPp2PKlQhiweJsyPfx2IYYCV On26Pvw3L39K8Jr/8ZUBnsKzv56bX9+1enahL4Bqu7At1CwuLqgkS2OKVA8SaNE9/wHQ4MYHm29 SyKeyaSYMTAGCQVa/j90wf8x4xFdp0DdSqxdmJQK4ObH3PmRnsxcoEAJZO3hunj1uIuiejxPKcV 3xh2XVjQ8iqYW2cXOR7AznnCHG+iGJtU1rH8QfKAIkRYSJsk8UjAyqzRxKhqPRarcAfVp3LHoxR oUtYP2rX1QQbVkXYiL4wYCIap2iB4XNmN3ohQOZo9AiVZxOrn7EfjKeQjDz68QfufabncNu5okK dYiR2yO3WsmtvVmnOK5bgKC4X2N7yk8s8sPv5CapbSaDSZlWYlT3F1Vjay5egUyv45bW/3b1zH3 wpb6QDrjgtXlcM3+39deHTBnclZpIeSzmVLx0x9PlkRtPzOUcMhpJJhY8uRGnY03F+U842oy7Ox qOJndIVh/6B0H6+7QENukxB2fVpyr/0nyQXGv6zhxVTwq7WA20QmP+02gfPSshqXJKhbykyQcU4 BMIFFqOk1
 lP6DdA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

I've fixed the docs with the suggested changes by Jeff and applied some
styling fixes.

[1/2] revision.c: implement --reverse=before for walks (Mirko Faina)
[2/2] revision.c: reduce memory usage on reverse before (Mirko Faina)

 Documentation/rev-list-options.adoc | 16 +++++--
 revision.c                          | 73 +++++++++++++++++++++++++++--
 revision.h                          |  8 +++-
 t/t4202-log.sh                      | 66 ++++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 10 deletions(-)

Range-diff against v2:
1:  599a247d82 ! 1:  4864ac46dd revision.c: implement --reverse=before for walks
    @@ Documentation/rev-list-options.adoc: With `--topo-order`, they would show 8 6 5
     +	`--walk-reflogs`. If `after`, output the commits chosen to be
     +	shown (see 'Commit Limiting' section above) in reverse order. If
     +	`before`, reverse the commits before filtering with `Commit
    -+	Limiting` options. This option can be used multiple times, last
    -+	one is applied. When the argument for `--reverse` is omitted, if
    -+	the current state is in no reverse, it defaults to `after`. If
    -+	it is in any reversed state, it restores the original ordering
    -+	by removing the reverse state.
    ++	Limiting` options. When multiple `--reverse=` options are given,
    ++	the final option overrides any previous options. The `--reverse`
    ++	option (with no specifier) behaves as `--reverse=after`, except
    ++	that, for historical reasons, it negates any previous reversed
    ++	state (so `--reverse --reverse` does nothing, nor does
    ++	`--reverse=before --reverse`. Note that `--reverse=before
    ++	--reverse --reverse` is the same as `--reverse=after`).
      endif::git-shortlog[]
      
      ifndef::git-shortlog[]
2:  480b322cf8 ! 2:  00489b0e52 revision.c: reduce memory usage on reverse before
    @@ revision.c: static struct commit *get_revision_internal(struct rev_info *revs)
      }
      
     +static void retrieve_with_window(struct rev_info *revs, int max_count,
    -+			  struct commit_list **reversed)
    ++			  	 struct commit_list **reversed)
     +{
     +	struct commit *c;
     +	struct commit_list *into_queue = NULL;
    @@ revision.c: static struct commit *get_revision_internal(struct rev_info *revs)
     +		}
     +	}
     +
    -+	while (outo_count) {
    -+		c = pop_commit(&outo_queue);
    -+		outo_count--;
    ++	while ((c = pop_commit(&outo_queue)))
     +		commit_list_insert(c, reversed);
    -+	}
    -+
    -+	while (into_count) {
    -+		c = pop_commit(&into_queue);
    -+		into_count--;
    ++	while ((c = pop_commit(&into_queue)))
     +		commit_list_insert(c, &outo_queue);
    -+		outo_count++;
    -+	}
    -+
    -+	while (outo_count) {
    -+		c = pop_commit(&outo_queue);
    -+		outo_count--;
    ++	while ((c = pop_commit(&outo_queue)))
     +		commit_list_insert(c, reversed);
    -+	}
     +}
     +
      struct commit *get_revision(struct rev_info *revs)
-- 
2.54.0

