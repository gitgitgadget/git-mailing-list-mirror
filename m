From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] pager: set LV=-c alongside LESS=FRSX
Date: Mon, 6 Jan 2014 18:14:05 -0800
Message-ID: <20140107021404.GK3881@google.com>
References: <874n6zbqlh.fsf@helix.nebula.avasys.jp>
 <20140106193339.GH3881@google.com>
 <874n5ghenr.fsf@helix.nebula.avasys.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olaf Meeuwissen <olaf.meeuwissen@avasys.jp>
X-From: git-owner@vger.kernel.org Tue Jan 07 03:14:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0MBL-0003uq-0s
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 03:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbaAGCOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 21:14:11 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:35612 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaAGCOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 21:14:09 -0500
Received: by mail-yh0-f51.google.com with SMTP id c41so3845969yho.10
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 18:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yiHz3oWEIpmmCq6aIBz9K92hwR5COafPihJpQZlg5cw=;
        b=sWyO54w05ubNtkX2JR+zoLHTtFZL4Ql0tBhlqep1uPP1mBtolQ10IAePAfOpgaR2ID
         aq6K1ufH7505/k9k4kMY3cJ4KESNEX+qlLp48XvLMKp0rMLmFTxsDjBrHflpCF3Nc7cD
         hlQRvJe5OR8FUrN8+4RG+4BJDlER9EqYzar0+Nc5Vq/isKrqKjvLfa0M32UGSOq+XxeY
         cU4GVqZNpdhZyaGCzF/ipMOaQNJEZlMBQVt2g+U7vmYAwUbE+4DLganf2zQJqFhBSMZB
         Cp6NabRAtB6RGTKNMV/v63bb4Uouz+0eW9w1A2kV46tD4djLtNJWJgyJJ2tsE+6uINUO
         fSfA==
X-Received: by 10.236.151.41 with SMTP id a29mr78342355yhk.39.1389060849012;
        Mon, 06 Jan 2014 18:14:09 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id k3sm21788089yhc.13.2014.01.06.18.14.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jan 2014 18:14:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <874n5ghenr.fsf@helix.nebula.avasys.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240093>

On systems with lv configured as the preferred pager (i.e.,
DEFAULT_PAGER=lv at build time, or PAGER=lv exported in the
environment) git commands that use color show control codes instead of
color in the pager:

	$ git diff
	^[[1mdiff --git a/.mailfilter b/.mailfilter^[[m
	^[[1mindex aa4f0b2..17e113e 100644^[[m
	^[[1m--- a/.mailfilter^[[m
	^[[1m+++ b/.mailfilter^[[m
	^[[36m@@ -1,11 +1,58 @@^[[m

"less" avoids this problem because git uses the LESS environment
variable to pass the -R option ('output ANSI color escapes in raw
form') by default.  Use the LV environment variable to pass 'lv' the
-c option ('allow ANSI escape sequences for text decoration / color')
to fix it for lv, too.

Noticed when the default value for color.ui flipped to 'auto' in
v1.8.4-rc0~36^2~1 (2013-06-10).

Reported-by: Olaf Meeuwissen <olaf.meeuwissen@avasys.jp>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Olaf Meeuwissen wrote[1]:

> Yes, it's called LV and documented in the lv(1) manual page.  Simply
> search for 'env' ;-)

Ah, thanks.  How about this patch?

[1] http://bugs.debian.org/730527

 Documentation/config.txt |  4 ++++
 git-sh-setup.sh          |  3 ++-
 pager.c                  | 11 +++++++++--
 perl/Git/SVN/Log.pm      |  1 +
 t/t7006-pager.sh         | 12 ++++++++++++
 5 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a405806..ed59853 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -567,6 +567,10 @@ be passed to the shell by Git, which will translate the final
 command to `LESS=FRSX less -+S`. The environment tells the command
 to set the `S` option to chop long lines but the command line
 resets it to the default to fold long lines.
++
+Likewise, when the `LV` environment variable is unset, Git sets it
+to `-c`.  You can override this setting by exporting `LV` with
+another value or setting `core.pager` to `lv +c`.
 
 core.whitespace::
 	A comma separated list of common whitespace problems to
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 190a539..fffa3c7 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -159,7 +159,8 @@ git_pager() {
 		GIT_PAGER=cat
 	fi
 	: ${LESS=-FRSX}
-	export LESS
+	: ${LV=-c}
+	export LESS LV
 
 	eval "$GIT_PAGER" '"$@"'
 }
diff --git a/pager.c b/pager.c
index 345b0bc..0cc75a8 100644
--- a/pager.c
+++ b/pager.c
@@ -80,8 +80,15 @@ void setup_pager(void)
 	pager_process.use_shell = 1;
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
-	if (!getenv("LESS")) {
-		static const char *env[] = { "LESS=FRSX", NULL };
+	if (!getenv("LESS") || !getenv("LV")) {
+		static const char *env[3];
+		int i = 0;
+
+		if (!getenv("LESS"))
+			env[i++] = "LESS=FRSX";
+		if (!getenv("LV"))
+			env[i++] = "LV=-c";
+		env[i] = NULL;
 		pager_process.env = env;
 	}
 	if (start_command(&pager_process))
diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
index 3f8350a..34f2869 100644
--- a/perl/Git/SVN/Log.pm
+++ b/perl/Git/SVN/Log.pm
@@ -117,6 +117,7 @@ sub run_pager {
 	}
 	open STDIN, '<&', $rfd or fatal "Can't redirect stdin: $!";
 	$ENV{LESS} ||= 'FRSX';
+	$ENV{LV} ||= '-c';
 	exec $pager or fatal "Can't run pager: $! ($pager)";
 }
 
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index ff25908..7fe3367 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -37,6 +37,18 @@ test_expect_failure TTY 'pager runs from subdir' '
 	test_cmp expected actual
 '
 
+test_expect_success TTY 'LESS and LV envvars are set for pagination' '
+	(
+		sane_unset LESS LV &&
+		PAGER="env >pager-env.out" &&
+		export PAGER &&
+
+		test_terminal git log
+	) &&
+	grep ^LESS= pager-env.out &&
+	grep ^LV= pager-env.out
+'
+
 test_expect_success TTY 'some commands do not use a pager' '
 	rm -f paginated.out &&
 	test_terminal git rev-list HEAD &&
-- 
1.8.5.1
