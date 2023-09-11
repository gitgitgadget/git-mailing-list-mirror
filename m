Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF2DCA0ECC
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbjIKVbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbjIKMOB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 08:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0357198
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 05:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694434390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fan+14jhTYIZGVDRbcI33DBmoaHUsknyitNzUJyTVs8=;
        b=hCZ9eRcqMedV9RNn9d57OuG07wMYzPQY6ke3I5XPHATqyRiWXStOwU3ztw0hJpskb5o5Zm
        Gw2lxGWEYlD11nU5EQoITIEQlZeRaiXw45YjhFlfNc+XsWTSaTURSRGWrPIsjzbw18hzHb
        YQ36gyHrutrSx9ZuWlAZd6XW2DX3VoI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-qfrmNO1DN1ayBUObiEuxlg-1; Mon, 11 Sep 2023 08:13:07 -0400
X-MC-Unique: qfrmNO1DN1ayBUObiEuxlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E225E8F8741;
        Mon, 11 Sep 2023 12:13:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.151])
        by smtp.corp.redhat.com (Postfix) with SMTP id 69E7F4402E;
        Mon, 11 Sep 2023 12:13:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 11 Sep 2023 14:12:14 +0200 (CEST)
Date:   Mon, 11 Sep 2023 14:12:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathias Krause <minipli@grsecurity.net>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: [PATCH 1/1] git-grep: improve the --show-function behaviour
Message-ID: <20230911121211.GA17401@redhat.com>
References: <20230911121126.GA17383@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911121126.GA17383@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

show_funcname_line() returns when "lno <= opt->last_shown" and this
is not right in that the ->last_shown line (which matched the pattern)
can also have the actual function name we need to report.

Change this code to check "lno < opt->last_shown". While at it, move
this check up to avoid the unnecessary "find the previous bol" loop.

Note that --lno can't underflow, lno==0 is not possible in this loop.

Simple test-case:

	$ cat TEST.c
	void func(void);

	void func1(xxx)
	{
		use1(xxx);
	}

	void func2(xxx)
	{
		use2(xxx);
	}

	$ git grep --untracked -pn xxx TEST.c

before the patch:

	TEST.c=1=void func(void);
	TEST.c:3:void func1(xxx)
	TEST.c:5:       use1(xxx);
	TEST.c:8:void func2(xxx)
	TEST.c:10:      use2(xxx);

after the patch:

	TEST.c=1=void func(void);
	TEST.c:3:void func1(xxx)
	TEST.c=3=void func1(xxx)
	TEST.c:5:       use1(xxx);
	TEST.c:8:void func2(xxx)
	TEST.c=8=void func2(xxx)
	TEST.c:10:      use2(xxx);

which looks much better to me.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 grep.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 0904d55b24..7cad8352f4 100644
--- a/grep.c
+++ b/grep.c
@@ -1350,12 +1350,11 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 	while (bol > gs->buf) {
 		const char *eol = --bol;
 
+		if (--lno < opt->last_shown)
+			break;
+
 		while (bol > gs->buf && bol[-1] != '\n')
 			bol--;
-		lno--;
-
-		if (lno <= opt->last_shown)
-			break;
 
 		if (match_funcname(opt, gs, bol, eol)) {
 			show_line(opt, bol, eol, gs->name, lno, 0, '=');
-- 
2.25.1.362.g51ebf55


