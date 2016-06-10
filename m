From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v5 2/3] completion: add __git_get_option_value helper
Date: Fri, 10 Jun 2016 12:12:05 +0200
Message-ID: <20160610101206.5760-3-thomas.braun@virtuell-zuhause.de>
References: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
 <20160610101206.5760-1-thomas.braun@virtuell-zuhause.de>
Cc: peff@peff.net, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 12:12:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBJQU-0005QY-HI
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 12:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbcFJKM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 06:12:28 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:36187 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753088AbcFJKM0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 06:12:26 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=localhost.localdomain); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1bBJQM-00037D-4l; Fri, 10 Jun 2016 12:12:22 +0200
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20160610101206.5760-1-thomas.braun@virtuell-zuhause.de>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1465553545;6e6a5725;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296961>

This function allows to search the commmand line and config
files for an option, long and short, with mandatory value.

The function would return e.g. for the command line
"git status -uno --untracked-files=all" the result
"all" regardless of the config option.

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index addea89..0bf67c9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -803,6 +803,50 @@ __git_find_on_cmdline ()
 	done
 }
 
+# Echo the value of an option set on the command line or config
+#
+# $1: short option name
+# $2: long option name including =
+# $3: list of possible values
+# $4: config string (optional)
+#
+# example:
+# result="$(__git_get_option_value "-d" "--do-something=" \
+#     "yes no" "core.doSomething")"
+#
+# result is then either empty (no option set) or "yes" or "no"
+#
+# __git_get_option_value requires 3 arguments
+__git_get_option_value ()
+{
+	local c short_opt long_opt val
+	local result= values config_key word
+
+	short_opt="$1"
+	long_opt="$2"
+	values="$3"
+	config_key="$4"
+
+	((c = $cword - 1))
+	while [ $c -ge 0 ]; do
+		word="${words[c]}"
+		for val in $values; do
+			if [ "$short_opt$val" = "$word" ] ||
+			   [ "$long_opt$val"  = "$word" ]; then
+				result="$val"
+				break 2
+			fi
+		done
+		((c--))
+	done
+
+	if [ -n "$config_key" ] && [ -z "$result" ]; then
+		result="$(git --git-dir="$(__gitdir)" config "$config_key")"
+	fi
+
+	echo "$result"
+}
+
 __git_has_doubledash ()
 {
 	local c=1
-- 
2.8.4.windows.1
