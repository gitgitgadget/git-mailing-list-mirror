From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-show-branch --current when not on a branch
Date: Mon, 26 May 2008 15:05:40 -0700
Message-ID: <7vhcck4t6z.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.10.0805240049400.3980@euler.pkqs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue May 27 00:06:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0kq3-0008S9-No
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 00:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215AbYEZWFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 18:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755159AbYEZWFv
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 18:05:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbYEZWFu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 18:05:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 366CF3DDC;
	Mon, 26 May 2008 18:05:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 750503DDB; Mon, 26 May 2008 18:05:44 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.10.0805240049400.3980@euler.pkqs.net> (Stephan
 Beyer's message of "Sat, 24 May 2008 01:00:38 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E4DE1544-2B6F-11DD-9203-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82966>

Stephan Beyer <s-beyer@gmx.net> writes:

> builtin-show-branch.c relied on resolve_ref() to return
> "refs/heads/foo" if on branch foo.  But if not on a branch,
> it returns "HEAD".  Hence, `head + pfxlen' (i.e. head+11)
> is a memory address beyond the "HEAD" string, so that
> further operation leads to access of uninitialized memory.
>
> This commit fixes the bug by just not adding the
> "refs/heads/"-length offset.  So append_one_rev() operates
> on "refs/heads/foo" instead of "foo", which still works.
> But now it also operates correctly on "HEAD".
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>

Thanks for a patch and (more importantly) prodding..

>  builtin-show-branch.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-show-branch.c b/builtin-show-branch.c
> index 019abd3..412eba0 100644
> --- a/builtin-show-branch.c
> +++ b/builtin-show-branch.c
> @@ -782,8 +782,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
>  				has_head++;
>  		}
>  		if (!has_head) {
> -			int pfxlen = strlen("refs/heads/");
> -			append_one_rev(head + pfxlen);
> +			append_one_rev(head);

This changes the output for normal case.  How about doing it like this instead?

 builtin-show-branch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 019abd3..a383323 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -782,8 +782,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				has_head++;
 		}
 		if (!has_head) {
-			int pfxlen = strlen("refs/heads/");
-			append_one_rev(head + pfxlen);
+			int offset = !prefixcmp(head, "refs/heads/") ? 11 : 0;
+			append_one_rev(head + offset);
 		}
 	}
 
