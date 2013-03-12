From: John Keeping <john@keeping.me.uk>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 19:09:56 +0000
Message-ID: <20130312190956.GC2317@serenity.lan>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
 <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
 <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 20:10:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFUaq-0001pZ-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 20:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680Ab3CLTKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 15:10:07 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:47266 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933070Ab3CLTKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 15:10:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 42F87606531;
	Tue, 12 Mar 2013 19:10:05 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pmnMI+vWu41t; Tue, 12 Mar 2013 19:10:04 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 085666064E1;
	Tue, 12 Mar 2013 19:09:58 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217981>

On Tue, Mar 12, 2013 at 02:12:29PM -0400, Matt McClure wrote:
> On Tue, Nov 27, 2012 at 7:41 AM, Matt McClure <matthewlmcclure@gmail.com> wrote:
> Your thoughts on the change?

Please include the patch in your message so that interested parties can
comment on it here, especially since the compare view on GitHub seems to
mangle the tabs.

For others' reference the patch is:

-- >8 --
From: Matt McClure <matt.mcclure@mapmyfitness.com>
Subject: [PATCH] difftool: Make directory diff symlink work tree

difftool -d formerly knew how to symlink to the work tree when the work
tree contains uncommitted changes. In practice, prior to this change, it
would not symlink to the work tree in case there were no uncommitted
changes, even when the user invoked difftool with the form:

    git difftool -d [--options] <commit> [--] [<path>...]
        This form is to view the changes you have in your working tree
        relative to the named <commit>. You can use HEAD to compare it
        with the latest commit, or a branch name to compare with the tip
        of a different branch.

Instead, prior to this change, difftool would use the file's HEAD blob
sha1 to find its content rather than the work tree content. This change
teaches `git diff --raw` to emit the null SHA1 for consumption by
difftool -d, so that difftool -d will use a symlink rather than a copy
of the file.

Before:

    $ git diff --raw HEAD^ -- diff-lib.c
    :100644 100644 f35de0f... ead9399... M  diff-lib.c

After:

    $ ./git diff --raw HEAD^ -- diff-lib.c
    :100644 100644 f35de0f... 0000000... M  diff-lib.c
---
 diff-lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index f35de0f..ead9399 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -319,6 +319,10 @@ static int show_modified(struct rev_info *revs,
 		return -1;
 	}
 
+	if (!cached && hashcmp(old->sha1, new->sha1)) {
+		sha1 = null_sha1;
+	}
+
 	if (revs->combine_merges && !cached &&
 	    (hashcmp(sha1, old->sha1) || hashcmp(old->sha1, new->sha1))) {
 		struct combine_diff_path *p;
-- 
1.8.2.rc2.4.g7799588
