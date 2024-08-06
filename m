Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300446444
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966451; cv=none; b=i2oqx4vFz0mzHBjxHLP4C0PHF45MLp+oHxB9jfsN17QRGr23OVjIcDk7aM0+Bfe1zIIN2ALTtauoblRrOH3cgj2uZsMimrG7DAfjBOQjE61lWcnEBr3Ld2VGv16xEgFPbb9XwjD0C8Bhph66xjyxyr//VB/OYDcypBL+wuBU6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966451; c=relaxed/simple;
	bh=htU1gXwd8ivCipzQA5FPxUuTS1hiivRiU5k3UttHl+w=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rS8/Q4M3pfxHoczmkWpuui0wsCUaLkote/Zx4wnZwzcKvalvBrVGf9lO06+vIm1jWLV6sAXfkiuQLE1FA+zhNWszxdhvU/lMJRD4RAFmcw5jS3SaufHWI+SE1ZPFtBbpAeZc1o0Z07c1E5k35ELK9j3QufztnbSI+vmjjEEBwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ood0AR5b; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ood0AR5b"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BF46123803;
	Tue,  6 Aug 2024 13:47:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=htU1gXwd8ivCipzQA5FPxUuTS1hiivRiU5k3Ut
	tHl+w=; b=ood0AR5bDT65ZzDnbdNZ7fHkc/CvZAK70tnNj+aKTFyplcIkKqLSec
	ZUW0a5CS4mNi+nC1UI4RVucniDAziuhdxrtov/qxZhi1U7jIuhGuOrkraJx4gyl9
	pwQ9wttHuVJk208Dws6YBhW7PG94dTz375Y/kT67cvo7qlrd3b73E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A9E0A23802;
	Tue,  6 Aug 2024 13:47:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC989237FD;
	Tue,  6 Aug 2024 13:47:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2] refs: avoid "too many arguments"
In-Reply-To: <20240806003539.3292562-2-gitster@pobox.com> (Junio C. Hamano's
	message of "Mon, 5 Aug 2024 17:35:36 -0700")
References: <20240806003539.3292562-1-gitster@pobox.com>
	<20240806003539.3292562-2-gitster@pobox.com>
Date: Tue, 06 Aug 2024 10:47:16 -0700
Message-ID: <xmqqed71tufv.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ECE7636C-541B-11EF-AA29-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Running "git refs migrate master main" would fail and say "too many
arguments".  By reading that message, you cannot tell if you just
should have given a single ref and made it "git refs migrate
master", or the command refuses to take any arguments.

Instead, report that "git ref migrate" takes no arguments, which is
far easier for the user to understand.

    $ git refs migrate master main
    fatal: 'git refs migrate' takes no arguments

The other side of the coin this change is covering is to remove
doubts in new users' minds when we say "git refs migrate", if it is
"git" command running with two "refs migrate" arguments, "git refs"
command running with one "migrate" argument, or "git refs migrate"
command running with no arguments.

In the same spirit, reword the existing "missing --ref-format=<format>"
message and say

    $ git refs migrate
    fatal: 'git refs migrate' needs '--ref-format=<format>'

Note that we are turning two usage() calls to die() calls.  The
former should signal that the message given is a command line that
shows the usage help of the command.  If we are giving a fatal error
message, we should not hesitate to use die().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is no longer a series.  I may resurrect [2,3,4/4] later, but
   they do not share any new helper routines at this moment, so they
   can stay independent patches.  Or perhaps while looking at this
   use case deeper during the review of this patch, we might come up
   with a good way to address this issue for many other scenarios
   and make a set of helper routines, in which case those other
   steps may have to become a part of series again to take advantage
   of them.

 builtin/refs.c          |  4 ++--
 t/t1460-refs-migrate.sh | 10 ++--------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index 46dcd150d4..a51602f84b 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -30,9 +30,9 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, migrate_usage, 0);
 	if (argc)
-		usage(_("too many arguments"));
+		die(_("'git refs migrate' takes no arguments"));
 	if (!format_str)
-		usage(_("missing --ref-format=<format>"));
+		die(_("'git refs migrate' needs '--ref-format=<format>'"));
 
 	format = ref_storage_format_by_name(format_str);
 	if (format == REF_STORAGE_FORMAT_UNKNOWN) {
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index f7c0783d30..e063a98b11 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -31,20 +31,14 @@ test_expect_success "superfluous arguments" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	test_must_fail git -C repo refs migrate foo 2>err &&
-	cat >expect <<-EOF &&
-	usage: too many arguments
-	EOF
-	test_cmp expect err
+	test_grep "takes no arguments" err
 '
 
 test_expect_success "missing ref storage format" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	test_must_fail git -C repo refs migrate 2>err &&
-	cat >expect <<-EOF &&
-	usage: missing --ref-format=<format>
-	EOF
-	test_cmp expect err
+	test_grep "needs ${SQ}--ref-format=<format>${SQ}" err
 '
 
 test_expect_success "unknown ref storage format" '

Interdiff against v1:
  diff --git a/builtin/refs.c b/builtin/refs.c
  index a2aac38ceb..a51602f84b 100644
  --- a/builtin/refs.c
  +++ b/builtin/refs.c
  @@ -30,11 +30,9 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
   
   	argc = parse_options(argc, argv, prefix, options, migrate_usage, 0);
   	if (argc)
  -		usage_msg_optf(_("unknown argument: '%s'"),
  -			       migrate_usage, options,
  -			       argv[0]);
  +		die(_("'git refs migrate' takes no arguments"));
   	if (!format_str)
  -		usage(_("missing --ref-format=<format>"));
  +		die(_("'git refs migrate' needs '--ref-format=<format>'"));
   
   	format = ref_storage_format_by_name(format_str);
   	if (format == REF_STORAGE_FORMAT_UNKNOWN) {
  diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
  index b32e740001..e063a98b11 100755
  --- a/t/t1460-refs-migrate.sh
  +++ b/t/t1460-refs-migrate.sh
  @@ -31,21 +31,14 @@ test_expect_success "superfluous arguments" '
   	test_when_finished "rm -rf repo" &&
   	git init repo &&
   	test_must_fail git -C repo refs migrate foo 2>err &&
  -	{
  -		printf "fatal: unknown argument: ${SQ}foo${SQ}\n\n" &&
  -		( git -C repo refs migrate -h || : )
  -	} >expect &&
  -	test_cmp expect err
  +	test_grep "takes no arguments" err
   '
   
   test_expect_success "missing ref storage format" '
   	test_when_finished "rm -rf repo" &&
   	git init repo &&
   	test_must_fail git -C repo refs migrate 2>err &&
  -	cat >expect <<-EOF &&
  -	usage: missing --ref-format=<format>
  -	EOF
  -	test_cmp expect err
  +	test_grep "needs ${SQ}--ref-format=<format>${SQ}" err
   '
   
   test_expect_success "unknown ref storage format" '
-- 
2.46.0-235-g968ce1ce0e

