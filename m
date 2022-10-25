Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173EAC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 05:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJYFNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 01:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJYFMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 01:12:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FF2103DB5
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 22:12:54 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02AB7154EA8;
        Tue, 25 Oct 2022 01:12:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QkQaLiNWlUaqfzdrmXrtZAEQImZCgSVQ7s62ag
        aGqZE=; b=pRGf7FbiXEwzgweq+pnUD3PWpDLggVUUx8ZlHivykcXz4RHHCE63ia
        r45kSSyqkwgr1+2NrXdwLEmVHPhRdbK99pC5LnU5VSsD26oCErdKGQ2kPifwDjPm
        +GcqL04ez3p07DExPTOy1hr/c4p/5iM95MQh3iP0CJS+drymJb8sE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDFB8154EA7;
        Tue, 25 Oct 2022 01:12:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EE16154EA6;
        Tue, 25 Oct 2022 01:12:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: [PATCH] Documentation: add lint-fsck-msgids
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
        <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
        <xmqqwn8oplsh.fsf@gitster.g>
Date:   Mon, 24 Oct 2022 22:12:51 -0700
In-Reply-To: <xmqqwn8oplsh.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        24 Oct 2022 21:30:38 -0700")
Message-ID: <xmqqa65kpju4.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD2856D6-5423-11ED-8CA5-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the initial development of the fsck-msgids.txt feature, it
has become apparent that it is very much error prone to make sure
the description in the documentation file are sorted and correctly
match what is in the fsck.h header file.

Add a quick-and-dirty Perl script and doc-lint target to sanity
check that the fsck-msgids.txt is consistent with the error type
list in the fsck.h header file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So the quick-and-dirty one gets repackaged with minimum polish to
   become such a lint-doc checker.  With the MISSING_TREE_OBJECT
   removed from fsck.h header, and the fixes to the msgids.txt
   documentation applied, the result passes the check.

 Documentation/Makefile              | 11 +++++
 Documentation/lint-fsck-msgids.perl | 70 +++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100755 Documentation/lint-fsck-msgids.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d47acb2e25..5e1a7f655c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -476,8 +476,19 @@ $(LINT_DOCS_MAN_SECTION_ORDER): .build/lint-docs/man-section-order/%.ok: %.txt
 .PHONY: lint-docs-man-section-order
 lint-docs-man-section-order: $(LINT_DOCS_MAN_SECTION_ORDER)
 
+.PHONY: lint-docs-fsck-msgids
+LINT_DOCS_FSCK_MSGIDS = .build/lint-docs/fsck-msgids.ok
+$(LINT_DOCS_FSCK_MSGIDS): lint-fsck-msgids.perl
+$(LINT_DOCS_FSCK_MSGIDS): ../fsck.h fsck-msgids.txt
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)$(PERL_PATH) lint-fsck-msgids.perl \
+		../fsck.h fsck-msgids.txt $@
+
+lint-docs-fsck-msgids: $(LINT_DOCS_FSCK_MSGIDS)
+
 ## Lint: list of targets above
 .PHONY: lint-docs
+lint-docs: lint-docs-fsck-msgids
 lint-docs: lint-docs-gitlink
 lint-docs: lint-docs-man-end-blurb
 lint-docs: lint-docs-man-section-order
diff --git a/Documentation/lint-fsck-msgids.perl b/Documentation/lint-fsck-msgids.perl
new file mode 100755
index 0000000000..1233ffe815
--- /dev/null
+++ b/Documentation/lint-fsck-msgids.perl
@@ -0,0 +1,70 @@
+#!/usr/bin/perl
+
+my ($fsck_h, $fsck_msgids_txt, $okfile) = @ARGV;
+
+my (%in_fsck_h, $fh, $bad);
+
+open($fh, "<", "$fsck_h") or die;
+while (<$fh>) {
+	if (/^\s+FUNC\(([0-9A-Z_]+), ([A-Z]+)\)/) {
+		my ($name, $severity) = ($1, $2);
+		my ($first) = 1;
+		$name = join('',
+			     map {
+				     y/A-Z/a-z/;
+				     if (!$first) {
+					     s/^(.)/uc($1)/e;
+				     } else {
+					     $first = 0;
+				     }
+				     $_;
+			     }
+			     split(/_/, $name));
+		$in_fsck_h{$name} = $severity;
+	}
+}
+close($fh);
+
+open($fh, "<", "$fsck_msgids_txt") or die;
+my ($previous, $current);
+while (<$fh>) {
+	if (!defined $current) {
+		if (/^\`([a-zA-Z0-9]*)\`::/) {
+			$current = $1;
+			if ((defined $previous) &&
+			    ($current le $previous)) {
+				print STDERR "$previous >= $current in doc\n";
+				$bad = 1;
+			}
+		}
+	} elsif (/^\s+\(([A-Z]+)\) /) {
+		my ($level) = $1;
+		if (!exists $in_fsck_h{$current}) {
+			print STDERR "$current does not exist in fsck.h\n";
+			$bad = 1;
+		} elsif ($in_fsck_h{$current} eq "") {
+			print STDERR "$current defined twice\n";
+			$bad = 1;
+		} elsif ($in_fsck_h{$current} ne $level) {
+			print STDERR "$current severity $level != $in_fsck_h{$current}\n";
+			$bad = 1;
+		}
+		$previous = $current;
+		$in_fsck_h{$current} = ""; # mark as seen.
+		undef $current;
+	}
+}
+close($fh);
+
+for my $key (keys %in_fsck_h) {
+	if ($in_fsck_h{$key} ne "") {
+		print STDERR "$key not explained in doc.\n";
+		$bad = 1;
+	}
+}
+
+die if ($bad);
+
+open($fh, ">", "$okfile");
+print $fh "good\n";
+close($fh);
-- 
2.38.1-359-g84c4c6d5a5

