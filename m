From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 2/2] tests: scrub environment of GIT_* variables
Date: Tue, 15 Mar 2011 05:10:45 -0500
Message-ID: <20110315101045.GD3923@elie>
References: <20110315064909.GA25738@elie>
 <20110315070445.GC29530@elie>
 <20110315073718.GB11754@sigill.intra.peff.net>
 <20110315100846.GB3923@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 11:10:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzRDL-0006FM-24
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 11:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162Ab1COKKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 06:10:50 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55511 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab1COKKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 06:10:49 -0400
Received: by ywj3 with SMTP id 3so164540ywj.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Kiz3gK3m1WEq9ai91r0MQVW+QmzzA1VMOiGmGOg12OE=;
        b=JQm3RL9qeq+Zrtw6EbCY1xQ77eifkN0jfTP+V7zUSG+pAGCfQFesZPqHZWoLDxpFd8
         7OhmrJBB2ae1FvVZ4eWEVhgOltG4ITvxHs5x9uq/ZZUK+cFJtk2fDfK8uEJTTTmo2XWq
         KZj8U8BPC7dYUNfqPIIA1nijf3OCTx034NtkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IO3PIrOmm/dB8M2ryKnF3RCQCxhr+nhFVqSPSrr6ueUHNMmyIiqwh43VZAl2XrOZcl
         toLfIq9ZsbfHldvRFrjGnOZGbZu1NT9K04Jj2c9f8oqWLxgE6gaSDA3S6KPTi8jPj7Y5
         6juT8FBWG8G1+OqQOCjqlPr3SPuvTF/gO9uwA=
Received: by 10.236.131.170 with SMTP id m30mr2020332yhi.116.1300183849231;
        Tue, 15 Mar 2011 03:10:49 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id k29sm89588yhk.14.2011.03.15.03.10.47
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 03:10:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315100846.GB3923@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169059>

Variables from the inherited environment that are meaningful to git
can break tests in undesirable ways.  For example,

	GIT_PAGER=more sh t5400-send-pack.sh -v -i

hangs.  So unset all environment variables in the GIT_ namespace in
test-lib, with a few exceptions:

- GIT_TRACE* are useful for tracking down bugs exhibited by a failing
  test;

- GIT_DEBUG* are GIT_TRACE variables by another name, practically
  speaking.  They should probably be tweaked to follow the
  GIT_TRACE_foo scheme and use trace_printf machinery some time.

- GIT_USE_LOOKUP from v1.5.6-rc0~134^2~1 (sha1-lookup: more memory
  efficient search in sorted list of SHA-1, 2007-12-29) is about
  trying an alternate implementation strategy rather than changing
  semantics and it can be useful to compare performance with and
  without it set.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks again.

 t/test-lib.sh |   23 +++++------------------
 1 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8893406..8aac727 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -43,29 +43,16 @@ TERM=dumb
 export LANG LC_ALL PAGER TERM TZ
 EDITOR=:
 unset VISUAL
-unset GIT_EDITOR
 unset EMAIL
-unset GIT_ALTERNATE_OBJECT_DIRECTORIES
-unset GIT_AUTHOR_DATE
+unset $(perl -e '
+	my @env = keys %ENV;
+	my @vars = grep(/^GIT_/ && !/^GIT_(TRACE|DEBUG|USE_LOOKUP)/, @env);
+	print join("\n", @vars);
+')
 GIT_AUTHOR_EMAIL=author@example.com
 GIT_AUTHOR_NAME='A U Thor'
-unset GIT_COMMITTER_DATE
 GIT_COMMITTER_EMAIL=committer@example.com
 GIT_COMMITTER_NAME='C O Mitter'
-unset GIT_DIFF_OPTS
-unset GIT_DIR
-unset GIT_WORK_TREE
-unset GIT_EXTERNAL_DIFF
-unset GIT_INDEX_FILE
-unset GIT_OBJECT_DIRECTORY
-unset GIT_CEILING_DIRECTORIES
-unset GIT_NOTES_REF
-unset GIT_NOTES_DISPLAY_REF
-unset GIT_NOTES_REWRITE_REF
-unset GIT_NOTES_REWRITE_MODE
-unset GIT_REFLOG_ACTION
-unset GIT_CHERRY_PICK_HELP
-unset GIT_QUIET
 GIT_MERGE_VERBOSITY=5
 export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
-- 
1.7.4.1
