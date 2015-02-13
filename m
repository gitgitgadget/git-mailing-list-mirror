From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not their referent
Date: Fri, 13 Feb 2015 10:05:25 -0800
Message-ID: <xmqqoaoxoffe.fsf@gitster.dls.corp.google.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>
	<54DCDA42.2060800@alum.mit.edu>
	<CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>
	<54DE259C.4030001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart?= =?utf-8?Q?=C3=ADn?= Nieto 
	<cmn@elego.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 13 19:05:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMKcR-0000z8-3e
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 19:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbbBMSFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 13:05:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753019AbbBMSF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 13:05:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F36A37E98;
	Fri, 13 Feb 2015 13:05:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ruIHh6vVPUia9VmI2TUEs4/z44=; b=HjhPl5
	yELinnb0lybiervbPOiP9AwGWv477gM8dq6Cq61KINf6Oevj5STCSqkX6xCi4yvj
	RwodH+huhQqf/RNWJJwc3v4+qptpZqDzp6KuTrN7ZzXomVpWThtXHPaPM5XYS1kP
	rUEhHCv6TdVHhQ5Cf850s1gda0iPQkszCsU4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W3Q4AWrHTWlA+KYQ3nY6JmJMrdBbb2Xy
	kH9Xf+4uJ9eNe7VrP8eIshG+dfLpsaKUTrn3J2BkoollhrS4YnjpkXYpGYGarJN8
	3+1/Zq3XOoU0H9AeKMP3GAeCkKbgn67PYPPqHB249yvwMYCedOY6jntpdub36R+L
	9H3Gg8rCtvk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1036537E96;
	Fri, 13 Feb 2015 13:05:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EB9637E94;
	Fri, 13 Feb 2015 13:05:26 -0500 (EST)
In-Reply-To: <54DE259C.4030001@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 13 Feb 2015 17:26:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E323DC1E-B3AA-11E4-A136-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263816>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I also realized that Git's current policy is probably not tenable if one
> process is re-seating a symref at the same time as another process is
> expiring its reflog. The "git reflog expire HEAD" might grab
> "refs/heads/master.lock" then start rewriting "logs/HEAD". Meanwhile,
> "git checkout foo" would grab "HEAD.lock" (not being blocked by the
> "expire" process), then rewrite it to "ref: refs/heads/foo", then grab
> "refs/heads/foo.lock" before updating "logs/HEAD". So both processes
> could be writing "logs/HEAD" at the same time.
> ...
> Switching to holding only "HEAD.lock" while updating "logs/HEAD" is the
> right solution,...

We convinced ourselves that not locking the symref is wrong, but
have we actually convinced us that not locking the underlying ref,
as long as we have a lock on the symref, is safe?

To protect you, the holder of a lock on refs/remotes/origin/HEAD
that happens to point at refs/remotes/origin/next, from somebody who
is updating the underlying refs/remotes/origin/next directly without
going through the symbolic ref (e.g. receive-pack), wouldn't the
other party need to find any and all symbolic refs that point at the
underlying ref and take locks on them?

As dereferencing a symbolic ref in the forward direction is much
cheaper than in the reverse, and because you need to dereference it
anyway, I wonder if we want the endgame to be "hold locks on both",
not "just hold a lock on the symlink".
