Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57881F859
	for <e@80x24.org>; Tue,  9 Aug 2016 22:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbcHIWke (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 18:40:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932515AbcHIWkd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 18:40:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 846EF34C6F;
	Tue,  9 Aug 2016 18:40:32 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XSQaB5hgFY9zygl1OMkqMdBsHz4=; b=exuMIx
	xiKjxZz1y7A+G/fIAFy48E174j1x3qMx/GFW2RJiJkj8x3GFIsJNRVnVoJqKuHZ/
	lfymI4kaIhIGfMjyVy3HAcOtdEx9AUg5tkj/ZWVzTXH2cMeuut++4opJnNaNo4pO
	aHqExEm5IDNiLCqF4WAPYkklJu4zDlgcjq8uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PWQmYy8UBFDjxJtOdK7DW8CB+hO0mJO7
	J8uI790KwOTFq/1BjDrkzp2zKVm54QyDqTDRMLldYPPBBzYRwY0NfY7uvQBAPTdG
	o0bBGIsWa4oCuEolfOHWC+y4lXFAP+30OYDX3T3K0oOfi7Nkyhci4CsQ8T7Ju+O3
	XqnNp3TUxfA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B85F34C6E;
	Tue,  9 Aug 2016 18:40:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1ED934C6D;
	Tue,  9 Aug 2016 18:40:31 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH RFC] diff: add SUBMODULE_DIFF format to display submodule diff
References: <20160809223219.17982-1-jacob.e.keller@intel.com>
Date:	Tue, 09 Aug 2016 15:40:29 -0700
In-Reply-To: <20160809223219.17982-1-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Tue, 9 Aug 2016 15:32:19 -0700")
Message-ID: <xmqq37md8t2a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4784CEA6-5E82-11E6-AD58-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> +static int prepare_submodule_diff(struct strbuf *buf, const char *path,
> +		unsigned char one[20], unsigned char two[20])
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	cp.git_cmd = 1;
> +	cp.dir = path;
> +	cp.out = -1;
> +	cp.no_stdin = 1;
> +	argv_array_push(&cp.args, "diff");
> +	argv_array_push(&cp.args, sha1_to_hex(one));
> +	argv_array_push(&cp.args, sha1_to_hex(two));
> +
> +	if (start_command(&cp))
> +		return -1;
> +
> +	if (strbuf_read(buf, cp.out, 0) < 0)
> +		return -1;
> +
> +	if (finish_command(&cp))
> +		return -1;
> +
> +	return 0;
> +}

It is a good idea to keep the submodule data isolated from the main
process by going through run-command/start-command interface (I
think the call to add_submodule_odb() should be rethought and
removed if possible).

I however wonder if you want to use src/dst-prefix to make the path
to the submodule appear there?  That is, if your superproject has a
submodule at "dir/" and two versions of the submodule changes a file
"doc/README", wouldn't you rather want to see

	diff --git a/dir/doc/README b/dir/doc/README

instead of comparison between a/doc/README and b/doc/README?
