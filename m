Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC378F9EC
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057582; cv=none; b=bq7Cl9PjDleIPmdIqURFLu6TZmpnlslwSDs+nAFbVKwAtv15jEp4KnAXcsgkOyf+k+jdJbz0FcVhsfeAzfChX8fTpGPeH7D1Y0QfKGFtN7dMtgMzfZYVpk6Sahqw1Hqlv1AmO28VIBlQvAc8GvI8UbGi2gWVv81n3gNLTHiUlhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057582; c=relaxed/simple;
	bh=7ezorumeZ/mAfqsKQvUD+YOU7wmXSq29tFA7HMgwO/0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=fUkKlrAvIeybP6IlJCYnb1ICiF5r/IrApyNLIqNOctKn1CT8I/da8VcUALDnUjN7I6kJHw61II/lUt2VnNb13lI7gnvyLoJqw6dnNOqKJMfAdbDFv+h40paaOCN2qUCRLUH8bqiAHCxx/4kRid+tkRFC6V+jLx3CQxtkI+Snx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46FFWpkY421612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 15:32:52 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>	<xmqq8qy4adl4.fsf@gitster.g>	<001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>	<xmqqttgr9aeb.fsf@gitster.g>	<ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net>	<004501dad61b$b35b7f30$1a127d90$@nexbridge.com>	<ZpRKu8Xsz70xNHFp@tapette.crustytoothpaste.net> <xmqqv8167kd8.fsf@gitster.g>
In-Reply-To: <xmqqv8167kd8.fsf@gitster.g>
Subject: RE: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
Date: Mon, 15 Jul 2024 11:32:46 -0400
Organization: Nexbridge Inc.
Message-ID: <00af01dad6cc$41f10d40$c5d327c0$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQLxORQfyENxav+zmXZW2AfFrMp2ygG7wSa1AglWfbcCCOoxCwFeXAgQAPqT5zMCVerbsANm6pyfr1wHetA=

On Monday, July 15, 2024 11:20 AM, Junio C Hamano wrote:
>"brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> I think we had discussed that you were using AT&T ksh on NonStop,
>> which would explain the situation.  That's the most common version of
>> ksh on proprietary Unix systems, and you can usually detect it with
>> something like this:
>
>What is sad is that we have this as literally the very first thing in our
test suite, as
>t0000.1, but ...
>
>        try_local_xy () {
>                local x="local" y="alsolocal" &&
>                echo "$x $y"
>        }
>
>        # Check whether the shell supports the "local" keyword. "local" is
not
>        # POSIX-standard, but it is very widely supported by
POSIX-compliant
>        # shells, and we rely on it within Git's test framework.
>        #
>        # If your shell fails this test, the results of other tests may be
>        # unreliable. You may wish to report the problem to the Git mailing
>        # list <git@vger.kernel.org>, as it could cause us to reconsider
>        # relying on "local".
>        test_expect_success 'verify that the running shell supports
"local"' '
>                x="notlocal" &&
>                y="alsonotlocal" &&
>                echo "local alsolocal" >expected1 &&
>                try_local_xy >actual1 &&
>                test_cmp expected1 actual1 &&
>                echo "notlocal alsonotlocal" >expected2 &&
>                echo "$x $y" >actual2 &&
>                test_cmp expected2 actual2
>        '
>
>... apparently it is just like any other test failure, so unless the tester
is running
>
>	$ shell t0000-basic.sh -i
>
>reading the output, *AND* goes to the test script to read that comment, the
helpful
>comment can easily be missed.
>
>I am wondering if it is worth doing something like this.
>
>
> t/t0000-basic.sh | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
>diff --git c/t/t0000-basic.sh w/t/t0000-basic.sh index
98b81e4d63..3cb8243cb4
>100755
>--- c/t/t0000-basic.sh
>+++ w/t/t0000-basic.sh
>@@ -34,7 +34,7 @@ try_local_xy () {
> # unreliable. You may wish to report the problem to the Git mailing  #
list
><git@vger.kernel.org>, as it could cause us to reconsider  # relying on
"local".
>-test_expect_success 'verify that the running shell supports "local"' '
>+test_lazy_prereeq WORKING_LOCAL '
> 	x="notlocal" &&
> 	y="alsonotlocal" &&
> 	echo "local alsolocal" >expected1 &&
>@@ -45,6 +45,17 @@ test_expect_success 'verify that the running shell
supports
>"local"' '
> 	test_cmp expected2 actual2
> '
>
>+if ! test_have_prereq WORKING_LOCAL
>+then
>+	skip_all='
>+		Your shell has no working "local", no tests will work.
>+		You may wish to report the problem to the Git mailing
>+		list <git@vger.kernel.org>, unless it is AT&T ksh,
>+		which we know lacks "local".  In the meantime, use
>+		shells that support "local", like dash, bash, pdksh...'
>+	test_done
>+fi
>+
> ################################################################
> # git init has been done in an empty repository.
> # make sure it is empty.

What is strange is that when running on NonStop using ksh, t0000.1 has never
failed. I think the situation is subtly different from what we are solving.
My take is that there is a difference in the local vs. non-local variable
set semantic, rather than just accepting the keyword. I would propose that
we need a more comprehensive local test to verify the actual expected
semantics rather than just testing the syntax.

