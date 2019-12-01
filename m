Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58460C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 15:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C64520725
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 15:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ri39OHXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfLAPi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 10:38:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58763 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfLAPi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 10:38:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 757853D13C;
        Sun,  1 Dec 2019 10:38:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M95RyqyYwUXO
        zuFC255JI5VgBHs=; b=ri39OHXcMNERuL3kja0Jh1uAP93cC5oV0MceEbZB74hE
        zBHMlWYv+BFSosCM5ExzksGO9egZFMRDzj4PCYijLDPKv9WK3p5r5WKi6tArF3fN
        eOTydL/mLjL39zM76Fcxl66vK8jDx78v9sI1YsB6bvVcRC6uhiLCyASL/zAk1yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Kpvymf
        9MJl0MHfMMViSk6PLpb4UW30Y7+uOQN/JJJf1gM0ehb71g+uKl1e+hWRhnijV0K7
        zThs6QZLJ7oCxmWqBuz5s723UZXnhAajWbqRvf9z5eNAKS/V0bz3d+BXMne3hZ5q
        RuY49t3nbAJ+UO04cOlhdDK4o0J9xuWRgTB5A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CD533D139;
        Sun,  1 Dec 2019 10:38:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFA033D138;
        Sun,  1 Dec 2019 10:38:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9300-fast-import: don't hang if background fast-import exits too early
References: <20191130104644.17350-1-szeder.dev@gmail.com>
        <xmqqsgm512vl.fsf@gitster-ct.c.googlers.com>
        <20191201093148.GH23183@szeder.dev>
Date:   Sun, 01 Dec 2019 07:38:52 -0800
In-Reply-To: <20191201093148.GH23183@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Sun, 1 Dec 2019 10:31:48 +0100")
Message-ID: <xmqq36e412er.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ADFF5142-1450-11EA-9F96-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> > -	test_when_finished "
>> > +	test_when_finished '
>> >  		exec 8>&-; exec 9>&-;
>> > -		kill $(cat V.pid) && wait $(cat V.pid)
>> > -		true"
>> > +		kill $(cat V.sh.pid) && wait $(cat V.sh.pid)
>> > +		kill $(cat V.fi.pid) && wait $(cat V.sh.pid)
>> > +		true'
>>=20
>> The original interpolates the PID of the fast-import when
>> "when-finished" program is registered, so it is OK if somebody else
>> removed V.pid file; the new one interpolates when "when-finished"
>> program is run, reading from V.??.pid, so somebody needs to make
>> sure these pid files will stay around.  I do not think it is an
>> issue as I suspect we've left it to the global clean-up procedure
>> that removes the trash directory to remove the pid file.
>
> In the original the same shell process starts 'git fast-import',
> writes its pidfile, and registers the test_when_finished commands, so
> we can be sure that the pid file is already present when the shell
> runs the $(cat V.pid) command substitutions.

Yes.  It also means that V.pid file was not very useful in the
when-finished handler in the original.  We could have just used a
shell variable.

> With this patch that's not the case anymore, because the background
> subshell starts 'git fast-import' and writes the pidfile, but the main
> shell process registers the test_when_finished commands.  IOW these
> two shell processes are racing, and it's possible that the
> test_when_finished command is executed before the background subshell
> can write the pidfile.  So double quotes around the block of
> test_when_finished commands are not good.

Oh, I was not questioning that.  I wanted to make sure, and I was
doing so aloud, that these files are

 (1) created way before, and=20
 (2) left on the filesystem

when-finished handler actually runs, because the original did not
need any guarantee for (2), but now the sq version does.
