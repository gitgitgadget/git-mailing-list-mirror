Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457FB1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 15:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdJXPQo (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 11:16:44 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:57304 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751552AbdJXPQi (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2017 11:16:38 -0400
X-AuditID: 1207440e-bf9ff70000007085-8a-59ef5953986d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.84.28805.3595FE95; Tue, 24 Oct 2017 11:16:36 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCBEA.dip0.t-ipconnect.de [87.188.203.234])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9OFGTow001980
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 24 Oct 2017 11:16:34 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] t1404: add a bunch of tests of D/F conflicts
Date:   Tue, 24 Oct 2017 17:16:24 +0200
Message-Id: <be088bd57e61f4ea0dc974a65829a928ecd30534.1508856679.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1508856679.git.mhagger@alum.mit.edu>
References: <cover.1508856679.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqBsS+T7S4Ok2RYuuK91MFg29V5gt
        bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFJdNSmpOZllqkb5dAlfGrUN9rAX7
        dCs2rJBrYHyk0sXIySEhYCLxdvYP1i5GLg4hgR1MEle2PGeCcE4xSSz+PpsNpIpNQFdiUU8z
        E4gtIqAmMbHtEAuIzSyQItHxvJsRxBYWcJRY8qqfGcRmEVCVuHZjB1icVyBK4kHvfVaIbfIS
        5x7cBqrh4OAUsJD4e00TJCwkYC7x4fJi5gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW
        6Rrr5WaW6KWmlG5ihIQI3w7G9vUyhxgFOBiVeHgbzN9FCrEmlhVX5h5ilORgUhLl/fceKMSX
        lJ9SmZFYnBFfVJqTWnyIUYKDWUmEd4XJ+0gh3pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs
        1NSC1CKYrAwHh5IEb38EUKNgUWp6akVaZk4JQpqJgxNkOA/QcJYwkOHFBYm5xZnpEPlTjPYc
        HTfv/mHi2AQmN3x/ACSfzXzdwCzEkpeflyolznsGZLQASFtGaR7cZFj8v2IUB3pUmPcuSBUP
        MHXAzX4FtJYJaK2s/RuQtSWJCCmpBkbvCy9if9uV3W7mM2i+m2HiKuV3IPrdvPMPkk/5e82w
        n2lX2XYx6H/lCtP3T9Ocsr005lt+nVzH97ZILWXZb+1XDY8Tg+r0nNZ+f5nz8McrtvxZjv8v
        Tp+1I/fng8g1aflSecrrzgaZ/hCPaTTJebiC5d5flpSUXxtimfc6xcg8WL23bnF11EMlluKM
        REMt5qLiRACgHC9d2gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is currently not allowed, in a single transaction, to add one
reference and delete another reference if the two reference names D/F
conflict with each other (e.g., like `refs/foo/bar` and `refs/foo`).
The reason is that the code would need to take locks

    $GIT_DIR/refs/foo.lock
    $GIT_DIR/refs/foo/bar.lock

But the latter lock couldn't coexist with the loose reference file

    $GIT_DIR/refs/foo

