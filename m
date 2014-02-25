From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: support repositories with .git-files
Date: Tue, 25 Feb 2014 14:12:11 -0800
Message-ID: <xmqqd2ia6dvo.fsf@gitster.dls.corp.google.com>
References: <1393211555-50270-1-git-send-email-davvid@gmail.com>
	<xmqqr46s9yzx.fsf@gitster.dls.corp.google.com>
	<530BB548.3050603@web.de>
	<xmqq1tyr6pfw.fsf@gitster.dls.corp.google.com>
	<530CFE56.6040807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?R8OhYm9yIExpcHTDoWs=?= <gabor.liptak@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 25 23:12:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIQEe-0000RR-M6
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 23:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbaBYWMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 17:12:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbaBYWMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 17:12:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFC856DDBD;
	Tue, 25 Feb 2014 17:12:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W6PtaBVwrkKppMl31supsakIE38=; b=Ma5t7O
	OKGk3iNTzCy6Cq5wufSkKQeDLq1IYOiWztvah7wiZNhUAqrN0k7mSVT4ZHnWle4i
	lLoWUb5Xc8t0LGvYM+YBIFUJbSf5sM7sjKrzFGdCxSK7og4GyfoPzeh1vJQqlFgp
	95XKd+07FlZLxJahPQs6P5x6ygvg9cseH/4js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t+HUho8CUsbD118Lu6/H4Gc9mCX94kSj
	/z/z4Upu+aNtlL2xOFN9Mqeehzcf8PLLHunYt56gYxn2jeLr6NTKA4tqQKz7RGjO
	rkgibZtDalO08zCrp3PppNW8HfiDYvW9JNlZMbe6lpsLAe4SD5cSrKRJZ0hCJPmP
	rAW8j4DC6Xc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC2D66DDBC;
	Tue, 25 Feb 2014 17:12:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF57B6DDBA;
	Tue, 25 Feb 2014 17:12:13 -0500 (EST)
In-Reply-To: <530CFE56.6040807@web.de> (Jens Lehmann's message of "Tue, 25 Feb
	2014 20:34:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E13888C0-9E69-11E3-873D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242687>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>>> +test_expect_success PERL 'difftool properly honours gitlink and core.worktree' '
>>> +	git submodule add ./. submod/ule &&
>>> +	(
>>> +		cd submod/ule &&
>>> +		git difftool --tool=echo  --dir-diff --cached
>> 
>> In the context of this fix, finishing with 0 exit status may be all
>> we care about, but do we also care about things like in what
>> directory the tool is invoked in, what arguments and extra
>> environment settings (if any) it is given, and stuff like that?
>
> Sure. But I just intended to test the fix (and the test can easily
> be extended by people who know more about difftool than I do).

Yes, we need to start somewhere and I'd agree that it was a good
starting point.

> Right, using echo was not the best choice here. I used it to avoid
> the dependency to meld...

Perhaps like this then?  This is an "a monkey sees what
difftool_test_setup does and then mimics" patch ;-).

 t/t7800-difftool.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 2418528..595f808 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -434,4 +434,17 @@ test_expect_success PERL 'difftool --no-symlinks detects conflict ' '
 	)
 '
 
+test_expect_success PERL 'difftool properly honours gitlink and core.worktree' '
+	git submodule add ./. submod/ule &&
+	(
+		cd submod/ule &&
+		git config diff.tool checktrees &&
+		git config difftool.checktrees.cmd '\''
+			test -d "$LOCAL" && test -d "$REMOTE"
+		'\'' &&
+		echo further >>file &&
+		git difftool --tool=checktrees --dir-diff
+	)
+'
+
 test_done
