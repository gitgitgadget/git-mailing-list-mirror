From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] New test for rebase with preserve merges and squash
Date: Fri, 21 Mar 2008 00:46:34 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803210040270.4124@racer.site>
References: <alpine.LSU.1.00.0803201208080.3983@racer.site> <1206018070-3402-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1836515949-1206056796=:4124"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:47:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcUTc-0004yg-8g
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 00:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbYCTXqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 19:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbYCTXqf
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 19:46:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:47126 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754824AbYCTXqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 19:46:35 -0400
Received: (qmail invoked by alias); 20 Mar 2008 23:46:32 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp009) with SMTP; 21 Mar 2008 00:46:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZugkRF6kZ7sUhSYqTP7u5hXcTY73fAVxmI6pQE9
	9hB8hRy08zSn32
X-X-Sender: gene099@racer.site
In-Reply-To: <1206018070-3402-1-git-send-email-joerg@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77689>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1836515949-1206056796=:4124
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 20 Mar 2008, Jörg Sommer wrote:

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 62e65d7..c849415 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -362,4 +362,56 @@ test_expect_success 'rebase with a file named HEAD in worktree' '
>  
>  '
>  
> +test_expect_success 'squash and preserve merges' '
> +	test_tick &&
> +	git checkout -b squash-and-preserve-merges master &&
> +	echo A > file1 &&
> +	git commit -m SaPM-1 file1 &&
> +	echo B > file1 &&
> +	git commit -m SaPM-2 file1 &&
> +	git merge to-be-preserved &&
> +	echo C > file1 &&
> +	git commit -m SaPM-3 file1
> +'
> +
> +# This test should fail, because the prompt includes the commit from the
> +# merge not only the merge:
> +# -> pick 9604163 unrelated
> +#    pick 5ef0364 SaPM-1
> +#    pick 22aadcf SaPM-2
> +#    pick 828f7d8 Merge branch 'to-be-preserved' into squash-and-preserve-merges
> +#    pick 2a15a54 SaPM-3
> +test_expect_failure 'expect preserve merges shown not commits from merge' '
> +        EXPECT_COUNT=4 FAKE_LINES="1 2 squash 4 3" \
> +          git rebase -i -p --onto branch1 master ||
> +        { git rebase --abort;
> +          EXPECT_COUNT=5 FAKE_LINES="1 2 3 squash 5 4" \
> +          git rebase -i -p --onto branch1 master;
> +          false; }
> +'

I'm sorry, but I have to tell you: I do not like that style at all (for 
one, your expect_failure can succeed for all kind of reasons, the exit 
value of git rebase --abort is not even checked).

And I do not understand the message "expect preserve merges shown not 
commits from merge".

Which makes things kinda awkwardly hard for me.

So I have to guess that you think that in this case:

  B---D-E-F-G
 /   ,---'
A---C

a revision range B..G excludes C?  Not so.  "^B ^C G" would, but there is 
no way to specify this with a call to rebase.

So I find it quite logical that your test case fails.

Hth,
Dscho



--8323584-1836515949-1206056796=:4124--
