From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v2] git-add--interactive pathspec and patch additions
Date: Fri, 23 Nov 2007 23:20:50 +0100
Message-ID: <499E75F1-88A3-411C-8B38-68D43307794D@wincent.com>
References: <1195845650-85962-1-git-send-email-win@wincent.com> <7vk5o8smaf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 23:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivgtx-0007tQ-R8
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 23:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbXKWWVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 17:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbXKWWVM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 17:21:12 -0500
Received: from wincent.com ([72.3.236.74]:60988 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761AbXKWWVL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2007 17:21:11 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lANMKpV0022546;
	Fri, 23 Nov 2007 16:20:52 -0600
In-Reply-To: <7vk5o8smaf.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65930>

El 23/11/2007, a las 22:07, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> The series implements these changes in seven steps that apply on =20
>> top of
>> "master"; these patches are rebased/squashed ones which *replace* th=
e
>> ones sent the other day:
>
> That's very unfortunate, as some already usable bits from the
> series are already in 'next'.

Well, no problem, I'll redo this tomorrow if I can get some free time. =
=20
Otherwise it will have to wait to Monday.

>>    1. Add -q/--quiet switch to git-ls-files
>>
>> Needed because run_cmd_pipe() doesn't propagate the child exit statu=
s
>> and system() likes to be chatty on the standard out. Of the possible
>> workarounds adding this switch seems to be the cleanest and most
>> portable.
>
> I do not like this very much.  If it is a problem that
> run_cmd_pipe() does not properly signal you an error, wouldn't
> it be much better to fix _that_ problem?  That way we do not
> have to add kludge to all commands we need to run and get the
> exit status out of.

The problem is that run_cmd_pipe has two code paths, one for Windows =20
and one for all the rest.

I could "fix" the non-Windows path by reading in all the command input =
=20
at once and explicitly doing a close() before returning. In that case =20
I believe that the exit status would be correctly set before the =20
function returns. The Windows code path, however, I am reluctant to =20
touch as I don't know its behaviour and can't test it.

The other alternative was to use qx() or backticks, but then I would =20
have to start worrying about sanitizing paths and once again because =20
of the dual-platform issues I was hesitant to do that. And how do you =20
redirect to /dev/null on Windows?

In any case, I actually *like* the addition of -q to git-ls-files. I =20
can see some places in the codebase (look in git-commit.sh, for =20
instance) where git-ls-files is run and the output is thrown away =20
(redirected to /dev/null) because it's not at all interesting to the =20
caller. It seems that there is a real use case there which amounts to =20
"just tell me whether these pathspecs are valid or not, I don't care =20
about any of the rest".

>>    6. Add "--patch" option to git-add--interactive
>>    7. Teach builtin-add to handle "--patch" option
>
> These should be straightforward, but use of Getopt::Long feels
> way overkill for an internal command like add--interactive which
> is called by only a very limited known callers (exactly one).
>
> If we assume "a single caller", we probably can do without 1 and
> 4, by making the caller in builtin-add to validate the list of
> pathspecs, reusing the code for "ls-files --error-unmatch",
> before calling the external helper "add--interactive".

Well, you're probably right. I was thinking, "just in case we ever =20
need to add more options"; but it may be that we never do, and perhaps =
=20
git-add--interactive will become builtin one day anyway.

> There are functions refactored as part of the builtin-commit
> series to be usable from outside "ls-files", and you can build a
> imple function called from interactive_add(ac, av) using them:
>
> static int validate_pathspec(const char *prefix, const char **pattern=
)

Ok, thanks for the tip, Junio. Like I said, will look at this either =20
tomorrow or Monday and get something posted that applies on top of =20
"next".

Cheers,
Wincent
