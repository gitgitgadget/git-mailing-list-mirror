From: Dragos Foianu <dragos.foianu@gmail.com>
Subject: [PATCH] describe: rewrite name_rev() iteratively
Date: Mon,  7 Apr 2014 01:47:14 +0300
Message-ID: <1396824434-31672-1-git-send-email-dragos.foianu@gmail.com>
Cc: Dragos Foianu <dragos.foianu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 00:47:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWvqr-0004qn-Le
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 00:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbaDFWrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 18:47:42 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37469 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbaDFWrk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2014 18:47:40 -0400
Received: by mail-wi0-f175.google.com with SMTP id cc10so4109802wib.8
        for <git@vger.kernel.org>; Sun, 06 Apr 2014 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5KbKqNrNpJN3QLLhatT4d5V5uD03oy31z8zX+wG3CxU=;
        b=Mq36ONjA8TT3jXhK4qZbx5xEvNxSr3UqQkLpzCO4YCaTocBxbOQxVRwrbSJz82PSzm
         GNp5cQTxPAN6pXm5Q2u+kg0vGGBG4FJ1fR+AP2ZqqX00pGAPnv3rifska6059Cw7A2+/
         3kXWzAi4hPmfXj+5rtnq3eOe5+36PyN+Hy3ON/sRv6aGB7HxgNfAKeWfTli/lcsp6vg5
         xQDkEZvBld9bALgwF/JGg4syGXMsFHS1QdZXd7njR7n7laXSe4GeRMhVAXV0Yan1Yc+T
         QdkOKSlhUJYMKG4B+OqQM9q+E7io4YL0nMkZ8WGzkaOgFZnS7BOUc6ZKLlLHEN2A1YfA
         6OQQ==
X-Received: by 10.194.173.193 with SMTP id bm1mr37837774wjc.55.1396824459486;
        Sun, 06 Apr 2014 15:47:39 -0700 (PDT)
Received: from aiur.aiur ([109.100.225.15])
        by mx.google.com with ESMTPSA id e42sm37576289eev.32.2014.04.06.15.47.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Apr 2014 15:47:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245799>

The "git describe --contains" command uses the name_rev() function which
is currently a recursive function. This causes a Stack Overflow when the
history is large enough.

Rewrite name_rev iteratively using a stack on the heap. This slightly
reduces performance due to the extra operations on the heap, but the
function no longer overflows the stack.

