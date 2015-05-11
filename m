From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/18] entry_matches(): inline function
Date: Mon, 11 May 2015 17:25:07 +0200
Message-ID: <1431357920-25090-6-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:25:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrpaV-0002S7-3r
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbbEKPZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:25:40 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61958 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138AbbEKPZi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:38 -0400
X-AuditID: 1207440e-f79bc6d000000c43-73-5550c9f12576
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id FC.55.03139.1F9C0555; Mon, 11 May 2015 11:25:37 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnH002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:36 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqPvxZECoQfc0Y4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd0bHvLdsBTO5K17/a2dtYPzO0cXIySEhYCKxYVUrI4QtJnHh3nq2LkYu
	DiGBy4wSnze2skM4x5kkzpw/zApSxSagK7Gop5kJxBYRUJOY2HaIBaSIWWAXo8S9pVNZQBLC
	AlYS7Rs2gdksAqoSu/ZvYwexeQVcJBa/uAa1Tk7i/PGfzCA2p4CrxNKrl8HqhYBqmh7fY5nA
	yLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkiY8e1gbF8vc4hRgINR
	iYfX4IJ/qBBrYllxZe4hRkkOJiVR3l97A0KF+JLyUyozEosz4otKc1KLDzFKcDArifAqrwHK
	8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeBtPADUKFqWmp1akZeaU
	IKSZODhBhnNJiRSn5qWkFiWWlmTEg6IjvhgYHyApHqC9X0HaeYsLEnOBohCtpxgVpcR5ZYHx
	LyQAksgozYMbC0serxjFgb4U5l0P0s4DTDxw3a+ABjMBDXaMAxtckoiQkmpgnFj9VTjwJXtN
	R2HU0XXmfToCuSoPu1sb+f/8VtnS9erf1r3GbDlLp573e6jbU9RSOqVr7yUWv7vvTt1x9XMw
	/Mz1R2+N9AMHa8bJJyW1AtW9vv+Yvu6KC0PlDpf5QU8ZPn8OnpZzQuf1+ZoT3MG6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268779>

It wasn't pulling its weight. And in a moment we will need similar
tests that take a refname rather than a ref_entry as parameter, which
would have made entry_matches() even less useful.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index faabd68..6bdd34f 100644
--- a/refs.c
+++ b/refs.c
@@ -841,11 +841,6 @@ static void prime_ref_dir(struct ref_dir *dir)
 	}
 }
 
-static int entry_matches(struct ref_entry *entry, const struct string_list *list)
-{
-	return list && string_list_has_string(list, entry->name);
-}
-
 struct nonmatching_ref_data {
 	const struct string_list *skip;
 	struct ref_entry *found;
@@ -855,7 +850,7 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 {
 	struct nonmatching_ref_data *data = vdata;
 
-	if (entry_matches(entry, data->skip))
+	if (data->skip && string_list_has_string(data->skip, entry->name))
 		return 0;
 
 	data->found = entry;
@@ -908,7 +903,7 @@ static int is_refname_available(const char *refname,
 			 * prefix of refname; e.g., "refs/foo".
 			 */
 			struct ref_entry *entry = dir->entries[pos];
-			if (entry_matches(entry, skip)) {
+			if (skip && string_list_has_string(skip, entry->name)) {
 				/*
 				 * The reference we just found, e.g.,
 				 * "refs/foo", is also in skip, so it
-- 
2.1.4
