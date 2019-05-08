Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7946B1F45F
	for <e@80x24.org>; Wed,  8 May 2019 10:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfEHK4N (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 06:56:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63066 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfEHK4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 06:56:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8378A1516A8;
        Wed,  8 May 2019 06:56:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=r0R44+xQkgtdv8AIoc4x3ZGVA
        Zo=; b=TmGmIhCLF1kttN23+tVmOqoNeopNAw2S2HR5wMUCudWmFD+MVUcOCVKwz
        72+Y7iPqbmdphRGBptdkVXq032fMSBh0kzKPGufEG94UohEGG/sXep4ao0VNTtR5
        sK1sFpbV7MnHfhcrn3XZ8PrgwxsNhURS8RT2ZMCCZrbhY4+mqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=joubww0T2cgfg3Dbx3C
        Q41W5PkOh9YhGCNyxIxMoXQWRDB+67Cj2lWRNuDOhHL4+JRJ7PkIFydDq+9l+Lru
        ccns8iTg94d9ZJn4v6JjJzSQzfjsshkRRaSvyh2kVNBoeshTJtWW9jmdAnhRsw7w
        0sN/lfvpLnbTG3hLYiUFBBOM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B8901516A7;
        Wed,  8 May 2019 06:56:10 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E724C1516A6;
        Wed,  8 May 2019 06:56:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 1/2] send-email: update the mechanism to set default  configuration values
Date:   Wed,  8 May 2019 19:56:06 +0900
Message-Id: <20190508105607.178244-2-gitster@pobox.com>
X-Mailer: git-send-email 2.21.0-777-g83232e3864
In-Reply-To: <xmqqzhnxfe3p.fsf@gitster-ct.c.googlers.com>
References: <xmqqzhnxfe3p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: E34A6E82-717F-11E9-B136-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The program has a good mechanism to specify the fallback default
values for boolean configuration variables after two invocations of
read_config() for "sendmail.$ident.$var" and "sendemail.$var" have
not found any configuration.  Imitate it so that we can set the
default values for non-boolean variables as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 56 ++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f4c07908d2..98bc295c6e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -250,28 +250,28 @@ sub do_edit {
 );
=20
 my %config_settings =3D (
-    "smtpserver" =3D> \$smtp_server,
-    "smtpserverport" =3D> \$smtp_server_port,
-    "smtpserveroption" =3D> \@smtp_server_options,
-    "smtpuser" =3D> \$smtp_authuser,
-    "smtppass" =3D> \$smtp_authpass,
-    "smtpdomain" =3D> \$smtp_domain,
-    "smtpauth" =3D> \$smtp_auth,
-    "smtpbatchsize" =3D> \$batch_size,
-    "smtprelogindelay" =3D> \$relogin_delay,
-    "to" =3D> \@initial_to,
-    "tocmd" =3D> \$to_cmd,
-    "cc" =3D> \@initial_cc,
-    "cccmd" =3D> \$cc_cmd,
-    "aliasfiletype" =3D> \$aliasfiletype,
-    "bcc" =3D> \@bcclist,
-    "suppresscc" =3D> \@suppress_cc,
-    "envelopesender" =3D> \$envelope_sender,
-    "confirm"   =3D> \$confirm,
-    "from" =3D> \$sender,
-    "assume8bitencoding" =3D> \$auto_8bit_encoding,
-    "composeencoding" =3D> \$compose_encoding,
-    "transferencoding" =3D> \$target_xfer_encoding,
+    "smtpserver" =3D> [\$smtp_server],
+    "smtpserverport" =3D> [\$smtp_server_port],
+    "smtpserveroption" =3D> [\@smtp_server_options],
+    "smtpuser" =3D> [\$smtp_authuser],
+    "smtppass" =3D> [\$smtp_authpass],
+    "smtpdomain" =3D> [\$smtp_domain],
+    "smtpauth" =3D> [\$smtp_auth],
+    "smtpbatchsize" =3D> [\$batch_size],
+    "smtprelogindelay" =3D> [\$relogin_delay],
+    "to" =3D> [\@initial_to],
+    "tocmd" =3D> [\$to_cmd],
+    "cc" =3D> [\@initial_cc],
+    "cccmd" =3D> [\$cc_cmd],
+    "aliasfiletype" =3D> [\$aliasfiletype],
+    "bcc" =3D> [\@bcclist],
+    "suppresscc" =3D> [\@suppress_cc],
+    "envelopesender" =3D> [\$envelope_sender],
+    "confirm"   =3D> [\$confirm],
+    "from" =3D> [\$sender],
+    "assume8bitencoding" =3D> [\$auto_8bit_encoding],
+    "composeencoding" =3D> [\$compose_encoding],
+    "transferencoding" =3D> [\$target_xfer_encoding],
 );
=20
 my %config_path_settings =3D (
@@ -411,7 +411,7 @@ sub read_config {
 	}
=20
 	foreach my $setting (keys %config_settings) {
-		my $target =3D $config_settings{$setting};
+		my $target =3D $config_settings{$setting}->[0];
 		next if $setting eq "to" and defined $no_to;
 		next if $setting eq "cc" and defined $no_cc;
 		next if $setting eq "bcc" and defined $no_bcc;
@@ -446,6 +446,16 @@ sub read_config {
 	${$setting->[0]} =3D $setting->[1] unless (defined (${$setting->[0]}));
 }
=20
+# fall back to builtin defaults
+while (my ($name, $setting) =3D each %config_settings) {
+	next unless @$setting =3D=3D 2;
+
+	my ($target, $default) =3D @$setting;
+	if (ref($target) eq "SCALAR") {
+		$$target =3D $default unless defined $$target;
+	} # elsif ... for other types later.
+}
+
 # 'default' encryption is none -- this only prevents a warning
 $smtp_encryption =3D '' unless (defined $smtp_encryption);
=20
--=20
2.21.0-777-g83232e3864

