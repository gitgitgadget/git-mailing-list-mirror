Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED8E2018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbcFXTKt (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:10:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbcFXTKs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:10:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6DEF2575A;
	Fri, 24 Jun 2016 15:10:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BhskyRK6HeKQ0OxNhAwC871U9QE=; b=MFVdCw
	tA6U8tdY7BVpE3zeNZ0EjnHEA34enwqV0mYpgDLg5debTqNYBwnrVXNhjU/+77JT
	9ptSfhg5MKYbT8ZrXOL5bxdO0SZQW1H3f9hWfYeyo7Rg8Qxk6WAcn6O3opm3sGNy
	cDIyHQRX1LEO21EajdfvF46sMGM8xlS7pPLbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jDcsVXIwsXK1untkQ/FHfAAiD3nzASDZ
	hFLMuEevgTMX+q5KX7Igd8yuNqbLt68ubRdFSq17r5UtFc8TR9vA7Uuq9Dq8mP46
	/mgjH+KcIx30rSE8e9FHQMzqKx91NklsNCMqKFcOCaTxTncvP0nHJ6UI0nn6RUCr
	+qCS6NgH5ig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC49525759;
	Fri, 24 Jun 2016 15:10:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3319025758;
	Fri, 24 Jun 2016 15:10:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 4/4] archive-tar: drop return value
References: <20160623231512.GA27683@sigill.intra.peff.net>
	<20160623232158.GD3668@sigill.intra.peff.net>
	<1865881092.716701.1466768964884.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<20160624131325.GA28941@sigill.intra.peff.net>
Date:	Fri, 24 Jun 2016 12:10:44 -0700
In-Reply-To: <20160624131325.GA28941@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 24 Jun 2016 09:13:25 -0400")
Message-ID: <xmqqoa6qflmz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AD8159C-3A3F-11E6-8234-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jun 24, 2016 at 01:49:24PM +0200, Remi Galan Alfonso wrote:
>
>> Hi Peff,
>> 
>> Jeff King <peff@peff.net> writes:
>> > @@ -413,7 +411,7 @@ static int write_tar_archive(const struct archiver *ar,
>> >  {
>> >          int err = 0;
>> >  
>> > -        err = write_global_extended_header(args);
>> > +        write_global_extended_header(args);
>> >          if (!err)
>> >                  err = write_archive_entries(args, write_tar_entry);
>> 
>> If we drop the error code from 'write_global_extended_header' then the
>> above 'if (!err)' becomes useless (always evaluates to 'true' since
>> 'err' is set to '0').
>
> Thanks, you're right.
>
> I wondered if we could drop "err" entirely, but write_archive_entries()
> does indeed have some error code paths (everybody uses write_or_die, but
> we return an error for things like unknown file types).

You could if you did this ;-)

Which I do not necessarily think is a good idea.

This may be easier to read

	write_global_extended_header(args)
        err = write_archive_entries(args, write_tar_entry);
        if (!err)
		write_trailer();
	return err;

though.

 archive-tar.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 903b74d..eed2c96 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -412,11 +412,9 @@ static int write_tar_archive(const struct archiver *ar,
 	int err = 0;
 
 	write_global_extended_header(args);
-	if (!err)
-		err = write_archive_entries(args, write_tar_entry);
-	if (!err)
-		write_trailer();
-	return err;
+
+	return (write_archive_entries(args, write_tar_entry) ||
+		write_trailer());
 }
 
 static int write_tar_filter_archive(const struct archiver *ar,
