From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/12] vcs-svn: quote paths correctly for ls command
Date: Sun, 6 Mar 2011 17:12:47 -0600
Message-ID: <20110306231246.GL24327@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 00:12:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwN8C-0001EM-SO
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925Ab1CFXMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:12:52 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43896 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913Ab1CFXMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:12:52 -0500
Received: by gyh20 with SMTP id 20so1459988gyh.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pB1PfoWfj38RZ8LkeqYO1MiabbIWH5K0D+Js6FYcz74=;
        b=OcWrLpTq5HQekG3r7wGRXBgT35hOTudIRAH0FCjrOTMOygGMbdQF4U1pN1aF9yWtpw
         9+nYyIzwiCYPFwWK5L23f64Lt5KmuFYDAYUpMbJXLB7UTKrLGj0c8IpEuBoqi7F46xJ1
         h8N1Kq2Jp4Uf44ebqk3SOatOYbWS42RhixEB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=H51zR3KMCx2N+bLmHGq+Azn+mQhrW/gx1W0hEzTHmzO0EgwxNEFRHqhBEVO/oNnJnw
         MuWleJ3ZplCgMAYjiureDmvOAD4R+nYyk9RjSdY0JjDi2ZTtMJ2qbHBtdwvg3072b8Gr
         OTVULskr+dUWggCg+LBgwDnZ5bpxRmZuLjYYk=
Received: by 10.236.186.105 with SMTP id v69mr2089333yhm.81.1299453171475;
        Sun, 06 Mar 2011 15:12:51 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.sbcglobal.net [69.209.66.207])
        by mx.google.com with ESMTPS id n56sm1301708yhn.7.2011.03.06.15.12.49
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:12:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168557>

From: David Barr <david.barr@cordelta.com>
Date: Sun, 12 Dec 2010 03:59:31 +1100

This bug was found while importing rev 601865 of ASF.

[jn: with test]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh     |   99 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/fast_export.c |    2 +-
 vcs-svn/string_pool.c |   11 +++++
 vcs-svn/string_pool.h |    1 +
 4 files changed, 112 insertions(+), 1 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 2ae5374..720fd6b 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -270,6 +270,105 @@ test_expect_success PIPE 'directory with files' '
 	test_cmp hi directory/file2
 '
 
+test_expect_success PIPE 'branch name with backslash' '
+	reinit_git &&
+	sort <<-\EOF >expect.branch-files &&
+	trunk/file1
+	trunk/file2
+	"branches/UpdateFOPto094\\/file1"
+	"branches/UpdateFOPto094\\/file2"
+	EOF
+
+	echo hi >hi &&
+	echo hello >hello &&
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-02-02T00:01:02.000000Z" \
+			svn:log "add directory with some files in it" &&
+		echo PROPS-END
+	} >props.setup &&
+	{
+		properties \
+			svn:author brancher@example.com \
+			svn:date "2007-12-06T21:38:34.000000Z" \
+			svn:log "Updating fop to .94 and adjust fo-stylesheets" &&
+		echo PROPS-END
+	} >props.branch &&
+	{
+		cat <<-EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		EOF
+		echo Prop-content-length: $(wc -c <props.setup) &&
+		echo Content-length: $(wc -c <props.setup) &&
+		echo &&
+		cat props.setup &&
+		cat <<-\EOF &&
+
+		Node-path: trunk
+		Node-kind: dir
+		Node-action: add
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: branches
+		Node-kind: dir
+		Node-action: add
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: trunk/file1
+		Node-kind: file
+		Node-action: add
+		EOF
+		text_no_props hello &&
+		cat <<-\EOF &&
+		Node-path: trunk/file2
+		Node-kind: file
+		Node-action: add
+		EOF
+		text_no_props hi &&
+		cat <<-\EOF &&
+
+		Revision-number: 2
+		EOF
+		echo Prop-content-length: $(wc -c <props.branch) &&
+		echo Content-length: $(wc -c <props.branch) &&
+		echo &&
+		cat props.branch &&
+		cat <<-\EOF
+
+		Node-path: branches/UpdateFOPto094\
+		Node-kind: dir
+		Node-action: add
+		Node-copyfrom-rev: 1
+		Node-copyfrom-path: trunk
+
+		Node-kind: dir
+		Node-action: add
+		Prop-content-length: 34
+		Content-length: 34
+
+		K 13
+		svn:mergeinfo
+		V 0
+
+		PROPS-END
+		EOF
+	} >branch.dump &&
+	try_dump branch.dump &&
+
+	git ls-tree -r --name-only HEAD |
+	sort >actual.branch-files &&
+	test_cmp expect.branch-files actual.branch-files
+'
+
 test_expect_success PIPE 'node without action' '
 	reinit_git &&
 	cat >inaction.dump <<-\EOF &&
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index a8ce5c6..4d57efa 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -107,7 +107,7 @@ static void ls_from_active_commit(uint32_t depth, const uint32_t *path)
 {
 	/* ls "path/to/file" */
 	printf("ls \"");
-	pool_print_seq(depth, path, '/', stdout);
+	pool_print_seq_q(depth, path, '/', stdout);
 	printf("\"\n");
 	fflush(stdout);
 }
diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
index c08abac..be43598 100644
--- a/vcs-svn/string_pool.c
+++ b/vcs-svn/string_pool.c
@@ -4,6 +4,7 @@
  */
 
 #include "git-compat-util.h"
+#include "quote.h"
 #include "trp.h"
 #include "obj_pool.h"
 #include "string_pool.h"
@@ -75,6 +76,16 @@ void pool_print_seq(uint32_t len, const uint32_t *seq, char delim, FILE *stream)
 	}
 }
 
+void pool_print_seq_q(uint32_t len, const uint32_t *seq, char delim, FILE *stream)
+{
+	uint32_t i;
+	for (i = 0; i < len && ~seq[i]; i++) {
+		quote_c_style(pool_fetch(seq[i]), NULL, stream, 1);
+		if (i < len - 1 && ~seq[i + 1])
+			fputc(delim, stream);
+	}
+}
+
 uint32_t pool_tok_seq(uint32_t sz, uint32_t *seq, const char *delim, char *str)
 {
 	char *context = NULL;
diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
index 3720cf8..96e501d 100644
--- a/vcs-svn/string_pool.h
+++ b/vcs-svn/string_pool.h
@@ -5,6 +5,7 @@ uint32_t pool_intern(const char *key);
 const char *pool_fetch(uint32_t entry);
 uint32_t pool_tok_r(char *str, const char *delim, char **saveptr);
 void pool_print_seq(uint32_t len, const uint32_t *seq, char delim, FILE *stream);
+void pool_print_seq_q(uint32_t len, const uint32_t *seq, char delim, FILE *stream);
 uint32_t pool_tok_seq(uint32_t sz, uint32_t *seq, const char *delim, char *str);
 void pool_reset(void);
 
-- 
1.7.4.1
