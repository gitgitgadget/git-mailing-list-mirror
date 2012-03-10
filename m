From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH maint-1.7.6] fast-import: don't allow 'ls' of path with empty
 components
Date: Fri, 9 Mar 2012 22:00:49 -0600
Message-ID: <20120310040049.GC3008@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308070951.GA2181@burratino>
 <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
 <20120310031228.GA3008@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 05:01:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6DUJ-0000uC-6H
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 05:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab2CJEAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 23:00:54 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46032 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab2CJEAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 23:00:53 -0500
Received: by yhmm54 with SMTP id m54so1394548yhm.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 20:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gfAcdXdfh3ezr8iNeeUYmJecnorOK5090Y33miEmvyg=;
        b=bDB0oNsmlGxLsM+RhjyVzXdoKQeJ6y5x1LYtsMoYVVnvfJrk4PZWZFqDdPeVTlxSm6
         GMrzCDwTmy/VrBGXeWlUOPRUtb/zOb5KYSH50hJ9fArWTEYhfQ7E+wu5stOkWA8fgGf1
         rbOqOh3H0aOvHF3WUKtdh+x0sG7tLevfkUE1aVk8+8pPlUsivFK5jwde8fIBmJBXda76
         ybWQ6aI7QI/USbPg9OBm4VCsF3q0n+fA1xIR2PES1NaJhCItf+/5hywAZRTbtYXhwhH2
         Mx9p616nafPveR75iGnQOvlyD4cpwghmZ+9UezRyDKqHKidipccnazy6ajIyH/gGfnfO
         VgkQ==
Received: by 10.182.114.70 with SMTP id je6mr1815035obb.30.1331352052986;
        Fri, 09 Mar 2012 20:00:52 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id yv3sm10260069obb.3.2012.03.09.20.00.51
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 20:00:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120310031228.GA3008@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192765>

As the fast-import manual explains:

	The value of <path> must be in canonical form. That is it must
	not:
	. contain an empty directory component (e.g. foo//bar is invalid),
	. end with a directory separator (e.g. foo/ is invalid),
	. start with a directory separator (e.g. /foo is invalid),

Unfortunately the "ls" command accepts these invalid syntaxes and
responds by declaring that the indicated path is missing.  This is too
subtle and causes importers to silently misbehave; better to error out
so the operator knows what's happening.

The C, R, and M commands already error out for such paths.

Based on initial analysis by David Barr.

Reported-by: Andrew Sayers <andrew-git@pileofstuff.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Also against on 8dc6a373d (fast-import: add 'ls' command, 2010-12-02).

 fast-import.c          |    2 ++
 t/t9300-fast-import.sh |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/fast-import.c b/fast-import.c
index fff285cd..47f61f3c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1640,6 +1640,8 @@ static int tree_content_get(
 		n = slash1 - p;
 	else
 		n = strlen(p);
+	if (!n)
+		die("Empty path component found in input");
 
 	if (!root->tree)
 		load_tree(root);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6b1ba6c8..2cd0f061 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1088,6 +1088,45 @@ test_expect_success \
 	INPUT_END'
 
+test_expect_success \
+	'N: reject foo/ syntax in copy source' \
+	'test_must_fail git fast-import <<-INPUT_END
+	commit refs/heads/N5C
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	copy with invalid syntax
+	COMMIT
+
+	from refs/heads/branch^0
+	C file2/ file3
+	INPUT_END'
+
+test_expect_success \
+	'N: reject foo/ syntax in rename source' \
+	'test_must_fail git fast-import <<-INPUT_END
+	commit refs/heads/N5D
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	rename with invalid syntax
+	COMMIT
+
+	from refs/heads/branch^0
+	R file2/ file3
+	INPUT_END'
+
+test_expect_success \
+	'N: reject foo/ syntax in ls argument' \
+	'test_must_fail git fast-import <<-INPUT_END
+	commit refs/heads/N5E
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	copy with invalid syntax
+	COMMIT
+
+	from refs/heads/branch^0
+	ls "file2/"
+	INPUT_END'
+
 test_expect_success \
 	'N: copy to root by id and modify' \
 	'echo "hello, world" >expect.foo &&
 	 echo hello >expect.bar &&
-- 
1.7.9.2
