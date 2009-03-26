From: Andreas Ericsson <ae@op5.se>
Subject: Re: Test that every revision builds before pushing changes?
Date: Thu, 26 Mar 2009 10:46:00 +0100
Message-ID: <49CB4ED8.4060205@op5.se>
References: <87myb8aja1.fsf@rimspace.net> <49CB39E5.5060000@op5.se> <87ljqs7ioz.fsf@rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Pittman <daniel@rimspace.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 10:47:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmmBZ-0008HP-Lk
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980AbZCZJqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 05:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755576AbZCZJqJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:46:09 -0400
Received: from mail.op5.se ([193.201.96.20]:59725 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636AbZCZJqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 05:46:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5C4521B8035A;
	Thu, 26 Mar 2009 10:46:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kUbtZMN2KM-9; Thu, 26 Mar 2009 10:46:08 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 65EBA1B80379;
	Thu, 26 Mar 2009 10:46:07 +0100 (CET)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <87ljqs7ioz.fsf@rimspace.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114760>

Daniel Pittman wrote:
> Andreas Ericsson <ae@op5.se> writes:
>> Daniel Pittman wrote:
>>> I would like to ensure that my commits are fully bisectable before =
I
>>> commit them to an upstream repository, at least to the limits of an
>>> automatic tool for testing them.
>>>
>>> 'git bisect run' is similar: it can automatically locate the breaki=
ng in
>>> a test suite, for example, but that doesn't help me in the case of =
three
>>> commits, A (good), B (bad) and C (good, fixing B).
>>>
>>> I would much rather, in this case, use rebase to fix B so that it, =
too,
>>> builds before I push the changes and pollute a public repository wi=
th a
>>> broken changeset =E2=80=94 and make bisect that much harder to use =
in future.
>> You can do that, but it requires manual work too. The trick is to ma=
ke
>> the release branch immutable on the public repository and use topic
>> branches with per-developer namespaces. The per-developer namespace
>> thing is actually important, as it leaves the freedom to rewind and
>> recreate topics to the developers (which shared branches do not).
>>
>> The manual step comes at merge-time; Someone has to be responsible f=
or
>> merging all the topics that are to be included in the release branch
>> and make sure it builds and passes all tests after each merge.
>=20
> Ah.  You have not quite grasped what I was looking for: I was after a
> tool to help automate that step, rather than a workflow around it.
>=20

Oh right. Sorry, I'm stuck in continuous-integration land where people
tend to want the server to take care of such things.

> For example, the responsible person for that testing could use the
> hypothetical (until someone tells me where to find it):
>=20
>     git test public..test make test
>=20
> Which would then effectively wrap:
>=20
>     for each revision between public and private:
>          git checkout revision
>          make test
>          # report if that fails, allow fixing the commit or whatever
>          # then 'git test continue' to carry on...
>=20
> That turn the process from a manual one to an automated one: it runs
> that command for every revision until it fails, or until they all pas=
s.
>=20

Something like this?
--%<--%<--
#!/bin/sh

git stash
revspec=3D"$1"
shift
for rev in $(git rev-list "$revspec"); do
	git checkout $rev
	"$@" || break
done
--%<--%<--

Run it as such:
=2E/git-test.sh public..test make test

Adding support for "continue" in there shouldn't be hard, since
you'd just replace the first rev with the first parent of the
last tested revision, although if you want to fix up a commit
in the middle, you'd have to manually rebase the other ones
onto the newly created commit (again, not very hard but I'll
leave both as an exercise to you).

It doesn't handle merges very nicely, btw, but I guess this
should be run prior to merging anyways.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
