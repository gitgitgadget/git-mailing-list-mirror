Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016418E02
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708149877; cv=none; b=uPrcVx6IpureBpWEuFeSAMOwU11yIUZrW6Ak4AJXwoUpM7stwtBZRykz8LBqnvB2P04i7SPaY19iBwCi1FZYkbLNz5XIZrTzHHcOJFTPEpdF/nIIZl+MM3eKQokENlR93BCXdDqLj2tFNz5rhc7a9sssNLlmZ1etGjpAKmfzwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708149877; c=relaxed/simple;
	bh=mIjHcc2epCZwYqhWPjhKo+WECpSQVf/T65O07MTxKb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lcbtk/mVAw6aFFHj/xNDMtoT8HOPWEPjeNcMW5dEqMjn4ZK2vDosX8sybMwNEesuO3SwE/RVuI6R9stF39kPadf3Clegmfo3ZruVik5kJ4b4mb+AcSS9BaZAR/Bgt7rcwWpIzbqW+N9K6hGiano0XkG8RrSiOU+caAo945hQ7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2293 invoked by uid 109); 17 Feb 2024 06:04:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Feb 2024 06:04:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21005 invoked by uid 111); 17 Feb 2024 06:04:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Feb 2024 01:04:38 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Feb 2024 01:04:34 -0500
From: Jeff King <peff@peff.net>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Linus Arver <linusa@google.com>, Git mailing list <git@vger.kernel.org>
Subject: Re: [BUG] git commit --trailer --verbose puts trailer below scissors
 line
Message-ID: <20240217060434.GE539459@coredump.intra.peff.net>
References: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com>

On Fri, Feb 16, 2024 at 04:04:18PM -0500, Philippe Blain wrote:

> Hello,
> 
> I've just found a bug in the current master: running
> 
> 	git commit --trailer="key: value" --verbose
> 
> puts the trailer below the diff, and thus below the scissors
> line (and so it is discarded).
> 
> I checked that it works OK in 2.42.1 but not in 2.43.2 so it is not
> a new regression in the 2.44 cycle, but I thought I'd write now in case
> someone spots the culprit commit faster than me.
> 
> I'll start a bisection now.

Looks like it bisects to 97e9d0b78a (trailer: find the end of the log
message, 2023-10-20). Here's a test that demonstrates it (signed-off-by:
me in case anyone wants to incorporate it into a fix):

diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index b5bf7de7cd..d8e216613f 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -485,6 +485,24 @@ test_expect_success 'commit --trailer not confused by --- separator' '
 	test_cmp expected actual
 '
 
+test_expect_success 'commit --trailer with --verbose' '
+	cat >msg <<-\EOF &&
+	subject
+
+	body
+	EOF
+	GIT_EDITOR=: git commit --edit -F msg --allow-empty \
+		--trailer="my-trailer: value" --verbose &&
+	{
+		cat msg &&
+		echo &&
+		echo "my-trailer: value"
+	} >expected &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&

-Peff
