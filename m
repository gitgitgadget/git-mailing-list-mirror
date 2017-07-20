Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEB4F1F600
	for <e@80x24.org>; Thu, 20 Jul 2017 20:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965172AbdGTUbE (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 16:31:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62956 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935439AbdGTUbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 16:31:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00B728D15A;
        Thu, 20 Jul 2017 16:30:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bFRNaLubkQ8zP0snqrhAejtIMY8=; b=fxuZb/
        i8XmZ+zZr/aoYbHPo6O5DfFjEya2LiFwRUjoUrS3xNAKLF/Eq5FVLgznbcgFBV7k
        8Lw0NGQGQ/irv8upnFD7RzAafqqIwJcd24mEVMjMkx9JJb7IqWTpaQIAv2zcrvjV
        jAySfdB6gFYs+zOIJYCjAM6e0wVi5XDuiS7fs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J5U+p6g3yaNCKA7BfMQ0UG60x9g2hLGF
        65bFD0KUGfaPfCCn5Ts7nWocvRhnzksHmlgB0dFxbR46kRLFLN399RWjguvnuM41
        NxNEr2jw5/Bev2PXs4NZLKjph4ARmkkHEkO5VVl/TAMiczwZ/+B1Fhg8mczJZIVW
        x+/+bw7zE20=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED49D8D159;
        Thu, 20 Jul 2017 16:30:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CBB68D158;
        Thu, 20 Jul 2017 16:30:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charles Bailey <charles@hashpling.org>
Cc:     Victor Toni <victor.toni@gmail.com>, git@vger.kernel.org,
        Charles Bailey <cbailey32@bloomberg.net>,
        Jeff King <peff@peff.net>
Subject: Re: Handling of paths
References: <CAG0OSgdEE3g-ugEJU4EZqfbxZ=3h2WPdLC4W4mG7b6UeTaXQ-Q@mail.gmail.com>
        <xmqq7ez2lwsv.fsf@gitster.mtv.corp.google.com>
        <20170720200523.GA13792@hashpling.org>
Date:   Thu, 20 Jul 2017 13:30:52 -0700
In-Reply-To: <20170720200523.GA13792@hashpling.org> (Charles Bailey's message
        of "Thu, 20 Jul 2017 21:05:23 +0100")
Message-ID: <xmqqwp72kg03.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 538B1B0C-6D8A-11E7-95F7-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charles Bailey <charles@hashpling.org> writes:

> On Thu, Jul 20, 2017 at 12:42:40PM -0700, Junio C Hamano wrote:
>> Victor Toni <victor.toni@gmail.com> writes:
>> 
>> > What's unexpected is that paths used for sslKey or sslCert are treated
>> > differently insofar as they are expected to be absolute.
>> > Relative paths (whether with or without "~") don't work.
>> 
>> It appears that only two of these among four were made aware of the
>> "~[username]/" prefix in bf9acba2 ("http: treat config options
>> sslCAPath and sslCAInfo as paths", 2015-11-23), but "sslkey" and
>> "sslcert" were still left as plain vanilla strings.  I do not know
>> if that was an elaborate omission, or a mere oversight, as it seems
>> that it happened while I was away, so...
>
> It was more of an oversight than a deliberate omission, but more
> accurately I didn't actively consider whether the other http.ssl*
> variables were pathname-like or not.
>
> At the time I was trying to make a config which needed to set
> http.sslCAPath and/or http.sslCAInfo more portable between users and
> these were "obviously" pathname-like to me. Now that I read
> the help for http.sslCert and http.sslKey, I see no reason that they
> shouldn't also use git_config_pathname. If I'd been more thorough I
> would have proposed this at the time.

Thanks.

I've read the function again and I think the attached patch covers
everything that ought to be a filename.

By the way, to credit you, do you prefer your bloomberg or hashpling
address?

-- >8 --
Subject: http.c: http.sslcert and http.sslkey are both pathnames

Back when the modern http_options() codepath was created to parse
various http.* options at 29508e1e ("Isolate shared HTTP request
functionality", 2005-11-18), and then later was corrected for
interation between the multiple configuration files in 7059cd99
("http_init(): Fix config file parsing", 2009-03-09), we parsed
configuration variables like http.sslkey, http.sslcert as plain
vanilla strings, because git_config_pathname() that understands
"~[username]/" prefix did not exist.  Later, we converted some of
them (namely, http.sslCAPath and http.sslCAInfo) to use the
function, and added variables like http.cookeyFile http.pinnedpubkey
to use the function from the beginning.  Because of that, these
variables all understand "~[username]/" prefix.

Make the remaining two variables, http.sslcert and http.sslkey, also
aware of the convention, as they are both clearly pathnames to
files.

Noticed-by: Victor Toni <victor.toni@gmail.com>
Helped-by: Charles Bailey <cbailey32@bloomberg.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index c6c010f881..76ff63c14d 100644
--- a/http.c
+++ b/http.c
@@ -272,10 +272,10 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.sslversion", var))
 		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
-		return git_config_string(&ssl_cert, var, value);
+		return git_config_pathname(&ssl_cert, var, value);
 #if LIBCURL_VERSION_NUM >= 0x070903
 	if (!strcmp("http.sslkey", var))
-		return git_config_string(&ssl_key, var, value);
+		return git_config_pathname(&ssl_key, var, value);
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
 	if (!strcmp("http.sslcapath", var))
