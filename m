Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489A18E37E
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186181; cv=none; b=R4TmyL89xs1IP0QU2r7jJot5mYoci4mBn0+xAVjVmL7hugcOYzHTL62a3sP0qkUtLr2sLvZD67OvH13T6M5qc36asz55YwqTre/pmXIcT5zToaycmFYGDVQreKMp8ViM0Mc88vuw7qWlOB4UroJu4sslsnHUOUogFBhLbnDF3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186181; c=relaxed/simple;
	bh=otQRzGHo4VgUvagcit7vwQ0OSrBZe9h0DOEozwq+qhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JvzflbtPnJn1vDOSZmfWkfIp9hs+eZhFDGXQ7y5fcTdP48oxMUB9UnEqgz0mA+83iXP4tHLz+xDW7ATTpQH/+0cDj0nrQbjFAR12SqH+T3S1QS4Y0bJZdnkc6AfuiYfB0ARYH+HRgzqNguaSJx97oOEBuhaw0vnTnVqPxkTY10A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=H9vPNYPX; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H9vPNYPX"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C7A91A819;
	Tue, 20 Aug 2024 16:36:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=otQRzGHo4VgUvagcit7vwQ0OSrBZe9h0DOEozw
	q+qhQ=; b=H9vPNYPXvOR9dADtiJ8DBzwiyGR81D8ViKK3Bj/EMSpmjO9TXDY+/b
	7IKfswH82EFJHlhFC/OzdsKLifKaO9jR+T4qiiPh5LQHcO4wfkApmOX1cXVPFyto
	zuHJr9M6KxMEGz6k61WQMVdkgPE6Oyq/0DBfDZdVj/dIO07Dnv6DM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 250771A818;
	Tue, 20 Aug 2024 16:36:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C0861A817;
	Tue, 20 Aug 2024 16:36:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/20] pretty: fix memory leaks when parsing pretty formats
In-Reply-To: <82f3908f9620cee29e36a51f6d18ddcc8392b966.1724159575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 20 Aug 2024 16:05:07 +0200")
References: <cover.1724159575.git.ps@pks.im>
	<82f3908f9620cee29e36a51f6d18ddcc8392b966.1724159575.git.ps@pks.im>
Date: Tue, 20 Aug 2024 13:36:11 -0700
Message-ID: <xmqq7ccb6if8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D6E730D8-5F33-11EF-A1AA-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When parsing pretty formats from the config we leak the name and user
> format whenever these are set multiple times. This is because we do not
> free any already-set value in case there is one.
>
> Plugging this leak for the name is trivial. For the user format we need
> to be a bit more careful, because we may end up assigning a pointer into
> the allocated region when the string is prefixed with either "format" or
> "tformat:". In order to make it safe to unconditionally free the user
> format we thus strdup the stripped string into the field instead of a
> pointer into the string.

Yup, the stripped one is trickier, but the change looks correct.

Will queue.

By the way, we tend to prefer no spaces after (cast) in our
codebase, but I just noticed that it is not spelled out in the
coding guidelines.  Comparing

    $ git grep -E -e '\((int|char \*)\) ' \*.c ':!compat/' ':!contrib/'
    $ git grep -E -e '\((int|char \*)\)[^ ]' \*.c ':!compat/' ':!contrib/'

tells me that the extra space after the (cast) is found mostly in
borrowed or imported sources and majority of culprits are found in
reftable library X-<.

Thanks.


--- >8 ---
Subject: CodingGuidelines: spaces around C operators

As we have operated with "write like how your surrounding code is
written" for too long, after a huge code drop from another project,
we'll end up being inconsistent before such an imported code is
cleaned up.  We have many uses of cast operator with a space before
its operand, mostly in the reftable code.

Spell the convention out before it spreads to other places.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index e4bd0abdcd..ccaea39752 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -303,7 +303,9 @@ For C programs:
      v12.01, 2022-03-28).
 
  - Variables have to be declared at the beginning of the block, before
-   the first statement (i.e. -Wdeclaration-after-statement).
+   the first statement (i.e. -Wdeclaration-after-statement).  It is
+   encouraged to have a blank line between the end of the declarations
+   and the first statement in the block.
 
  - NULL pointers shall be written as NULL, not as 0.
 
@@ -323,6 +325,13 @@ For C programs:
         while( condition )
 		func (bar+1);
 
+ - A binary operator (other than ",") and ternary conditional "?:"
+   have a space on each side of the operator to separate it from its
+   operands.  E.g. "A + 1", not "A+1".
+
+ - A unary operator (other than "." and "->") have no space between it
+   and its operand.  E.g. "(char *)ptr", not "(char *) ptr".
+
  - Do not explicitly compare an integral value with constant 0 or '\0',
    or a pointer value with constant NULL.  For instance, to validate that
    counted array <ptr, cnt> is initialized but has no elements, write:
