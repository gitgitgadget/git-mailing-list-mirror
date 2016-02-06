From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] On the --depth argument when fetching with submodules
Date: Fri, 05 Feb 2016 16:05:01 -0800
Message-ID: <xmqqoabubt5e.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kbt2-Vm94eTQY0PmJrNwqyTa36FJy5Q+2YBsxu6uYdTmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 01:05:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRqNE-0006lj-U2
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 01:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbcBFAFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 19:05:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750699AbcBFAFE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 19:05:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B05D842E98;
	Fri,  5 Feb 2016 19:05:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TuTLZiWVKKeYQU0bIzF+7tmgbS0=; b=avZx95
	iqfROcB05rP4SsIan+biAtBzsWRJWm2idJDTkLWJ0fc4bgoCMdsc96pznDr9GUJE
	TF4VTFeLmO6sDMMq3jlxdXTzyKwGdEyteprfATOOAjQy9vG9bJIdHoOnhz/qCgPv
	0X8V+dpJhSCmPn9XtQLR3wGnCiiH4L4SEIWMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dY7TGpkv/HYMcSQpe712lt0HsKmsE23c
	eaRMRssTHUooxAtT82T0vaVeOcl6mWqpGd0S6QQH6niLjOih4Bl+ck902Shi3R3Y
	9pSKHmk6zA31K3h3mgpCkBO0Zc0TlcbXHDmfgWuyYtOj/mRzauTUWlf1gogF4ioe
	hFW1K+EH/14=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6D7F42E96;
	Fri,  5 Feb 2016 19:05:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E49642E94;
	Fri,  5 Feb 2016 19:05:03 -0500 (EST)
In-Reply-To: <CAGZ79kbt2-Vm94eTQY0PmJrNwqyTa36FJy5Q+2YBsxu6uYdTmQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 5 Feb 2016 14:48:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45517CC4-CC65-11E5-9F5B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285655>

Stefan Beller <sbeller@google.com> writes:

> Currently when cloning a project, including submodules, the --depth argument
> is passed on recursively, i.e. when cloning with "--depth 2", both the
> superproject as well as the submodule will have a depth of 2.  It is not
> garantueed that the commits as specified by the superproject are included
> in these 2 commits of the submodule.
>
> Illustration:
> (superproject with depth 2, so A would have more parents, not shown)
>
> superproject/master: A <- B
>                     /      \
> submodule/master:  C <- D <- E <- F <- G
>
> (Current behavior is to fetch G and F)

I think the issue is deeper than merely "--depth 2", and you would
be better off stepping back and think about various use cases to
make sure that we know what kind of behaviour we want to support
before delving into one particular corner case.  We currently pass
the depth recursively, and I do not think it makes much sense, but I
view it as a secondary question "among the behaviours we want to
support, which one should be the default?"  It may turn out that not
passing it recursively at all, or even passing a different depth, is
a better default, but we wouldn't know until we know what are the
desirable behaviour in various workflows.

If you are actively working on the superproject plus some submodules
but you are merely using the submodule you depicted above, not
working on changing it, even when you want the full history of the
superproject (i.e. no "--depth 2"), you may not want history of the
submodule.  Even though we have a way to say "I am not interested in
this submodule AT ALL" by not doing "submodule init", not having
anything at all at the path submodule/ may not allow you to build
the whole thing, and we currently lack a way to express "I am not
interested in the history of this thing, but I need at least the
tree that matches the commit referred to by the superproject".

If you are working on a single submodule, trying to fix a bug in the
context of the whole project, you might want to have a single-depth
clone of the superproject and all other submodules, plus the whole
history of the single submodule.

In either of these examples, the top-level "--depth" does not have
much to do with what depth the user wants to use when cloning or
fetching the submodule repositories.

I have a feeling (but I would not be surprised if somebody who uses
submodules heavily has a counter-example from real life) that
regardless of "--depth" or full clone, fetching the tip of matching
branch is not a good default behaviour.  In your picture, even when
depth is not given at all, there isn't much point fetching F or G.

> So to fetch the correct submodule commits, we need to
> * traverse the superproject and list all submodule commits.
> * fetch these submodule commits (C and E) by sha1

I do not think requiring that C to be fetched when the superproject
is cloned with --depth=2 (hence A and B are present in the result)
is a good definition of "correct submodule commits".  The initial
clone could be "superproject follows --depth, all submodules are
cloned with --depth=1 at the commits referenced by the superproject
tree"--by that definition, you need E but you do not want C.

As a specification of the behaviour, the above two might work, but I
do not think that should be the implementation.  In other words,
"The implementation should behave as if it did the above two" is OK,
and it is also OK to qualify with further conditions to help the
implementation.  For example, the current structure assumes that E
and C are reachable from "some" ref in submodule, so that at least a
whole clone of the submodule would give them to you--otherwise you
would not be able to even build the superproject at A or B.  Perhaps
it is OK to further require that, when you are working in a single
branch mode and working on 'master', you are required to have
commits C and E reachable on the 'master' branch in the submodule,
and that may lets you limit the need for such scanning of the
history?
