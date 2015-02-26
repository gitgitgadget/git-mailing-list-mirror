From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: preserve commit messages
Date: Thu, 26 Feb 2015 11:49:18 -0800
Message-ID: <xmqq61aomp1d.fsf@gitster.dls.corp.google.com>
References: <1424540906.15539.22.camel@scientia.net>
	<f58ae048d7fd468cfdd7f7d369b3b4fc0a564641.1424697676.git.git@drmicha.warpmail.net>
	<xmqqsidwtq4i.fsf@gitster.dls.corp.google.com>
	<54EC98BD.7060100@drmicha.warpmail.net>
	<xmqq8ufnrwm1.fsf@gitster.dls.corp.google.com>
	<54ED9AF7.6080908@drmicha.warpmail.net>
	<xmqqoaohonpt.fsf@gitster.dls.corp.google.com>
	<54EEFDF7.8090306@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 20:49:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR4RA-0005By-2F
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 20:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbbBZTt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 14:49:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752169AbbBZTt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 14:49:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA0013A9F3;
	Thu, 26 Feb 2015 14:49:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=joJfIjJ7X4rAUpmYQaLBkiDdKfY=; b=Awcx/8
	zRXEnjD/bR6AK2+Ijbrbw1wIK+fO/tj3M+qVDpiFiaHrWvb6doJpWs8cT7kkEWEG
	mVJuweCxpu43iIZlOETrLoeQ+zNO3SO9nVePTFY/thFoGrryHstSC7UNBiGd2lL8
	u0Sv96XTck8Y2PYKHoX99xRvm77V1fyxxgrTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yjkhpKeLgwjw+3Cu4gURtqgLANeWWUpA
	G23imoSlfnH7Fo9HoNE59Og8A2DgyQWW3ah9Zea8Ae3W/6CQkPa0Y4rBw9Y9hOH7
	FOa1GuMBR31xzmAE+zV1IHz2Y6qjXUF5DABuvxPnfWpqAXA6PeMtwybgVGDa+CXa
	L5D+Gt6LyC4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E24663A9F2;
	Thu, 26 Feb 2015 14:49:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6197B3A9EF;
	Thu, 26 Feb 2015 14:49:19 -0500 (EST)
In-Reply-To: <54EEFDF7.8090306@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 26 Feb 2015 12:05:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E3D2DC2-BDF0-11E4-85BA-802E9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264452>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Hmm. With "--edit", current config being in effect should be expected,
> right? So how about:
>
> In case of no conflict: force cleanup=verbatim unless --edit is used?

Perhaps something like that.

Stepping back a bit and imagine a world where the sole purpose of
cherry-pick were to recreate the original commit as faithfully as
possible.  The commit log message would not be cleaned up in such
a case by default, and the users need cherrypick.cleanup setting
if they do not like that default.

The implementation of cherry-pick that does not spawn the editor
in that world would look like this:

    - read the cleanup mode from cherrypick.cleanup config; if there
      is none, read the cleanup mode from commit.cleanup config; if
      neither is defined, then use 'verbatim' as the default;

    - invoke "commit --cleanup=" + that mode from the command line
      to force the mode chosen by the above.

Thanks to the falling back to commit.cleanup, the above logic would
be usable even before we invent cherrypick.cleanup configuration,
i.e. in today's world.  If there is no commit.cleanup defined by the
user, the above logic would still use 'verbatim' as the default for
'cherry-pick', while using the 'default' for 'commit'.

When cherry-pick invokes the editor, then the first part would be
different.  So my conclusion would be something like:

    #if IN_THE_FUTURE
        if (config_exists(cherrypick.cleanup))
            mode = config_value(cherrypick.cleanup);
        else
    #endif
        if (config_exists(commit.cleanup))
            mode = config_value(commit.cleanup);
        else
            mode = editing ? 'verbatim' : 'default';

        invoke "commit --cleanup=" + mode;

perhaps?
