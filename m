From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Tue, 29 Dec 2015 10:27:09 -0800
Message-ID: <xmqqk2nxi002.fsf@gitster.mtv.corp.google.com>
References: <cover.1451298323.git.mostynb@opera.com>
	<xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com>
	<5681D02C.1040609@opera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: Mostyn Bramley-Moore <mostynb@opera.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 19:27:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDyzV-0004CN-J6
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 19:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbbL2S1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 13:27:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753502AbbL2S1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 13:27:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4777E36F9B;
	Tue, 29 Dec 2015 13:27:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=izuCKV2IKJkbWYaL7KytA5/pXX4=; b=kYNWlI
	IM8Hgnd+9S+fW/g0JOfV89ywqV+whe9hbiafOq2JoESkKhiVkka2yIpTTrSXIsNo
	qcd0fGNpgrqt3Jf0QazI/6QVZtEH0z8Qp0K1x38d8gkDA/qxO2wden0K8gbfZVI7
	K1BNpzcB+Qsk0Ts4Jz98qpGdjC3LTqPmt/aMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sScjDgfpcbxwD1GDx3vlqHcjNtgQDv9G
	v8R1K9raFh0efdx9ExdJUOHEVp3BfiUPfNb5FC01FiZc7MbWdrx+zzFMgIrnvVei
	QOjtYi+1XEbCj2pb0shmqxnba6O6aLofvFpZYITvmiPfeJWIkBk5NbzT8OZlPlt2
	hEhqprTqsBU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3DC4136F9A;
	Tue, 29 Dec 2015 13:27:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A1E5036F99;
	Tue, 29 Dec 2015 13:27:10 -0500 (EST)
In-Reply-To: <5681D02C.1040609@opera.com> (Mostyn Bramley-Moore's message of
	"Tue, 29 Dec 2015 01:13:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C64B1080-AE59-11E5-BCAA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283138>

Mostyn Bramley-Moore <mostynb@opera.com> writes:

>> I do not think it is wrong per-se to add an option to use regular
>> expressions instead of globs, but if we are to do so, the endgame we
>> aim for MUST be that we do so consistently to all the other commands
>> that iterate over refs and limit their output to the ones that match
>> given pattern (or a set of patterns), not just 'describe'.
>
> There is one important distinction between 'git describe' and the
> other commands that iterate through refs- it applies an internal
> search strategy and outputs at most one match.  This makes it
> difficult to search for the closest matching tag...

If that was what you were trying to solve, then it sounds like a
typical XY problem.  You do not need custom matching flags; you need
a "give me N (or all) names based on possible tags" option.

And I do not think it is a bad thing to add.  I already
said that an option to match with a regular expression is not a bad
thing to add, either ;-)

> Besides 'git grep', the only regex type flag that is given a short
> option seems to be -E for 'git log' and 'git rev-list'.  I have no
> objection to dropping the short options, or leaving only -E.

They also take -F, but "log" and friends do not pattern match the
refnames, so I do not think you have to worry about them at the
moment.

It is more important to envision what we would do in the future when
a command that takes a pattern (or a set of patterns) to match the
refnames with _and_ another pattern (or a set of patterns) to match
something else, and take that into account when designing this
"allowing matching logic for refnames to be customized from glob to
something else" feature, so that we do not paint outselves into a
corner we cannot later get out of.  Imagine a hypothetical command
'git mgrep' that can look for a pattern in tips of multiple branches
that can be used this way:

    $ git mgrep -e 'froo*tz' --refs 'refs/heads/release/*'

which may look for strings that match "froo*tz" in the trees of
all branches whose name match the pattern 'release/*'.  In this
example, the pattern to match strings is a BRE (same default as 
"git grep"), and the pattern to match refnames is a glob.

Consistency & similarity with "git grep" would most likely lead us
to add -E/-F/-G/-P options to this command and to make it affect how
the pattern to match strings works.  For example:

    $ git mgrep -E -e 'fro+tz' --match-refs 'refs/heads/release/*'

may look for the same strings that would match the first example,
but the pattern is expressed in ERE.  "-P", "-G", and "-F" options
would also work the same way.

Now, the question is what this "-E" (or -P/-G/-F) should do with the
matching the command does with the refnames.  The easiest (and
laziest) way out from the implementors' point of view might be to
declare that they affect both at the same time.  But is that useful
in practice?  It probably isn't, as it forces the users to write

    $ git mgrep -E -e 'fro+tz' --match-refs 'refs/heads/release/.*'

because the ref matching suddenly starts to use ERE (not glob),
which most likely is not something users would expect.  So we may
need a separate set of options to affect the way how refs are
matched.

We cannot just say "but we do not have that 'mgrep' command yet, so
we can do whatever we want to do with 'describe' today".  When the
need eventually arises that requires us to be able to specify how
strings are matched and how refnames are matched independently, we
would end up with an inconsistent UI where 'describe' takes '-P' (or
'--perl-regexp') to affect the way how refnames are matched, while
commands like 'mgrep' would need to use '--refmatch-perl-regexp' (or
any other name that can be distinguished from '--perl-regexp') to do
the same thing because they do not want '--perl-regexp' to affect
the matching of refnames.

And at that point in the future, it is too late to fix 'describe',
as people are so used to use '--perl-regexp' to match with refs.  We
will forever regret that we did not give the option a name that can
be used independently from the existing '--perl-regexp' that is
about matching for strings, not refnames.

That is exactly the kind of thing that would paint us in a corner
that we cannot get out of, which we need to avoid, hence we need to
think ahead now.
 
