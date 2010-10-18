From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] reset: accept "git reset <removed file>"
Date: Mon, 18 Oct 2010 17:48:40 -0500
Message-ID: <20101018224840.GA9729@burratino>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <20101018211522.GA7655@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 00:52:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7yZD-0000Xq-SM
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 00:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab0JRWwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 18:52:25 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59986 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab0JRWwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 18:52:25 -0400
Received: by qwa26 with SMTP id 26so1085971qwa.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 15:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YBUVkU0c/D3cScN/JKZHSn7kEGjxX9JGbZ3NEf4jxzg=;
        b=myXYcq2P3LlKX/iPheVDrWvEl0a3TowD9TwhYM7RUW2n/xix42hZIn89EMZmxsY58w
         itO3XfuZm3FvbXGDEIvyNw8XpQ6Fu7BOMzOFKsfkBW2KpxzfiSPRooPRjOEnQxXdTlVG
         soA/FngKTTbijoAtlc8CricWiNG+7MlAIjn/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=et7expu3PBEdyDyP7rCAQ3AJuVSGKPaC+2MG3Qd2B6aF8htn0IID8DPykzyFIrUDza
         QdtpChaShdOlXOf8lAwkM1g6PGdCKxLVbq/UM7tp+5ev2aR3qwJmMMHRhbGQlNXOPIYy
         U5DplBQe6ySFuDdJw7CU8pPds/khLI88wiWUs=
Received: by 10.229.238.200 with SMTP id kt8mr4439286qcb.0.1287442344106;
        Mon, 18 Oct 2010 15:52:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id mz11sm12406463qcb.39.2010.10.18.15.52.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 15:52:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018211522.GA7655@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159294>

Suppose I try to use "git reset" to un-add an new, unwanted file:

	echo hello >foo.c
	git add foo.c
	rm foo.c; # bad file! bad!
	git reset foo.c

The file foo.c does not exist on disk, so "git reset" rejects the
request with

	fatal: ambiguous argument 'foo.c': unknown revision or path not in the working tree.
	Use '--' to separate paths from revisions

Git can do better: since foo.c is not a revision and has an entry in
the index, it is clear the request refers to a path and not a rev.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> Ah, this is a kind of obnoxious thing!  For a newly added file,
>
> 	git reset -- <path>
>
> ought to un-add it, but it doesn't.

Err, yes it does.  Probably I was thinking of

	rm <path>
	git reset <path>

producing an "ambiguous argument" message.

 builtin/reset.c  |    8 +++++++-
 t/t7102-reset.sh |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 0037be4..7d23d75 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -295,7 +295,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			rev = argv[i++];
 		} else {
 			/* Otherwise we treat this as a filename */
-			verify_filename(prefix, argv[i]);
+			const char *name = argv[i];
+			if (prefix)
+				name = prefix_filename(prefix, strlen(prefix), name);
+			if (read_cache() < 0)
+				die("Could not read index");
+			if (cache_name_pos(name, strlen(name)) < 0)
+				verify_filename(prefix, argv[i]);
 		}
 	}
 
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index b8cf260..69d125e 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -5,7 +5,7 @@
 
 test_description='git reset
 
-Documented tests for git reset'
+Miscellaneous tests for git reset'
 
 . ./test-lib.sh
 
@@ -441,6 +441,15 @@ test_expect_success 'disambiguation (1)' '
 
 '
 
+test_expect_success "disambiguation (1')" '
+
+	git reset --hard &&
+	git reset secondfile &&
+	git diff --exit-code &&
+	git diff --cached --exit-code
+
+'
+
 test_expect_success 'disambiguation (2)' '
 
 	git reset --hard &&
@@ -448,11 +457,18 @@ test_expect_success 'disambiguation (2)' '
 	git add secondfile &&
 	rm -f secondfile &&
 	test_must_fail git reset secondfile &&
-	test -n "$(git diff --cached --name-only -- secondfile)" &&
+	test -z "$(git diff --cached --name-only)" &&
 	test ! -f secondfile
 
 '
 
+test_expect_success "disambiguation (2')" '
+
+	git reset --hard &&
+	test_must_fail git reset doesnotexist
+
+'
+
 test_expect_success 'disambiguation (3)' '
 
 	git reset --hard &&
@@ -465,6 +481,13 @@ test_expect_success 'disambiguation (3)' '
 
 '
 
+test_expect_success "disambiguation (3')" '
+
+	git reset --hard &&
+	git reset HEAD doesnotexist
+
+'
+
 test_expect_success 'disambiguation (4)' '
 
 	git reset --hard &&
@@ -476,4 +499,11 @@ test_expect_success 'disambiguation (4)' '
 	test ! -f secondfile
 '
 
+test_expect_success "disambiguation (4')" '
+
+	git reset --hard &&
+	git reset -- doesnotexist
+
+'
+
 test_done
-- 
1.7.2.3
