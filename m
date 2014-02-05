From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths
 scanning
Date: Wed, 5 Feb 2014 20:51:19 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140205165119.GA18558@tugrik.mns.mnsspb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
 <c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
 <xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com>
 <xmqqeh3jbwbt.fsf@gitster.dls.corp.google.com>
 <20140204163400.GA20436@tugrik.mns.mnsspb.ru>
 <xmqq4n4eafmj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 17:49:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB5fP-00047s-90
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 17:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbaBEQtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 11:49:35 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:59910 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508AbaBEQte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 11:49:34 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WB5fF-0003wB-86; Wed, 05 Feb 2014 20:49:29 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WB5h1-0004pp-Ri; Wed, 05 Feb 2014 20:51:19 +0400
Content-Disposition: inline
In-Reply-To: <xmqq4n4eafmj.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241605>

On Tue, Feb 04, 2014 at 10:37:24AM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> >> if we did not want to reinvent the whole tree walking thing, which
> >> would add risks for new bugs and burden to maintain this and the
> >> usual two-tree diff tree walking in sync.
> >
> > Junio, I understand it is not good to duplicate code and increase
> > maintenance risks....
> > Instead I propose we switch to the new tree walker completely.
> 
> I am not fundamentally opposed to the idea. We'll see what happens.

Thanks. Locally, with draft patches with generalized tree-walker, for
`git log --raw --no-abbrev --no-renames` I was able to get to as fast as
with old two-tree walker for navy.git and 1% faster for linux.git and
all tests pass.

Only, before I clean things up, I'd like to ask - would the following
patch be accepted

---- 8< ---
diff --git a/tree-walk.c b/tree-walk.c
index 79dba1d..4dc86c7 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -37,7 +37,7 @@ static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned
 
 	/* Initialize the descriptor entry */
 	desc->entry.path = path;
-	desc->entry.mode = mode;
+	desc->entry.mode = canon_mode(mode);
 	desc->entry.sha1 = (const unsigned char *)(path + len);
 }
 
diff --git a/tree-walk.h b/tree-walk.h
index ae04b64..ae7fb3a 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -16,7 +16,7 @@ struct tree_desc {
 static inline const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
 {
 	*pathp = desc->entry.path;
-	*modep = canon_mode(desc->entry.mode);
+	*modep = desc->entry.mode;
 	return desc->entry.sha1;
 }
---- 8< ---
 
?

The reason I ask is because it is more handy to work with tree_desc
structures, compared to splitting it to sha1/path/mode/pathlen, and
if canon_mode() is done only once, clients don't have to pay the
performance price of canon_mode on each tree_desc "extract".

I understand there is fsck, which on invalid tree entry prints the mode,
but maybe somehow fsck should be special, and common interface be tuned
to usual clients?

Thanks,
Kirill
