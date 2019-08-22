Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC911F461
	for <e@80x24.org>; Thu, 22 Aug 2019 15:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbfHVPGT (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 11:06:19 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:41223 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbfHVPGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 11:06:19 -0400
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 14A4D200003;
        Thu, 22 Aug 2019 15:06:16 +0000 (UTC)
Date:   Thu, 22 Aug 2019 20:36:14 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Giuseppe =?utf-8?B?Q3JpbsOy?= <giuscri@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190822150614.o25g37pwfcaos2zn@localhost.localdomain>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/19 02:32PM, Giuseppe Crinò wrote:
> Note how `git log` discards the ending quote character:
> ```
> root@NBR1710R:~# git init repo
> Initialized empty Git repository in /root/repo/.git/
> root@NBR1710R:~# cd repo/
> root@NBR1710R:~/repo# git config user.name Les Actualite\'
> root@NBR1710R:~/repo# cat .git/config
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> [user]
>         name = Les
> root@NBR1710R:~/repo# git config user.name "Les Actualite\'"
> root@NBR1710R:~/repo# cat .git/config
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> [user]
>         name = Les Actualite\\'
> root@NBR1710R:~/repo# touch foo
> root@NBR1710R:~/repo# git add foo
> root@NBR1710R:~/repo# git commit -m 'first'
> [master (root-commit) a78e11f] first
>  Committer: Les Actualite <root@NBR1710R>
> Your name and email address were configured automatically based
> on your username and hostname. Please check that they are accurate.
> You can suppress this message by setting them explicitly. Run the
> following command and follow the instructions in your editor to edit
> your configuration file:
> 
>     git config --global --edit
> 
> After doing this, you may fix the identity used for this commit with:
> 
>     git commit --amend --reset-author
> 
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 foo
> root@NBR1710R:~/repo# git log
> commit a78e11ff0707bd4f1bea195735a7fc8b7ee2b9f8 (HEAD -> master)
> Author: Les Actualite <root@NBR1710R>
> Date:   Thu Aug 22 14:25:11 2019 +0200
> 
>     first
> ```
> 
> I can't test with the development tree right now,
> ```
> root@NBR1710R:~/repo# git --version
> git version 2.17.1
> ```

Hi,

I took a quick look into this problem. The issue is not with git log, 
but instead with git commit. When you commit, 
builtin/commit.c::author_info() calls ident.c::fmt_ident(), which in 
turn calls ident.c::strbuf_addstr_without_crud(), which in turn calls 
ident.c::crud().

This strbuf_addstr_without_crud() function removes various characters 
from the start and end of the author info, one of which is the single 
quotation. I'm not sure why this is done, the more experienced folk 
where will have the answer.

Anyway, the fix is simple enough. Remove the lines that mark single 
quotes as crud in the crud() function. This will fix the issue for the 
future commits. If you need to fix it for past commits, you need to 
re-write your history with the fix applied.

Below is the quick-and-dirty patch that fixes this. If there is no 
reason for this patch to be dropped, I'll send a proper one once some 
other people have commented.

-- >8 --
diff --git a/ident.c b/ident.c
index e666ee4e59..63cc5e32d3 100644
--- a/ident.c
+++ b/ident.c
@@ -204,9 +204,7 @@ static int crud(unsigned char c)
 		c == ';' ||
 		c == '<' ||
 		c == '>' ||
-		c == '"' ||
-		c == '\\' ||
-		c == '\'';
+		c == '"';
 }
 
 static int has_non_crud(const char *str)

-- 
Regards,
Pratyush Yadav
