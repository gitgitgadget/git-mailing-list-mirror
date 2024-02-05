Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C845956
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154463; cv=none; b=iXdgU3+5khlc1uy5VfIr+vhzxcAM60yQ0+w6mabKg4WGYqudK5l17bkxVOeYqvIR6ARTPjXfuaOLzYWQCFQnC4ehALcHBVuyu8vPxmDO86oe7Ligu4wlg4ImnPz0mCaSGTNIb7rdjRavFCp1YQIjxhSAF1EEjH0soov0MovLn28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154463; c=relaxed/simple;
	bh=6lkNX+Q6XiueTXMBk0YSYCw4t7RMhInB1y5xzqgwULs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HFxh/PCl1YOO5Q87VhybqJWtmDi74z6DfGukb3eZhNlOT2lUTGq/5wdfgf3eGXmbV0PJCJOnf/YtHcpPN11bGzA6aEgER/03N8HfMZYta+wBNuinE5fYV067zdGeaQjd81ESb44NOQGqxxBR5/egkwUCbo08vWsaUoBzl2GXnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 415HYEgJ2220857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 17:34:14 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Achu Luma'" <ach.lumap@gmail.com>, <git@vger.kernel.org>
Cc: <christian.couder@gmail.com>,
        "'Christian Couder'" <chriscool@tuxfamily.org>
References: <20240205162506.1835-1-ach.lumap@gmail.com>
In-Reply-To: <20240205162506.1835-1-ach.lumap@gmail.com>
Subject: RE: [Outreachy][PATCH 1/2] date: refactor 64 bit prereq code into reusable functions
Date: Mon, 5 Feb 2024 12:34:09 -0500
Organization: Nexbridge Inc.
Message-ID: <020a01da5859$89e41210$9dac3630$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJG+DLJogej7FKn0EbXWbwPX+LtxLAiwhrw
Content-Language: en-ca

On Monday, February 5, 2024 11:25 AM, Achu Luma wrote:
>In a following commit we are going to port code from "t/helper/test-date.c"
and
>"t/t0006-date.sh" to a new "t/unit-tests/t-date.c" file using the recently
added unit
>test framework.
>
>We cannot fully port all the code from "t/helper/test-date.c" though, as
the test-
>tool date helper is still used by a number of "t/*.sh" tests.
>The TIME_IS_64BIT and TIME_T_IS_64BIT prereqs are especially used by
"t5000-
>tar-tree.sh", "t5318-commit-graph.sh" and
"t5328-commit-graph-64bit-time.sh"
>while checking those prereqs will be required in the new
"t/unit-tests/t-date.c" file
>too.
>
>To avoid duplicating in both "t/helper/test-date.c" and
"t/unit-tests/t-date.c" the
>small amount of code checking these prereqs, let's move it into inline
functions in
>"date.h".
>
>The names of these new inline functions contain "TIME_IS_64BIT" or
>"TIME_T_IS_64BIT" as it will simplify the macros we will use when we will
port code
>to "t/unit-tests/t-date.c" in a following commit.
>
>Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>Signed-off-by: Achu Luma <ach.lumap@gmail.com>
>---
> date.h               | 6 ++++++
> t/helper/test-date.c | 4 ++--
> 2 files changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/date.h b/date.h
>index 6136212a19..fb70490a51 100644
>--- a/date.h
>+++ b/date.h
>@@ -70,4 +70,10 @@ void datestamp(struct strbuf *out);  timestamp_t
>approxidate_careful(const char *, int *);  int date_overflows(timestamp_t
date);
>time_t tm_to_time_t(const struct tm *tm);
>+static inline int check_prereq_TIME_IS_64BIT(void) {
>+	return sizeof(timestamp_t) == 8;
>+}
>+static inline int check_prereq_TIME_T_IS_64BIT(void) {
>+	return sizeof(time_t) == 8;
>+}
> #endif
>diff --git a/t/helper/test-date.c b/t/helper/test-date.c index
>0683d46574..be0b8679c3 100644
>--- a/t/helper/test-date.c
>+++ b/t/helper/test-date.c
>@@ -126,9 +126,9 @@ int cmd__date(int argc UNUSED, const char **argv)
> 	else if (!strcmp(*argv, "getnanos"))
> 		getnanos(argv+1);
> 	else if (!strcmp(*argv, "is64bit"))
>-		return sizeof(timestamp_t) == 8 ? 0 : 1;
>+		return !check_prereq_TIME_IS_64BIT();
> 	else if (!strcmp(*argv, "time_t-is64bit"))
>-		return sizeof(time_t) == 8 ? 0 : 1;
>+		return !check_prereq_TIME_T_IS_64BIT();
> 	else
> 		usage(usage_msg);
> 	return 0;
>--
>2.43.0.windows.1

I would suggest that you also take into account whether time_t is signed or
not (more difficult perhaps). Some platforms use signed time_t to allow
representation of dates prior to 1970-01-01, while others make this signed.
Some other platforms (S/390 for example) have retained time_t as 32-bits but
have a time64_t for 64 bits. It might be useful to account for this.
--Randall

