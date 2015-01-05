From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv0 2/4] fast-import.c:do_change_note_fanout(): Also apply load_tree() to initial root
Date: Mon,  5 Jan 2015 04:39:36 +0100
Message-ID: <1420429178-20336-2-git-send-email-johan@herland.net>
References: <CALKQrgdVp7cLER2DQxwdFT82Y=Pamrx6=oa3bY=X7mWy_r3QWA@mail.gmail.com>
 <1420429178-20336-1-git-send-email-johan@herland.net>
Cc: Git mailing list <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jan 05 04:40:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7yWm-0002VE-KT
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 04:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbbAEDkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 22:40:07 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:53614 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbbAEDkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 22:40:04 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so17230702lbv.0
        for <git@vger.kernel.org>; Sun, 04 Jan 2015 19:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+kMR/VNgG3dConaE1jSDEbBaYfGMWgchUhU4+5cePyQ=;
        b=LIg+++JzfUr5BpswA0wUbgOCnbqiOUqbsKEWIdDoqKVjKbaSksdiZPfWE9X1noCTGA
         9vRbKsYhd32MLQFD9dHeBLwJ5wKqrCePiOo/trSFcgd8Uz7CJ268jba1a1aWYHLN/4Bw
         72fdvBlV8dA30293/C9uBoNFq2vVP9g853TMh0XvAgKHFYyj8YKNgLUODj46NpRA+03D
         +TD3pOsMh+Th6bYnaUmquhOiJN0jDxgN5nonmYIBgWjFwmMShVAIowX19p4URtvRJows
         Pj9Ujl2a+IgcfjxlwAJ7xJAl+J1N4xRdRkeSSXai31nvJ0eMkPxX33hIIzseIB+O0S57
         nEXA==
X-Received: by 10.153.5.1 with SMTP id ci1mr82828495lad.67.1420429203114;
        Sun, 04 Jan 2015 19:40:03 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id ya4sm4239978lbb.32.2015.01.04.19.40.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Jan 2015 19:40:01 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <1420429178-20336-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262013>

TODO: tests!

do_change_note_fanout() recursively traverses a "struct tree_entry" data
structure. Before recursively traversing into a subtree, we make sure to
call load_tree() on that subtree. However, for the initial/root struct
tree_entry object, we assumed that load_tree() had already been invoked by
our caller. This is true, except in the following case:

If we load a previously written notes tree using 'filemodify' instead of
'from' [1], then we do not pass the notes ref to load_branch() (which
takes care of calling load_tree() on the root tree_entry).

When load_tree(root) has not been called before the first 'notemodify'
command is parsed, the for loop in do_change_note_fanout() does nothing,
and we end up not counting the existing notes, which ends up producing
a notes tree with mixed/insufficient fanout.

Fix this by always making sure to call load_tree() at the start of
do_change_note_fanout(). Since load_tree() is now called before the for loop,
we no longer need to call load_tree() on a subtree before recursing into it,
the recursive call will take care of its own load_tree().

[1]: Usually, when adding notes to an existing notes tree, one would use a
     'from' command like this:

         from refs/notes/foo^0

     However, if one does not want to retain notes history (i.e. one wants
     the current refs/notes/foo commit to be build without any parents),
     then one can replace the 'from' command with the following 'filemodify'
     "hack" to pre-load the existing notes tree without using it as a parent:

         M 040000 refs/notes/foo^{tree} \n

Discovered-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Johan Herland <johan@herland.net>
---
 fast-import.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 04dfd50..aa7b64e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2159,6 +2159,9 @@ static uintmax_t do_change_note_fanout(
 	unsigned char sha1[20];
 	char realpath[60];
 
+	if (!root->tree)
+		load_tree(root);
+
 	for (i = 0; root->tree && i < root->tree->entry_count; i++) {
 		e = root->tree->entries[i];
 		tmp_hex_sha1_len = hex_sha1_len + e->name->str_len;
@@ -2210,8 +2213,6 @@ static uintmax_t do_change_note_fanout(
 				leaf.tree);
 		} else if (S_ISDIR(e->versions[1].mode)) {
 			/* This is a subdir that may contain note entries */
-			if (!e->tree)
-				load_tree(e);
 			num_notes += do_change_note_fanout(orig_root, e,
 				hex_sha1, tmp_hex_sha1_len,
 				fullpath, tmp_fullpath_len, fanout);
-- 
2.1.1.392.g062cc5d
