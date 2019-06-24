Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830A11F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfFXSrd (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:47:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64351 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFXSrd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:47:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3451C7C644;
        Mon, 24 Jun 2019 14:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Y6Nnroqhmua9QWy/Cwx0QTgmTU=; b=ooKBkF
        T3eIo7nPc9JoSDvzdUsWBblaC7UCe12Lld9G3nMf11G5wb/ZcFMRvExhpZQoepdI
        oor79SirqESTL0VKbBPD6USAcJfUKsd7dy67ff+SF/um3B+2r/+PCf+jf3M4UgL9
        LWNZtCpvnT4up/eAObgbveSbQCPuz6pzbd+P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gn1lCjC93SPQyVMcMNnPC6vD04tP+fbO
        71I/9VFmwgW8sA3o7uhga+dn1ly8rxv4ELlJUdzMN822QownyeP1i8WpHDmF/1qa
        GRxh11sdyxuzkhn6zcYr8yrPdyBGmXxbEJAop+mdpbesQTyAfIe8iRbsedvtgvkP
        a2Voempx4+w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2AF167C643;
        Mon, 24 Jun 2019 14:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3457A7C641;
        Mon, 24 Jun 2019 14:47:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     robbat2@gentoo.org
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: include contrib docs in dist-doc tarballs
References: <20190623215046.24030-1-robbat2@gentoo.org>
Date:   Mon, 24 Jun 2019 11:47:26 -0700
In-Reply-To: <20190623215046.24030-1-robbat2@gentoo.org> (robbat2@gentoo.org's
        message of "Sun, 23 Jun 2019 14:50:46 -0700")
Message-ID: <xmqqk1dahlc1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83DE071E-96B0-11E9-9770-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

robbat2@gentoo.org writes:

> +.PHONY: dist-doc distclean contrib-doc

I do not think I want to do this.

Contrib are not part of the core because they are not.  We do not
install their "executable" from the top-level Makefile and I prefer
to keep it that way.  Why should we ship their documentation
ourselves?  If somebody wants to build and distribute the contrib
material, they should be spending their cycles to also build and
distribute the matching docs, not me.

> +# subdirs with install-html & install-man targets
> +contrib_doc_dirs := contrib/contacts contrib/subtree
> +doc_dirs := Documentation $(contrib_doc_dirs)
> +
> +contrib-doc:
> +	$(MAKE) -C contrib/svn-fe svn-fe.html svn-fe.1 # no doc target
> +	for d in $(contrib_doc_dirs) ; do \
> +		$(MAKE) -C $$d doc ; \
> +	done
> +
> +dist-doc: doc contrib-doc
>  	$(RM) -r .doc-tmp-dir
>  	mkdir .doc-tmp-dir
> -	$(MAKE) -C Documentation WEBDOC_DEST=../.doc-tmp-dir install-webdoc
> +	for d in $(doc_dirs) ; do \
> +		$(MAKE) -C $$d \
> +			DESTDIR=$(PWD)/ \
> +			htmldir=/.doc-tmp-dir/ \
> +			install-html ; \
> +	done
> +	: # These files have no install targets
> +	cp --target .doc-tmp-dir \

"cp --target"???  It may be tempting but I do not think we can rely
on it being available everywhere.

> +		contrib/subtree/git-subtree.txt \
> +		contrib/contacts/git-contacts.txt \
> +		contrib/svn-fe/svn-fe.html \
> +		contrib/svn-fe/svn-fe.txt
