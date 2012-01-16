From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Simulating an empty git repository without having said repository
 on disk
Date: Tue, 17 Jan 2012 00:09:56 +0100
Message-ID: <CAD77+gSB+aYjrMk+zV7BVstGME7Mmxtxg0jkG9KvY3vxwrvvaw@mail.gmail.com>
References: <CAD77+gR=txp8sKrA57ztQX0a1-QZM7wwR6ThBq77c=c+AbsS0w@mail.gmail.com>
 <20120116204131.GC18699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 17 00:10:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmvh1-00068r-VN
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 00:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab2APXKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 18:10:19 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:44426 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751068Ab2APXKR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 18:10:17 -0500
Received: by obcva7 with SMTP id va7so5156515obc.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 15:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=v6GgaB+tWowPAoQChdIpFPtav5WM0m/SpcrJX1OvqxA=;
        b=lJbHL/e8UMmLIK/kmQjXyHqiJug6voAS/lZtrdtcxnY31MJoSYJ9lqjkeIJrGh64vD
         OT/TbY6W4+XvJBxoMunBspYL/NqYNiIiD5b7rcJqqOT7yfr6v3G32MVZCu6w1NT4AAQ4
         QyUIQGt2zcwQU2euYaY5y+9iolcEvgDo8eW1Q=
Received: by 10.182.119.73 with SMTP id ks9mr12827740obb.45.1326755417247;
 Mon, 16 Jan 2012 15:10:17 -0800 (PST)
Received: by 10.182.49.168 with HTTP; Mon, 16 Jan 2012 15:09:56 -0800 (PST)
In-Reply-To: <20120116204131.GC18699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188667>

On Mon, Jan 16, 2012 at 21:41, Jeff King <peff@peff.net> wrote:

> I don't use vcsh, but I seem to recall that it works by overlaying th=
e
> working trees of different repositories on each other, right?

In parallel, but yes.


> So you
> can't just say "oh, files in foo/ belong to repository 'bar'". You mu=
st
> take the union of the set of tracked files from all repos, then find =
the
> difference of that from the set of all files.

Correct.


> Can individual repos mark things as excluded, too? Or do you have a
> master exclusion list? I.e., if I decide that I don't want "foo" trac=
ked
> at all, how do I tell vcsh?

That's something I am still contemplating as there are several ways:

* excludes
* pre-/appends to the gitignore of every repo
* runtime magic

=46eedback welcome :)


> I'm not sure why you care about the empty tree if you are only lookin=
g
> at untracked files. Or perhaps the problem is that you are using "git
> status", which fundamentally cares about looking at differences betwe=
en
> HEAD and the index, even though you don't care in this case. In that =
case,
> maybe "git ls-files -o" would be more appropriate?

--others does not work as I need to look at several repos. I tried to
get the union of --others, but that creates 'argument too large' very
quickly.

Initially, I tried with find, but as that is depth-first, it takes
ages when compared to git's early stopping at directories.


> The most straightforward way in git would be to generate a temporary
> index that mentions all of the tracked files, like this:
>
> =C2=A0tmp=3D/some/tmp/index
> =C2=A0rm -f $tmp
> =C2=A0for i in repo; do
> =C2=A0 =C2=A0git --git-dir=3D$repo ls-files -z |
> =C2=A0 =C2=A0 =C2=A0GIT_INDEX_FILE=3D$tmp xargs -0 git update-index -=
-add
> =C2=A0done
> =C2=A0GIT_INDEX_FILE=3D$tmp git ls-files -o
>
> but that is very close to your "create an empty git repo" (in fact, y=
ou
> might even need to in order for update-index to be happy). But it wou=
ld
> give you a place to put a master exclusion list (you would use it as
> --exclude=3D... in the final ls-files).
>
> If you have per-repo exclusion lists, then you could take a different
> approach, and simply run "git ls-files -o" for each repository. Any
> files which appeared in _every_ output would be untracked (since trac=
ked
> files or individually-excluded files would be omitted from at least o=
ne
> repo). Like:

See above, but I will try yours as well.


> =C2=A0perl -lne "/^\s*$count (.*)/ and print \$1"

I know I sound picky, but I would also like to avoid any third-party
dependencies if possible. Perl is common, but not installed
everywhere.


> The downside is that you are doing $count traversals of the untracked
> directories. On an OS with a reasonable lstat and a directory structu=
re
> that fits into cache, that is probably not too big a deal, though.

With cold cache, it can take ages. Especially once you have a few
git-annex repos in $HOME.


> I took a lot of guesses at exactly what you want. It might be more cl=
ear
> if you gave us an example situation along with the output you expect.

repo foo tracks .foo and .foo.d, bar .bar, etc

% vcsh list #lists repos
foo
bar
baz
% ls -aR
=2Efoo
=2Efoo.d/
=2Ebar
=2Ebaz.d/
=2Equux.d/
=2Equux.d/foo
=2Equux.d/quux.d/quux
=2Equux.d/quux.d/quuux
=2Equux.d/quux.d/quuuux
=2Equux.d/quuuux.d/quuuux
pants
shirts
% vcsh run foo git ls-files # run command in context of repo foo
=2Efoo
=2Efoo.d
=2Equux.d/foo
% vcsh list-untracked # with the code I want in it
=2Equux.d/quux.d/
=2Equux.d/quuuux.d/
pants
shirts
%

I hope that makes sense.

The only part that does not already work today is list-untracked.

=46or failed attempts look at
https://github.com/RichiH/vcsh/tree/list-untracked
https://github.com/RichiH/vcsh/tree/list-untracked-2


Thanks,
Richard
