Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEFCC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 04:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJYEkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 00:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiJYEkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 00:40:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3818E1D67E
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 21:40:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36244154BAA;
        Tue, 25 Oct 2022 00:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F3skyrtt64in6883EThgEC7wxqWcM9xF44QBsc
        NGj14=; b=WsStOUO3LngUC98ua3gTQK8VpC/B4zAyinDHTnXH5oV7NrFbQZSGTN
        QIpEQdZyBiDUtpdRd/JVrrygb8y2Mqag2j1n7kgGM4cdMu0eH5cVr9XA3OroagS7
        PhiHnAr6k0HjvBImuoDcc4u2v5/LX0TQuGAWA2n8Xj/vDAwF2Of9E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E621154BA9;
        Tue, 25 Oct 2022 00:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C771154BA6;
        Tue, 25 Oct 2022 00:40:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 0/2] Document fsck msg ids
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
        <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
        <xmqqwn8oplsh.fsf@gitster.g>
Date:   Mon, 24 Oct 2022 21:40:09 -0700
In-Reply-To: <xmqqwn8oplsh.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        24 Oct 2022 21:30:38 -0700")
Message-ID: <xmqqfsfcplcm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BC9C340-541F-11ED-84EF-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  I did a bit of sanity checking and it made my earlier
> suspicion stronger.  We MUST have at least an automated checker to
> check the doc against the fsck.h header, if not an automated
> generator of the doc from the fsck.h header.

FYI, here are a pair of quick-and-dirty Perl scripts that I used for
the sanity checking.  The first one "parses" the fsck-msgs.txt and
formats lines like

    badTagName	INFO

i.e. camelCased error message name, a TAB, and the severity.

The second one reads the FOREACH_FSCK_MSG_ID() definition in fsck.h
that look like "FUNC(BAD_TAG_NAME, INFO)", camelcases the name and
shows what can be compared with the output of the first one.

There are two sanity checks that must pass when a developer updates
the documentation.

 - The output from m.perl on the documentation must already be sorted.

 - The output from n.perl on fsck.h, when sorted, must match the
   output from m.perl on the documentation.

$ cat >m.perl <<\EOF
#!/usr/bin/perl

my ($previous, $current);

while (<>) {
	if (!defined $current) {
		if (/^\`([a-zA-Z0-9]*)\`::/) {
			$current = $1;
			if ((defined $previous) &&
			    ($current le $previous)) {
				print STDERR "$previous >= $current???\n";
			}
		}
	} elsif (/^\s+\(([A-Z]+)\) /) {
		print "$current	$1\n";
		$previous = $current;
		undef $current;
	}
}
EOF
$ cat >n.perl <<\EOF
#!/usr/bin/perl

while (<>) {
	if (/^\s+FUNC\(([0-9A-Z_]+), ([A-Z]+)\)/) {
		my ($name, $severity) = ($1, $2);
		my ($first) = 1;
		$name = join('',
			     map {
				     y/A-Z/a-z/;
				     if (!$first) {
					     s/^(.)/uc($1)/e;
				     } else {
					     $first = 0;
				     }
				     $_;
			     }
			     split(/_/, $name));
		print "$name	$severity\n";
	}
}
EOF
$ perl m.perl Documentation/fsck-msgids.txt >/var/tmp/1
$ sort /var/tmp/1 >/var/tmp/2
$ diff -u /var/tmp/1 /var/tmp/2
#### no output should appear in the above comparison
$ perl n.perl fsck.h | sort >/var/tmp/2
$ diff -u /var/tmp/1 /var/tmp/2
#### no output should appear in the above comparison

