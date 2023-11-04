Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB0E7497
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AvPieqhK"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF67B134
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 00:59:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BBDA61BC3C2;
	Sat,  4 Nov 2023 03:59:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jl1ZdwxqWPcwRi8W3qCg4vZHIuEPN3CpVIs1zS
	erDL8=; b=AvPieqhKY8eJKJIGyKSB7/aJ57xWZw7OT4q6JN2A9UP0A1+rlmtZ3/
	xoGHAUUAMLX2K//J2D0D0qovc7IukiKPlp3/svwzLjsduqt4j8IYa1S34EwFh1N5
	0ESF1BEpdYq+i8hJYEbBl0hOvI8absjFZklZVhPXpR+qyHw4rD79s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2A041BC3C1;
	Sat,  4 Nov 2023 03:59:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EED971BC3C0;
	Sat,  4 Nov 2023 03:59:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: rsbecker@nexbridge.com,  Git List <git@vger.kernel.org>
Subject: Re: Request for Help - Too many perl arguments as of 2.43.0-rc0
In-Reply-To: <CAPig+cQpxRQnhffR8EWWRhqJPmOeOuCE3qsuMcnDyuMLLbTH8Q@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 4 Nov 2023 02:36:48 -0400")
References: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com>
	<CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com>
	<00c301da0e9d$0d2cb8e0$27862aa0$@nexbridge.com>
	<CAPig+cRG3VWgnwOPWvbW9boUooa6sD9d667wbSUe4_RkcR60vg@mail.gmail.com>
	<00c401da0ea1$b61899c0$2249cd40$@nexbridge.com>
	<CAPig+cQpxRQnhffR8EWWRhqJPmOeOuCE3qsuMcnDyuMLLbTH8Q@mail.gmail.com>
Date: Sat, 04 Nov 2023 16:59:45 +0900
Message-ID: <xmqq8r7egd8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1F3A445A-7AE8-11EE-A70C-25B3960A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> Also, in the longer term, as you suggested, `xargs` is likely a more
> fruitful solution.

Hmph, the list of our test scripts exceed command line limit?  That
sounds a bit nasty, as we somehow need to prepare a pipe and feed
them into it, in order to drive xargs downstream of the pipe.


Ideally if there were a GNUMake function that slices a list into
sublists of "reasonable" lengths, we could use it to directly drive
N invocations of check-non-portable-shell script instead of xargs,
but I didn't find one.  Here is I came up with, using foreach that
is "slice the list into many sublists of 1 element", but it made me
feel dirty.

 t/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/t/Makefile w/t/Makefile
index 3e00cdd801..f9ac6bb4eb 100644
--- c/t/Makefile
+++ w/t/Makefile
@@ -122,7 +122,8 @@ test-lint-executable:
 		echo >&2 "non-executable tests:" $$bad; exit 1; }
 
 test-lint-shell-syntax:
-	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)
+	@{ $(foreach t,$(T) $(THELPERS) $(TPERF),echo "$t";) } | \
+	xargs '$(PERL_PATH_SQ)' check-non-portable-shell.pl
 
 test-lint-filenames:
 	@# We do *not* pass a glob to ls-files but use grep instead, to catch
