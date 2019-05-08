Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E671F45F
	for <e@80x24.org>; Wed,  8 May 2019 10:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfEHKN4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 06:13:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51592 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfEHKN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 06:13:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EB505B1EE;
        Wed,  8 May 2019 06:13:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l8co/TVmzEgFLHnUVJgHpH1Eev0=; b=KeFfP7
        pcfZ4LqXt6pQOqEy5o2XNt8jcD6chPjRr2I7e39qcj6w6NyheFfUZTIWc7u3RxUB
        L4b4whjUwbGJhxAIm6Gf2n7RG5N0USEWW9fSEgL4GFN794dn41dNHiD3fjEoyJzE
        V+H9a2TGnO2kNt7EDEDpcEUMawFyn9rXUnOPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OjQehIRS+H7Mo6ckpacwQBjldlhhJlPd
        hgQY+zkSG5Ktm5s1IqKvB29H+JtbqJEFLaIharsBTG6GD5+CrK3jlgJT2CGUixf+
        Ex8w8Qvx0XENnBV7K9VKE+Z6VH892M8foDRWKr7xY9DHxi+4G4BadzBPTl2a9TMN
        wT1spuPxTQA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46E7B5B1ED;
        Wed,  8 May 2019 06:13:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 71F7D5B1EC;
        Wed,  8 May 2019 06:13:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Brian M Carlson <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Re* [PATCH 1/1] send-email: fix transferencoding config option
References: <20190409192733.10173-1-xypron.glpk@gmx.de>
        <20190409215856.GD92879@google.com>
        <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com>
        <xmqqef59gy10.fsf_-_@gitster-ct.c.googlers.com>
Date:   Wed, 08 May 2019 19:13:46 +0900
In-Reply-To: <xmqqef59gy10.fsf_-_@gitster-ct.c.googlers.com> (Junio
        C. Hamano's message of "Wed, 08 May 2019 17:18:03 +0900")
Message-ID: <xmqqzhnxfe3p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F873E1F4-7179-11E9-85EF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So, here is a two-patch series that tries to do so, primarily done
> to gauge if there still is the level of interest needed to make it
> worth for us to pursue this topic.  Here is the first one; I'll send
> the second one that takes advantage of this change separately (but
> it should be trivial to imagine what that step would involve).
>
> -- >8 --
> Subject: [PATCH 1/2] send-email: update the mechanism to set default configuration values
>
> The program has a good mechanism to specify the fallback default
> values for boolean configuration variables after two invocations of
> read_config() for "sendmail.$ident.$var" and "sendemail.$var" have
> not found any configuration.  Imitate it so that we can set the
> default values for non-boolean variables as well.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-send-email.perl | 51 ++++++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 22 deletions(-)

This one was embarrassingly buggy, and needs the following squashed
in.

Sorry about that.

 git-send-email.perl | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ca7faff094..831947c7ed 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -411,7 +411,7 @@ sub read_config {
 	}
 
 	foreach my $setting (keys %config_settings) {
-		my $target = $config_settings{$setting};
+		my $target = $config_settings{$setting}->[0];
 		next if $setting eq "to" and defined $no_to;
 		next if $setting eq "cc" and defined $no_cc;
 		next if $setting eq "bcc" and defined $no_bcc;
@@ -447,10 +447,13 @@ sub read_config {
 }
 
 # fall back to builtin defaults
-for my $setting (values %config_settings) {
-	if (@$setting == 2 && !defined (${$setting->[0]})) {
-		${$setting->[0]} = $setting->[1];
-	}
+while (my ($name, $setting) = each %config_settings) {
+	next unless @$setting == 2;
+
+	my ($target, $default) = @$setting;
+	if (ref($target) eq "SCALAR") {
+		$$target = $default unless defined $target;
+	} # elsif ... for other types later.
 }
 
 # 'default' encryption is none -- this only prevents a warning

