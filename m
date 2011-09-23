From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] diff_index: honor in-index, not working-tree, .gitattributes
Date: Fri, 23 Sep 2011 01:37:13 -0400
Message-ID: <CAG+J_Dyh=t2VAZ6rAqcF2meEgBCN5c+J_m_YvVQbKfvXeJ8WGA@mail.gmail.com>
References: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com>
	<1316727861-90460-2-git-send-email-jaysoffian@gmail.com>
	<7v8vpgxkvb.fsf@alter.siamese.dyndns.org>
	<CAG+J_DzUQ3OGfiX=vHVGC7SHvwToVjD7uwFyDa8Tq6t7YwX12Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 07:37:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6yS1-0001dk-Ri
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 07:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab1IWFhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 01:37:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53605 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab1IWFhO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 01:37:14 -0400
Received: by gwb15 with SMTP id 15so3502636gwb.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 22:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=S8iSDekYkWSl2KwGT/svKCgTwog9XM4Okt+aHK0YoJg=;
        b=h8AsWUACPyBy6crbN+fBbT7RXHet9OxXri9tajgaeVJBVV5LFHXMOMu87FMH1mmeZa
         yeMdVnv9O0EYu3L3+8k1TG0I0XTLTGRCxjwHmTcHBxER93to+4p++XUyQX3100TwG4wJ
         O7Jkmwc7tnox5+by+q8udPaGpbtDf2V/dTTzU=
Received: by 10.236.155.1 with SMTP id i1mr33917yhk.8.1316756233880; Thu, 22
 Sep 2011 22:37:13 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Thu, 22 Sep 2011 22:37:13 -0700 (PDT)
In-Reply-To: <CAG+J_DzUQ3OGfiX=vHVGC7SHvwToVjD7uwFyDa8Tq6t7YwX12Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181944>

On Thu, Sep 22, 2011 at 8:38 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Thu, Sep 22, 2011 at 6:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I think the logical conclusion of assuming that we will keep the "single
>> source only" semantics (which I think we will, by the way, unless I hear a
>> concrete proposal to how we apply attributes from more than one sources in
>> what way to which side of the diff) is that a patch might be an
>> improvement over the current behaviour if it teaches "diff-tree" to read
>> from the tree and populate the in-core index (never writing it out to
>> $GIT_DIR/index) from the postimage tree (i.e. "diff preimage postimage" or
>> "diff -R postimage preimage") when it is run in a bare repository.
>
> Okay, I can give that a try.

This area of git is still black magic to me. My best guess is
something like this:

diff --git a/tree-diff.c b/tree-diff.c
index b3cc2e4753..6fd84eb2bb 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -5,6 +5,8 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
+#include "attr.h"
+#include "unpack-trees.h"

 static void show_entry(struct diff_options *opt, const char *prefix,
 		       struct tree_desc *desc, struct strbuf *base);
@@ -280,6 +282,19 @@ int diff_tree_sha1(const unsigned char *old,
const unsigned char *new, const cha
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
 	init_tree_desc(&t1, tree1, size1);
 	init_tree_desc(&t2, tree2, size2);
+
+	if (is_bare_repository()) {
+		struct unpack_trees_options unpack_opts;
+		memset(&unpack_opts, 0, sizeof(unpack_opts));
+		unpack_opts.index_only = 1;
+		unpack_opts.head_idx = -1;
+		unpack_opts.src_index = &the_index;
+		unpack_opts.dst_index = &the_index;
+		unpack_opts.fn = oneway_merge;
+		if (unpack_trees(1, DIFF_OPT_TST(opt, REVERSE_DIFF) ? &t1 : &t2,
&unpack_opts) == 0)
+			git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
+	}
+
 	retval = diff_tree(&t1, &t2, base, opt);
 	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename()) {
 		init_tree_desc(&t1, tree1, size1);

(And in case gmail line wraps that -- https://gist.github.com/1236806)

Am I barking up the right tree? (Obviously still needs tests, and
maybe an --[no]-tree-attributes option.)

j.
