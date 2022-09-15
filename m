Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BD2ECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 15:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiIOP11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 11:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiIOP1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 11:27:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27954422F9
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 08:27:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1082715438A;
        Thu, 15 Sep 2022 11:27:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XMGzn5Qo4UF0xC55jAjcQVnzn2z7ubkYUxaP4L
        BniWo=; b=jGz3tmuXvLWYCiwzl6TBStoswkktbp5wTS044v09nD/TYChcxXrj7D
        suvLXdK2fAPo27NQJRVxSWWQ1OHEU8UqBVFVkJC0UCeJzuB8C02U2KTokAw3IqDn
        Blz25y98rDgIr3xl5JA17X+4Z0fAmq1i7tcENLX3a5L2yEGEwwt/E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07959154389;
        Thu, 15 Sep 2022 11:27:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70968154388;
        Thu, 15 Sep 2022 11:27:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Brijesh Patel <bridgepatel@gmail.com>, git@vger.kernel.org
Subject: Re: BUG: Value for GIT_SSL_NO_VERIFY has no effect
References: <CACs=J2MLnawNF5mp19sCJAZADPenHjWVZvKW5rM1fwELHjqqyg@mail.gmail.com>
        <YyMi76Cy7KnfZFU4@tapette.crustytoothpaste.net>
Date:   Thu, 15 Sep 2022 08:27:22 -0700
In-Reply-To: <YyMi76Cy7KnfZFU4@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 15 Sep 2022 13:04:47 +0000")
Message-ID: <xmqq8rmkpsit.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E581A83A-350A-11ED-B640-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-09-15 at 01:46:50, Brijesh Patel wrote:
>> Hi,
>
> Hey,
>
>> It appears that any value assigned to GIT_SSL_NO_VERIFY (true or
>> false) has no effect on the GIT operations. For testing purposes, we
>> have created a host entry for github.com and mapped it to foo.com.
>
> This is definitely true.  There are several Git environment variables
> that act this way, including GIT_CURL_VERBOSE, that check whether the
> environment is present or absent, not whether it's set to a particular
> value.
>
> I believe this behaviour is by design (although other folks are free to
> correct me if they think I'e wrong).

Yeah, a plausible alternative that could have existed is to name the
variable GIT_SSL_VERIFY with the boolean (or the usual Boolean +
'auto', even though I do not offhand think of what 'auto' should
do), but this variable definitely is designed to be "if set, the
feature named by the variable goes in effect, and you unset it to
make it ineffective".

I did a quick audit of the environment variables documented in
git(1) and it is a bit messy.  Many environment variables use
git_env_bool() to make themselves a proper Boolean environment
variable, but some others that are described to take "1" to "enable"
do not honor the usual "yes/true/on" convention.

SSL_NO_VERIFY is worse, as it is not even described.  So we should
add it to "git help git".

 Documentation/git.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git c/Documentation/git.txt i/Documentation/git.txt
index 0ef7f5e4ec..1b7e37e79a 100644
--- c/Documentation/git.txt
+++ i/Documentation/git.txt
@@ -682,6 +682,11 @@ for further details.
 	plink or tortoiseplink. This variable overrides the config setting
 	`ssh.variant` that serves the same purpose.
 
+`GIT_SSL_NO_VERIFY`::
+	Setting and exporting this environment variable to any value
+	tells Git not to verify the SSL certificate when fetching or
+	pushing over HTTPS.
+
 `GIT_ASKPASS`::
 	If this environment variable is set, then Git commands which need to
 	acquire passwords or passphrases (e.g. for HTTP or IMAP authentication)
