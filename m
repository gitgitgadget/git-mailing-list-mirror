Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B065C
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718328058; cv=none; b=I3HwnAHZtk/9lU1GudSwvXBHaezq6we3Cbob2db+OOscvWrSCQF4oojNiDtyTjsHtjzg/HMXTRUt7YCm2jo+X9HhlD/L/vNwsv6eA4NEd/n7rNnCiUb5QHVnvNfP0EfIZOVpjTadXZAM9CbaQoxOnmw/4lZDyw88o5k1uMYGbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718328058; c=relaxed/simple;
	bh=faZqjxy9KoCjVl1iBizteN2GTyMyKh/ZdBLVjh+pRco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n+kqHigSFp1gPSP1q6Et+fe0u+4urcAOffaYj+xDFzsyKC6CsS1c9sXsKvQZmgIVx1sHObkvNgYTYkLrW2tHB87BUi+dsJpuF8qOoOEcXHb2aueZpdaDkRQ/qeGQj+JgdHco+71+QzgpZgks7oQEUVSFDSdDETAw0/mjt1v/gXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xYDlOpku; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xYDlOpku"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A3D701DDC3;
	Thu, 13 Jun 2024 21:20:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=faZqjxy9KoCjVl1iBizteN2GTyMyKh/ZdBLVjh
	+pRco=; b=xYDlOpkuLjQ1SBw70+W+DFu03Sl/Ey2Zh9+jY9mf2pI37eB/o2L75m
	gu4If1r3ElXux2/O91gX3D3zb1Y+oEWyOR9YyPaytDoCaQy1tLdaosApL5Rh7ZQ7
	6ntNpPwbEGMtn9qi+Q0tDQkMaEyf8jkdfUxmg2mohF7IzNtAQ1x48=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A6BE1DDC1;
	Thu, 13 Jun 2024 21:20:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB8D21DDC0;
	Thu, 13 Jun 2024 21:20:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "darcy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  darcy <acednes@gmail.com>
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
In-Reply-To: <xmqqcyorcldv.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	08 Jun 2024 11:58:04 -0700")
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
	<pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
	<xmqq1q58ejnw.fsf@gitster.g> <xmqqcyorcldv.fsf@gitster.g>
Date: Thu, 13 Jun 2024 18:20:53 -0700
Message-ID: <xmqqwmmsiakq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 58AC59EA-29EC-11EF-9B4B-965B910A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> The CI build on Windows tells me that my worry was warranted.
>
>   https://github.com/git/git/actions/runs/9424299208/job/25964281907#step:4:643
>
> (GitHub seems to show the breakage details only to those who are
> logged in, so you'd need to be logged in to visit that link)

So here is what I accumulated in SQUASH??? patches on top of your
topic while waiting for an updated version to unbreak the CI.

 * The "end of git time" timestamp does not fit in time_t on 32-bit
   systems, so I updated it to use timestamp_t at least for now.

 * t0006 has two tests that use TIME_IS_64BIT,TIME_T_IS_64BIT
   prerequisites; I introduced HAVE_64BIT_TIME to simplify them.

 * nobody passes $4 to check_parse to tell it to expect a failure,
   so I removed it.  It always expects success.

 * check_parse now honors a global variable REQUIRE_64BIT_TIME that
   is used as the prerequisite to run its test_expect_success; the
   "near the end of git time" tests you added use the mechanism to
   pass HAVE_64BIT_TIME prerequisite.

The last one is a bit questionable, as it only "punts" on 32-bit
systems, instead of making sure we get the expected error messages.
I think it is OK to punt here and have a separate test that checks
timestamp around year 2040 for that condition.

 date.c          |  2 +-
 t/t0006-date.sh | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/date.c b/date.c
index 95776c8a92..bee9fe8f10 100644
--- a/date.c
+++ b/date.c
@@ -870,7 +870,7 @@ static int match_object_header_date(const char *date, timestamp_t *timestamp, in
 
 
 /* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
-static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
+static const timestamp_t timestamp_max = (((timestamp_t)2100 - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
 
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index e8fdf361ad..fd373e1b39 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -8,6 +8,11 @@ TEST_PASSES_SANITIZE_LEAK=true
 # arbitrary reference time: 2009-08-30 19:20:00
 GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
 
+if test_have_prereq TIME_IS_64BIT,TIME_T_IS_64BIT
+then
+	test_set_prereq HAVE_64BIT_TIME
+fi
+
 check_relative() {
 	t=$(($GIT_TEST_DATE_NOW - $1))
 	echo "$t -> $2" >expect
@@ -80,14 +85,15 @@ check_show raw "$TIME" '1466000000 -0200'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT,TIME_T_IS_64BIT
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" HAVE_64BIT_TIME
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" HAVE_64BIT_TIME
 
-check_parse() {
+REQUIRE_64BIT_TIME=
+check_parse () {
 	echo "$1 -> $2" >expect
-	test_expect_${4:-success} "parse date ($1${3:+ TZ=$3})" "
-	TZ=${3:-$TZ} test-tool date parse '$1' >actual &&
-	test_cmp expect actual
+	test_expect_success $REQUIRE_64BIT_TIME "parse date ($1${3:+ TZ=$3}) -> $2" "
+		TZ=${3:-$TZ} test-tool date parse '$1' >actual &&
+		test_cmp expect actual
 	"
 }
 
@@ -133,6 +139,7 @@ check_parse '1969-12-31 23:59:59 Z' bad
 check_parse '1969-12-31 23:59:59 +11' bad
 check_parse '1969-12-31 23:59:59 -11' bad
 
+REQUIRE_64BIT_TIME=HAVE_64BIT_TIME
 check_parse '2099-12-31 23:59:59' '2099-12-31 23:59:59 +0000'
 check_parse '2099-12-31 23:59:59 +00' '2099-12-31 23:59:59 +0000'
 check_parse '2099-12-31 23:59:59 Z' '2099-12-31 23:59:59 +0000'
@@ -147,6 +154,7 @@ check_parse '2100-00-00 00:00:00 +00' bad
 check_parse '2100-00-00 00:00:00 Z' bad
 check_parse '2100-00-00 00:00:00 -11' bad
 check_parse '2100-00-00 00:00:00 +11' bad
+REQUIRE_64BIT_TIME=
 
 check_approxidate() {
 	echo "$1 -> $2 +0000" >expect
