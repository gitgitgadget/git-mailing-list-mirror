From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Sun, 05 Apr 2009 12:59:09 -0700
Message-ID: <7vzleuq3ci.fsf@gitster.siamese.dyndns.org>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 <7vmyausz3h.fsf@gitster.siamese.dyndns.org>
 <94a0d4530904051228m4e57ec90y810dded41f47e443@mail.gmail.com>
 <7v7i1yrj3t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:11:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqYWU-0003Yg-Qb
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbZDET7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 15:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbZDET7V
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:59:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbZDET7V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 15:59:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CD0FA7168;
	Sun,  5 Apr 2009 15:59:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C9188A7167; Sun,
  5 Apr 2009 15:59:11 -0400 (EDT)
In-Reply-To: <7v7i1yrj3t.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 05 Apr 2009 12:33:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F3A7598-221C-11DE-8AF9-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115693>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Apr 5, 2009 at 10:02 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> This is the list of actions I've mapped:
>>>>
>>>> =C2=A0* add: git stage =3D git stage add (git add)
>>>> =C2=A0* rm: (git rm --cached)
>>>> =C2=A0* diff: (git rm --cached)
>>>> =C2=A0* import: stage all files; modified, deleted, new
>>>> =C2=A0* ls: (git ls-files --stage)
>>>
>>> I do not think these are good ideas at all, as it just spreads more
>>> confusion, not less.
>>
>> Do you agree that there's already a lot of confusion? (stage, cache,
>> index, etc.)
>>
>> And do you agree that many git newbies don't use the stage? Actually
>> most of them don't even know what it is, and just do "git commit -a"=
=2E
>>
>> If so, how do you think these issues should be handled?
>
> Perhaps not spreading "stage" even wider?  That is the newest confusi=
ng
> term that caused the most harm.

This probably needs clarification for new people who do not know the
history.

Before Linus published the very original git, he was designing a system
that can work with the tarball+patches workflow, and dircache (which wa=
s
the name of the .git directory) was a mechanism to give various snapsho=
ts
a faster access by using the git object machinery by "caching" the resu=
lt
of applying sequence of patches to certain point of history.  The file
inside the .dircache that records the object names that correspond to t=
he
state in the work tree state was .dircache/index.

We've been living with the cache/index, and many user visible actions h=
ave
been called in sentences like "adding contents to the cache" or "compar=
ing
with the index" that used cache/index more or less interchangeably.  La=
ter
we started to standardizing on the term "index" primarily because that =
is
the entity on the filesystem the end user is aware of (as opposed to
"cache" that still live throughout the code).

Some operations however needed to have two modes of operation, one bein=
g
working on both work tree files and the index and another being working
only on the index.  Most of the time, the former was the default (and t=
he
only mode implemented) and the latter mode needed an explicit option to
ask for.  --cached is used when you ask them to ignore work tree
(i.e. "git apply --cached", "git diff --cached").  Unfortunately apply =
has
a third variant that works only on the work tree and because it is mean=
t
as a replacement of GNU patch that works outside a git repository, that
mode is the default, and you need to ask with "git apply --index" to
affect both the index and the work tree.

If we were already well into "standardize on index, not telling the
end-users about cache" journey back then, and --cached should have been
called --index-only, but unfortunately the history was the other way
around.

Later, some outside people started "git training industry" without talk=
ing
with the git development community and started using a new term "to sta=
ge"
as a verb to describe "add to the index".  Addition of "git diff --stag=
ed"
was supposed to lesson the confusion resulted from this mess, but as we
can see from your patch it had a reverse effect.

I do not think "to stage" as the name of the _concept_ is a bad thing
per-se.  But the name of the concept and the command verb (and option
name) does not have to agree with each other.

    cf. http://gitster.livejournal.com/19427.html

In retrospect, I think it might have been less problematic if we firmly
rejected "stage" as an option name, but instead renamed the --cached
option to --index-only and made the former a synonym to the latter to
really standardize on "index".  I think it still is Ok to use the word =
"to
stage" to colloquially call the act of "adding to index", but if we did
not add that to the UI but kept it strictly at the concept level, it wo=
uld
have made the UI less confusing, not more.
