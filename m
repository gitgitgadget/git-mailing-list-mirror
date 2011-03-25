From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] vcs-svn: make reading of properties binary-safe
Date: Thu, 24 Mar 2011 23:07:30 -0500
Message-ID: <20110325040730.GB3007@elie>
References: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <1300970636-31743-1-git-send-email-david.barr@cordelta.com>
 <20110325033431.GA3007@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 05:07:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2yJK-0004XR-A7
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 05:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901Ab1CYEHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 00:07:36 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:58188 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab1CYEHf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 00:07:35 -0400
Received: by yia27 with SMTP id 27so308767yia.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VpLbohxYgKHFUhVZgOWQEQFZ8lxeoHswlWxoFlYWybA=;
        b=hsBGPyO6zZSZvqDNj7F61CYNwdArE3GS/kkgzeNHf925PCTihwkT/yPcua/I8IErxC
         Z6wJM54V0iKseOZKdr/xG0dLOOdS5Q3eGl15mMUW81Z4L2/RUPHwrL95vZ8u9E+lXfXo
         stzszxFATpgvfMd/w1HOsXbCeb4JsPP6ux5wY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K1wL064x+rDa5q5NstNcBDIkrBqrt0OJh76E8mR6kO1+a5eHzuuFc0K2LeiZ5Ue4+M
         xsVrzDoYvaNNIHm/+2pzyDjCtmZOtKzlc2iMrIwFUZuegg4tzmG13/ZisdWUXMBq1NEW
         9s+FEZLdGnLY+Z/wYRGHFbWrLo9MpR80x+mIE=
Received: by 10.236.195.38 with SMTP id o26mr383718yhn.320.1301026054903;
        Thu, 24 Mar 2011 21:07:34 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.ameritech.net [68.255.102.141])
        by mx.google.com with ESMTPS id z7sm346665yhc.17.2011.03.24.21.07.33
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 21:07:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110325033431.GA3007@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169960>

A caller to buffer_read_string cannot easily tell the difference
between the string "foo" followed by an early end of file and the
string "foo\0bar\0baz".  In a half-hearted attempt to catch early EOF,
c9d1c8ba (2010-12-28) introduced a safety strlen(val) == len for
property keys and values, to at least keep svn-fe from reading
uninitialized data when a property list ends early due to EOF.

But it is permissible for both keys and values to contain null
characters, so in handling revision 59151 of the ASF repository svn-fe
encounters a null byte and produces the following message:

 fatal: invalid dump: unexpected end of file

Fix it by using buffer_read_binary to read to a strbuf (and keep track
of the actual length read).  Most consumers of properties still use
C-style strings, so in practice we still can't use an author or log
message with embedded nuls, but at least this way svn-fe won't error
out.

Reported-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh |   27 +++++++++++++++++++++++++++
 vcs-svn/svndump.c |   24 ++++++++++--------------
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 5a6a4b9..47f1e4f 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -370,6 +370,33 @@ test_expect_failure 'change file mode but keep old content' '
 	test_cmp hello actual.target
 '
 
+test_expect_success 'null byte in property value' '
+	reinit_git &&
+	echo "commit message" >expect.message &&
+	{
+		properties \
+			unimportant "something with a null byte (Q)" \
+			svn:log "commit message"&&
+		echo PROPS-END
+	} |
+	q_to_nul >props &&
+	{
+		cat <<-\EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		EOF
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props
+	} >nullprop.dump &&
+	test-svn-fe nullprop.dump >stream &&
+	git fast-import <stream &&
+	git diff-tree --always -s --format=%s HEAD >actual.message &&
+	test_cmp expect.message actual.message
+'
+
 test_expect_success 'change file mode and reiterate content' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index ea5b128..c00f031 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -147,6 +147,7 @@ static void die_short_read(void)
 static void read_props(void)
 {
 	static struct strbuf key = STRBUF_INIT;
+	static struct strbuf val = STRBUF_INIT;
 	const char *t;
 	/*
 	 * NEEDSWORK: to support simple mode changes like
@@ -163,15 +164,15 @@ static void read_props(void)
 	uint32_t type_set = 0;
 	while ((t = buffer_read_line(&input)) && strcmp(t, "PROPS-END")) {
 		uint32_t len;
-		const char *val;
 		const char type = t[0];
 		int ch;
 
 		if (!type || t[1] != ' ')
 			die("invalid property line: %s\n", t);
 		len = atoi(&t[2]);
-		val = buffer_read_string(&input, len);
-		if (!val || strlen(val) != len)
+		strbuf_reset(&val);
+		buffer_read_binary(&input, &val, len);
+		if (val.len < len)
 			die_short_read();
 
 		/* Discard trailing newline. */
@@ -179,22 +180,17 @@ static void read_props(void)
 		if (ch == EOF)
 			die_short_read();
 		if (ch != '\n')
-			die("invalid dump: expected newline after %s", val);
+			die("invalid dump: expected newline after %s", val.buf);
 
 		switch (type) {
 		case 'K':
+			strbuf_swap(&key, &val);
+			continue;
 		case 'D':
-			strbuf_reset(&key);
-			if (val)
-				strbuf_add(&key, val, len);
-			if (type == 'K')
-				continue;
-			assert(type == 'D');
-			val = NULL;
-			len = 0;
-			/* fall through */
+			handle_property(&val, NULL, 0, &type_set);
+			continue;
 		case 'V':
-			handle_property(&key, val, len, &type_set);
+			handle_property(&key, val.buf, len, &type_set);
 			strbuf_reset(&key);
 			continue;
 		default:
-- 
1.7.4.1
