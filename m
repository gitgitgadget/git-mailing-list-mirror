Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34CB620135
	for <e@80x24.org>; Wed,  8 Mar 2017 22:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbdCHWdh (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 17:33:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60602 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750849AbdCHWde (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 17:33:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 088337009E;
        Wed,  8 Mar 2017 17:16:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VA6dKmH0lr8XEv6m3rfKm6H80BU=; b=wLYm+U
        slTO2vFl5MSAThjjfRCc0jZicOx4SUr+ztp9qBaP5pPI7FyNmYG6Ie3n6Fa6mihL
        qMJ7XnA8ohVuFW6fbZvv7waBC9awUp+5Ysn20vf9zuijbnwKNs5GEd/HaQIHyfQG
        eCToeOEs5hxaLChXWdneFfsFWMT4yNuPoukzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eVg4PJ40AAbr/XreQqLPUVk9m8YtjpIA
        va3lue1T0Hj84cLvDG8wtDgNbSubs40nEyyvmon6awqCTyNExR9mCuBD0EG08DG6
        BzJefRpSZ8Kml0+S12F5cr4F4oT/pgBCDL9bAuoboB68j0xFi050BVFTLaUqKZFR
        1BvJFy5BeXo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 010187009D;
        Wed,  8 Mar 2017 17:16:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6ABE37009B;
        Wed,  8 Mar 2017 17:16:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Guillaume Wenzek <guillaume.wenzek@gmail.com>
Subject: [PATCH] branch: honor --abbrev/--no-abbrev in --list mode
References: <CAAvNd=ir1qNQVaKphdg51AfGnsNgTrfvW2L6cca3SHiZrWNgHA@mail.gmail.com>
        <xmqqlgsf39fg.fsf@gitster.mtv.corp.google.com>
        <xmqqzigv1lc3.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 08 Mar 2017 14:16:54 -0800
In-Reply-To: <xmqqzigv1lc3.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 08 Mar 2017 13:59:24 -0800")
Message-ID: <xmqqvarj1kix.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0595C98-044C-11E7-BEBF-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "branch --list" command was converted to use the --format
facility from the ref-filter API, we forgot to honor the --abbrev
setting in the default output format and instead used a hardcoded
"7".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with test.  I am building directly this fix on top of
   the kn/ref-filter-branch-test topic that was merged to 'master'
   after 2.12, and haven't checked if there will be conflicts with
   other topics in-flight (I am expecting none, but I do not know
   until I start today's integration cycle).

 builtin/branch.c  | 19 +++++++++++++++----
 t/t3200-branch.sh | 25 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index cbaa6d03c0..537c47811a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -335,9 +335,18 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 		    branch_get_color(BRANCH_COLOR_CURRENT));
 
 	if (filter->verbose) {
+		struct strbuf obname = STRBUF_INIT;
+
+		if (filter->abbrev < 0)
+			strbuf_addf(&obname, "%%(objectname:short)");
+		else if (!filter->abbrev)
+			strbuf_addf(&obname, "%%(objectname)");
+		else
+			strbuf_addf(&obname, " %%(objectname:short=%d) ", filter->abbrev);
+
 		strbuf_addf(&local, "%%(align:%d,left)%%(refname:lstrip=2)%%(end)", maxwidth);
 		strbuf_addf(&local, "%s", branch_get_color(BRANCH_COLOR_RESET));
-		strbuf_addf(&local, " %%(objectname:short=7) ");
+		strbuf_addf(&local, " %s ", obname.buf);
 
 		if (filter->verbose > 1)
 			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
@@ -346,10 +355,12 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 		else
 			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
 
-		strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
-			    "%%(else) %%(objectname:short=7) %%(contents:subject)%%(end)",
+		strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s"
+			    "%%(if)%%(symref)%%(then) -> %%(symref:short)"
+			    "%%(else) %s %%(contents:subject)%%(end)",
 			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth, quote_literal_for_format(remote_prefix),
-			    branch_get_color(BRANCH_COLOR_RESET));
+			    branch_get_color(BRANCH_COLOR_RESET), obname.buf);
+		strbuf_release(&obname);
 	} else {
 		strbuf_addf(&local, "%%(refname:lstrip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
 			    branch_get_color(BRANCH_COLOR_RESET));
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 8a833f354e..39bd5ac8fa 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -207,6 +207,31 @@ test_expect_success 'git branch --list -d t should fail' '
 	test_path_is_missing .git/refs/heads/t
 '
 
+test_expect_success 'git branch --list -v with --abbrev' '
+	test_when_finished "git branch -D t" &&
+	git branch t &&
+	git branch -v --list t >actual.default &&
+	git branch -v --list --abbrev t >actual.abbrev &&
+	test_cmp actual.default actual.abbrev &&
+
+	git branch -v --list --no-abbrev t >actual.noabbrev &&
+	git branch -v --list --abbrev=0 t >actual.0abbrev &&
+	test_cmp actual.noabbrev actual.0abbrev &&
+
+	git branch -v --list --abbrev=36 t >actual.36abbrev &&
+	# how many hexdigits are used?
+	read name objdefault rest <actual.abbrev &&
+	read name obj36 rest <actual.36abbrev &&
+	objfull=$(git rev-parse --verify t) &&
+
+	# are we really getting abbreviations?
+	test "$obj36" != "$objdefault" &&
+	expr "$obj36" : "$objdefault" >/dev/null &&
+	test "$objfull" != "$obj36" &&
+	expr "$objfull" : "$obj36" >/dev/null
+
+'
+
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expected <<\EOF &&
-- 
2.12.0.246.ga2ecc84866-goog

