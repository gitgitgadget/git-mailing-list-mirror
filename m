From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 4/5] Be more specific if upstream branch is not fetched
Date: Thu, 12 Apr 2012 11:15:35 +0200
Message-ID: <4F869D37.1050508@in.waw.pl>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl> <1334161035-26355-5-git-send-email-zbyszek@in.waw.pl> <20120412053017.GA27369@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 11:15:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIG8C-0004zG-Fx
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 11:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827Ab2DLJPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 05:15:52 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34724 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866Ab2DLJPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 05:15:51 -0400
Received: from [193.0.104.94]
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SIG7y-0006EZ-0a; Thu, 12 Apr 2012 11:15:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <20120412053017.GA27369@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195322>

On 04/12/2012 07:30 AM, Jeff King wrote:
> On Wed, Apr 11, 2012 at 06:17:14PM +0200, Zbigniew J=C4=99drzejewski-=
Szmek wrote:
>=20
>> If the branch configured as upstream was missing from
>> remote.<remote>.fetch, git said "Upstream branch not found".
>> We can be more helpful, and separate the cases when upstream
>> is not configured, and when it is configured, but specific
>> branch is not fetched.
>=20
> I very much like the direction of this series, but I found this one a
> little confusing. If you have upstream config, but the configured mer=
ge
> branch is not part of the remote's refspecs, what does it mean? You
> would be able to "git pull", but you would not have a remote tracking
> branch representing what the remote has. So this message:
>=20
>> -		return error("No upstream branch found for '%s'", upstream->name)=
;
>> +		if (!upstream->merge)
>> +			return error("No upstream configured for branch '%s'",
>> +				     upstream->name);
>> +		return error("Upstream branch '%s' not fetched from remote '%s'",
>> +			     upstream->merge[0]->src, upstream->remote_name);
>=20
> doesn't seem right to me. The upstream branch can be fetched just fin=
e;
> it is simply that we do not maintain a tracking branch for it.
Hi,

maybe I'm missing something, but I think that git will not fetch branch=
es
(or commits) which are not part of remote's refspecs. The fact that we =
do
not have a remote-tracking branch would be secondary.

% git init repo6
Initialized empty Git repository in /var/tmp/repo6/.git/
% cd repo6
% git commit -m init --allow-empty
[master (root-commit) 46c16de] init
% git checkout -b side
% git commit -m side --allow-empty
[side 6a0f0e9] side
% git clone . clone
Cloning into 'clone'...
done.
% cd clone
% git config remote.origin.fetch refs/heads/master:refs/remotes/master
% git fetch -v
=46rom /var/tmp/repo6/.
 * [new branch]      master     -> master
% git show 6a0f0e9
fatal: ambiguous argument '6a0f0e9': unknown revision or path not in th=
e working tree.
Use '--' to separate paths from revisions

The scenario leading to this error message would be:
1. user clones
2. user sets remote's refspec to avoid fetching too much stuff
3. user creates a side branch
4. user edits .git/config by hand to create [branch "side"]
based on [branch "master]. (I think that this is a pretty common thing =
to do.)
5. side@{u} is not fetched

A second scenario:

Actually, the fact that we have a remote tracking branch is ignored, if=
 it is
missing from the remote's refspec. (Such situation will arise if the re=
mote's
refspec is set after the remote branch was fetched.)

% git branch -a
  master
* side
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
  remotes/origin/side
% git show side@{u}
error: Upstream branch 'refs/heads/origin/side' not fetched from remote=
 'origin'
error: Upstream branch 'refs/heads/origin/side' not fetched from remote=
 'origin'
fatal: ambiguous argument 'side@{u}': unknown revision or path not in t=
he working tree.
Use '--' to separate paths from revisions
% git config remote.origin.fetch
refs/heads/master:refs/remotes/master
% tail -3 .git/config
[branch "side"]
        remote =3D origin
        merge =3D refs/heads/origin/side

So I think that the proposed error message is OK.

Zbyszek

> Having worked it out in my head, I think that is maybe even what you
> meant, but reading the message the first time left me very confused.
> I'm not sure what a better wording would be, though. I was thinking
> something like:
>=20
>    Upstream branch '%s' is not stored as a remote-tracking branch.
>=20
> or something, but I know we have had trouble with the term "tracking
> branch" in the past. Maybe there is a less loaded term.
>=20
> -Peff
>=20
