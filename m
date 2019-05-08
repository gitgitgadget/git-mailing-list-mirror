Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251981F45F
	for <e@80x24.org>; Wed,  8 May 2019 10:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfEHK4N (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 06:56:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60696 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfEHK4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 06:56:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C4B8149C1C;
        Wed,  8 May 2019 06:56:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=R3NLhbUrqWwDbioGrFQ1RUTt9
        04=; b=iu8TnwW3sYjEUgR7tXQT7dHpHxffUJpbW+tX1wZD830Z3nyuqMhCW6Yu8
        RrJMJmpGOabMAiCxJzO8wey/Riib78p4LahHacLq0IQmeKcwTt1d4zS9nsL38z4A
        dNloXBAKRWKlnU/gx3KDHKtFErvSBNBdXc4jMNMJTXbFoj4H18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=wZ6TXOjAppJoV/ml94a
        6/UT5Ha2EaTpKx8eu74uIteQYqgAWnI47M39ywQEdJCCsI2Du4qy53a5NvAD+2Xc
        Js9+ZB+dLUrevFRcw1/Pt3sXB1f2JzUi7lEEZZbu+yDZxU/qXBZdDnN6zSxAR6Ca
        unOEgmrgiJjdqow/Z7g4PX80=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05058149C1B;
        Wed,  8 May 2019 06:56:12 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6696C149C1A;
        Wed,  8 May 2019 06:56:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 2/2] send-email: honor transferencoding config option again
Date:   Wed,  8 May 2019 19:56:07 +0900
Message-Id: <20190508105607.178244-3-gitster@pobox.com>
X-Mailer: git-send-email 2.21.0-777-g83232e3864
In-Reply-To: <xmqqzhnxfe3p.fsf@gitster-ct.c.googlers.com>
References: <xmqqzhnxfe3p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: E42B5528-717F-11E9-B074-E828E74BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
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

It was made trivial to do so by the previous change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 98bc295c6e..b9dd775b63 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -231,7 +231,7 @@ sub do_edit {
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
-my $target_xfer_encoding =3D 'auto';
+my ($target_xfer_encoding);
=20
 my ($debug_net_smtp) =3D 0;		# Net::SMTP, see send_message()
=20
@@ -271,7 +271,7 @@ sub do_edit {
     "from" =3D> [\$sender],
     "assume8bitencoding" =3D> [\$auto_8bit_encoding],
     "composeencoding" =3D> [\$compose_encoding],
-    "transferencoding" =3D> [\$target_xfer_encoding],
+    "transferencoding" =3D> [\$target_xfer_encoding, 'auto'],
 );
=20
 my %config_path_settings =3D (
--=20
2.21.0-777-g83232e3864

