From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Re: Get all tips quickly
Date: Mon, 14 Apr 2014 18:20:30 +0400
Message-ID: <2565BB66-62C0-4E59-9C90-4040E529B3D6@jetbrains.com>
References: <4A7A3A96-DC10-4748-BBCC-F52F48977022@jetbrains.com> <534AE379.7000705@alum.mit.edu>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?0KHRgtCw0YEg0JXRgNC+0YXQuNC9?= 
	<Stanislav.Erokhin@jetbrains.com>
To: Michael Haggerty <mhagger@alum.mit.edu>, avarab@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 14 16:20:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhkc-0002Ua-Ma
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 16:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360AbaDNOUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2014 10:20:39 -0400
Received: from mail1.intellij.net ([46.137.178.215]:41877 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbaDNOUf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 10:20:35 -0400
Received: (qmail 16150 invoked by uid 89); 14 Apr 2014 14:20:33 -0000
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@80.76.244.114)
  by ip-10-62-119-91.eu-west-1.compute.internal with ESMTPA; 14 Apr 2014 14:20:33 -0000
In-Reply-To: <534AE379.7000705@alum.mit.edu>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246248>


Hi Michael, =C6var,

Thank you very much for your answers.

Each of 'git show-ref=92 and =91git for-each-ref=92 is 2 times faster t=
han =91git log --branches --tags --remotes=92 on =93warmed up" FS cache=
s, but take the same time on =93cold=94 FS.

It seems that all these approaches internally walk down from all refere=
nces.=20

So, given that there is no way to get just tips (I was actually hoping =
that Git might be storing them somewhere else), we will stick to =91git=
 show ref -d=92.

Thanks a lot,
Kirill.


On 13 Apr 2014, at 22:29 , =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.=
com> wrote:

> Tried "git for-each-ref" and the various options it has?
>=20
> Doing this for 35k tags is still going to be non-trivial.

On 13 Apr 2014, at 23:20 , Michael Haggerty <mhagger@alum.mit.edu> wrot=
e:

> On 04/13/2014 04:19 PM, Kirill Likhodedov wrote:
>> What is fastest possible way to get all =93tips=94 (leafs of the Git=
 log
>> graph) in a Git repository with hashes of commits they point to?
>>=20
>> We at JetBrains are tuning performance of Git log integration in our
>> IntelliJ IDEA and want to get all tips as fast as possible. Currentl=
y
>> we use 'git log =97branches --tags --remotes --no-walk=92, but the
>> problem is that it is slow if there are a lot of references. In our
>> repository we have about 35K tags, and therefore the tags is the mai=
n
>> slowdown. On the other hand, we have just a couple of dozens of tips
>> as well as branch references, and `git log --branches --remotes` is
>> very fast.
>>=20
>> So we are searching a way to get tags pointing to the graph leafs
>> faster.
>=20
> The fastest ways to get all references plus the commits that are poin=
ted
> at by annotated references would probably be `git show-ref -d`.  The
> funny-looking entries like "refs/tags/v1.7.0^{}" are the annotated ta=
gs
> peeled to the object that they ultimately refer.  But this command
> doesn't tell the types of the objects, and there can be trees and blo=
bs
> mixed in.
>=20
> If your question is also to figure out the minimum set of references
> that are needed to include all tips (i.e., commits with no descendant=
s),
> then the answer is trickier.  There is a command that should do what =
you
> say:
>=20
>    git merge-base --independent <commit>...
>=20
> but (1) with a lot of references, your arguments wouldn't all fit on =
the
> command line (recursive use of xargs might be needed), (2) I don't kn=
ow
> if "merge-base --independent" is programmed to work efficiently on so
> many inputs, and (3) I don't know of a cheap way of getting a list of
> all commits referred to by references (i.e., dereferencing annotated
> tags but ignoring references/annotated tags that refer to trees or bl=
obs).
>=20
>=20
> Another approach is to start by finding the leaf commits by SHA-1.  Y=
ou
> can do this by listing all commits, and listing all commits' parents,
> and then finding the objects that appear in the first list but not th=
e
> second.  This could look like
>=20
>    comm -23 \
>        <(git log --all --pretty=3Dformat:'%H' | sort -u) \
>        <(git log --all --pretty=3Dformat:'%P' | tr ' ' '\n' | sort -u=
)
>=20
> If you want reference names corresponding to these SHA-1s, you could =
use
> name-rev to convert the SHA-1s into refnames:
>=20
>    git rev-parse --symbolic-full-name $(
>        comm -23 \
>            <(git log --all --pretty=3Dformat:'%H' | sort -u) \
>            <(git log --all --pretty=3Dformat:'%P' | tr ' ' '\n' | sor=
t -u) |
>        git name-rev --stdin --name-only
>        )
>=20
> The "rev-parse --symbolic-full-name" is needed because "name-ref" see=
ms
> only able to emit abbreviated reference names.
>=20
>=20
> In practice, you might want to cache some of the results to avoid hav=
ing
> to do a full tree traversal every time.
>=20
>> We also tried to read tags by manually parsing .git files (it is
>> faster than invoking git log), but unfortunately annotated tags in
>> .git/refs/tags/ are written without the hashes they point to (unlike
>> .git/packed-refs).
>=20
> I strongly recommend against parsing these files yourselves.  Your
> software would not be robust against any future changes to the file
> formats etc.
>=20
> Michael
>=20
> --=20
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
