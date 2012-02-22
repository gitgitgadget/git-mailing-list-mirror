From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv3 0/5] Re: tag: make list exclude !<pattern>
Date: Tue, 21 Feb 2012 17:28:45 -0800
Message-ID: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
References: <20120211190856.GB4903@tgrennan-laptop>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:29:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0111-000482-7j
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 02:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424Ab2BVB3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 20:29:01 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:56034 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab2BVB3A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 20:29:00 -0500
Received: by qafk1 with SMTP id k1so7771133qaf.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 17:29:00 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.229.135.83 as permitted sender) client-ip=10.229.135.83;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.229.135.83 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.229.135.83])
        by 10.229.135.83 with SMTP id m19mr15752232qct.43.1329874140070 (num_hops = 1);
        Tue, 21 Feb 2012 17:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uNAxMcG6DAWqpWOzenE+lQ42V7rVmkUTfPzhQOHbCrY=;
        b=cl0eiIyxQ5Pn9KyFNFMP+s3xXYA7mCQrmeG3Jd/pPLNqx1LRlaerLvyN7QqyUgRZG4
         kYEz/chQl2d0fellQ06/8H7AwWHFVMOG7zf9BTFg/fG2ZQS9lKuH22ng3NsjWKQGBGcr
         EF4VszK7ZBPO0EmArczW3+f02981OZIPQpK1I=
Received: by 10.229.135.83 with SMTP id m19mr13361941qct.43.1329874139995;
        Tue, 21 Feb 2012 17:28:59 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n8sm2148026qan.12.2012.02.21.17.28.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 17:28:59 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <20120211190856.GB4903@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191210>

It has taken me a while to get back to this; the following series rebase
and rework my proposed "!<pattern>" feature.  The first patch extracts
match_pattern() from builtin/tag.c and updates this to replace similar
functions in builtin/{branch,for-each-ref,ls-remote}.c

The second patch uses the OPT_CALLBACK wrapper on the recently added
"--points-at" option of git-tag.  I should have implemented it this way
to begin with but I missed Jeff King's suggestion within that thread.

The remaining patches add "--exclude <pattern>" options (vs.
"!<pattern>") to: git-tag, git-branch, and git-for-each-ref.

For example,
  $ git tag -l --exclude "*-rc?" "v1.7.8*"
  $ git branch -r --exclude \*HEAD
  $ git for-each-ref --format="%(refname)" --exclude "*HEAD"
	refs/remotes/origin

Instead of,
  $ git tag -l "!*-rc?" "v1.7.8*"
  $ git branch -r "!*HEAD"
  $ git for-each-ref --format="%(refname)" "!*HEAD" refs/remotes/origin

Note that I haven't yet added an "--exclude" feature to git-ls-remote
because I think that I should first update its option parsing.

Thanks,
Tom Grennan (5):
  refs: add match_pattern()
  tag --points-at option wrapper
  tag --exclude option
  branch --exclude option
  for-each-ref --exclude option

 Documentation/git-branch.txt       |    7 ++++-
 Documentation/git-for-each-ref.txt |    7 ++++-
 Documentation/git-tag.txt          |    6 +++-
 builtin/branch.c                   |   30 ++++++++-----------
 builtin/for-each-ref.c             |   27 +++++------------
 builtin/ls-remote.c                |   12 ++------
 builtin/tag.c                      |   35 ++++++++++------------
 refs.c                             |   36 +++++++++++++++++++++++
 refs.h                             |   12 ++++++++
 t/t3200-branch.sh                  |   23 +++++++++++++++
 t/t6300-for-each-ref.sh            |   11 +++++++
 t/t7004-tag.sh                     |   56 ++++++++++++++++++++++++++++++++++++
 12 files changed, 195 insertions(+), 67 deletions(-)

-- 
1.7.8
