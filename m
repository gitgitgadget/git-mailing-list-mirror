From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Review of git multimail
Date: Tue, 02 Jul 2013 15:21:22 -0700
Message-ID: <7vsizwiowt.fsf@alter.siamese.dyndns.org>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 00:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu8x0-0001RY-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 00:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab3GBWV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 18:21:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453Ab3GBWV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 18:21:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 136242DCF8;
	Tue,  2 Jul 2013 22:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l9LrN8KZiGWZq7RO/mQfoBfMSTc=; b=EbOFyk
	LCfv0arB8ivG04rZUnJcSEuKHHFsBrPhPYHdldEbvO0050esoTLZancYZHXJ8g4i
	JJxTu+vwCeHvghvAsUkoBJFge2Ziu8s8EKlz0bzpTW1UpYrHKJcWSzy8TyQipcKF
	ZiJFjzhN1Dkpb6FOBWaDBJNTkk3xDWO8h6r1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JryRj3BxybuD8vEtY8UaDZP0gBm4VeDT
	CS7CZsS0bxdhGNe2xKplSNJ5cxpnFuhqGdy/Wvo6kh5058MOMV6HiX1R6oyAX7MC
	C9IdSPwcStd+5jCoF1aTDXLho2AquolYAc34953Oe/+yqCPdHMfaz6EKDVYjWBJU
	ozb9DVOSiWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0629E2DCF7;
	Tue,  2 Jul 2013 22:21:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6719E2DCF4;
	Tue,  2 Jul 2013 22:21:24 +0000 (UTC)
In-Reply-To: <1372793019-12162-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 3 Jul 2013 00:53:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB130374-E365-11E2-8E62-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229435>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>     def get(self, name, default=''):
>>         try:
>>             values = self._split(read_git_output(
>>                     ['config', '--get', '--null', '%s.%s' % (self.section, name)],
>>                     env=self.env, keepends=True,
>>                     ))
>
> Wait, what is the point of using --null and then splitting by hand
> using a poorly-defined static method?  Why not drop the --null and
> splitlines() as usual?

You may actually have spotted a bug or misuse of "--get" here.

With this sample configuration:

        $ cat >sample <<\EOF
        [a]
                one = value
                one = another

        [b]
                one = "value\nanother"
        EOF

A script cannot differentiate between them without using '--null'.

	$ git config -f sample --get-all a.one
        $ git config -f sample --get-all b.one

But that matters only when you use "--get-all", not "--get".  If
this method wants to make sure that the user did not misuse a.one
as a multi-valued configuration variable, use of "--null --get-all"
followed by checking how many items the command gives you back would
be a way to do so.
