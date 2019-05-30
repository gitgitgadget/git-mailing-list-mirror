Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA281F462
	for <e@80x24.org>; Thu, 30 May 2019 16:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfE3Qoj (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 12:44:39 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:56963 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3Qoj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 12:44:39 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45FD2D2S8Nz5tlF;
        Thu, 30 May 2019 18:44:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B47BC208D;
        Thu, 30 May 2019 18:44:35 +0200 (CEST)
Subject: [PATCH] userdiff: two simplifications of patterns for rust
To:     =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190520170403.16672-1-marcandre.lureau@redhat.com>
 <e1c4c2ab-927d-fff9-b9e7-13943cba2273@kdbg.org>
 <CAMxuvay3ynFuP3fu57T0f9NEhjbCfM2hCUrdBHvxw-d1Jj54FA@mail.gmail.com>
 <xmqqtvde4jxv.fsf@gitster-ct.c.googlers.com>
 <a7d42d82-7d84-bf25-55ce-5c57a7ce70e9@kdbg.org>
 <CAMxuvaxW9fc4ft=aERSUt4+n237bdtDpKJMvyKq=H7yz-VLWbg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2d32b107-9278-faa0-4fea-afe662031272@kdbg.org>
Date:   Thu, 30 May 2019 18:44:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxW9fc4ft=aERSUt4+n237bdtDpKJMvyKq=H7yz-VLWbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- Do not enforce (but assume) syntactic correctness of language
  constructs that go into hunk headers: we only want to ensure that
  the keywords actually are words and not just the initial part of
  some identifier.

- In the word regex, match numbers only when they begin with a digit,
  but then be liberal in what follows, assuming that the text that is
  matched is syntactially correct.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 28.05.19 um 23:01 schrieb Marc-André Lureau:
> Both of these changes were based on your recommendations. Would you
> mind sending a follow-up patch yourself?
> 
> I can send a seperate patch for the 3 extra tests.

So, here it is. Looking forward to seeing a patch with the tests.

 userdiff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 8d7e62e2a5..2bcf105caf 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -131,11 +131,10 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
 PATTERNS("rust",
-	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl(<.+>)?)[ \t]+[^;]*)$",
+	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+_0-9.eE]+(f32|f64|u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"
-	 "|0[box]?[0-9a-fA-F_]+(u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"
+	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
 	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 "[={}\"]|[^={}\" \t]+"),
-- 
2.21.0.285.gc38d92e052
