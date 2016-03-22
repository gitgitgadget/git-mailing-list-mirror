From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: Fix regression for deinit without submodules
Date: Tue, 22 Mar 2016 16:42:14 -0700
Message-ID: <1458690134-538-1-git-send-email-sbeller@google.com>
Cc: cederp@opera.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 23 00:42:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiVwN-0007iU-8q
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 00:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbcCVXmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 19:42:20 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32872 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbcCVXmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 19:42:18 -0400
Received: by mail-pf0-f178.google.com with SMTP id 4so199730037pfd.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 16:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Do0id7EjBNvx/vr7mcSj+fP9hlkxYFaLeHiXMVLG0LA=;
        b=fiuLkqqG/g+YZ45rd1bifLcuEphN/hKlniydWeLLl+OX1R2m2IBq+iAGvKJA04ELck
         jv+j6v8e9iHYjfOYBH0cTVIxNojMH+b2tV9NisF/Jgea19VK+bNztBjoDHWiPxwaJCYq
         DBrQfi0v4JnedDd829R6BGZUmyJhTMQJ1re+VCBOn+lW+jN7L2kTNZnm2kPp6bo9KYG+
         KDuywxkpWLbJerLSnEeUPIvKNlld0jpskVa8/PLOvJ2IS9MjV1QaWdxwFidEG4ZrZR0M
         TZSwzOLFGb2ByhtEgnku1jgaYsexv067nv5k/KpaTDolNw0H5hprp+ptJp36IMFYIS17
         jYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Do0id7EjBNvx/vr7mcSj+fP9hlkxYFaLeHiXMVLG0LA=;
        b=azZGqpeuIt8hVZdjj8vHttnTEN7Ud5Qo14cDoK72DaOkQVJuXKcQp1mKgDIOfRV4tj
         DpWfyhNdNc4f1i2/ky4XdO5IHX8TtahuUc0N8hrjRaSM+eQXW0YLAoeA94urqVpFeoQz
         QDsNhR9WV7PYY3aytSs/7goIr6PnLeld/MvfnooQLkppWH8leD2OepY9wzOaxCcGJ46X
         1Oac2hvAvl2bLlZrN/wQTJwOaWqC71kCp1JIoqCgqruAlruW0xYlm+kg0Vg9Yb22oEfN
         0FlaY1qa+SaYC+T5QbMW3GSTZoiNDu5NMafctFigVpQnUwHUTPIU2fNc9XFJ7ipzOqHa
         gSDg==
X-Gm-Message-State: AD7BkJL4F0wmEtek0ryntl9sm7ycXXRL0Hhu/hZ8g4Ytmy+ttH7q1jQPcZYa7ipEsMM9d7Hq
X-Received: by 10.98.86.146 with SMTP id h18mr58352426pfj.9.1458690137629;
        Tue, 22 Mar 2016 16:42:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f1b0:8994:3428:87f7])
        by smtp.gmail.com with ESMTPSA id y7sm44761076pfa.82.2016.03.22.16.42.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 16:42:16 -0700 (PDT)
X-Mailer: git-send-email 2.7.4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289587>

Per Cederqvist wrote:
> It used to be possible to run
>
>    git submodule deinit -f .
>
> to remove any submodules, no matter how many submodules you had.  That
> is no longer possible in projects that don't have any submodules at
> all.  The command will fail with:
>
>     error: pathspec '.' did not match any file(s) known to git.

This regression was introduced in 74703a1e4dfc (submodule: rewrite
`module_list` shell function in C, 2015-09-02), as we optimized
the new module listing for performance by first checking whether it is
a git link instead of feeding it to match_pathspec.

By switching these two commands we get the same behavior as before,
i.e. in an empty repository this still breaks, but if there are files
but no submodules this works.

By reversing the order we also revert an accidental feature. If you had
a README file in a repository, you could do

    git submodule deinit "READM*"

and it would report that there is no submodule matching the "READM*"
path spec.

Reported-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Ok, let's try again. This is what I understand is the best bugfix for
 2.8 and below. (This patch was developed on top of 2.7.4)
 
 As discussed we want to have a better solution in the future, which
 may included having the --unmatch-ok flag, but that is not in the scope
 for now.
 
 Thanks,
 Stefan


 builtin/submodule--helper.c |  6 +++---
 t/t7400-submodule-basic.sh  | 13 +++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ed764c9..5295b72 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -37,9 +37,9 @@ static int module_list_compute(int argc, const char **argv,
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
-		if (!S_ISGITLINK(ce->ce_mode) ||
-		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
-				    0, ps_matched, 1))
+		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
+				    0, ps_matched, 1) ||
+		    !S_ISGITLINK(ce->ce_mode))
 			continue;
 
 		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index be82a75..e1abd19 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -849,6 +849,19 @@ test_expect_success 'set up a second submodule' '
 	git commit -m "submodule example2 added"
 '
 
+test_expect_success 'submodule deinit works on repository without submodules' '
+	test_when_finished "rm -rf newdirectory" &&
+	mkdir newdirectory &&
+	(
+		cd newdirectory &&
+		git init &&
+		>file &&
+		git add file &&
+		git commit -m "repo should not be empty"
+		git submodule deinit .
+	)
+'
+
 test_expect_success 'submodule deinit should remove the whole submodule section from .git/config' '
 	git config submodule.example.foo bar &&
 	git config submodule.example2.frotz nitfol &&
-- 
2.7.4.dirty
