Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E28C2092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750711AbdAVWGs (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:06:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63681 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750703AbdAVWGs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:06:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECFC963E47;
        Sun, 22 Jan 2017 17:06:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CgnzO7bv/8MHkP7UIULrQezIRGQ=; b=NBLsEQ
        UH6pW9W/T/1a73TUX5K9H8Yr/POstLNs9ZWpk9BqVZqEfLsGAbmmix9u131c3/mm
        YOGB3CYDPtaNc2ynZ/XR3XCG19hdc6o0RceBrmLWrD4Ia1SDD0CrDPspU3Mak7a7
        fqm9huRTQZltkHo+4X73oeoZT/Gmho+eOQLZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=veGUzUY7TrOGbDFJA2ZEUMpQIPYluYjc
        yHmHoqLQ8AziTlfurPgpYbezeCqoul1HoLqXaVEco2DO2s4aP+cJNwWJyZeQTAZR
        l6+Z4Hhia/reUwqBeBLxo3GAMC8xhxHI4RGGolvVQUAETZSOZ9fox4ZOsM37HE8m
        yiL/Gbkyd60=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1C0763E46;
        Sun, 22 Jan 2017 17:06:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48B8F63E45;
        Sun, 22 Jan 2017 17:06:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ariel Davis <ariel.z.davis@icloud.com>
Cc:     git@vger.kernel.org
Subject: Re: interaction between git-diff-index and git-apply
References: <C45218A3-8A81-4307-AADB-FBA4F51EAC51@icloud.com>
Date:   Sun, 22 Jan 2017 14:06:45 -0800
In-Reply-To: <C45218A3-8A81-4307-AADB-FBA4F51EAC51@icloud.com> (Ariel Davis's
        message of "Sun, 22 Jan 2017 14:09:51 -0500")
Message-ID: <xmqqinp6vjey.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10AFB680-E0EF-11E6-866B-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ariel Davis <ariel.z.davis@icloud.com> writes:

> I have noticed an interesting interaction between git-diff-index and git-apply.
> Essentially, it seems that if we start with a clean working tree, then
> git-apply a patch, then git-apply the reverse of that patch, git-diff-index
> still thinks files are modified. But then, if we git-status, git-diff-index
> seems to "realize" the files are actually not modified.

That is perfectly normal and you are making it too complex.  You do
not need to involve "git apply" at all.

    $ git init
    $ echo hello >file && git add file && git commit -m initial
    $ git diff-index HEAD
    $ echo hello >file
    $ git diff-index HEAD
    :100644 100644 ce013625030ba8dba906f756967f9e9ca394464a 0000000000000000000000000000000000000000 M	file

    $ git update-index --refresh
    $ git diff-index HEAD
    $ exit

A few things about Git that are involved in the above are:

 * There are plumbing commands that are geared more towards
   scripting Git efficiently and there are end-user facing Porcelain
   commands.

 * Git uses cached "(l)stat" information to avoid having to inspect
   the contents of the file all the time.  The idea is that Git
   remembers certain attributes (like size and last modified time)
   of a file when the contents of the file and the blob object in
   the index are the same (e.g. when you did "git add file" in the
   above sequence), and it can tell a file was edited/modified if
   these attributes are different from those recorded in the index
   without comparing the contents of the file with the blob.

 * The plumbing commands trust the cached "(l)stat" information for
   efficiency and whoever uses the plumbing commands are responsible
   for culling the false positives when cached "(l)stat" information
   is used to see which paths are modified.  They (typically these
   are scripted commands) do so with "update-index --refresh".

 * The Porcelain commands sacrifice the efficiency and internally do
   an equivalent of "update-index --refresh" at the beginning to
   hide the false positive.

After your reverse application of the patch with "git apply" (or the
second "echo hello" into the file in the above example), the
contents of the file is equivalent to what is in the index, but the
last modified timestamp (among others) is different because you
wrote into the file.  If you do not do "update-index --refresh"
before running "diff-index" again, "diff-index" will notice and
report the fact that you touched that file.  If you run "git status",
"git diff", etc., they internally do "update-index --refresh" and
then after that until you touch the file on the filesystem, the
cached "(l)stat" information will match and you will stop seeing the
false positive.
