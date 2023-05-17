Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146DEC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 19:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjEQTG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQTG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 15:06:27 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEFB40CF
        for <git@vger.kernel.org>; Wed, 17 May 2023 12:06:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D81951E9F2A;
        Wed, 17 May 2023 15:06:25 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=XiWFHioLNVWE+JCQsUUBv0Skr
        smGNSivu0ZMSpnkFbI=; b=LxKnBFghYGRNovrIyueFxRKJYObjILt8GUdi+d9u/
        rMK9SbAE752xKypMBiB7Id9/mAbDaHjf6fP51BiiKG4/kbrSri26gMtB/HEl3yFc
        z0Q6LM35r2awZP7gQdeYXTEIP1AitRmQpS8FLIk55gNscEFE/3yQYSOuS/y4wyqM
        H8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D13411E9F29;
        Wed, 17 May 2023 15:06:25 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EEFA61E9F28;
        Wed, 17 May 2023 15:06:21 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Wed, 17 May 2023 15:06:18 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@outlook.com>,
        Jeff King <peff@peff.net>
Subject: [BUG 2.41.0] t/lib-httpd/apache.conf incompatible with RHEL/CentOS 7
Message-ID: <ZGUlqu7sP7yxbaTI@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Pobox-Relay-ID: E9991AD4-F4E5-11ED-8488-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After applying the imap-send.c patch=B9 on RHEL/CentOS 7, I
noticed the http tests fail because the Apache httpd config
is not valid with httpd-2.4.6=B2 on CentOS 7.

The tests fail with:

    Parse errors: No plan found in TAP output

The problem is that CGIPassAuth, added in 988aad99b4 (t5563:
add tests for basic and anoymous HTTP access, 2023-02-27) is
not supported by httpd < 2.4.13:

    Starting httpd on port 10410
    [Wed May 17 17:06:52.184409 2023] [core:warn] [pid 477886] AH00111: C=
onfig variable ${LIB_HTTPD_SVN} is not defined
    [Wed May 17 17:06:52.184495 2023] [core:warn] [pid 477886] AH00111: C=
onfig variable ${LIB_HTTPD_SVNPATH} is not defined
    AH00526: Syntax error on line 149 of /builddir/build/BUILD/git-2.41.0=
.rc0/t/lib-httpd/apache.conf:
    Invalid command 'CGIPassAuth', perhaps misspelled or defined by a mod=
ule not included in the server configuration
    error: web server setup failed

Since edd060dc84 (t/lib-httpd: bump required apache version
to 2.4, 2023-02-01), we require httpd-2.4 and no longer have
any <IfVersion> conditions.  I'm not sure if this a reason
to add some again (nor am I certain if httpd's IfVersion
supports minor versions).

Perhaps there's a more elegant way to fix this?  (I haven't
thought of anything in patch form yet, apologies.)

I'd like to still build git for CentOS 7 and not skip all
the http tests, but if it's time to say it is not worth
supporting, I can understand.  RHEL/CentOS 7 has a little
over a year left before it is EOL=B3.

=B9 <20230517070632.71884-1-list@eworm.de>
=B2 https://httpd.apache.org/docs/2.4/mod/core.html#cgipassauth
=B3 https://blog.centos.org/2023/04/end-dates-are-coming-for-centos-strea=
m-8-and-centos-linux-7/#centos-linux-7-end-of-life-june-30-2024

Thanks,

--=20
Todd
