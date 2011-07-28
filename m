From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: long fast-import errors out "failed to apply delta"
Date: Thu, 28 Jul 2011 11:56:34 +0200
Message-ID: <20110728095634.GA6991@elie>
References: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
 <CA+gfSn8C-nB2hSSRTqSu1N1Z-b8ctRsVmUGAjLXTW0du_W3EQw@mail.gmail.com>
 <CA+gfSn8m=_vd91Xe5EnFXUvZnuJf-yUE6H7FU+ak8S8a+NtCjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 11:57:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmNKr-0007p8-GY
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 11:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab1G1J4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 05:56:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44700 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab1G1J4v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 05:56:51 -0400
Received: by fxh19 with SMTP id 19so1112175fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6vdDS3sfP6tCxnUjWedwTXP/3Db7mAfj3aTgCPLA0vY=;
        b=uUouvolJHFAPjSoXTyuxm9vySxhBkRnsAdS/WnENtZxytkhCLR8EfGteigCcGOmrgP
         lccK+2lDBf8WnY49MnGx5J7thmTekzQ4YjHb2/U+DSCdWaafDYSVYaNYjxaLPj6f5P5j
         1+/FbxWmTtMuszrdtaq+VDpPR1eWIueGGF42s=
Received: by 10.223.41.156 with SMTP id o28mr1131716fae.11.1311847010218;
        Thu, 28 Jul 2011 02:56:50 -0700 (PDT)
Received: from elie (adsl-165-140-99.teol.net [109.165.140.99])
        by mx.google.com with ESMTPS id d6sm377580fak.10.2011.07.28.02.56.48
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 02:56:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+gfSn8m=_vd91Xe5EnFXUvZnuJf-yUE6H7FU+ak8S8a+NtCjA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178053>

Dmitry Ivankov wrote:

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1514,6 +1514,9 @@ static int tree_content_set(
>                                 if (e->tree)
>                                         release_tree_content_recursive(e->tree);
>                                 e->tree = subtree;
> +                               if (S_ISDIR(mode)) {
> +                                       hashclr(e->versions[0].sha1);
> +                               }
>                                 hashclr(root->versions[1].sha1);
>                                 return 1;
>                         }

Based on your later explanations, it looks like this hit the nail on
the head.  The idea is that normally e->tree includes entries for both
e->versions[0] and e->versions[1] and that in the "M 040000 ..." case,
this codepath at least currently doesn't have enough information to
decide on a good delta base.

Just doing a "hashclr(e->versions[0].sha1)" will change the preimage
tree object for the parent directory, causing invalid deltas _there_.
So that's not quite right.

Possible fixes:

 a. invalidate preimage tree names all the way up the hierarchy.
    This is what I misread the code as doing at first.  It would
    be a cop-out; I think we can do better.

 b. merge the preimage and postimage trees in e->tree, and use
    the existing preimage tree as delta basis.  This would produce
    an unnecessarily large delta, but it should work.

 c. add a bit to "struct tree_content" (or abuse delta_depth) to
    say "my parent entry's versions[0].sha1 has nothing to do with
    me; please do not write me out as a delta against it"

 d. invalidate preimage tree object names up the hierarchy, and allow
    tree_content_set callers to pass a "const struct tree_entry_ms *"
    argument indicating a preimage tree object name for the new
    subtree.

 e. instead of replacing a tree entry, delete it and add it again as a
    new tree entry.  Make sure internal APIs can deal with multiple
    tree entries with the same name.

I find (c) tempting.  Like this, vaguely.  What do you think?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c |   35 ++++++++++++++++++++++++++++++-----
 1 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 9e8d1868..2880af7b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -170,6 +170,11 @@ Format of STDIN stream:
 #define DEPTH_BITS 13
 #define MAX_DEPTH ((1<<DEPTH_BITS)-1)
 
+/*
+ * We abuse the setuid bit on directories to mean "do not delta".
+ */
+#define NO_DELTA S_ISUID
+
 struct object_entry {
 	struct pack_idx_entry idx;
 	struct object_entry *next;
@@ -1415,8 +1420,9 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 		struct tree_entry *e = t->entries[i];
 		if (!e->versions[v].mode)
 			continue;
-		strbuf_addf(b, "%o %s%c", (unsigned int)e->versions[v].mode,
-					e->name->str_dat, '\0');
+		strbuf_addf(b, "%o %s%c",
+			(unsigned int)(e->versions[v].mode & ~NO_DELTA),
+			e->name->str_dat, '\0');
 		strbuf_add(b, e->versions[v].sha1, 20);
 	}
 }
@@ -1426,7 +1432,7 @@ static void store_tree(struct tree_entry *root)
 	struct tree_content *t = root->tree;
 	unsigned int i, j, del;
 	struct last_object lo = { STRBUF_INIT, 0, 0, /* no_swap */ 1 };
-	struct object_entry *le;
+	struct object_entry *le = NULL;
 
 	if (!is_null_sha1(root->versions[1].sha1))
 		return;
@@ -1436,7 +1442,8 @@ static void store_tree(struct tree_entry *root)
 			store_tree(t->entries[i]);
 	}
 
-	le = find_object(root->versions[0].sha1);
+	if (!(root->versions[0].mode & NO_DELTA))
+		le = find_object(root->versions[0].sha1);
 	if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
 		mktree(t, 0, &old_tree);
 		lo.data = old_tree;
@@ -1470,6 +1477,7 @@ static void tree_content_replace(
 {
 	if (!S_ISDIR(mode))
 		die("Root cannot be a non-directory");
+	hashclr(root->versions[0].sha1);
 	hashcpy(root->versions[1].sha1, sha1);
 	if (root->tree)
 		release_tree_content_recursive(root->tree);
@@ -1514,6 +1522,23 @@ static int tree_content_set(
 				if (e->tree)
 					release_tree_content_recursive(e->tree);
 				e->tree = subtree;
+
+				/*
+				 * We need to leave e->versions[0].sha1 alone
+				 * to avoid modifying the preimage tree used
+				 * when writing out the parent directory.
+				 * But after replacing the subdir with a
+				 * completely different one, it's not a good
+				 * delta base any more, and besides, we've
+				 * thrown away the tree entries needed to
+				 * make a delta against it.
+				 *
+				 * So let's just explicitly disable deltas
+				 * for the subtree.
+				 */
+				if (S_ISDIR(e->versions[0].mode))
+					e->versions[0].mode |= NO_DELTA;
+
 				hashclr(root->versions[1].sha1);
 				return 1;
 			}
@@ -2928,7 +2953,7 @@ static void print_ls(int mode, const unsigned char *sha1, const char *path)
 		/* mode SP type SP object_name TAB path LF */
 		strbuf_reset(&line);
 		strbuf_addf(&line, "%06o %s %s\t",
-				mode, type, sha1_to_hex(sha1));
+				mode & ~NO_DELTA, type, sha1_to_hex(sha1));
 		quote_c_style(path, &line, NULL, 0);
 		strbuf_addch(&line, '\n');
 	}
-- 
1.7.6
