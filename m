From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Sun, 16 Nov 2014 11:08:27 -0800
Message-ID: <xmqqk32vyndg.fsf@gitster.dls.corp.google.com>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>
	<1416122508-30654-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 16 20:08:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xq5Ba-0002bH-7y
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 20:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484AbaKPTIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 14:08:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751448AbaKPTI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 14:08:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1A031AA24;
	Sun, 16 Nov 2014 14:08:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4h3GNKmV2FbVyXKOIFP8AMOkYs0=; b=LT0s3W
	DM41TM0ILH+r7gbCOMMJKcgIiVD20dsg7F4ZHME/Ymj9XLrjx7HItzm11GUny7/Z
	dWIGIPnUIFZG1HaBigBbFAmxuOx6iO/DgS411OHCuvSpJL6vqfJ3659jSAsBzHNP
	DpX6WAAQU0hS8Soq0LVlUKjYZySDW4wQS/of0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D8av/ieSUq7P4s7r4GtLKsVpen30TSaj
	b9VtqyRdOUlIkautQ7lz5gCn0181BFctwjtpRWHczNBLaWC8Z9JogO7Dw5D4c1me
	ISaWsz/jX64+jbsNGxCAShYLDsAAIbE0BvQ89DAEnjSC8D5PnlUy4NyHVLAkstrz
	qC3r95579rI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D83191AA23;
	Sun, 16 Nov 2014 14:08:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4529D1AA21;
	Sun, 16 Nov 2014 14:08:30 -0500 (EST)
In-Reply-To: <1416122508-30654-2-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sun, 16 Nov 2014 08:21:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3C3BD6E-6DC3-11E4-B447-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Since time immemorial, the test of whether to set "core.filemode" has
> been done by trying to toggle the u+x bit on $GIT_DIR/config and then
> testing whether the change "took". It is somewhat odd to use the
> config file for this test, but whatever.

The last sentence should read "We could create a test file and use
it for this purpose and then remove it, but config is a file we know
exists at this point in the code (and it is the only file we know
that exists), so it was a very sensible trick".

Or remove it altogether.  In other words, do not sound as if you do
not know what you are doing in your log message.  That would rob
confidence in the change from the person who is reading "git log"
output later.

> @@ -255,6 +255,7 @@ static int create_default_files(const char *template_path)
>  		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>  				!lstat(path, &st2) &&
>  				st1.st_mode != st2.st_mode);
> +		filemode &= !chmod(path, st1.st_mode);

Sounds good.

You could also &&-chain this "flip it back" to the above statement.
If filemode is not trustable on a filesytem, doing one extra chmod()
to correct would not help us anyway, no?


>  	}
>  	git_config_set("core.filemode", filemode ? "true" : "false");
