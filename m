Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA231A2C39
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636227; cv=none; b=Uast0FFU04bsgOjYW6w+QD7zW38Vw4+AwUPQ4/wjaB50ESJ0nVCsGj4o9tf7AubnU+YNgUxXie0GOHXX3MO7qx5fnJv+xDQNDcYrZS10eDio0EGpdrzpuzKg47SAtv2/WHy3uMhzGmeCQWlP0l9GM09Zw9Nr+ew6iNSV0YjyYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636227; c=relaxed/simple;
	bh=Ka37MAAZdveBvV03qOFAttRg4bycrwsoZyf30wO97Fo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YxyEC7NWVY/0o59QU0cmkRiw6tBR6vOUxpc9f4CKvKxIz8kxdO50gHjPe1pt4WMs8XQJOrU24S97pp/ScGj7FDYfsZe+tEWg29xTByyBNg+1D2oAnvCsMhImkZa6eAYS0ZZXjmbv+T8la1/ZmGCknLXH9rgsbjOPI4fuSveiT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hq+m8kTy; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hq+m8kTy"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C6FD35A47;
	Fri,  6 Sep 2024 11:23:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ka37MAAZdveBvV03qOFAttRg4bycrwsoZyf30w
	O97Fo=; b=hq+m8kTypP/mWFUACuIFmpStpbkRanY12DwTljytSYpNY76fohUXwz
	JsDZOIOt8ee2TMEa7CIwuPb9JYSor3K5pL9qvmY5wCm27xlBDqseWUecCmy+osHF
	XA5DknsBHQhb3+a0CQNzau01DBoywjLE1sy6xBJDILl/eXu0Jb0W8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 93C9A35A46;
	Fri,  6 Sep 2024 11:23:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C5CD35A42;
	Fri,  6 Sep 2024 11:23:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Brian Lyles <brianmlyles@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] interpret-trailers: handle message without trailing
 newline
In-Reply-To: <fab48d5b-4808-439e-9384-ca4861b95edc@gmail.com> (Phillip Wood's
	message of "Fri, 6 Sep 2024 10:07:02 +0100")
References: <20240905173445.1677704-1-brianmlyles@gmail.com>
	<20240906041326.1684570-1-brianmlyles@gmail.com>
	<fab48d5b-4808-439e-9384-ca4861b95edc@gmail.com>
Date: Fri, 06 Sep 2024 08:23:42 -0700
Message-ID: <xmqqmskkyfep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00F9C04C-6C64-11EF-8799-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for the comprehensive commit message. If the problem only affects
> "git interpret-trailers" I wonder if it would be simpler to do
>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 1d969494cf..e6f22459f1 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -132,6 +132,7 @@ static void read_input_file(struct strbuf *sb, const char *file)
>                  if (strbuf_read(sb, fileno(stdin), 0) < 0)
>                          die_errno(_("could not read from stdin"));
>          }
> +        strbuf_complete_line(sb);
>  }

It is much simpler, and if we are to require a message that the user
uses interpret-trailers on not to end in an incomplete line (which I
do not have any objection to), it is absolutely the right approach.

With a devil's advocate hat on, though, if the trailer operation is
to find the trailer on the incomplete line at the end, and insert a
trailer _before_ that one, would it be more faithful to the command
given by the end-user, if we inserted the new trailer without
touching the existing trailer line (including its lack of
terminating EOL)?  Which would mean that we'd need to remember the
fact that we added a LF here, and then before writing the result out
make the buffer to end with an incomplete line.  Which I personally
think is crazy, compared to the approach to declare that a message
that you subject to interpret-trailers command MUST BE a proper
text, not ending with an incomplete line.

So, yeah, I like that idea.

