Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A207E2079E
	for <e@80x24.org>; Sun, 15 Jan 2017 18:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbdAOSbA (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 13:31:00 -0500
Received: from sauhun.de ([89.238.76.85]:46516 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751174AbdAOSbA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 13:31:00 -0500
Received: from localhost (p54B33795.dip0.t-ipconnect.de [84.179.55.149])
        by pokefinder.org (Postfix) with ESMTPSA id A246231C094;
        Sun, 15 Jan 2017 19:30:57 +0100 (CET)
From:   Wolfram Sang <wsa@the-dreams.de>
To:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC for GIT] pull-request: add praise to people doing QA
Date:   Sun, 15 Jan 2017 19:30:51 +0100
Message-Id: <20170115183051.3565-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asking for opinions on lkml and git...

Getting enough quality assurance is likely one of the bigger upcoming tasks in
the near future. To improve the situation, praise the people already doing that
by adding their names to pull requests in the same manner that patch authors
are credited. Here is an example, I sent out today [1]:

=== old stuff

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

...

Vlad Tsyrklevich (1):
      i2c: fix kernel memory disclosure in dev interface

=== new stuff starts here

with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (1):
      (Rev.) i2c: piix4: Avoid race conditions with IMC

Benjamin Tissoires (1):
      (Test) i2c: do not enable fall back to Host Notify by default

Vladimir Zapolskiy (1):
      (Rev.) i2c: print correct device invalid address

=== diffstat, ...

This patch is a very early RFC to collect opinions. I am not very familiar with
the git codebase, but I guess using a filter needs to be reworked, the
dependency on GNU awk may be frowned upon (though 'asorti' is really useful
here), the reg-ex are not super-solid, and it should be a command-line option,
of course. That all being said, it was a fast way to produce what I would like
to add to my pull requests for the i2c subsystem and to see if other kernel/git
maintainers are interested in something like this.

Disclaimer: while this patch applies to the git codebase, I have to admit that
I simply patched around in /usr/lib/git-core of my Debian machine :)

So much for now, let me know what you think,

   Wolfram

[1] http://lkml.org/lkml/2017/1/15/55

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 git-praise-qa.awk   |   33 +++++++++++++++++++++++++++++++++
 git-request-pull.sh |    1 +
 2 files changed, 34 insertions(+)

Index: git-2.11.0/git-request-pull.sh
===================================================================
--- git-2.11.0.orig/git-request-pull.sh
+++ git-2.11.0/git-request-pull.sh
@@ -155,6 +155,7 @@ then
 fi &&
 
 git shortlog ^$baserev $headrev &&
+git log --no-merges ^$baserev $headrev | git-praise-qa.awk &&
 git diff -M --stat --summary $patch $merge_base..$headrev || status=1
 
 exit $status
Index: git-2.11.0/git-praise-qa.awk
===================================================================
--- /dev/null
+++ git-2.11.0/git-praise-qa.awk
@@ -0,0 +1,33 @@
+#! /usr/bin/gawk -f
+
+# New commit found, empty subject variable
+/^commit / { subject = "" }
+
+# Grab the subject line
+!subject && /^    / { subject = substr($0, 5); }
+
+# Scan for tags and get the type
+/^    Reviewed-by:/ { type = "Rev." }
+/^    Tested-by:/ { type = "Test" }
+
+type && subject {
+	# Extract the name
+	sub(/^.*: /, ""); sub(/ <.*/, ""); name = $0;
+	# Collect tags given by 'name'
+	tags[name] = tags[name] "      (" type ") " subject "\n";
+	count[name]++;
+	# Done, clear flag
+	type = "";
+}
+
+END {
+	print "\nwith much appreciated quality assurance from"
+	print "----------------------------------------------------------------"
+	# Sort by names
+	asorti(tags, sorted_names);
+	# printout in git style
+	for (i in sorted_names) {
+		name = sorted_names[i];
+		print name " (" count[name] "):" "\n" tags[name];
+	}
+}
