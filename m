Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2DD1F45F
	for <e@80x24.org>; Wed,  8 May 2019 08:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfEHIUt (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 04:20:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56325 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfEHIUt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 04:20:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 299F36C894;
        Wed,  8 May 2019 04:20:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kY8R49DuhvdVWnQayxp07YPjByk=; b=S57S9S
        q7Iwp9V0BFT4/MvVWAUC2XNKkyTvRAJ/BYELejTf8dIUL/rNE1g2eyMPwhHbgA62
        86GW4bWZK3ytCKmuT07siNk0b2DIfJsSxSoPpCwcDTxeBc1xkQMBuLtRp3ocFfeJ
        akgOBPXhGHfKvKvxZYond5vFy+xHNXK0N/tXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PAK6pxK/15I/9Npx1SflvjIkzrpwg1/z
        Dp/2yeUGCDG+vrWVXAjboVu9jVPaTt/QlF0arjM/Uwu1H6oIxcQrPlm2eRe6FWTn
        tzX+q3fdfncb7thREpGM1NLYLSGyzuIL5fHUDeKrJGfRb5jeL23OgSk1auCgR4py
        vglBv4Dm3+0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21BFC6C893;
        Wed,  8 May 2019 04:20:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 51A426C892;
        Wed,  8 May 2019 04:20:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Brian M Carlson <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] send-email: honor transferencoding config option again
References: <20190409192733.10173-1-xypron.glpk@gmx.de>
        <20190409215856.GD92879@google.com>
        <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com>
        <xmqqef59gy10.fsf_-_@gitster-ct.c.googlers.com>
Date:   Wed, 08 May 2019 17:20:44 +0900
In-Reply-To: <xmqqef59gy10.fsf_-_@gitster-ct.c.googlers.com> (Junio
        C. Hamano's message of "Wed, 08 May 2019 17:18:03 +0900")
Message-ID: <xmqqa7fxgxwj.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DFC253A-716A-11E9-9D8F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since e67a228cd8a ("send-email: automatically determine
transfer-encoding"), the value of sendmail.transferencoding in the
configuration file is ignored, because $target_xfer_encoding is
already defined read_config sub parses the configuration file.

Instead of initializing variable $target_xfer_encoding to 'auto' on
definition, we have to set it to the default value of 'auto' if is
undefined after calling read_config() twice to parsing the
configuration files for "sendemail.transferencoding" and
"sendemail.$ident.transferencoding".

This is made trivial by the previous change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is the second one.  Totally untested, though.

 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ca7faff094..7458a0d1ef 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -231,7 +231,7 @@ sub do_edit {
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
-my $target_xfer_encoding = 'auto';
+my ($target_xfer_encoding);
 
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 
@@ -271,7 +271,7 @@ sub do_edit {
     "from" => [\$sender],
     "assume8bitencoding" => [\$auto_8bit_encoding],
     "composeencoding" => [\$compose_encoding],
-    "transferencoding" => [\$target_xfer_encoding],
+    "transferencoding" => [\$target_xfer_encoding, 'auto'],
 );
 
 my %config_path_settings = (
-- 
2.21.0-777-g83232e3864

