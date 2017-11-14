Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2C8202A0
	for <e@80x24.org>; Tue, 14 Nov 2017 05:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751014AbdKNFao (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 00:30:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61018 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750734AbdKNFam (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 00:30:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06457ADDBB;
        Tue, 14 Nov 2017 00:30:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=medIyffd/5ipNaupcYD92IHl6a4=; b=NI+Gk3
        y0pY5a1vmeroiTqIepECfhWdYPBga0GKYhjQNiLxVZTYEApbZ4qf4pbpwtfLKX2j
        qkGNO5mHTdm85tnNz7XoSyMOT/ZRf6tONSlENYoIULEABwFRJnRJlU7OmzoO0YvL
        5zBeRnM6TKw53l1DkH96/13COpzdiZZX9oPvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HTXhVdJ68IbJq4P45Vc4m054wrCZh8+h
        CCpifZ9GiAdWJXLyOyJ0tyYRtg0z2SKejm2moUgqpIDz740EExbRH7/IKUdfaBhY
        dZ9zA+4l4IoBc9DMmLkRRF2yv8iQUJMfnvYKy1L3QWic1Bb1F7g8Me6BTh7R87bh
        uuJQLKNx5+w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F14B4ADDBA;
        Tue, 14 Nov 2017 00:30:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F1D1ADDB9;
        Tue, 14 Nov 2017 00:30:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 21/30] merge-recursive: Add get_directory_renames()
References: <20171110190550.27059-1-newren@gmail.com>
        <20171110190550.27059-22-newren@gmail.com>
Date:   Tue, 14 Nov 2017 14:30:35 +0900
In-Reply-To: <20171110190550.27059-22-newren@gmail.com> (Elijah Newren's
        message of "Fri, 10 Nov 2017 11:05:41 -0800")
Message-ID: <xmqqmv3p4ebo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F15B1E72-C8FC-11E7-BB00-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +		entry = dir_rename_find_entry(dir_renames, old_dir);
> +		if (!entry) {
> +			entry = xcalloc(1, sizeof(struct dir_rename_entry));
> +			hashmap_entry_init(entry, strhash(old_dir));

Please make these two lines into its own dir_rename_entry_init()
helper.  Because the structure is defined as

+struct dir_rename_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	char *dir;
+	unsigned non_unique_new_dir:1;
+	char *new_dir;
+	struct string_list possible_new_dirs;
+};
+

in the previous patch, we'd want to see its string_list member to be
initialised explicitly (we do not want to depend on "filling with
NUL happens to make it a NODUP kind of string_list, which suits our
purpose").  The definition of _init() function may belong to the
previous step.

