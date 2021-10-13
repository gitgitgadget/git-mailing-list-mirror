Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A299C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADCD611CA
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhJMTRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:17:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53896 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJMTRA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 15:17:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9F2CD8502;
        Wed, 13 Oct 2021 15:14:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=D9murBf3D2z2uZ+ChEWmb8Yy94Hb+rQWzvpidNfzgb4=; b=o3Nw
        GGCDeLUW6HG8Wgcjk5JbbhydXk9sT2xArHBOOU6lPpE3ZKqvDRH9DUy7itsEhDKv
        XDJSq/Fx1+DRrJ7D+8GcwcFIPR85hG2vTA6bC60nzSOUItapl9VXpdymhCaiysoq
        lCNF3CjumYYgmdr78IGIOg2NZPLfHKj2onPS0BI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2A99D8501;
        Wed, 13 Oct 2021 15:14:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 224B2D8500;
        Wed, 13 Oct 2021 15:14:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrea Monaco <andrea.monaco@autistici.org>
Cc:     git@vger.kernel.org
Subject: Re: Possibly wrong assignment in config.c
References: <87pms8rh2h.fsf@autistici.org>
Date:   Wed, 13 Oct 2021 12:14:54 -0700
Message-ID: <xmqqzgrcg2j5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9549370-2C59-11EC-B9BE-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrea Monaco <andrea.monaco@autistici.org> writes:

> config.c: In function 'git_config_copy_or_rename_section_in_file':
> config.c:3358:17: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>  3358 |       output[0] = '\t';
>       |       ~~~~~~~~~~^~~~~~

Hmph, with a wider context, I think the tool is pointing at the
assignment found here?

	while (fgets(buf, sizeof(buf), config_file)) {
		unsigned i;
		int length;
		int is_section = 0;
		char *output = buf;
		for (i = 0; buf[i] && isspace(buf[i]); i++)
			; /* do nothing */
		if (buf[i] == '[') {
			/* it's a section */
			int offset;
			...
			offset = section_name_match(&buf[i], old_name);
			if (offset > 0) {
				...
					output += offset + i;
					if (strlen(output) > 0) {
						...
						output -= 1;
						output[0] = '\t';
					}
				} else {
					copystr = store_create_section(new_name, &store);
				}
			}
			remove = 0;
		}

Inside the "if (buf[i] == '[')" block, i is not negative, and inside
the "if (offset > 0)" block, offset is positive.  So "output +=
offset + i", unless offset and i are so huge to cause integer
wraparound, would only be incrementing offset by some positive
integer.  So immediately after "output += offset + i", output is at
least buf+1, if not larger, and &output[-1] is at least pointing at
&buf[0], no?

Or is the tool worried about integer addition (offset+i) wrapping
around?

Or I may need a bit more caffeine, perhaps?  I am puzzled...

Thanks.