Reported-by: Sylvestre Ledru <sylvestre@mozilla.com>
Signed-off-by: Dragos Foianu <dragos.foianu@gmail.com>
---
 builtin/name-rev.c |  176 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 128 insertions(+), 48 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c824d4e..5848d81 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -19,66 +19,146 @@ static long cutoff = LONG_MAX;
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
+typedef struct rev_data {
+	struct commit *commit;
+	const char *tip_name;
+	int generation;
+	int distance;
+	int deref;
+} *rev_data;
+
+typedef struct rev_stack {
+	struct rev_data *rev;
+	struct rev_stack *next;
+} *rev_stack;
+
+static void stack_push(rev_stack *stack, rev_data data) {
+	rev_stack new_node = xmalloc(sizeof(*new_node));
+
+	new_node->rev = data;
+	new_node->next = *stack;
+	*stack = new_node;
+}
+
+static void stack_push_end(rev_stack *stack, rev_data data) {
+	rev_stack new_node = xmalloc(sizeof(*new_node));
+
+	while (*stack != NULL)
+		stack = &(*stack)->next;
+	new_node->rev = data;
+	new_node->next = *stack;
+	*stack = new_node;
+}
+
+static rev_data stack_pop(rev_stack *stack) {
+	rev_stack next = (*stack)->next;
+	rev_data rev = (*stack)->rev;
+	free(*stack);
+
+	*stack = next;
+	return rev;
+}
+
+static rev_data make_rev_data(struct commit *commit,
+		const char* tip_name, int generation, int distance,
+		int deref)
+{
+	rev_data data = xmalloc(sizeof(*data));
+
+	data->commit = commit;
+	data->tip_name = tip_name;
+	data->generation = generation;
+	data->distance = distance;
+	data->deref = deref;
+
+	return data;
+}
+
 static void name_rev(struct commit *commit,
 		const char *tip_name, int generation, int distance,
 		int deref)
 {
-	struct rev_name *name = (struct rev_name *)commit->util;
-	struct commit_list *parents;
-	int parent_number = 1;
+	rev_stack stack = NULL;
+	rev_data data, next_rev;
 
-	parse_commit(commit);
+	data = make_rev_data(commit, tip_name, generation, distance, deref);
+	stack_push(&stack, data);
 
-	if (commit->date < cutoff)
-		return;
+	while (stack != NULL) {
+		rev_data rev = stack_pop(&stack);
 
-	if (deref) {
-		char *new_name = xmalloc(strlen(tip_name)+3);
-		strcpy(new_name, tip_name);
-		strcat(new_name, "^0");
-		tip_name = new_name;
+		struct rev_name *name = (struct rev_name *) rev->commit->util;
+		struct commit_list *parents;
+		int parent_number = 1;
 
-		if (generation)
-			die("generation: %d, but deref?", generation);
-	}
+		parse_commit(rev->commit);
+
+		if (rev->commit->date < cutoff)
+			continue;
+
+		if (rev->deref) {
+			char *new_name = xmalloc(strlen(rev->tip_name) + 3);
+			strcpy(new_name, rev->tip_name);
+			strcat(new_name, "^0");
+			rev->tip_name = new_name;
 
-	if (name == NULL) {
-		name = xmalloc(sizeof(rev_name));
-		commit->util = name;
-		goto copy_data;
-	} else if (name->distance > distance) {
+			if (rev->generation)
+				die("generation: %d, but deref?",
+					rev->generation);
+		}
+
+		if (name == NULL) {
+			name = xmalloc(sizeof(rev_name));
+			rev->commit->util = name;
+			goto copy_data;
+		} else if (name->distance > rev->distance) {
 copy_data:
-		name->tip_name = tip_name;
-		name->generation = generation;
-		name->distance = distance;
-	} else
-		return;
-
-	for (parents = commit->parents;
-			parents;
-			parents = parents->next, parent_number++) {
-		if (parent_number > 1) {
-			int len = strlen(tip_name);
-			char *new_name = xmalloc(len +
-				1 + decimal_length(generation) +  /* ~<n> */
-				1 + 2 +				  /* ^NN */
-				1);
-
-			if (len > 2 && !strcmp(tip_name + len - 2, "^0"))
-				len -= 2;
-			if (generation > 0)
-				sprintf(new_name, "%.*s~%d^%d", len, tip_name,
-						generation, parent_number);
-			else
-				sprintf(new_name, "%.*s^%d", len, tip_name,
-						parent_number);
+			name->tip_name = rev->tip_name;
+			name->generation = rev->generation;
+			name->distance = rev->distance;
+		} else
+			continue;
 
-			name_rev(parents->item, new_name, 0,
-				distance + MERGE_TRAVERSAL_WEIGHT, 0);
-		} else {
-			name_rev(parents->item, tip_name, generation + 1,
-				distance + 1, 0);
+		for (parents = rev->commit->parents;
+				parents;
+				parents = parents->next, parent_number++) {
+			if (parent_number > 1) {
+				int len = strlen(rev->tip_name);
+				char *new_name = xmalloc(len +
+					/* ~<n> */
+					1 + decimal_length(rev->generation) +
+					/* ^NN */
+					1 + 2 +
+					1);
+
+				if (len > 2 &&
+					!strcmp(rev->tip_name + len - 2, "^0"))
+					len -= 2;
+
+				if (rev->generation > 0)
+					sprintf(new_name, "%.*s~%d^%d", len,
+						rev->tip_name, rev->generation,
+						parent_number);
+				else
+					sprintf(new_name, "%.*s^%d", len,
+						rev->tip_name, parent_number);
+
+				next_rev = make_rev_data(parents->item,
+					new_name, 0,
+					rev->distance + MERGE_TRAVERSAL_WEIGHT,
+					0);
+
+				stack_push_end(&stack, next_rev);
+			} else {
+				next_rev = make_rev_data(parents->item,
+					rev->tip_name, rev->generation + 1,
+					rev->distance + 1, 0);
+
+				stack_push(&stack, next_rev);
+			}
 		}
+
+		free(rev);
 	}
 }
 
-- 
1.7.10.4
