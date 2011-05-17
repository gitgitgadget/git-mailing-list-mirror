From: Shawn Pearce <spearce@spearce.org>
Subject: Re: ACLs for GIT
Date: Tue, 17 May 2011 07:06:26 -0700
Message-ID: <BANLkTi=W2CtA2YaV_spru1E9pTWgoge3Kw@mail.gmail.com>
References: <4DD02876.1040404@bbn.com> <20110515201608.GX6349@kiwi.flexilis.local>
 <4DD12517.1000308@bbn.com> <BANLkTikwEivOiQVV-B=g3pP_StXAa8CVwg@mail.gmail.com>
 <BANLkTi=9vp+ibVa3tQzXbZSeYATKwmF60Q@mail.gmail.com> <BANLkTimPbQe7DGmR0VvDkU3=ZNjcAu7axw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin L Resnick <mresnick@bbn.com>,
	"R. Tyler Croy" <tyler@monkeypox.org>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 16:06:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMKvE-0000L1-6T
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 16:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab1EQOGr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2011 10:06:47 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34887 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab1EQOGq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 10:06:46 -0400
Received: by vxi39 with SMTP id 39so342526vxi.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 07:06:46 -0700 (PDT)
Received: by 10.52.181.193 with SMTP id dy1mr736180vdc.73.1305641206100; Tue,
 17 May 2011 07:06:46 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Tue, 17 May 2011 07:06:26 -0700 (PDT)
In-Reply-To: <BANLkTimPbQe7DGmR0VvDkU3=ZNjcAu7axw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173799>

On Tue, May 17, 2011 at 05:08, Sitaram Chamarty <sitaramc@gmail.com> wr=
ote:
> On Tue, May 17, 2011 at 7:19 AM, Shawn Pearce <spearce@spearce.org> w=
rote:
>> On Mon, May 16, 2011 at 18:32, Sitaram Chamarty <sitaramc@gmail.com>=
 wrote:
>
>>> PS: Gitolite does have unreleased code to do this but it's a hack w=
ith
>>> several limitations. =A0Gitolite makes a temp "clone -l", deletes a=
ll
>>> refs from it that the user has no access to, then redirects the
>>> git-upload-pack to that repo instead ;-)
>>
>> Cute hack. Doesn't prevent the evil client from making an indirect
>> reference to something you shouldn't have. :-)
>
> You mean he constructs a commit that references a SHA he should not b=
e
> having, pushes that to the branch he is allowed to read/write, then
> pulls it down again to now really get that commit?

Yes. Or, he has a SHA-1 he suspects is a tree or blob and lists that
in a tree he pushes to a branch he can write to. Now he can fetch that
branch back, and obtain that object whose SHA-1 he has but whose
contents he does not have.

There is another attack that is incredibly improbable, but that JGit
tries to protect against here as well. An evil user could try to push
an object that uses the REF_DELTA format and specifies a SHA-1 base
that he wants to see at least some of the content of. The delta copy
instructions copy some of the base, and then insert content the
attacker knows. In theory the attacker cannot predict the SHA-1 of the
resulting object and thus cannot reference it in a tree or commit in
order to make a link and fetch it back. However if there is a weakness
in SHA-1 that has not been discovered yet an attacker may be able to
craft the text he knows and supplied as delta insert commands in such
a way that the text of the object he is trying to copy has little to
no impact on the resulting SHA-1. Now he can predict the SHA-1 this
delta creates, and if he can make a link to it, he can fetch it back
and acquire at least part of the remote object. Its paranoid to check
the REF_DELTA bases for visibility before applying the delta, but we
do it in JGit because its better to be slightly paranoid than to
assume this theoretical attack is too improbable to succeed. (And it
is given what we know about SHA-1 today.)

> Yeah, I started writing a hook that looks at `rev-list
> oldsha..newsha`, and for each commit run `git branch --contains SHA`
> and make sure it either (a) is totally new to the repo, ie no ref
> contains this commit or (b) at least one of the refs that contains
> this commit is allowed for this user.

Yea, that isn't sufficient because of the tree/blob link issue. (See ab=
ove.)

> I haven't had time to do that though. =A0Also, if there has been a
> rewind/force-push and the attacker knows the now unreachable SHA, thi=
s
> would not catch it (it'd look like a totally new commit). =A0That's a
> hard one.

Yes. This the branch --contains test is insufficient because you need
to verify the "new" object actually was transmitted by the client in
this exchange, and wasn't just already present on disk. This is hard
because in C Git unpack-objects will not write the object if the
object already exists, and then there is no list of objects the client
sent. Again this is another area where JGit is paranoid. It keeps
track of every object actually sent by the user. The only "new"
objects permitted are those that were sent by the user, any other
"new" objects are attempts to access something the client shouldn't
have access to, or is a broken pack file created by a broken client
(i.e. it did not send all objects it should have sent).

> Having two repos is still the best plan ;-)

Yes, but tell that to Gerrit Code Review users. They really use the
branch ACL features. :-)

--=20
Shawn.
