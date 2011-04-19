From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REGRESSION] git-wrapper to run-commands codepath regression
Date: Mon, 18 Apr 2011 17:07:35 -0700
Message-ID: <7vipub6r3s.fsf@alter.siamese.dyndns.org>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 02:07:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QByTt-0001SP-RC
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 02:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab1DSAHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 20:07:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab1DSAHn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 20:07:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24F865919;
	Mon, 18 Apr 2011 20:09:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RKL2/FILmx0QBYpatwM3QA2q9fE=; b=Y+kFIy
	yqlpIoHIAqc9B1P8xDg5Yew8RBDN9pbnMFz5oehIsIBLsX95/Doe4NP/Q7B/A0bP
	m3wuUGHO1ccAV6NeQBuWWh44kARVfNyPXA/5vDAFZPWZgnJ2IbpOZ065kdPjCR6E
	Tw6uvI34QRv8AzduIjrl2FK6D3NlmCC3gvZ+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x4Kiaz4r5apHG4um5tVsfXDOr8GN+1Ye
	eROXwB5umw0416NPSMgf9A9cYghA5/48PuyLlphDwxxhsDJ079j1a0cWXlGm9Z6x
	lVHV9xMjOB9N0nFNJWDVimKLvXL5wrBK8YU7IW5ejTLB+3jT6siNIZOXnCtBqVaP
	8zd5Exczh2o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 106115918;
	Mon, 18 Apr 2011 20:09:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 462095915; Mon, 18 Apr 2011
 20:09:37 -0400 (EDT)
In-Reply-To: <7v8vv78eld.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 18 Apr 2011 13:54:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51C6BAFE-6A19-11E0-BB76-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171767>

Junio C Hamano <gitster@pobox.com> writes:

> There appears to be a regression in the codepath between git wrapper and
> run_commands API.
>
> 	$ T=/var/tmp/test-commands
> 	$ mkdir $T
> 	$ cat >$T/git-hello <<\-EOF
> 	#!/bin/sh
> 	echo hello
> 	EOF
> 	$ chmod +x $T/git-hello
> 	$ oPATH=$PATH
> 	$ PATH=$T:$PATH
> 	$ export PATH
> 	$ git hello
> 	hello
>
> So far, I added a "hello" subcommand to "git", and it runs correctly.
>
> ...
> Note that we can observe the same regression if you instead make $T
> unreadable with:
>
> 	$ chmod 755 $T/git-hello ;# make it executable again
> 	$ chmod a-rwx $T ;# but that directory cannot be read
> 	$ git hello
>
> So that is the "regression" part.
>
> The following is a tangent that was brought up at $work.

And that is the topic of this follow-up.

> Some people might argue that we should skip $T/git-hello in the last case
> and try to find git-hello in a later directory listed in $PATH, but I do
> not personally think that is a right thing to do.  It would make the
> problem harder to diagnose, and more importantly, the fact that the user
> listed $T earlier in the $PATH is a strong indication that the user wants
> the scripts in $T override the scripts with the same name in directories
> that appear later in the $PATH, and we should report when that is not
> happening, either
>
>  (1) when $T/git-hello was found but was not executable; or
>
>  (2) when we cannot read $T and we cannot even tell $T/git-hello exists or
>      not.
>
> So I think it is Ok to be silent only when we see ENOENT like the current
> code does.

Unfortunately, as we are giving "git-hello" to underlying execvp(3),
instead of splitting $PATH, prefixing each element of it in front of
"git-hello" and trying execv() in a loop, when the call fails, we do not
know which component of $PATH caused execvp() to fail, and end up saying
"fatal: cannot exec 'git-hello': Permission denied".  So in that sense, we
are not helping the end user by making it easier to diagnose the problem.

We would need to emulate what execvp() does ourselves (i.e. split $PATH,
prefix each component and try execv(), ignoring ENOENT or EACCES while
trying next component in $PATH), plus note the first path that got EACCES
so that we can report which script (including its leading directories) had
trouble executing.  Perhaps a simple enough task for beginners.
