From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] rev-parse: fix potential bus error with --parseopt option spec handling
Date: Mon, 25 Feb 2008 23:07:39 -0500
Message-ID: <1203998859-86344-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 05:08:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTr77-0000Ya-NJ
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 05:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930AbYBZEHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 23:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755730AbYBZEHo
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 23:07:44 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:26084 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743AbYBZEHn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 23:07:43 -0500
Received: by an-out-0708.google.com with SMTP id d31so450456and.103
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 20:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=Yl1+aIF2/7k6+N404NQdtlrDJGj4/J4YzjnzIW2O/Gk=;
        b=SGfGuB3UtNrFbg22b3K1duv6hyPwbTNo8xZ1lOuCc4zpY9tyscjRSBLm/Ekc1EWK6dDR+wo+ZsDlpFelua7kB0Yp7US/dTXEAL2TQoWD8pCGZJJwtjVMCp9GyOwNpxhFIMkgdQJK+mxvOX1ipu5qQmWUbHN0tKOwh143Cus/n+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=RXNeppUprxcEHLdPqv47uFeT/05Vfn4TNxIyBctVmUk3LFxRWLZJ8DTUdKZIhJ9vPCNzOn39cWabfUH+RKtqf6w6BRhXfr5/fQR8pZA7D0gq0nHPcBiTnees2JqR8Jan9KLHeOD5piYKfFHsCTr3dTbRCA//qwd+ijRSJR8Alnw=
Received: by 10.100.228.17 with SMTP id a17mr3063570anh.42.1203998862519;
        Mon, 25 Feb 2008 20:07:42 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id c2sm8127247ana.4.2008.02.25.20.07.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Feb 2008 20:07:41 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.331.ga714
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75104>

A non-empty line containing no spaces should be treated by --parseopt as
an option group header, but was causing a bus error. Also added a test
script for rev-parse --parseopt.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
e.g.
% printf "foo\n--\noption-group-header\n" | git rev-parse --parseopt -- -h
Bus error

Wasn't sure whether to add the --parseopt test to t0040-parse-options.sh or
t1500-rev-parse.sh. I ended up creating a new test script. Hopefully calling
it out will increase the likelihood of it growing additional --parseopt tests.

 builtin-rev-parse.c           |    2 +-
 t/t1502-rev-parse-parseopt.sh |   43 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletions(-)
 create mode 100755 t/t1502-rev-parse-parseopt.sh

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index b9af1a5..90dbb9d 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -315,7 +315,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		s = strchr(sb.buf, ' ');
 		if (!s || *sb.buf == ' ') {
 			o->type = OPTION_GROUP;
-			o->help = xstrdup(skipspaces(s));
+			o->help = xstrdup(skipspaces(sb.buf));
 			continue;
 		}
 
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
new file mode 100755
index 0000000..762af5f
--- /dev/null
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='test git rev-parse --parseopt'
+. ./test-lib.sh
+
+cat > expect.err <<EOF
+usage: some-command [options] <args>...
+    
+    some-command does foo and bar!
+
+    -h, --help            show the help
+    --foo                 some nifty option --foo
+    --bar ...             some cool option --bar with an argument
+
+An option group Header
+    -C [...]              option C with an optional argument
+
+Extras
+    --extra1              line above used to cause a segfault but no longer does
+
+EOF
+
+test_expect_success 'test --parseopt help output' '
+	git rev-parse --parseopt -- -h 2> output.err <<EOF
+some-command [options] <args>...
+
+some-command does foo and bar!
+--
+h,help    show the help
+
+foo       some nifty option --foo
+bar=      some cool option --bar with an argument
+
+ An option group Header
+C?        option C with an optional argument
+
+Extras
+extra1    line above used to cause a segfault but no longer does
+EOF
+	git diff expect.err output.err
+'
+
+test_done
-- 
1.5.4.3.331.ga714
