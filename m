From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Moving (renaming) submodules, recipe/script
Date: Tue, 08 Jan 2013 18:12:13 +0100
Message-ID: <50EC536D.8050606@web.de>
References: <20130107003603.GA25698@odin.tremily.us> <20130107013952.GE3823@elie.Belkin> <50EA7269.1080006@web.de> <20130108143214.GA3755@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>,
	Peter Collingbourne <peter@pcc.me.uk>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:12:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tscj9-0002Zl-V6
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 18:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662Ab3AHRMT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2013 12:12:19 -0500
Received: from mout.web.de ([212.227.15.3]:57240 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756627Ab3AHRMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 12:12:18 -0500
Received: from [192.168.178.41] ([91.3.170.228]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MXpZD-1TWIbg3Obv-00Wzgb; Tue, 08 Jan 2013 18:12:16
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130108143214.GA3755@odin.tremily.us>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:KEm5FjpxeGzll1kOZt3H4VDDLxuUk6jnrcKEd2kaK6V
 DBNW07RE/OrbSZhvyMQHda7hAV9Dan4UZc8nYBjrRz5pGa9ggu
 Fki3r9r3qE/qPt2zqZZ2f+Mx+6QXadKk2wn/b7IM+NWSLNbkWu
 jUgGxw9MFEjsMhQahqXsMKKmWE5CjT/jD54AbBuJSoinINVHAC
 uuOwPyFZqhHijIH+F3PiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212976>

Am 08.01.2013 15:32, schrieb W. Trevor King:
> On Mon, Jan 07, 2013 at 07:59:53AM +0100, Jens Lehmann wrote:
>> Am 07.01.2013 02:39, schrieb Jonathan Nieder:
>>> (just cc-ing Jens and Peter, who might be interested)
>>
>> I=B4m currently working on teaching mv to move submodules and intend
>> to send those patches to the list after finishing submodule deinit.
>> Please see
>>   https://github.com/jlehmann/git-submod-enhancements/commits/mv-sub=
modules
>> for the current state of this series.
>=20
> Thinking about this a bit more, I'm not clear on how out-of-tree
> updates (i.e. worktree in .git/modules/*/config) propogated during
> branch checkouts (merges, rebases, etc.).  I just got a broken rebase
> trying to move a trivial patch back before the submodule move, and Gi=
t
> was confused about what had happened to the submodules.  Here's a
> simple script that illustrates the problem:
>=20
>   #!/bin/sh
>   rm -rf a b c
>   mkdir a
>   (cd a
>    git init
>    echo a > README
>    git add README
>    git commit -am 'a'
>   )
>   git clone a b
>   (cd b
>    git submodule add ../a submod-1
>    git commit -am 'add submodule at submod-1'
>   )
>   git clone b c
>   (cd c
>    git submodule update --init
>   )
>   (cd b
>    git-submodule-mv.sh submod-1 submod-2
>    git commit -am 'move submodule from submod-1 to submod-2'
>   )
>   (cd c
>    git pull
>    ls -d .git/modules/*
>    cat .git/modules/submod-1/config
>    ls -a submod*
>   )
>=20
> The end result is that `c` gets the `.gitmodules` path updates and ne=
w
> gitlinked directory from the submodule move in `b` (using my
> git-submodule-mv.sh posted earlier in this thread), but `submod-1` is
> left lying around (because Git doesn't know that it can remove
> submod-1/.git and submod-1/README).

That's just what current git does with removed submodules (but my
recursive submodule update series will handle that just fine).

>  The Git directory for the
> submodule stays in .git/modules/submod-1/ (good), but the worktree in
> .git/modules/submod-1/config still points to ../../../submod-1 (bad).

You'll not only have to update the gitfile but also the core.worktree
setting in the repo. Sorry I missed that when you posted your script.

> This means that submodule moves are possible, but anyone trying to
> share them between several repositories (or trying to rebase across
> the move within their own repository) is in for a world of suffering
> ;).  I'm not sure how this should be addressed, but I didn't see
> anything handling it in Jens' new series.

If you adjust core.worktree properly you'll just have the old
submodule work tree lying around (just like you do after you rm'd
it) and everything apart from that should just work.

As I mentioned that will be fixed by recursive submodule checkout.
I'll see if I can polish my preliminary branch so that interested
people can play around with it if anyone is interested.
