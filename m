Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0487720705
	for <e@80x24.org>; Thu,  8 Sep 2016 17:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbcIHRiB (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 13:38:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59630 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752669AbcIHRiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 13:38:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FAE63CAF9;
        Thu,  8 Sep 2016 13:37:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kOUZRoT+7KqwmvL+2/es3VwbwOU=; b=cebmnR
        icy3JDabzOSFIVg0oQU7yReCHCZharD/dTs9d1HxIGYXuKt/yTumk9+wEdlRyi7t
        57VmIaCemz+cZZdhSGIYDTTAeu/Mu6x1HIiZHedic05bHWHnFX9Zui7M3QR2VhBA
        aUxgZVVW4IvrzijhP8vWZxABPjViSMNo3Fi4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sWNzxI6y/kalmcw9KZ9MnXYrzp2Y1Lu/
        K8Kvyi1Ul1duvDFmvBo7nRE2Q1aZEruUcAAm4RKod++7zQUa+HGwqc4CAH/lbUrZ
        TqiFY0nSQH28kfYpGPQrdQoIhtMNUNP+P8q39pee0a8W1gVRdcHIYliTKgYQiLPo
        QQxQktUuRq8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E6F73CAF8;
        Thu,  8 Sep 2016 13:37:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7E853CAF7;
        Thu,  8 Sep 2016 13:37:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        tboegi@web.de, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v1 2/2] read-cache: make sure file handles are not inherited by child processes
References: <20160905211111.72956-1-larsxschneider@gmail.com>
        <20160905211111.72956-3-larsxschneider@gmail.com>
        <20160906210632.GA28263@starla>
        <7B903664-0324-4375-A81C-1317020CBE9B@gmail.com>
        <20160907181036.GA14931@starla>
        <xmqqtwdrmuvo.fsf@gitster.mtv.corp.google.com>
        <F33245FC-C53A-4977-8E72-68AF3D2BB8BB@gmail.com>
Date:   Thu, 08 Sep 2016 10:37:53 -0700
In-Reply-To: <F33245FC-C53A-4977-8E72-68AF3D2BB8BB@gmail.com> (Lars
        Schneider's message of "Thu, 8 Sep 2016 07:57:39 +0200")
Message-ID: <xmqqbmzyi972.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB2F6874-75EA-11E6-876D-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>>> We probably should be using O_NOATIME for all O_RDONLY cases
>>> to get the last bit of performance out (especially since
>>> non-modern-Linux systems probably still lack relatime).
>> 
>> No, please do not go there.
>> 
>> The user can read from a file in a working tree using "less",
>> "grep", etc., and they all update the atime, so should "git grep".
>> We do not use atime ourselves on these files but we should let
>> outside tools rely on the validity of atime (e.g. "what are the
>> files that were looked at yesterday?").
>> 
>> If you grep for noatime in our current codebase, you'd notice that
>> we use it only for files in objects/ hierarchy, and that makes very
>> good sense.  These files are what we create for our _sole_ use and
>> no other tools can peek at them and expect to get any useful
>> information out of them (we hear from time to time that virus
>> scanners leaving open file descriptors on them causing trouble, but
>> that is an example of a useless access), and that makes a file in
>> objects/ hierarchy a fair game for noatime optimization.
>
> How do we deal with read-cache:ce_compare_data, though?

We are using open() in our current code in that codepath, without
NOATIME.  We shouldn't start using git_open_noatime() merely for
convenience.

We would probably want to do a preliminary refactoring so that we
can say "we want only CLOEXEC and not NOATIME".  Perhaps we would
want to make the existing one in sha1_file.c to something like:

	int git_open_noatime(const char *name)
        {
		return git_open(name, GIT_OPEN_NOATIME);
	}

and then add

	#define GIT_OPEN_NOATIME 01

to cache.h and add

	int git_open(const char *name, unsigned int flag)
        {
        	static int open_noatime = O_NOATIME;

		for (;;) {
                	int fd, open_flag;

                        open_flag = 0;
                        if (flag & GIT_OPEN_NOATIME)
                                open_flag |= open_noatime;

			errno = 0;
                        fd = open(name, O_RDONLY | open_flag);
                        if (fd >= 0)
                        	return fd;

			if (errno == ENOENT || !open_flag)
				return -1;

			/* The failure may be due to additional	flags */
                       	if ((flag & GIT_OPEN_NOATIME) &&
			    (open_flag & O_NOATIME)) {
				flag &= ~GIT_OPEN_NOATIME;
				open_noatime = 0;
			}
		}
	}

to wrapper.c in the first step, which is a "no-op refactoring" step.

Then add

	#define GIT_OPEN_CLOEXEC 02

and update git_open(), perhaps like so:

	int git_open(const char *name, unsigned int flag)
        {
        	static int open_noatime = O_NOATIME;
        	static int open_cloexec = O_CLOEXEC;

		for (;;) {
                	int fd, open_flag;

                        open_flag = 0;
                        if (flag & GIT_OPEN_NOATIME)
                                open_flag |= open_noatime;
                        if (flag & GIT_OPEN_CLOEXEC)
                                open_flag |= open_cloexec;

			errno = 0;
                        fd = open(name, O_RDONLY | open_flag);
                        if (fd >= 0)
                        	return fd;

			if (errno == ENOENT || !open_flag)
				return -1;

			/* The failure may be due to additional	flags */
                       	if ((flag & GIT_OPEN_NOATIME) &&
			    (open_flag & O_NOATIME)) {
				flag &= ~GIT_OPEN_NOATIME;
                                open_noatime = 0;
			}
                       	if ((flag & GIT_OPEN_CLOEXEC) &&
			    (open_flag & O_CLOEXEC)) {
				flag &= ~GIT_OPEN_CLOEXEC;
                                open_cloexec = 0;
			}
		}
	}

The retry logic is "if we were asked to do this flag, and if we did
pass that flag, then we know open() with that flag fails here, so we
won't waste time trying with it again", which came from the NOATIME
codepath we already have, but it may not match what we use CLOEXEC
for and may need to be adjusted.  I didn't think that part of the
code through.

Then the ce codepath that reads from the working tree would use

	git_open(ce->name, GIT_OPEN_CLOEXEC);

to obtain the file descriptor for reading, perhaps?
