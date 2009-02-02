From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] builtin-remote: make rm operation safer in mirrored repository
Date: Mon,  2 Feb 2009 13:40:14 -0500
Message-ID: <1233600014-82346-1-git-send-email-jaysoffian@gmail.com>
References: <76718490902020536g6f4bcee2i76ee046a8dc7d46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 19:41:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU3ju-0003hw-4y
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 19:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbZBBSkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 13:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbZBBSkU
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 13:40:20 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:63840 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbZBBSkS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 13:40:18 -0500
Received: by qw-out-2122.google.com with SMTP id 3so914709qwe.37
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 10:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=494wlTPwscv0TCD2V1bsDO7j16x1MuwwN35Zz0yQXUo=;
        b=qBI5TFdbNSiBux7KASzyJdHWzxHbSjjVa2X2Xd9VuPkLkHYEXAbH+ht4Nc394jyyQu
         ekJyX5cd/OXboK6w9rJeZZLid8Zi8abiZERJvDNm+BCTzcw8zBV3SZ6CePAGsoR+g4SA
         VDAM24DPwpag01yXni0M587x1mx6s6hD5kV3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vCvy9ozBnpoLtEijYwvr/fwu7Cw45a9CScgKa6TR2XNil3BfzGW/cEH3+ejHVyf6OM
         DB73yJFXPBzuy3N6RinEkPp5e/WLnmWXrd1B2z6KWmhkFnUgF6kbY/yOyEROYS6Dbg9A
         pfaZmYVXj8jYbNTM9IPFFbIq2mNmy5GlQkl/8=
Received: by 10.214.182.15 with SMTP id e15mr6713234qaf.314.1233600017402;
        Mon, 02 Feb 2009 10:40:17 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 4sm244107qwe.51.2009.02.02.10.40.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 10:40:16 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2.308.gd57ba
In-Reply-To: <76718490902020536g6f4bcee2i76ee046a8dc7d46@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108105>

"git remote rm <repo>" is happy to remove non-remote branches (and their
reflogs). This may be okay if the repository truely is a mirror, but if the
user had done "git remote add --mirror <repo>" by accident and was just
undoing their mistake, then they are left in a situation that is difficult to
recover from.

After this commit, "git remote rm" skips over non-remote branches and instead
advises the user on how to remove such branches using "git branch -d", which
itself has nice safety checks wrt to branch removal lacking from "git remote
rm".

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
This version adds a test case. I also noticed that the check I'd added to
add_branch_for_removal() was generating spurious warnings because I'd added it
in the wrong place; this version moves the check below the
remote_find_tracking() checks.

 builtin-remote.c  |    7 +++++++
 t/t5505-remote.sh |    9 +++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index abc8dd8..571caff 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -323,6 +323,13 @@ static int add_branch_for_removal(const char *refname,
 			return 0;
 	}
 
+	/* don't delete non-remote branches */
+	if (prefixcmp(refname, "refs/remotes")) {
+		warning("not removing non-remote branch; use git branch -d %s to remove",
+			abbrev_branch(refname));
+		return 0;
+	}
+
 	/* make sure that symrefs are deleted */
 	if (flags & REF_ISSYMREF)
 		return unlink(git_path("%s", refname));
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 1f59960..80d40ea 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -107,6 +107,15 @@ test_expect_success 'remove remote' '
 )
 '
 
+test_expect_success 'remove remote protects non-remote branches' '
+(
+	cd test &&
+	git config --add remote.oops.fetch "+refs/*:refs/*" &&
+	git remote rm oops 2>stderr &&
+	grep "not removing non-remote branch.* master " stderr
+)
+'
+
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
-- 
1.6.1.2.308.gd57ba
