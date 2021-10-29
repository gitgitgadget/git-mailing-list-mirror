Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B52DC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E2660FF2
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhJ2UQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:16:55 -0400
Received: from elephants.elehost.com ([216.66.27.132]:27041 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ2UQy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:16:54 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19TKENQm073247
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 16:14:23 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Bug] wrapper.c uses unportable unsetenv
Date:   Fri, 29 Oct 2021 16:14:17 -0400
Organization: Nexbridge Inc.
Message-ID: <012301d7cd01$90428960$b0c79c20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdfM/7sCVI0gXRY4TYOGT9bxO2027A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The unsetenv()/setenv(overwrite) calls are not 100% portable - as in not on
all POSIX implementations. It breaks the build on some of the NonStop
platforms. This will change in a year or two but I really don't want to fall
behind on git releases.

This was introduced at 3540c71 but I was on vacation when it happened so did
not catch it during reviews - my apologies for that.

Is it critical that this be called or can we #ifdef it away if it isn't
supported for a build? The #if is exactly this:

wrapper.c@150
+ #if (_TANDEM_ARCH_ > 3 || (_TANDEM_ARCH_ == 3 && __L_Series_RVU >= 2010))
	if (setenv(name, value, overwrite))
		die_errno(_("could not setenv '%s'"), name ? name :
"(null)");
+ #endif

wrapper.c@154
+ #if (_TANDEM_ARCH_ > 3 || (_TANDEM_ARCH_ == 3 && __L_Series_RVU >= 2010))
	if (!unsetenv(name))
		die_errno(_("could not unsetenv '%s'"), name ? name :
"(null)");
+ #endif

-Randall

