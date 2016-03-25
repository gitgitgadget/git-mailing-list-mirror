From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/5] submodule--helper clone: lose the extra prefix option
Date: Fri, 25 Mar 2016 15:39:43 -0700
Message-ID: <xmqqmvpm18sw.fsf@gitster.mtv.corp.google.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
	<1458931156-29125-6-git-send-email-sbeller@google.com>
	<xmqqfuve2vln.fsf@gitster.mtv.corp.google.com>
	<xmqq60wa2s7w.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZotAZeKJxRsHczMp5BG7edu=GLj6mox08M6afkMu1UDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 23:39:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajaOW-0002ku-Un
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 23:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbcCYWjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 18:39:48 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754099AbcCYWjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 18:39:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43ABB4FD25;
	Fri, 25 Mar 2016 18:39:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xN+DGU75JY/26YzHdjxRrIdlDjU=; b=TZ+vox
	EmGFwiNzMaVmE91LFeUq7HBYkhq8HzXz+9kumF+gelUiDBNOH7nXwdB0r7HtYBRZ
	pgkOHa9aEB9q5okKpqDV44QhfmcYCwmEpaalkhrKxcpn+5iGgGSlvXTOWUVTwKqf
	JXwiiNMijes3l6tI0OPnuVYTNfQMc7bnMToSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hI95lmNHhXW4ipnrewSIlOgKQ4nMpaYk
	cYy9Ih2wxRu3VKDOGrDibLze2GixpVZevwzJNN89ndhElBnGdt+K4OZPNZUO4Om1
	5JDT8zWJTCXpujxBgSo7nbxP0vPLT4P/Wved3fVd9AuQQAWKBAW4mPwgGClM80B0
	m41pbndlNHE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37AEF4FD24;
	Fri, 25 Mar 2016 18:39:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 828B24FD23;
	Fri, 25 Mar 2016 18:39:44 -0400 (EDT)
In-Reply-To: <CAGZ79kZotAZeKJxRsHczMp5BG7edu=GLj6mox08M6afkMu1UDg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 25 Mar 2016 15:09:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 78AE7F04-F2DA-11E5-BD3C-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289959>

Stefan Beller <sbeller@google.com> writes:

> The replacement works fine in all tests except for the recursive
> tests as then the chdir is an important detail. In the submodule
> there is no $wt_prefix (as it is the parents' wt_prefix we passed in),

So the real reason is that we may tweak $wt_prefix to refer to a
non-existing directory, that submodule--helper is buggy and does not
notice it, and that using "-C $wt_prefix" would catch it because it
first tries to chdir to it.

The calling script "git submodule" first sets $wt_prefix to the
original directory, so there is no way chdir'ing back there would
not work, but if we update it (e.g. by appending a path to a
submodule we want to work in), it may very well end up referring to
a directory that does not exist (e.g. it may not have been
"init"ed).  Is that what is going on?

If that is the case, it makes a lot more sense as an explanation.
The justification for the main change 4/5 in the log message,
i.e. "-C $wt_prefix" is more familiar, was an irrelevant subjective
statement that only said "we could change it to use -C" without
explaining why "--prefix $wt_prefix" was wrong, and that was why I
was unhappy about it.

> So here is the example from before:
>         repo/ # a superproject repository
>         repo/untracked/ # an untracked dir in repo/
>         repo/sub/ # a submodule
>         repo/sub/subsub # a submodule of a submodule
>
> When calling "git submodule <cmd> --recursive" from within
> repo/untracked/, the recursed instance will end up in
> repo/sub/ with the parents prefix ("untracked/")
>
> In case of git -C $wt_prefix we would try to chdir into
> repo/sub/untracked/ which doesn't exist and our journey ends here.

That sounds like an unrelated bug, though.  Whether -C or --prefix
is used, we shouldn't be using "repo/sub/untracked" after going to
"repo/sub".  If the <cmd> somehow wanted to refer to a relative path
(e.g. "file") in the original directory, it should be using
../untracked as the base (e.g. it would use "../untracked/file").

Of course by using -C, you might notice that repo/sub/untracked does
not exist, but that is not a proper error checking---what if the
submodule at repo/sub does have a directory with that name?  IOW,
the computation that gave repo/sub/untracked instead of ../untracked
is wrong and using -C would not make it right.

And if you clear the prefix you originally obtained in calling
script "git submodule", which is "untracked/", even if <cmd> somehow
wanted to refer to the "file" in that directory, the only clue to do
so is forever lost.  Again, this is unrelated to -C/--prefix, but
that is what the patch 2 in the original series (which was rolled
into patch 1 in the update) was about.

So I am not sure what the value of using -C is.  At least that
"example from before" does not serve as a good justification.