, because `$GIT_DIR/refs/foo` cannot be both a directory and a file at
the same time (hence the name "D/F conflict).

Add a bunch of tests that we cleanly reject such transactions.

In fact, many of the new tests currently fail. They will be fixed in
the next commit along with an explanation.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1404-update-ref-errors.sh | 146 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 100d50e362..8b5e9a83c5 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -34,6 +34,86 @@ test_update_rejected () {
 
 Q="'"
 
+# Test adding and deleting D/F-conflicting references in a single
+# transaction.
+df_test() {
+	local prefix="$1"
+	shift
+	local pack=:
+	local symadd=false
+	local symdel=false
+	local add_del=false
+	local addref
+	local delref
+	while test $# -gt 0
+	do
+		case "$1" in
+		--pack)
+			pack="git pack-refs --all"
+			shift
+			;;
+		--sym-add)
+			# Perform the add via a symbolic reference
+			symadd=true
+			shift
+			;;
+		--sym-del)
+			# Perform the del via a symbolic reference
+			symdel=true
+			shift
+			;;
+		--del-add)
+			# Delete first reference then add second
+			add_del=false
+			delref="$prefix/r/$2"
+			addref="$prefix/r/$3"
+			shift 3
+			;;
+		--add-del)
+			# Add first reference then delete second
+			add_del=true
+			addref="$prefix/r/$2"
+			delref="$prefix/r/$3"
+			shift 3
+			;;
+		*)
+			echo 1>&2 "Extra args to df_test: $*"
+			return 1
+			;;
+		esac
+	done
+	git update-ref "$delref" $C &&
+	if $symadd
+	then
+		addname="$prefix/s/symadd" &&
+		git symbolic-ref "$addname" "$addref"
+	else
+		addname="$addref"
+	fi &&
+	if $symdel
+	then
+		delname="$prefix/s/symdel" &&
+		git symbolic-ref "$delname" "$delref"
+	else
+		delname="$delref"
+	fi &&
+	cat >expected-err <<-EOF &&
+	fatal: cannot lock ref $Q$addname$Q: $Q$delref$Q exists; cannot create $Q$addref$Q
+	EOF
+	$pack &&
+	if $add_del
+	then
+		printf "%s\n" "create $addname $D" "delete $delname"
+	else
+		printf "%s\n" "delete $delname" "create $addname $D"
+	fi >commands &&
+	test_must_fail git update-ref --stdin <commands 2>output.err &&
+	test_cmp expected-err output.err &&
+	printf "%s\n" "$C $delref" >expected-refs &&
+	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
+	test_cmp expected-refs actual-refs
+}
+
 test_expect_success 'setup' '
 
 	git commit --allow-empty -m Initial &&
@@ -188,6 +268,72 @@ test_expect_success 'empty directory should not fool 1-arg delete' '
 	git update-ref --stdin
 '
 
+test_expect_success 'D/F conflict prevents add long + delete short' '
+	df_test refs/df-al-ds --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents add short + delete long' '
+	df_test refs/df-as-dl --add-del foo foo/bar
+'
+
+test_expect_failure 'D/F conflict prevents delete long + add short' '
+	df_test refs/df-dl-as --del-add foo/bar foo
+'
+
+test_expect_failure 'D/F conflict prevents delete short + add long' '
+	df_test refs/df-ds-al --del-add foo foo/bar
+'
+
+test_expect_success 'D/F conflict prevents add long + delete short packed' '
+	df_test refs/df-al-dsp --pack --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents add short + delete long packed' '
+	df_test refs/df-as-dlp --pack --add-del foo foo/bar
+'
+
+test_expect_failure 'D/F conflict prevents delete long packed + add short' '
+	df_test refs/df-dlp-as --pack --del-add foo/bar foo
+'
+
+test_expect_failure 'D/F conflict prevents delete short packed + add long' '
+	df_test refs/df-dsp-al --pack --del-add foo foo/bar
+'
+
+# Try some combinations involving symbolic refs...
+
+test_expect_failure 'D/F conflict prevents indirect add long + delete short' '
+	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents indirect add long + indirect delete short' '
+	df_test refs/df-ial-ids --sym-add --sym-del --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents indirect add short + indirect delete long' '
+	df_test refs/df-ias-idl --sym-add --sym-del --add-del foo foo/bar
+'
+
+test_expect_failure 'D/F conflict prevents indirect delete long + indirect add short' '
+	df_test refs/df-idl-ias --sym-add --sym-del --del-add foo/bar foo
+'
+
+test_expect_failure 'D/F conflict prevents indirect add long + delete short packed' '
+	df_test refs/df-ial-dsp --sym-add --pack --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents indirect add long + indirect delete short packed' '
+	df_test refs/df-ial-idsp --sym-add --sym-del --pack --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents add long + indirect delete short packed' '
+	df_test refs/df-al-idsp --sym-del --pack --add-del foo/bar foo
+'
+
+test_expect_failure 'D/F conflict prevents indirect delete long packed + indirect add short' '
+	df_test refs/df-idlp-ias --sym-add --sym-del --pack --del-add foo/bar foo
+'
+
 # Test various errors when reading the old values of references...
 
 test_expect_success 'missing old value blocks update' '
-- 
2.14.1

