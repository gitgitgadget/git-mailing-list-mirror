Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B4E1F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfHZBoR (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58318 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729098AbfHZBoQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:16 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE6ED60FDE;
        Mon, 26 Aug 2019 01:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783854;
        bh=Z96NRj1jnqLTFdTVW5eJzqCq7iz3sJC1LVPXkDr4V1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=L6N07+3+ndDEPy5YuQRRei4hOW7bGPb5tvSXRzbkfW/CH8xtoI3SSCRZubTlThr2h
         /R6G0ReQL8c/n1ABWMjxxmZaE9ki1J0n0revKAZhF95oNJoTnNpePHF679kiBKRkDx
         dBI4EbTIznXd13q9tNgqODMeUKfKloME78hYsb8JjEx0SQQFX6EZDG5qVw2BQ2sof1
         81yahXd3hQobhWtWQGEP8/X54uYwlbpr0KjX+8HOvmwOG6BHtjQ1Kdx93XOLu+hwCD
         86+zQtew77n22JEkeEckX7PodxESj7vL8xB+i5RJOQ7WHEHKWi0T87MFQAn1MCG2JJ
         ARFHCO9ZDHcZsys86eQY5X6n7KOEZQXjCfwOuonpzznQfr1pV9tDs3rzOtIBrKEqrJ
         AhrKLFuo10LaLDXrM0wlJJ6HjKxZnF4q5kW5N7IBS0Lnm6ilMn0TX77Z/Q2Cmg/RAJ
         XrbizCjHNjUKkC4G3Zf8Ma4xlJ7i83y7bm27CMbY7jPWn7PVM4t
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 10/14] t3800: make hash-size independent
Date:   Mon, 26 Aug 2019 01:43:40 +0000
Message-Id: <20190826014344.16008-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190826014344.16008-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190826014344.16008-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace references to several hard-coded object IDs with a variable
referring to the generated commit.  Avoid matching on exact character
positions, which will be different depending on the hash in use.  In the
test for a valid object ID, use an obviously invalid one from the lookup
table.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3800-mktag.sh | 49 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 8eb47942e2..64dcc5ec28 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -23,6 +23,7 @@ check_verify_failure () {
 # first create a commit, so we have a valid object/type
 # for the tag.
 test_expect_success 'setup' '
+	test_oid_init &&
 	echo Hello >A &&
 	git update-index --add A &&
 	git commit -m "Initial commit" &&
@@ -69,28 +70,28 @@ check_verify_failure '"object" line SHA1 check' '^error: char7: .*SHA1 hash$'
 #  4. type line label check
 
 cat >tag.sig <<EOF
-object 779e9b33986b1c2670fff52c5067603117b3e895
+object $head
 xxxx tag
 tag mytag
 tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure '"type" line label check' '^error: char47: .*"\\ntype "$'
+check_verify_failure '"type" line label check' '^error: char.*: .*"\\ntype "$'
 
 ############################################################
 #  5. type line eol check
 
-echo "object 779e9b33986b1c2670fff52c5067603117b3e895" >tag.sig
+echo "object $head" >tag.sig
 printf "type tagsssssssssssssssssssssssssssssss" >>tag.sig
 
-check_verify_failure '"type" line eol check' '^error: char48: .*"\\n"$'
+check_verify_failure '"type" line eol check' '^error: char.*: .*"\\n"$'
 
 ############################################################
 #  6. tag line label check #1
 
 cat >tag.sig <<EOF
-object 779e9b33986b1c2670fff52c5067603117b3e895
+object $head
 type tag
 xxx mytag
 tagger . <> 0 +0000
@@ -98,37 +99,37 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure '"tag" line label check #1' \
-	'^error: char57: no "tag " found$'
+	'^error: char.*: no "tag " found$'
 
 ############################################################
 #  7. tag line label check #2
 
 cat >tag.sig <<EOF
-object 779e9b33986b1c2670fff52c5067603117b3e895
+object $head
 type taggggggggggggggggggggggggggggggg
 tag
 EOF
 
 check_verify_failure '"tag" line label check #2' \
-	'^error: char87: no "tag " found$'
+	'^error: char.*: no "tag " found$'
 
 ############################################################
 #  8. type line type-name length check
 
 cat >tag.sig <<EOF
-object 779e9b33986b1c2670fff52c5067603117b3e895
+object $head
 type taggggggggggggggggggggggggggggggg
 tag mytag
 EOF
 
 check_verify_failure '"type" line type-name length check' \
-	'^error: char53: type too long$'
+	'^error: char.*: type too long$'
 
 ############################################################
 #  9. verify object (SHA1/type) check
 
 cat >tag.sig <<EOF
-object 779e9b33986b1c2670fff52c5067603117b3e895
+object $(test_oid deadbeef)
 type tagggg
 tag mytag
 tagger . <> 0 +0000
@@ -150,7 +151,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify tag-name check' \
-	'^error: char67: could not verify tag name$'
+	'^error: char.*: could not verify tag name$'
 
 ############################################################
 # 11. tagger line label check #1
@@ -164,7 +165,7 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #1' \
-	'^error: char70: could not find "tagger "$'
+	'^error: char.*: could not find "tagger "$'
 
 ############################################################
 # 12. tagger line label check #2
@@ -179,7 +180,7 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #2' \
-	'^error: char70: could not find "tagger "$'
+	'^error: char.*: could not find "tagger "$'
 
 ############################################################
 # 13. disallow missing tag author name
@@ -194,7 +195,7 @@ This is filler
 EOF
 
 check_verify_failure 'disallow missing tag author name' \
-	'^error: char77: missing tagger name$'
+	'^error: char.*: missing tagger name$'
 
 ############################################################
 # 14. disallow missing tag author name
@@ -209,7 +210,7 @@ tagger T A Gger <
 EOF
 
 check_verify_failure 'disallow malformed tagger' \
-	'^error: char77: malformed tagger field$'
+	'^error: char.*: malformed tagger field$'
 
 ############################################################
 # 15. allow empty tag email
@@ -238,7 +239,7 @@ tagger T A Gger <tag ger@example.com> 0 +0000
 EOF
 
 check_verify_failure 'disallow spaces in tag email' \
-	'^error: char77: malformed tagger field$'
+	'^error: char.*: malformed tagger field$'
 
 ############################################################
 # 17. disallow missing tag timestamp
@@ -252,7 +253,7 @@ tagger T A Gger <tagger@example.com>__
 EOF
 
 check_verify_failure 'disallow missing tag timestamp' \
-	'^error: char107: missing tag timestamp$'
+	'^error: char.*: missing tag timestamp$'
 
 ############################################################
 # 18. detect invalid tag timestamp1
@@ -266,7 +267,7 @@ tagger T A Gger <tagger@example.com> Tue Mar 25 15:47:44 2008
 EOF
 
 check_verify_failure 'detect invalid tag timestamp1' \
-	'^error: char107: missing tag timestamp$'
+	'^error: char.*: missing tag timestamp$'
 
 ############################################################
 # 19. detect invalid tag timestamp2
@@ -280,7 +281,7 @@ tagger T A Gger <tagger@example.com> 2008-03-31T12:20:15-0500
 EOF
 
 check_verify_failure 'detect invalid tag timestamp2' \
-	'^error: char111: malformed tag timestamp$'
+	'^error: char.*: malformed tag timestamp$'
 
 ############################################################
 # 20. detect invalid tag timezone1
@@ -294,7 +295,7 @@ tagger T A Gger <tagger@example.com> 1206478233 GMT
 EOF
 
 check_verify_failure 'detect invalid tag timezone1' \
-	'^error: char118: malformed tag timezone$'
+	'^error: char.*: malformed tag timezone$'
 
 ############################################################
 # 21. detect invalid tag timezone2
@@ -308,7 +309,7 @@ tagger T A Gger <tagger@example.com> 1206478233 +  30
 EOF
 
 check_verify_failure 'detect invalid tag timezone2' \
-	'^error: char118: malformed tag timezone$'
+	'^error: char.*: malformed tag timezone$'
 
 ############################################################
 # 22. detect invalid tag timezone3
@@ -322,7 +323,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -1430
 EOF
 
 check_verify_failure 'detect invalid tag timezone3' \
-	'^error: char118: malformed tag timezone$'
+	'^error: char.*: malformed tag timezone$'
 
 ############################################################
 # 23. detect invalid header entry
@@ -337,7 +338,7 @@ this line should not be here
 EOF
 
 check_verify_failure 'detect invalid header entry' \
-	'^error: char124: trailing garbage in tag header$'
+	'^error: char.*: trailing garbage in tag header$'
 
 ############################################################
 # 24. create valid tag
