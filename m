From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rename a remote does not update pushdefault (v1.9.5)
Date: Mon, 30 Mar 2015 12:39:17 -0700
Message-ID: <xmqq384mxoka.fsf@gitster.dls.corp.google.com>
References: <B2C5B27F9C4A45469123297E3F6BCF0C55DA0AEA07@XMAIL08.UGent.be>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Duytschaever <Alexander.Duytschaever@UGent.be>
X-From: git-owner@vger.kernel.org Mon Mar 30 21:39:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcfWw-0000It-77
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 21:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbbC3TjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 15:39:21 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752679AbbC3TjU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 15:39:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87A7D44C96;
	Mon, 30 Mar 2015 15:39:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Rtazd2wv7IUtmBcssphDpsQg0A=; b=lTkrzW
	qq46V4t/PlruTIwfR76aGTjHHemSDIc0Yrmy15l+DKcz8AL5kkGStcy4FeZU62Fp
	X4eXdXrInlltqBBTr1ubfgSRK8K+Q/NRcmxWh5P8JezfRaNbbzcA53LpFA4hrAAh
	heFMTM6K8d2HPTKGMNvZ9n88brqqxfaRn9B3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h4WA9bzjdqKYmw/8QMwW37MRX10WJs7B
	G0YMxf5cE3rBBhcz1vbJG1cmC4eWe7dHQmjtPI1jPiTdpSq6Ki7f5nVcvjLzXTjB
	+RlT6upWVxQi7BkTN8g+nNrXTztCHlwCY50vuHcIuZgLrFb4G7ZyRxX5ueIGy0Vg
	2kTuM6bpKNc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8191244C94;
	Mon, 30 Mar 2015 15:39:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD0E344C92;
	Mon, 30 Mar 2015 15:39:18 -0400 (EDT)
In-Reply-To: <B2C5B27F9C4A45469123297E3F6BCF0C55DA0AEA07@XMAIL08.UGent.be>
	(Alexander Duytschaever's message of "Mon, 30 Mar 2015 11:28:30
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 74E6CF9E-D714-11E4-BBE1-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266468>

Alexander Duytschaever <Alexander.Duytschaever@UGent.be> writes:

> When defining pushdefault and renaming the associated remote, the
> pushdefault setting becomes invalid. Instead, it should follow the
> renamed remote if that was designated as pushdefault.
>
> Test procedure:
>
> 1. Create/cd empty directory
> 2. `git init .`
> 3. `git remote add abc def`
> 4. Observe that `git remote` now shows 'abc'
> 5. `git config default.pushdefault abc`
> 6. Observe that `git config --list` shows default.pushdefault=abc

I do not think we have default.pushdefault.  Perhaps you meant
remote.pushdefault, but even then, I do not think we usually set
that up by default.

> 7. `git remote rename abc xyz`
>
> BUG: observe that pushdefault still refers to 'abc', while it should now refer to 'xyz'.

Again,  by default remote.pushDefault is not set up by us, so there
is nothing to comment here.

> (Initially (wrongly) filed as TGit bug:

Perhaps TGit is setting remote.pushDefault?  If so, I would say a
bug (if there is a bug, which I highly doubt; see below) belongs
there.

Having said all that, if you did this instead, you will see that
remote.pushdefault will not change:

    $ git init
    $ git remote add abc def
    $ git config remote.pushdefault abc
    $ git config remote.pushdefault
    abc
    $ git remote rename abc xyz
    $ git config remote.pushdefault
    abc

and I can see this argued both ways.

1. Imagine you so far had three remotes A, B and DEFAULT defined,
   among which the last one was the default push destination, like
   this:

       [remote]
           pushDefault = DEFAULT
       [remote "A"]
           url = http://a.xz/project
       [remote "B"]
           url = http://b.xz/project
       [remote "DEFAULT"]
           url = http://c.xz/project

   and for whatever reason, you decided c.xz should not be the default
   place for you to push to, but instead you want to make b.xz the
   default.  It is conceivable that you would expect this to work:

       $ git remote rename DEFAULT C
       $ git remote rename B DEFAULT
    
   to give you this:

       [remote]
           pushDefault = DEFAULT
       [remote "A"]
           url = http://a.xz/project
       [remote "DEFAULT"]
           url = http://b.xz/project
       [remote "C"]
           url = http://c.xz/project

   And for that use case, remaing remote.pushDefault is absolutely the
   wrong thing to do.  After the "rename DEFAULT C", remote.pushDefault
   must not be moved to C, because the next "rename B DEFAULT" will not
   be able to guess that remote.pushDefault wants to become DEFAULT.

2. On the other hand, starting from the same "A, B and DEFAULT"
   state, you may be trying to rename DEFAULT everywhere to C to
   come to this instead:

       [remote]
           pushDefault = C
       [remote "A"]
           url = http://a.xz/project
       [remote "B"]
           url = http://b.xz/project
       [remote "C"]
           url = http://c.xz/project

   And for that use case, not remaing remote.pushDefault will appear to
   be a bug, as remote.pushDefault will be left as DEFAULT.

Whichever way you implement "remote rename", you will make half of
the users happy while making other half unhappy.  One use case will
be happier if remote.pushdefault is left intact; the other use case
will be happier if remote.pushdefault is updated.  There are two
sides to this coin.

I think the implementation took the most straight-forward path to
say "we rename everything inside remote.C.* section and adjust the
refspecs for remote-tracking branches because that is what appear in
that section"; which allows the first use case and the second use
case would be just a single "git config remote.pushDefault C" away.

If you change what the command does this late in the game, then not
only you will upset people who have been happy with the current
behaviour (mostly those who used the first scenario), but you will
not really help people who may have wished that remote.pushDefault
to be adjusted either, because they are already used to do the final
"git config remote.pushDefault C" anyway.

So...
