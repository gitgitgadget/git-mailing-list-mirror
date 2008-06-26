From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] don't allow 'commit --amend' during rebase conflict resolution
Date: Thu, 26 Jun 2008 17:33:58 +0400
Message-ID: <20080626133358.GG5737@dpotapov.dyndns.org>
References: <20080625233208.GE5737@dpotapov.dyndns.org> <20080626121303.GF8610@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 26 15:35:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBrcy-0001A3-RJ
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 15:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbYFZNeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 09:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbYFZNeI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 09:34:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:32422 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbYFZNeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 09:34:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so14751fgg.17
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bQWRngv2Lu774HIbbLnLOg2t4YJVyoOfunD1bwbj/sg=;
        b=HMzZBzMCuAtpHhcHQ31s/db34ZtgmaVbhuTDhz+la7ajyGUm6ScDhAR5RZzkiBAHiE
         MQzwP3e05MgbPuJ64BIULfkq1ZqLU1BTC62FZEtcqGjXyDdu/n3R4dbTD8bdBV3vPEF6
         E+Q+03dkP47MZRblDB5Qo7HKeH9euX9qxDj2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CaOqF7ROekQwsXvgYxZfG5T10pEMEYVar3Alzco6bWrscqgkeIbWgxkipg+6JaDaNS
         G7+KFLPsEqPfYhr0/7pSBL7JI9hrU6qWIo/fjMAa9d88omUefNXDBGDwWQSyqrAosGLk
         RlqZXWNuFb34zOOcitObqRkGafE6ZmPFbCiY8=
Received: by 10.86.28.2 with SMTP id b2mr75181fgb.78.1214487241844;
        Thu, 26 Jun 2008 06:34:01 -0700 (PDT)
Received: from localhost ( [85.141.151.43])
        by mx.google.com with ESMTPS id 12sm189407fgg.0.2008.06.26.06.34.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Jun 2008 06:34:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080626121303.GF8610@mit.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86450>

Running 'commit --amend' during git rebase is almost certainly a mistake,
which causes that two consequent patches are squashed together. Moreover,
the commit message of the second commit is silently lost. It is almost
certainly not what the user expects. In that very unlikely case when you
really want to combine two patches during rebase conflict resolution,
you can do that using "git reset --soft HEAD^" followed by "git commit".
---

On Thu, Jun 26, 2008 at 08:13:03AM -0400, Theodore Tso wrote:
> 
> In fact, we do this already for git-merge.  Why not just do the same
> thing in the middle of a merge conflict with git-rebase?

Thank you for suggestion. I have corrected my patch to so the same as
we do in the case of git-merge conflict. MERGE_MSG is already removed
on successful commit, so the patch is very simple now.

 builtin-commit.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e3ad38b..6d1d955 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -725,6 +725,10 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die("You have nothing to amend.");
 	if (amend && in_merge)
 		die("You are in the middle of a merge -- cannot amend.");
+	/* no MERGE_HEAD but MERGE_MSG means a conflict during rebase */
+	if (amend && !access(git_path("MERGE_MSG"), F_OK))
+		die("You are in the middle of a rebase conflict -- "
+			"cannot amend.");
 
 	if (use_message)
 		f++;
-- 
1.5.6.60.gbc566
