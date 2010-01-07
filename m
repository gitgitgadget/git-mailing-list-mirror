From: Greg Price <price@MIT.EDU>
Subject: [PATCH 3/6] for-each-ref: --stdin to match specified refs against
 pattern
Date: Thu, 7 Jan 2010 18:08:28 -0500
Message-ID: <47cee601ac5a3b8938b902b173cbaf4146e0d657.1309133817.git.greg@quora.com>
References: <cover.1309133817.git.greg@quora.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 02:42:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QazuP-0006H7-A9
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 02:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab1F0Ajz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 20:39:55 -0400
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:63336 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756045Ab1F0Ajr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2011 20:39:47 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jun 2011 20:39:47 EDT
X-AuditID: 12074425-b7b82ae000000a2a-62-4e07d00156b4
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2A.01.02602.100D70E4; Sun, 26 Jun 2011 20:34:10 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id p5R0YjE0029005;
	Sun, 26 Jun 2011 20:34:45 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5R0Yi5J019016;
	Sun, 26 Jun 2011 20:34:45 -0400 (EDT)
In-Reply-To: <cover.1309133817.git.greg@quora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixCmqrct0gd3P4P8iJouuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugSvj5bcWpoI+4YrJbYfZGhgP8XcxcnJICJhILP55
	nA3CFpO4cG89kM3FISSwj1HiwZPfjBDOBkaJ1b8uM0M4Xxglfk09xwTSIiSgLnGz7RAjhK0j
	sXv6bBYI20ri7pUVUHFDiSdH77B3MXJw8AqESEx5xQVicgoYSbxsVICpuH+hCewINgEFiR/z
	1zGD2CICahIT2w6BTWQWEJdYN/c82BQWARWJZf0iIGFhoIGb395incAouICRYRWjbEpulW5u
	YmZOcWqybnFyYl5eapGuhV5uZoleakrpJkZQwLG7qO5gnHBI6RCjAAejEg/vwwR2PyHWxLLi
	ytxDjJIcTEqivKLngUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeN+FAeV4UxIrq1KL8mFS0hws
	SuK8Id7/fYUE0hNLUrNTUwtSi2CyMhwcShK8QSBDBYtS01Mr0jJzShDSTBycIMN5gIaHgtTw
	Fhck5hZnpkPkTzHqcix6tewwoxBLXn5eqpQ4byZIkQBIUUZpHtwcWKJ4xSgO9JYwbxtIFQ8w
	ycBNegW0hAloSd9lNpAlJYkIKakGRiZD7rcdS0+VHpi8qvRb1bKuxkV1cfVzBLbGzG3irjIq
	rpxaYn0sec6juu+hb59xN5wJyYqX8jA5IG2is+ZgUHZhb9/0sN2v/7TtYmBPLc72+Fnr3vb4
	fe76s51JYgJfptVyW98qf7tQ8tH0pwK/m7iF50k7rc+x4dHlqtIPbymaffxVLbO1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176340>

The pattern syntax of for-each-ref is handy for users, but a bit subtle:
a pattern matches a ref if it matches as an fnmatch pattern, or literally,
or literally against a prefix of the refname up to a slash.  Expose the
for-each-ref pattern-matcher for scripts to use, so that they can provide
a consistent user interface without duplicating the implementation.

Signed-off-by: Greg Price <price@mit.edu>
---
 builtin/for-each-ref.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89e75c6..0413ec0 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -779,6 +779,20 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	return 0;
 }
 
+static void for_each_ref_stdin(each_ref_fn fn, void *cb_data)
+{
+	struct strbuf buf;
+	unsigned char sha1[20];
+
+	strbuf_init(&buf, 0);
+	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+		if (read_ref(buf.buf, sha1))
+			continue;
+		fn(buf.buf, sha1, 0, cb_data);
+	}
+	strbuf_release(&buf);
+}
+
 static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b)
 {
 	struct atom_value *va, *vb;
@@ -943,7 +957,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	int i, num_refs;
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
-	int maxcount = 0, quote_style = 0;
+	int maxcount = 0, quote_style = 0, stdin_refs = 0;
 	struct refinfo **refs;
 	struct grab_ref_cbdata cbdata;
 
@@ -962,6 +976,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_STRING(  0 , "format", &format, "format", "format to use for the output"),
 		OPT_CALLBACK(0 , "sort", sort_tail, "key",
 		            "field name to sort on", &opt_parse_sort),
+		OPT_BOOLEAN( 0 , "stdin", &stdin_refs, "read candidate refs from stdin, rather than all refs"),
 		OPT_END(),
 	};
 
@@ -986,7 +1001,10 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.grab_pattern = argv;
-	for_each_rawref(grab_single_ref, &cbdata);
+	if (stdin_refs)
+		for_each_ref_stdin(grab_single_ref, &cbdata);
+	else
+		for_each_rawref(grab_single_ref, &cbdata);
 	refs = cbdata.grab_array;
 	num_refs = cbdata.grab_cnt;
 
-- 
1.7.5.4
