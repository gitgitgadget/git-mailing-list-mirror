From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] commit: reject invalid UTF-8 codepoints
Date: Wed, 03 Jul 2013 17:47:08 -0700
Message-ID: <7vehbfcfsj.fsf@alter.siamese.dyndns.org>
References: <20130629174023.GB226907@vauxhall.crustytoothpaste.net>
	<7v7ghcl50r.fsf@alter.siamese.dyndns.org>
	<20130704001724.GQ862789@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Jul 04 02:47:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuXhn-0008Vs-RM
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 02:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab3GDArX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 20:47:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773Ab3GDArW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 20:47:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BBF3225E6;
	Thu,  4 Jul 2013 00:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PtHacMTGMwjnA1p4VGhj+jIlBbU=; b=oVCTCQ
	1MOEQhytQeqfL4Q2cZepJUfbtF915VrGSlPAeGP3eT67YZUisvh9BICtclCXdX8b
	GM2gFjJ/GyKyc1Rb8fZrdUFLz0KFtJ5LrgAdO78/E6/l08IEqaTOBKdKT1/2CiAv
	yGrifajesBA44tcPazrODNMXbwgKR3XNNR0Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jC8RikGgnG6LXB1dqKZDcYiBbJonKxez
	q9KC87TiJFYzr8JoAmc1w4SS3qeop3tYpbf+1XtrJ32Rxt7mafk2032hAsK8TWW9
	XLTEH0wgVdy9aRzQCCOYDiy0Nc2eW/OhE8dRyiqeWe1hLMGWmq+xcIKckz55IbuD
	IsQNEwaCZAs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11934225E5;
	Thu,  4 Jul 2013 00:47:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82B57225E0;
	Thu,  4 Jul 2013 00:47:20 +0000 (UTC)
In-Reply-To: <20130704001724.GQ862789@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 4 Jul 2013 00:17:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48898F88-E443-11E2-A52E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229553>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> git format-patch --binary seems to produce the exact same output as
> without the --binary option.  Is there a different way I should be
> selecting the binary option?

These days --binary is a no-op option for format-patch (we used to
default to showing "binary files differ" in diff and required the
option to force generating binary patch), but the real issue is that
you haven't told Git that these "invalid" files are binary files and
not text X-<.

Perhaps add something like this temporarily to .git/info/attributes
when running the command?

	$ cat >>.git/info/attributes <<\EOF
        t/t3900/UTF-8-invalid.txt	binary
        EOF

Another idea is _not_ to create these invalid files inside t3900/
but create them in the set-up part of the test script to the current
directory, using "printf" to make sure the readers who read test
know what exact byte sequence is written out in the test and is
used, which might be a better option in the long run.

Thanks.
