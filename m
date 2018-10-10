Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9364E1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 11:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJJSfs (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 14:35:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44768 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJSfs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 14:35:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so4533030edb.11
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 04:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AA5hpRie/BRqmg+0sooMQi33vRD4ndgbLKkWgv3hqDE=;
        b=IZWTpfjyDlyOmSruMB0WMpmu3sMeGA594oSVMyLzrPRCovf+/sl7V/npqQtg9cJfzy
         noqrg+BrbEDDtc/sj8AmAPzkuwk+fAqAsAmJ/3WGovWpCm6vAeM5ZPxpgHIdSygEWSB+
         yOxN9i+Z8MpC7gdtgCo3qFqcB38G2YSbRZV5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AA5hpRie/BRqmg+0sooMQi33vRD4ndgbLKkWgv3hqDE=;
        b=nFeIMK197Xssu1IoDmwXh5TbwOW8SedG4Om0svYXdAQjUCkp7earxamZFDYGkmM5Es
         f0tKZcJO7aXPcaW7Fy5hsLhP10OpdFGSFD8j/FdLCa4CPg8UVfkqt+Dj4fqDyqE+mIHG
         wQDTE68DxO/+SxSEJ4fYUszoFDCdPSHQaUAAaHo2pk1l/cHmwfz57/7s9RBgp8OWJsBL
         vfsV0VpAmW+AYyn9dHmTNuZDjTZ7ThQPJKamagYnaursGxkcWPGw7XQ9re7gAj8KPScL
         fl6qowMcNWMKP29fWKazplnLHDN2lTWQ1BR2ajZudQEvL62FMIj+n5VD77CwXMt4Jof8
         H7PA==
X-Gm-Message-State: ABuFfoh0sE48SK3yYmnPq4tg22s+PKRUfHax5s6BYJIwfyvSevEIkG2H
        SsCJ3IUN5yeaOo0XNGVPTA8ZL7ZUrbY=
X-Google-Smtp-Source: ACcGV625100DLcX6aqd05VJPmk7sOaRubXt/TrAos7Ttp1pRZ/qlmPtyxx9pC7oFaLA9rlyPXXxVUQ==
X-Received: by 2002:a50:87c5:: with SMTP id 5-v6mr39669410edz.89.1539170047288;
        Wed, 10 Oct 2018 04:14:07 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id e10-v6sm4154596ejl.25.2018.10.10.04.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 04:14:06 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 2/3] send-email: only consider lines containing @ or <> for automatic Cc'ing
Date:   Wed, 10 Oct 2018 13:13:50 +0200
Message-Id: <20181010111351.5045-3-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.g084f1d7761
In-Reply-To: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the address sanitizations routines do accept local addresses, that
is almost never what is meant in a Cc or Signed-off-by trailer.

Looking through all the signed-off-by lines in the linux kernel tree
without a @, there are mostly two patterns: Either just a full name, or
a full name followed by <user at domain.com> (i.e., with the word at
instead of a @), and minor variations. For cc lines, the same patterns
appear, along with lots of "cc stable" variations that do not actually
name stable@vger.kernel.org

  Cc: stable # introduced pre-git times
  cc: stable.kernel.org

In the <user at domain.com> cases, one gets a chance to interactively
fix it. But when there is no <> pair, it seems we end up just using the
first word as a (local) address.

As the number of cases where a local address really was meant is
likely (and anecdotally) quite small compared to the number of cases
where we end up cc'ing a garbage address, insist on at least a @ or a <>
pair being present.

This is also preparation for the next patch, where we are likely to
encounter even more non-addresses in -by lines, such as

  Reported-by: Coverity
  Patch-generated-by: Coccinelle

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 git-send-email.perl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2be5dac337..1916159d2a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1694,6 +1694,11 @@ sub process_file {
 				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
 				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
 			}
+			if ($c !~ /.+@.+|<.+>/) {
+				printf("(body) Ignoring %s from line '%s'\n",
+					$what, $_) unless $quiet;
+				next;
+			}
 			push @cc, $c;
 			printf(__("(body) Adding cc: %s from line '%s'\n"),
 				$c, $_) unless $quiet;
-- 
2.19.1.6.g084f1d7761

