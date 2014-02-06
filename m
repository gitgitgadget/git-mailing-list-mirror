From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths
 scanning
Date: Thu, 6 Feb 2014 20:22:54 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140206162254.GA28889@tugrik.mns.mnsspb.ru>
References: <xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com>
 <xmqqeh3jbwbt.fsf@gitster.dls.corp.google.com>
 <20140204163400.GA20436@tugrik.mns.mnsspb.ru>
 <xmqq4n4eafmj.fsf@gitster.dls.corp.google.com>
 <20140205165119.GA18558@tugrik.mns.mnsspb.ru>
 <xmqqfvnx5umg.fsf@gitster.dls.corp.google.com>
 <20140205191427.GA3923@mini.zxlink>
 <xmqq61ot4a8e.fsf@gitster.dls.corp.google.com>
 <20140205202248.GB4695@mini.zxlink>
 <xmqqfvnx180z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 17:21:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBRhU-0001uv-G8
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 17:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355AbaBFQVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 11:21:10 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:35827 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597AbaBFQVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 11:21:09 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WBRhI-0002R3-CO; Thu, 06 Feb 2014 20:21:04 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WBRj4-0005YN-Bm; Thu, 06 Feb 2014 20:22:54 +0400
Content-Disposition: inline
In-Reply-To: <xmqqfvnx180z.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241703>

On Wed, Feb 05, 2014 at 02:58:36PM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
> 
> > On Wed, Feb 05, 2014 at 11:42:41AM -0800, Junio C Hamano wrote:
> >> Kirill Smelkov <kirr@navytux.spb.ru> writes:
> >> 
> >> > I agree object data should be immutable for good. The only thing I'm talking
> >> > about here is mode, which is parsed from a tree buffer and is stored in
> >> > separate field:
> >> 
> >> Ah, I do not see any problem in that case, then.
> >> 
> >> Thanks.
> >
> > Thanks, that simplifies things for me.

Below is a patch which does it. Please apply, if it is ok.


> Surely.
> 
> Be careful when traversing N-trees in parallel---you may have to
> watch out for the entry ordering rules that sorts the following
> paths in the order shown:
> 
> 	a
> 	a-b
>         a/b
>         a_b
> 
> Inside a single tree, you cannot have 'a' and 'a/b' at the same
> time, but one tree may have 'a' (without 'a/b') while another one
> may have 'a/b' (without 'a'), and walking them in parallel has
> historically been one source of funny bugs.

Thanks for the warning. I'm relying here on base_name_compare() and
ordering it imposes on entries and how it differentiates directories and
files, so let's hope this should be ok.

Actual reworking is still in flux though...

Thanks,
Kirill


---- 8< ----
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Thu, 6 Feb 2014 15:36:31 +0400
Subject: [PATCH] Finally switch over tree descriptors to contain a pre-parsed entry

This continues 4651ece8 (Switch over tree descriptors to contain a
pre-parsed entry) and moves the only rest computational part

    mode = canon_mode(mode)

from tree_entry_extract() to tree entry decode phase - to
decode_tree_entry().

The reason to do it, is that canon_mode() is at least 2 conditional
jumps for regular files, and that could be noticeable should canon_mode()
be invoked several times.

That does not matter for current Git codebase, where typical tree
traversal is

    while (t->size) {
        sha1 = tree_entry_extract(t, &path, &mode);
        ...
        update_tree_entry(t);
    }

i.e. we do t -> sha1,path.mode "extraction" only once per entry. In such
cases, it does not matter performance-wise, where that mode
canonicalization is done - either once in tree_entry_extract(), or once
in decode_tree_entry() called by update_tree_entry() - it is
approximately the same.

But for future code, which could need to work with several tree_desc's
in parallel, it could be handy to operate on tree_desc descriptors, and
do "extracts" only when needed, or at all, access only relevant part of
it through structure fields directly.

And for such situations, having canon_mode() be done once in decode
phase is better - we won't need to pay the performance price of 2 extra
conditional jumps on every t->mode access.

So let's move mode canonicalization to decode_tree_entry(). That was the
final bit. Now after tree entry is decoded, it is fully ready and could
be accessed either directly via field, or through tree_entry_extract()
which this time got really "totally trivial".

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 tree-walk.c | 2 +-
 tree-walk.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
 
-- 
1.9.rc1.181.g641f458
