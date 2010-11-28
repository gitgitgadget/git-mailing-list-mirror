From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] fast-import: stricter parsing of integer options
Date: Sun, 28 Nov 2010 13:42:46 -0600
Message-ID: <20101128194246.GB19998@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
 <20101128194131.GA19998@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 20:42:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMn9H-0002nk-9D
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab0K1Tmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:42:54 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44890 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab0K1Tmx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 14:42:53 -0500
Received: by yxt3 with SMTP id 3so1163845yxt.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 11:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gGrcAajqcGNeiVn5M88ikaggUk2/ocyzZyoFH4u8LkI=;
        b=fjqECeGLn+Z+XcEp1J/yIZpaepGuwMLPMyit0I1ekr0rSSqGcveT6O/huD6UvL1x7e
         Y8MuSOp5puOMn3qEO6o+e1R6Wdg5xRBm/ykheOrTse5LpQvWDdL66KWpB3PYCJgSz0Nr
         qxh6YZYJJbNxP2RUqMzCqY/kGNGrM/CVtvvxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xAMsT7RYC4J+vK3sC8rq5LKR4zno3cFgQzoRfO9mrcPESC0MymZjAkA/+7a6/zETeB
         gGsO4n6h8Zd29zjD8nyCgLGs1r/+RL4BU49nDtkLtUyjuJ7e5zJ2t/jvC3e3MUAmd4J5
         bs3LSl6a+QSlvsOgtv70B/HnCHTV1rwIoGxy8=
Received: by 10.150.92.12 with SMTP id p12mr9140886ybb.69.1290973371664;
        Sun, 28 Nov 2010 11:42:51 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id q31sm1049067yba.18.2010.11.28.11.42.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 11:42:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101128194131.GA19998@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162355>

Check the result from strtoul to avoid accepting arguments like
--depth=-1 and --active-branches=foo,bar,baz.

Requested-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
See http://thread.gmane.org/gmane.comp.version-control.git/159117/focus=159236
for context.

 fast-import.c          |   13 +++++++++++--
 t/t9300-fast-import.sh |    8 ++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 74f08bd..959afef 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2745,16 +2745,25 @@ static void option_date_format(const char *fmt)
 		die("unknown --date-format argument %s", fmt);
 }
 
+static unsigned long ulong_arg(const char *option, const char *arg)
+{
+	char *endptr;
+	unsigned long rv = strtoul(arg, &endptr, 0);
+	if (strchr(arg, '-') || endptr == arg || *endptr)
+		die("%s: argument must be an unsigned integer", option);
+	return rv;
+}
+
 static void option_depth(const char *depth)
 {
-	max_depth = strtoul(depth, NULL, 0);
+	max_depth = ulong_arg("--depth", depth);
 	if (max_depth > MAX_DEPTH)
 		die("--depth cannot exceed %u", MAX_DEPTH);
 }
 
 static void option_active_branches(const char *branches)
 {
-	max_active_branches = strtoul(branches, NULL, 0);
+	max_active_branches = ulong_arg("--active-branches", branches);
 }
 
 static void option_export_marks(const char *marks)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 131f032..2c27da6 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1528,6 +1528,14 @@ test_expect_success 'R: unknown commandline options are rejected' '\
     test_must_fail git fast-import --non-existing-option < /dev/null
 '
 
+test_expect_success 'R: die on invalid option argument' '
+	echo "option git active-branches=-5" |
+	test_must_fail git fast-import &&
+	echo "option git depth=" |
+	test_must_fail git fast-import &&
+	test_must_fail git fast-import --depth="5 elephants" </dev/null
+'
+
 cat >input <<EOF
 option non-existing-vcs non-existing-option
 EOF
