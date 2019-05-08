Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034951F45F
	for <e@80x24.org>; Wed,  8 May 2019 08:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfEHISJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 04:18:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58935 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfEHISI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 04:18:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED07D148CE2;
        Wed,  8 May 2019 04:18:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NXgM0EbzxscXygeS9ZpeZ+hxpZ8=; b=rEjwls
        4NGY2goQ6OXXMxessgKjCKAB2bExfoaDqGy4ZZIyL+q8crCTVxHK9N5VaMnYOSC9
        ajxzTDOYANgo1G5JCOLI7Ny6AFJPKCu7NrYPWSPxx2X8kNO7oL0jJkGEBfgt0P8e
        8tuvDVThuqlDWdMtXKNP1xJOLaSSgEVkGJ7MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sX4e3ZnG7QdYpkLTpnwlUwdY45ok0H8E
        o22py/bnURiPcZVN6fzdkJkK0KVa+WfT5HdjsT0CQBO+Q2UVexgriX71OBSlMwX3
        gIcFrO3eoVuyAZGtMvRGKHK7TuIX5pda7IWW/AZ10/7rTma/YuiPnkv6TwqEoz+l
        K9StBH7rEVw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4320148CE1;
        Wed,  8 May 2019 04:18:04 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 502BA148CDF;
        Wed,  8 May 2019 04:18:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Brian M Carlson <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re* [PATCH 1/1] send-email: fix transferencoding config option
References: <20190409192733.10173-1-xypron.glpk@gmx.de>
        <20190409215856.GD92879@google.com>
        <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 08 May 2019 17:18:03 +0900
In-Reply-To: <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 10 Apr 2019 12:48:38 +0900")
Message-ID: <xmqqef59gy10.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD6C11EE-7169-11E9-B93E-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if we can follow the pattern used by the code to handle the
> fallback for %config_bool_settings we can see immediately after
> these two calls to read_config()?  That is, each of the element in
> the %config_* hash is not merely a pointer to where the value is
> stored, but also knows what the default fallback value should be,
> and a loop _in the caller of_ read_config(), after it finishes
> making calls to the read_config function, fills in the missing
> default?

So, here is a two-patch series that tries to do so, primarily done
to gauge if there still is the level of interest needed to make it
worth for us to pursue this topic.  Here is the first one; I'll send
the second one that takes advantage of this change separately (but
it should be trivial to imagine what that step would involve).

-- >8 --
Subject: [PATCH 1/2] send-email: update the mechanism to set default configuration values

The program has a good mechanism to specify the fallback default
values for boolean configuration variables after two invocations of
read_config() for "sendmail.$ident.$var" and "sendemail.$var" have
not found any configuration.  Imitate it so that we can set the
default values for non-boolean variables as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 51 ++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f4c07908d2..ca7faff094 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -250,28 +250,28 @@ sub do_edit {
 );
 
 my %config_settings = (
-    "smtpserver" => \$smtp_server,
-    "smtpserverport" => \$smtp_server_port,
-    "smtpserveroption" => \@smtp_server_options,
-    "smtpuser" => \$smtp_authuser,
-    "smtppass" => \$smtp_authpass,
-    "smtpdomain" => \$smtp_domain,
-    "smtpauth" => \$smtp_auth,
-    "smtpbatchsize" => \$batch_size,
-    "smtprelogindelay" => \$relogin_delay,
-    "to" => \@initial_to,
-    "tocmd" => \$to_cmd,
-    "cc" => \@initial_cc,
-    "cccmd" => \$cc_cmd,
-    "aliasfiletype" => \$aliasfiletype,
-    "bcc" => \@bcclist,
-    "suppresscc" => \@suppress_cc,
-    "envelopesender" => \$envelope_sender,
-    "confirm"   => \$confirm,
-    "from" => \$sender,
-    "assume8bitencoding" => \$auto_8bit_encoding,
-    "composeencoding" => \$compose_encoding,
-    "transferencoding" => \$target_xfer_encoding,
+    "smtpserver" => [\$smtp_server],
+    "smtpserverport" => [\$smtp_server_port],
+    "smtpserveroption" => [\@smtp_server_options],
+    "smtpuser" => [\$smtp_authuser],
+    "smtppass" => [\$smtp_authpass],
+    "smtpdomain" => [\$smtp_domain],
+    "smtpauth" => [\$smtp_auth],
+    "smtpbatchsize" => [\$batch_size],
+    "smtprelogindelay" => [\$relogin_delay],
+    "to" => [\@initial_to],
+    "tocmd" => [\$to_cmd],
+    "cc" => [\@initial_cc],
+    "cccmd" => [\$cc_cmd],
+    "aliasfiletype" => [\$aliasfiletype],
+    "bcc" => [\@bcclist],
+    "suppresscc" => [\@suppress_cc],
+    "envelopesender" => [\$envelope_sender],
+    "confirm"   => [\$confirm],
+    "from" => [\$sender],
+    "assume8bitencoding" => [\$auto_8bit_encoding],
+    "composeencoding" => [\$compose_encoding],
+    "transferencoding" => [\$target_xfer_encoding],
 );
 
 my %config_path_settings = (
@@ -446,6 +446,13 @@ sub read_config {
 	${$setting->[0]} = $setting->[1] unless (defined (${$setting->[0]}));
 }
 
+# fall back to builtin defaults
+for my $setting (values %config_settings) {
+	if (@$setting == 2 && !defined (${$setting->[0]})) {
+		${$setting->[0]} = $setting->[1];
+	}
+}
+
 # 'default' encryption is none -- this only prevents a warning
 $smtp_encryption = '' unless (defined $smtp_encryption);
 
-- 
2.21.0-777-g83232e3864

