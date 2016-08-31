Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC641F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933777AbcHaIzD (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:60663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933545AbcHaIyx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:54:53 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MRXzM-1bYVyR0mqG-00ScmO; Wed, 31 Aug 2016 10:54:47
 +0200
Date:   Wed, 31 Aug 2016 10:54:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/34] sequencer (rebase -i): implement the short commands
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <41ccb12044cd26fa8aa919b537cd396b983f4e31.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CLYoKAwg3mO18lQPZP8zmFIBC5AuKE2a+/ba/NQsgORtBZNi+5L
 xBxaITzxAeByymmgXKI0m3SIhvRIYDx8VNaV2uE03dN1HegT14XU7zSNAeLAJCEO5aGH7lR
 TV106X8jEz5SKTztpjhacMuOT7B1yFhQDYI4vu6d7Dpb2VMMS/gvLy53nI4CbA/dKoxDmAW
 YeDsdNWLASkqX2Dkwo6og==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rkFm+K/kYik=:Dh1UhN+9BYwWqrm0eAFibk
 OVh2B7PF7IHMaU84mu1ftYLRkt7Tbk5/y4ps8eCfyaXzJwJ5EhIcq53/t2lLNSldVmlD/Hoox
 bVsUgzY2LTvL69vgzhlLDxpVFriYIPb0NM9yO+/NGMMRor9FtD6+1fqpHn6nlR7btE+PvqI0k
 mf8bNg9MBYiybOXIQKu0UNvDo4pvQGqN8Fr2A9E9jbnp2pbbg7R88MlDqBbXEH1RTD1Mm1AvS
 EDvjhm60PQJtWtCKBUf0z0eixhKsqegDLgOWG58BB3Uto+8IP3otol/aZ9oITe72gMzMipoG5
 XGsmjfx3kYxjgT7F3S3FfP5M86ZDBgfGpqADX2a+PjRdNMqIhmVDGAAnze20WFoSNxhckS2qs
 V+UWI6n3U+nDm3ly8dL6TtYL3T8gr2Io3CISWgc3BdT/JRbpusVHCfnP1Xb4REQLlYtHm5pZ9
 OR/xWGookniGJC6cOg9/mJEgWoZe2oy89zLdb9QE/ObQMdJNUBCA5FOUaFso+lWKhW2gWZC0C
 nY7ONvWdWb/HLVcajC+gNUuF3cwd38X9O9jfqOEbRvftj6Gri/jfGq7A3na8wCEzFWJ7LcUTJ
 9hwzwbBk9YkaFpwDCXYsUTdcz3ivzoezKNBh8mOFoBQnfP7NqXpNLABy7HptRJrH1SwtZI7vW
 H3Xu5F+nwyTQpOfg8OIWAlQntWS8OucSlov6GF/NxqeAgALIsXvrL7895o+BlneFiL9WM+pE5
 XbG4/9ZSaEl9qoZo/rpWLLlJy3ofZgiAWrqD702l3NkRSwIDLk0ULNBpzxNQV4QhqjwmB7A7w
 Sdqsckk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For users' convenience, most rebase commands can be abbreviated, e.g.
'p' instead of 'pick' and 'x' instead of 'exec'. Let's teach the
sequencer to handle those abbreviated commands just fine.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3ae5978..919698b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -705,20 +705,23 @@ enum todo_command {
 	TODO_NOOP
 };
 
-static const char *todo_command_strings[] = {
-	"pick",
-	"revert",
-	"edit",
-	"fixup",
-	"squash",
-	"exec",
-	"noop"
+static struct {
+	char c;
+	const char *str;
+} todo_command_info[] = {
+	{ 'p', "pick" },
+	{ 0,   "revert" },
+	{ 'e', "edit" },
+	{ 'f', "fixup" },
+	{ 's', "squash" },
+	{ 'x', "exec" },
+	{ 0,   "noop" }
 };
 
 static const char *command_to_string(const enum todo_command command)
 {
-	if (command < ARRAY_SIZE(todo_command_strings))
-		return todo_command_strings[command];
+	if (command < ARRAY_SIZE(todo_command_info))
+		return todo_command_info[command].str;
 	die("Unknown command: %d", command);
 }
 
@@ -1126,12 +1129,17 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return 0;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
-		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
+	for (i = 0; i < ARRAY_SIZE(todo_command_info); i++)
+		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
 			item->command = i;
 			break;
 		}
-	if (i >= ARRAY_SIZE(todo_command_strings))
+		else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
+			bol++;
+			item->command = i;
+			break;
+		}
+	if (i >= ARRAY_SIZE(todo_command_info))
 		return -1;
 
 	if (item->command == TODO_NOOP) {
-- 
2.10.0.rc2.102.g5c102ec


