From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule helper: accept '.' for repositories with no submodules
Date: Tue, 22 Mar 2016 10:59:39 -0700
Message-ID: <1458669579-32160-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, cederp@opera.com
X-From: git-owner@vger.kernel.org Tue Mar 22 19:00:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQav-0007VH-Ca
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbcCVR7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:59:48 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36212 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757109AbcCVR7p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:59:45 -0400
Received: by mail-pf0-f181.google.com with SMTP id u190so321990803pfb.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XACaKXlTdaIdxxmscD/i6m+yb736xc2M3DssQlrpvSY=;
        b=IcBigJTNew/QrBrXlS6VV8bQKL0jJjXTsgt5P3BR3d7LNNPL77pwUD2WkuEA4xPcfR
         zbUzG49IPWsU2pQdyrKVNmHYbrGllzxDSuyxWW4wt3e4GyEmnPIHAsK9Pz8AnjwDW0Vl
         7irOcO3h2+w1QdapxGWoNEDBTkQKKu87wxhQu9UYtl58QYNh9VmHQcDHZJjPp4pzbf9v
         bSnrBdudgPM+NSj+aj22YjL+H03sFBneHHC1I40ghVYHBqdpZhr7VwA99x7ICg4v/k7m
         UV5kTf2Cit6EOIjuEAXDAETeEVu5wW5YMEDWQnQiK/DL09DNkr/ixwM9yS/RVdDAhOaK
         0+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XACaKXlTdaIdxxmscD/i6m+yb736xc2M3DssQlrpvSY=;
        b=KJzFoezKv15vwKMhT0m7O6XgFQgXwkXQeqR+FWiu0l3Xg6Gz7eRQVXdnjkkZhtznvF
         W7P1cLSL2oIolH0/88CJD4Bx5FrouziVs1Yj+OPwzhR7qrkuBrDgt+C5kZONxXCmLhCE
         4lIc5YwC5tWZwIgKB+HAyaP/5+W1DKjTlorvIG2zwT1Y0dR0irMdXjV8VWsX22K3qWxw
         aOf2SOkFVVsixeQpP6o2qh41pYuGUDb/QKq55SRLMxm3ha9mc43EX78IhaD+lgeqr7WS
         njIf8Qb835n5XoqTZnRKqoL2I3Inm8pD5eWiyMkDT+Zcp0bjxcsSs6Mc5YPJ8iW5wtDw
         hFmA==
X-Gm-Message-State: AD7BkJJxWlBGCC39RogPs/yNssRkGWKjgpZnlEUiZrxtl3CCDpCdxsEsdPt1OSOISOiI0I+L
X-Received: by 10.98.34.18 with SMTP id i18mr56082292pfi.26.1458669583879;
        Tue, 22 Mar 2016 10:59:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f1b0:8994:3428:87f7])
        by smtp.gmail.com with ESMTPSA id l4sm34801104pfi.73.2016.03.22.10.59.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 10:59:43 -0700 (PDT)
X-Mailer: git-send-email 2.7.4.1.g33fcf9d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289535>

In 74703a1e4d (2015-09-02, submodule: rewrite `module_list` shell
function in C), "submodule deinit ." was broken.

The original module_list accepted '.' as a pathspec just fine, as it
was using

  git ls-files -z --error-unmatch --stage -- "$@" || { custom filtering}

and git ls-files doesn't make a difference between "." and no arguments
there. When using the parse_pathspec function in C, this is a difference
however, when no path matches.

'submodule deinit' asks users to explicitely to give '.' instead of
empty arguments to specify all submodules (as a safety measure?),
so we have to support that as well.

Add a test case to prevent this error coming up again and fix this
by special casing '.' in the new module_list to reduce the difference
between the old and new module_list.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This applies on v2.7.4
 
 I looked at alternatives of how to fix it, e.g.
 later in module_list to make an exception for calling
        if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
             result = -1;
 but that is similarly ugly.

 builtin/submodule--helper.c |  8 ++++++++
 t/t7400-submodule-basic.sh  | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ed764c9..47e6839 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -23,6 +23,14 @@ static int module_list_compute(int argc, const char **argv,
 {
 	int i, result = 0;
 	char *ps_matched = NULL;
+
+	/*
+	 * We need to treat a path spec of '.' the same as an empty
+	 * path spec, because "submodule deinit" wants to be given '.'
+	 * instead of an empty list.
+	 */
+	if (argc == 1 && !strcmp(".", argv[0]))
+		argv[0] = NULL;
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index be82a75..fdf7105 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -849,6 +849,16 @@ test_expect_success 'set up a second submodule' '
 	git commit -m "submodule example2 added"
 '
 
+test_expect_success 'submodule deinit -f . works on empty repository' '
+	test_when_finished "rm -rf newdirectory" &&
+	mkdir newdirectory &&
+	(
+		cd newdirectory &&
+		git init &&
+		git submodule deinit .
+	)
+'
+
 test_expect_success 'submodule deinit should remove the whole submodule section from .git/config' '
 	git config submodule.example.foo bar &&
 	git config submodule.example2.frotz nitfol &&
-- 
2.7.4.1.g33fcf9d
