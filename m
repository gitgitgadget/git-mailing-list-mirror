From: Anders Kaseorg <andersk@ksplice.com>
Subject: =?UTF-8?Q?=5BPATCH_v2_2=2F4=5D_describe=3A_Don=E2=80=99t_use_a_flex_array_in_struct_commit=5Fname?=
Date: Tue, 7 Dec 2010 23:43:18 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012072342480.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino> <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <7vfwu9qvew.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1012072204371.23348@dr-wily.mit.edu> <alpine.DEB.2.02.1012072341570.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 05:43:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQBsE-0003Yp-N4
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 05:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab0LHEnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 23:43:21 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48935 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab0LHEnV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 23:43:21 -0500
Received: by qwa26 with SMTP id 26so805012qwa.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 20:43:20 -0800 (PST)
Received: by 10.224.54.129 with SMTP id q1mr6768664qag.79.1291783400283;
        Tue, 07 Dec 2010 20:43:20 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id t17sm145852qcp.38.2010.12.07.20.43.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 20:43:20 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <alpine.DEB.2.02.1012072341570.23348@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163168>

Now add_to_known_names overwrites commit_names in place when multiple
tags point to the same commit.  This will make it easier to store
commit_names in a hash table.

Signed-off-by: Anders Kaseorg <andersk@ksplice.com>
---
 builtin/describe.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 700f740..5b8461d 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -38,7 +38,7 @@ struct commit_name {
 	unsigned prio:2; /* annotated tag = 2, tag = 1, head = 0 */
 	unsigned name_checked:1;
 	unsigned char sha1[20];
-	char path[FLEX_ARRAY]; /* more */
+	const char *path;
 };
 static const char *prio_names[] = {
 	"head", "lightweight", "annotated",
@@ -85,15 +85,15 @@ static void add_to_known_names(const char *path,
 	struct commit_name *e = commit->util;
 	struct tag *tag = NULL;
 	if (replace_name(e, prio, sha1, &tag)) {
-		size_t len = strlen(path)+1;
-		free(e);
-		e = xmalloc(sizeof(struct commit_name) + len);
+		if (!e) {
+			e = xmalloc(sizeof(struct commit_name));
+			commit->util = e;
+		}
 		e->tag = tag;
 		e->prio = prio;
 		e->name_checked = 0;
 		hashcpy(e->sha1, sha1);
-		memcpy(e->path, path, len);
-		commit->util = e;
+		e->path = path;
 	}
 	found_names = 1;
 }
-- 
1.7.3.3
