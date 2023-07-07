Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684DBEB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 23:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjGGXPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 19:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGGXPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 19:15:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938FE2125
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 16:15:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEBEC2A55E;
        Fri,  7 Jul 2023 19:15:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+FSFfs/ZymPeyj7g5zgI4olMK24c9a16S6wb15
        bt98A=; b=B4srpAJ/eYUOvpD/KZ6cv1DI+TU1RVJXLCvPSye7Mi/zhB9WzAQL/s
        pPdEvRRqKcmaclTLRS7wrfVyG6p5cl4a9UW9fxN8JREQiwpJKbf/53j/N8qBzwRZ
        uoVis0bMhqJuYcZr2mVM7TJe5RxO3BmQmRIPFvx+l0InFAmWS2FF4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E86A42A55D;
        Fri,  7 Jul 2023 19:15:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F1AA2A55C;
        Fri,  7 Jul 2023 19:15:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH v2 1/3] Enable gitattributes read from sparse directories
References: <20230701064843.147496-1-cheskaqiqi@gmail.com>
        <20230707151839.504494-1-cheskaqiqi@gmail.com>
        <20230707151839.504494-2-cheskaqiqi@gmail.com>
Date:   Fri, 07 Jul 2023 16:15:03 -0700
In-Reply-To: <20230707151839.504494-2-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Fri, 7 Jul 2023 11:18:37 -0400")
Message-ID: <xmqqzg4771qg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B056FA6-1D1C-11EE-ACF4-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> +	pos = index_name_pos_sparse(istate, path, strlen(path));
> +	pos = -pos-2;

With SP at appropriate places, i.e. "pos = -pos - 2".

But more importantly, where does the -2 come from?  For a missing
entry, we get a negative number, and the location that the cache
entry with the given path would be inserted can be recovered by
computing -pos - 1, and that is why 

	if (0 <= pos) {
		... handle existing ce at pos ...
	} else if (pos < 0) {
		pos = -pos - 1;
		... if such a path were in the index, it would have
		... been at pos
	}

looks fairly familiar to those who have read our code.  Even in such
a case, we do not blindly compute "-pos - 1", though.

In any case, this magic "adjustment" of the returned value needs to
be explained, perhaps in in-code comment around there.

> +	if (!path_in_cone_mode_sparse_checkout(path, istate) && pos>=0) {

With SP at appropriate places, i.e. " && 0 <= pos".

Thanks.
