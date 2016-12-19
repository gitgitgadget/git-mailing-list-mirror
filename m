Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3D51FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933769AbcLSSsr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:48:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57696 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933608AbcLSSsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:48:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20EEC58396;
        Mon, 19 Dec 2016 13:48:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TA2rg5+8EiencQQhMNr1U1UKxSE=; b=tE27Ez
        RQwUrix7V0I+PS9oWb9nL2ArFdjVkqZngv5xFhoZvbH9ZBaDrftjb1+JYrcyZyu6
        EoUs7B18JGIH8MaYsLk1eYJDGIvI0lDCGIofaPxOlzAno76FeZatANzqNpKgI3NJ
        rSsjpTv/ymORdmv3t7yaD8Sicn0n4kUTaakjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ufieL67Gb8PVdlVkXiNUgLlhKMpEMVNz
        Pal8ejI446tQwG2lSVh5pv2UtUlPAvtrAAJfb69DL8sud26WT/iCDZ+rr1i8MK7+
        2BCtFF7Q2XlrYFucf9LV/ryz11JLmB4xklYYQto3LVjnYN1++S4xN7DfU6TM0t0m
        fdh8yz/KDSM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 185C658395;
        Mon, 19 Dec 2016 13:48:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E18F58394;
        Mon, 19 Dec 2016 13:48:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 03/34] sequencer (rebase -i): implement the 'edit' command
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <a1361151ad1dad8f4dc3c412c7ed30f625d67ba0.1481642927.git.johannes.schindelin@gmx.de>
        <xmqqbmwf1pqd.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612191438200.54750@virtualbox>
Date:   Mon, 19 Dec 2016 10:48:36 -0800
In-Reply-To: <alpine.DEB.2.20.1612191438200.54750@virtualbox> (Johannes
        Schindelin's message of "Mon, 19 Dec 2016 14:46:08 +0100 (CET)")
Message-ID: <xmqq4m1zpxff.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C06A97D2-C61B-11E6-AD55-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +	strbuf_addf(&buf, "%s/patch", get_dir(opts));
>> > +	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
>> > +	init_revisions(&log_tree_opt, NULL);
>> > +	log_tree_opt.abbrev = 0;
>> > +	log_tree_opt.diff = 1;
>> > +	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
>> > +	log_tree_opt.disable_stdin = 1;
>> > +	log_tree_opt.no_commit_id = 1;
>> > +	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
>> > +	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
>> > +	if (!log_tree_opt.diffopt.file)
>> > +		res |= error_errno(_("could not open '%s'"), buf.buf);
>> > +	else {
>> > +		res |= log_tree_commit(&log_tree_opt, commit);
>> > +		fclose(log_tree_opt.diffopt.file);
>> > +	}
>> > +	strbuf_reset(&buf);
>> > +	strbuf_addf(&buf, "%s/message", get_dir(opts));
>> > +	if (!file_exists(buf.buf)) {
>> > +		find_commit_subject(commit_buffer, &subject);
>> > +		res |= write_message(subject, strlen(subject), buf.buf, 1);
>> > +		unuse_commit_buffer(commit, commit_buffer);
>> > +	}
>> > +	strbuf_release(&buf);
>> > +
>> > +	return res;
>> > +}
>> 
>> OK.  This seems to match what scripted make_patch does in a handful
>> of lines.  We probably should have given you a helper to reduce
>> boilerplate that sets up log_tree_opt so that this function does not
>> have to be this long, but that is a separate topic.
>> 
>> Does it matter output_format is set to FORMAT_PATCH here, though?
>> With --no-commit-id set, I suspect there is no log message or
>> authorship information given to the output.

Sorry, this was me being stupid.  

FORMAT_PATCH here does not have anythning to do with "git
format-patch" (and "git log --pretty=email").  The PATCH there is as
opposed to things like --stat and --raw.  We want patch text that
can be fed to "git apply" and it is absolutely the right thing to
use here.
