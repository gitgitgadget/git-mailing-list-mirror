From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: Use OPT_BOOL instead of OPT_BOOLEAN to allow one action multiple times
Date: Tue, 30 Jul 2013 15:28:52 -0700
Message-ID: <7vfvuvvg0r.fsf@alter.siamese.dyndns.org>
References: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com>
	<7va9l3x34f.fsf@alter.siamese.dyndns.org>
	<51F83010.2060804@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 00:29:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4IPi-0001Hp-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 00:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab3G3W24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 18:28:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756336Ab3G3W2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 18:28:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68F323454B;
	Tue, 30 Jul 2013 22:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MeDy3CDpCoZ/6YQEoStLKaLjXxE=; b=kxHsh3
	JwUmx0aavCMxfF3dBMfATZCqIvlgVSZSZu7/xUTPIkBjIqKXxPA3HCTTGwnO0rOX
	MxHmGGq9am+1y7OHz0JRzn+HeZ3TEvtPWXHef2LQ2MMkiJ/cWEZhNXhgTrPxomCq
	ZkrYmJRzo3eoDFAI1kZmjYBaTS6M/TM18As7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m1d7hl6GMWnY+gm2KSVxPwvde2r4W4W6
	UEGwGwAZjqZmHqzvPF6Mc6bv8X1pZmNllHc5I8GVvunBcC1qs4HEf2Y+kN6+YHek
	BLwOEBmCwZtW0Xp0cDvODrktHVFvDdH/1gcI1Thf77HmS78yo/W/eVvdxn2w/hgc
	4Ywh1Xo49pA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D7213454A;
	Tue, 30 Jul 2013 22:28:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A36A134545;
	Tue, 30 Jul 2013 22:28:53 +0000 (UTC)
In-Reply-To: <51F83010.2060804@googlemail.com> (Stefan Beller's message of
	"Tue, 30 Jul 2013 23:28:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A69E038-F967-11E2-9E6F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231395>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Here is just another idea: 
> 	if (cmdmode == 'v')
> This may be hard to read, (What is 'v'? I cannot remember 
> all the alphabet ;)) So maybe we could have an enum instead of
> the last parameter? 
> OPT_CMDMODE( short, long, variable, description, enum)

I actually was thinking about going totally in the opposite
direction.

People who grew up with the old Unix tradition getopt(3) are used to
code like this:

        while ((opt = getopt(ac, av, "abcde")) != -1) {
                switch (opt) {
                case 'a': perform_a(); break;
                case 'b': perform_b(); break;
                ...
                }
        }

In other words, the "enum" is most convenient if it matches the
"short" option, so instead of having to repeat ourselves over and
over, like I did in that illustration patch for builtin/tag.c, e.g.

		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete tags"), 'd'),
		OPT_CMDMODE('v', "verify", &cmdmode, N_("verify tags"), 'v'),

we could just do

#define OPT_CMDMODE(s, l, v, h) \
    { OPTION_CMDMODE, (s), (l), (v), NULL, \
      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (s) }
