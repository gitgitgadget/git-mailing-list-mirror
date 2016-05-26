From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Thu, 26 May 2016 23:11:56 +0200
Message-ID: <5747669C.9020807@kdbg.org>
References: <20160520132829.7937-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr, gitster@pobox.com,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 26 23:12:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b62Za-0006xw-0H
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 23:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbcEZVMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 17:12:00 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:46594 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755101AbcEZVMA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 17:12:00 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3rG1zx4nj7z5tl9;
	Thu, 26 May 2016 23:11:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id BBB1D527A;
	Thu, 26 May 2016 23:11:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295693>

Am 24.05.2016 um 16:25 schrieb William Duclot:
> +PATTERNS("css",
> +	 "^([^,{}]+)((,[^}]*\\{)|([ \t]*\\{))$",

This hunk header pattern is a bit too restrictive for my taste. Find
below a few more test cases that you should squash in. One case fails
because only the first CSS selector is picked up, for which I do not
see a reason.

Another case fails because the opening brace is not on the line with
the CSS selectors.

I think what the hunk header pattern should do is:

1. reject lines containing a colon (because that are properties)
2. if a line begins with a name in column 1, pick the whole line

See the cpp patterns: a pattern beginning with ! is a "reject" pattern.


diff --git a/t/t4018/css-brace-in-col-1 b/t/t4018/css-brace-in-col-1
new file mode 100644
index 0000000..7831577
--- /dev/null
+++ b/t/t4018/css-brace-in-col-1
@@ -0,0 +1,5 @@
+RIGHT label.control-label
+{
+    margin-top: 10px!important;
+    border : 10px ChangeMe #C6C6C6;
+}
diff --git a/t/t4018/css-rule b/t/t4018/css-common
similarity index 100%
rename from t/t4018/css-rule
rename to t/t4018/css-common
diff --git a/t/t4018/css-long-selector-list b/t/t4018/css-long-selector-list
new file mode 100644
index 0000000..7ccd25d
--- /dev/null
+++ b/t/t4018/css-long-selector-list
@@ -0,0 +1,6 @@
+p.header,
+label.control-label,
+div ul#RIGHT {
+    margin-top: 10px!important;
+    border : 10px ChangeMe #C6C6C6;
+}
diff --git a/t/t4018/css-prop-sans-indent b/t/t4018/css-prop-sans-indent
new file mode 100644
index 0000000..a9e3c86
--- /dev/null
+++ b/t/t4018/css-prop-sans-indent
@@ -0,0 +1,5 @@
+RIGHT, label.control-label {
+margin-top: 10px!important;
+padding: 0;
+border : 10px ChangeMe #C6C6C6;
+}
diff --git a/t/t4018/css-short-selector-list b/t/t4018/css-short-selector-list
new file mode 100644
index 0000000..6a0bdee
--- /dev/null
+++ b/t/t4018/css-short-selector-list
@@ -0,0 +1,4 @@
+label.control, div ul#RIGHT {
+    margin-top: 10px!important;
+    border : 10px ChangeMe #C6C6C6;
+}
-- 
2.9.0.rc0.40.gb3c1388
