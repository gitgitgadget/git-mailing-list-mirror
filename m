From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/9] commit --dry-run: give advice on empty amend
Date: Sat, 24 Jul 2010 20:01:16 -0500
Message-ID: <20100725010116.GH18420@burratino>
References: <20100725005443.GA18370@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 03:02:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocpbl-0000Ir-1g
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 03:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab0GYBCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 21:02:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50473 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab0GYBCU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 21:02:20 -0400
Received: by gyg10 with SMTP id 10so545937gyg.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 18:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AE79n2/gsEDTkyXDPo7pTAdP+OjHPt1TqKGWaepnTCI=;
        b=kNL5QM4K3MItWayq+jo754o+1mZUKh0IfZQYQ8CrIuVtq2vQoXN/SlgLriswHu5f50
         DQb4eGS5TXfhJTLh7Xms1lJeRKEWx0++O5QkrvleSxpttp87cVYx/cnkLoVEnC2fi2YZ
         suqyIjkYNOVUPZ+pt/r8Zfj/gOBfKqCW4tD2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XTp3Y6RE5CyjZgSXbxOspXiDdktBaCpzGPp3rDa8QZvQQ3beFlDArmkfuBcbKe8jaD
         E0i47MWulfZoIAPOrGkw1x60YqI1DDyNBQBN3/ralWeyx3O7ypGAANCOq06BcEVL8zdV
         81oiwo2ihwuUhQ+CO2NPkpZfSrN8C4ONmhNrI=
Received: by 10.150.73.32 with SMTP id v32mr7386088yba.128.1280019739502;
        Sat, 24 Jul 2010 18:02:19 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p8sm4326572ybk.3.2010.07.24.18.02.18
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 18:02:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100725005443.GA18370@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151700>

Share code from the non-dry-run case to ensure the output from
"commit --amend --dry-run" matches that from "commit --amend"
on attempts to amend away a commit.  The output had fallen
out of synch in v1.7.1.1~16^2 (2010-06-06).

The only change in output is some extra text to stderr.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/commit.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index febefee..9a4ea34 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1016,7 +1016,14 @@ static int dry_run_commit(int argc, const char **argv, const char *prefix,
 	const char *index_file;
 
 	index_file = prepare_index(argc, argv, prefix, 1);
-	commitable = run_status(stdout, index_file, prefix, 0, s);
+
+	/*
+	 * Give extra advice when faced with attempts to amend away a commit.
+	 */
+	if (!something_is_staged() && !empty_commit_ok(index_file, prefix, s))
+		commitable = 0;
+	else
+		commitable = run_status(stdout, index_file, prefix, 0, s);
 	rollback_index_files();
 
 	return commitable ? 0 : 1;
-- 
1.7.2.9.ge3789.dirty
