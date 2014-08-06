From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: "Branch objects" (was: Re: cherry picking and merge)
Date: Wed, 6 Aug 2014 20:31:18 +0200
Message-ID: <CANQwDwcHSO+KwhZbo4BTcWnAWGWbJzNQ7CY2m3nq+p0t9uDeqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 20:32:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF60L-0003B9-Tm
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 20:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206AbaHFScA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 14:32:00 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:43306 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071AbaHFSb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 14:31:59 -0400
Received: by mail-ob0-f170.google.com with SMTP id wp4so2092921obc.15
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gKVIoBLFnmWOWR4cTmxPv/jU7KpxsmFHyGx8xmVy+Xc=;
        b=v2zyCct8G8dMyOVnDLwU28EtZJWuHWd9cZ9NenLSGbzJ/Gl2efvEfKchgB59iveu8F
         L90x9syl8KB+3fEMdSdncc1Z806i3z+Pjp+iqRxkAgMa+9fV8XzgcbQLTnypziiNYkYC
         8223N6nUVO9NlXtwEMhdK0Hxh1UmnVfr4z5rRH5rmYcw8y20aeylSPcLqgfuLZwle67c
         q2Tml+qgI3kMjAyYpvoygnOrYSM1qWCVdjt2soQssdapnzjMeBF23IRihj5bQ+LMesfF
         QfCozFxOazXwC8bHQN6m/bkhoc+7qO+hcSs3noneu+oJs3NgDu0URFk7MxsNgzhKCQ+C
         zT8w==
X-Received: by 10.182.44.169 with SMTP id f9mr17794332obm.18.1407349919356;
 Wed, 06 Aug 2014 11:31:59 -0700 (PDT)
Received: by 10.76.103.146 with HTTP; Wed, 6 Aug 2014 11:31:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254886>

On Wed, Aug 6, 2014 at 6:26 PM, Nico Williams <nico@cryptonector.com> w=
rote:
> On Wed, Aug 6, 2014 at 10:58 AM, Jakub Nar=C4=99bski <jnareb@gmail.co=
m> wrote:
>> W dniu 2014-08-01 22:55, Nico Williams pisze:
>>>
>>> It would help if cherry-pick history where recorded somewhere (beyo=
nd
>>> the reflog)...
>>>
>>> Cherry-picks should record two parents, like merges.
>>>
>>> (Of course, it does no good to know about an unreachable parent, wh=
en
>>> a commit with two parents is pushed to a repo that doesn't have one=
 of
>>> those parents, which can happen when topic branches aren't pushed
>>> upstream.)
>>
>> There was (long time ago) a long thread about idea of adding some
>> kind of 'weak' references (links), 'weakparent' that can be automati=
cally
>> used by Git but do not pollute the commit message,
>> and do not affect reachability calculations.  Ultimately it went
>> nowhere (as you can see) - there were many problems.
>
> My proposal was to put this sort of ancillary history info in a
> "branch object" (and that branches should be objects).  This would
> have a number of benefits, not the least of which is that at push tim=
e
> you can drop such ancillary history without having to alter the
> commits being pushed.

Is it something like object-ified reflog, similar to how replacement
objects (git-replace) can be thought to be object-ified grafts (I know
they are more)? Do I understand it correctly?

Did you plan to (ab)use known object types: tree and commit (a bit
similar to git-replace and git-note object, though there is no need for
fanout trees - the top level tree can reproduce refs hierarchy)? I see
that you planned to (ab)use existing transfer mechanism of refs and
objects...


BTW. sometimes I do wonder if we are not making a mistake trying
to shoehorn new features like stash, replacements and notes into
DAG, objects (commit, tree, blob), refs and reflogs. I'd rather Git
did not make the same mistake (well, I think it was a mistake) that
Mercurial did with .hgtags file, (ab)using file transfer for tags, inst=
ead
of adding separate transfer mechanism like Git has... which led to
contortions in interpreting / deling with said file (most recent versio=
n
is used, not the one in checked out revision) and things like having
to commit creating a tag for it to be transferrable.

>> For example: how it would work for reverts and rebases?
>
> Reverts upstream?  The revert should record the commit hash of the
> commit it reverts (but file-level reverts lose), so that this could b=
e
> noticed.

If it is object-ified reflog then reverts are not a problem...

> Rebases upstream?  Well, that shouldn't happen, but if it does then
> you must rebase --onto and any cherry-picks of upstream rebased
> commits lose their ties to those (but this can be detected).

With rebases the problem is that it would be nice to have (at least
for a short time) the history of series of patches (the metahistory,
or history of a branch), but usually one doesn't need old pre-rebase
version after cleaning up the history for publishing.

> In general recording more metadata (assuming there's not privacy
> issues to consider) can't hurt.  Using it might, but having the optio=
n
> to can also help.

True...

--=20
Jakub Nar=C4=99bski
