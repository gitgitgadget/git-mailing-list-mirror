Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0F1DFCB
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444820; cv=pass; b=cJmfhhkI/oVn4DI9ZY/methKwKYbTu1bND3VVX55LsKtgRmNqpegIMRqkBThbUqxXbu4Y8Lk7I4UTeiqihK8W1wH9g+4l6gLt/biTD7ozzfxAO8P9uB2TG8GkboB0LUdAk7OirAU/q8Zjt/rpYaT8TpalooEWPhtbEsB0WYSwCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444820; c=relaxed/simple;
	bh=VpTJQKFVsfNy9bZJIG6U4bov1W0701Pe15ycXSH0D0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AM2SU0oTrS9GX1OFv2525wabaYIelFNyW9+4zcc41+iuK4vjR/4fZ4Sn0+NjZGSHlOvUWi6jDWkZCwFB5LJJpTCJ3GAJH6+PjhxXj3Rc8gL4yWLSHaHh+hJibxaCzlsjhV6ev0eXU4ChpJ1K4JC/muEyqvlYPBY97Lv6au1iVgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=EiJsMtYC; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="EiJsMtYC"
ARC-Seal: i=1; a=rsa-sha256; t=1760444738; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=daWC5Gbt+CyKoV78pmP+q9L6DGiq6j2q/aZuS2P9xcrVkRp7ojFOMyzLuHl9ZeL5yAFeML1ifzbkV5IRE1cD3QAhfCRmGeA19Cf95l7zkH9KvD7d4YvPwXhsGjzWpOX6X6DDdOLsu6kSbk4zvP2hFGFZOeLOO9+YsZ+BADvZv2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444738; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=nba+PHRo/vZTaNzIOXZjt1c0cp75oOZSva0WqO8vg88=; 
	b=WJnQND/yrWNUc6PVPmwdMJz981F6Y/+NpjemqK/lMt67oFrqCEe2yeIM/NZLtrxGYTtJaSsPJz3+6tNxtLODPyLGGeiBKfY5vUHk4RqhMkzqksOLa/eWGCK7MNfNmtXUufaiUYrATZYf4LCxOe4dvwEle7GpbEyX1q5RXuCNOO0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444738;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=nba+PHRo/vZTaNzIOXZjt1c0cp75oOZSva0WqO8vg88=;
	b=EiJsMtYCECnAfU4KbO7DpWbV+jTElWhbEcKz9/rc5Gyl+19VLluFBuweZiZ/O/kj
	oxHn26atUiAqxBXPbuuMjiusc40qNk9uoS2fsQb/1G2KJm3rwAh0qeOnCUJAoC2n29H
	AoIlaTIhKFYHY7JtB2b47xFRC/j6MIDyMtFb09JA=
Received: by mx.zohomail.com with SMTPS id 1760444736187548.6325241188703;
	Tue, 14 Oct 2025 05:25:36 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 11/29] rebase: reuse buffer for trailer args
Date: Tue, 14 Oct 2025 20:24:24 +0800
Message-ID: <20251014122452.1851103-12-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Reset the reusable buffer before reading trailer
arguments in read_basic_state() so the existing
allocation can be reused.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2a2674e375..ff8dd9ec90 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -508,7 +508,7 @@ static int read_basic_state(struct rebase_options *opts)
 		opts->gpg_sign_opt = xstrdup(buf.buf);
 	}
 
-	strbuf_release(&buf);
+	strbuf_reset(&buf);
 
 	if (strbuf_read_file(&buf, state_dir_path("trailer", opts), 0) >= 0) {
 		const char *p = buf.buf, *end = buf.buf + buf.len;
-- 
2.51.0

