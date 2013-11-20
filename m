From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7507-*.sh: Fix test #8 (could not run '"$FAKE_EDITOR"')
Date: Wed, 20 Nov 2013 10:33:28 -0800
Message-ID: <xmqqhab67wjr.fsf@gitster.dls.corp.google.com>
References: <528CE716.8060307@ramsay1.demon.co.uk>
	<xmqqsiur6l9k.fsf@gitster.dls.corp.google.com>
	<20131120174226.GA16453@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, Jens.Lehmann@web.de,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 20 19:33:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjCaq-00032b-Cp
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 19:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab3KTSdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 13:33:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998Ab3KTSdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 13:33:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A975454402;
	Wed, 20 Nov 2013 13:33:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vUcxcASjKrw/vwovHYtV514odT0=; b=FE44qS
	2Xz8U53vYJaajaqAZwWp3W4zm9nO6UuJZcCopFg8xxbCASN6Dldfmd0TrcploJbK
	xKkQKqShRbz2n+0spfAk3F1MAXBtHwRgo2DvT/W/VUoSHHfAc/mhn9X6jW2/DlQ+
	6WWvVw7rCRYbJ/7qJTEwG0AN1hN1keknfdGG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x4xSqyyZGywRfTN9AKgCDCtm9JOLzYYq
	VFWkvtTmkp7p2PFKdKL/5nTZCAGLPtf2oZmAY5dwXBq+F49e8Th9XY0qUKTHDQsb
	ZZ6X+SLxtPsNWXZru5wOXUB8ncK21rvIRA6bYHKIX7aa+QCRP9zAriJA85KmyAIZ
	YNP5njQ8BAM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B73554401;
	Wed, 20 Nov 2013 13:33:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEA3054400;
	Wed, 20 Nov 2013 13:33:33 -0500 (EST)
In-Reply-To: <20131120174226.GA16453@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 20 Nov 2013 12:42:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42FB4380-5212-11E3-B911-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238090>

Jeff King <peff@peff.net> writes:

> The test_set_editor helper does some magic to help with quoting, but
> that should not be an issue in this case (since we are using "cat"). We
> are using test_set_editor elsewhere in the script, which would have set
> EDITOR previously. But I would think that GIT_EDITOR, which we are using
> here, would supersede that. However, the error message he shows
> indicates that git is using EDITOR (as FAKE_EDITOR is part of that quote
> magic).
>
> Am I misremembering the issues with one-shot variables and functions?

I think there are two problems involved.

The first is that we are not really using GIT_EDITOR under some
shells; to wit:

------------------------ >8 ------------------------

$ cat >/var/tmp/dashtest.sh <<\EOF
#!/bin/sh

test_must_fail () {
	(
		env | sed -n -e '/EDITOR/s/^/>> /p'
	)
}

EDITOR=dog
export EDITOR

GIT_EDITOR=cat test_must_fail foo
EOF

$ dash /var/tmp/dashtest.sh
>> EDITOR=dog
$ bash /var/tmp/dashtest.sh
>> GIT_EDITOR=cat
>> EDITOR=dog

------------------------ 8< ------------------------

So it appears that GIT_EDITOR that was never exported in the script
fails to get exported with the "VAR=VAL cmd" syntax under dash, when
cmd is not a command but is a shell function.  The "git commit" in
question ends up using $EDITOR.

Another is that EDITOR="$FAKE_EDITOR" that is set up earlier in the
is having trouble launching (I have a feeling that it never was
actually used because everybody uses "commit -F <file>").
