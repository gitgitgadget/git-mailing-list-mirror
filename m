From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Sat, 31 Dec 2011 16:28:11 -0500
Message-ID: <CABURp0pdvf9Eo_pM2UCYUBANOJOGON6pQS-SXuCWQE=s2XNOfQ@mail.gmail.com>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com> <7vsjk3vw67.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 31 22:28:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rh6Tt-0005uu-QL
	for gcvg-git-2@lo.gmane.org; Sat, 31 Dec 2011 22:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab1LaV2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Dec 2011 16:28:36 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:44920 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab1LaV2e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Dec 2011 16:28:34 -0500
Received: by werm1 with SMTP id m1so7000517wer.19
        for <git@vger.kernel.org>; Sat, 31 Dec 2011 13:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kT1+NLPm0GDWBJ1P7jzQeiQUlo7QZHyRJeqW8OHhkqo=;
        b=dbH7R7cor6k/SJzPZ1W/vbohfjUQai5weCYKXH7Ok5HCAA7gigzbAdxM1tFlU2i4Zv
         3rxx/PaIoYSBxq0Vf2kqzTnVT6iQfNcw4jOZ6x7u+gkOhhi3rvp30Cl6vI2LPnksl+eI
         Tts8BI1NfgsLjzq6AQGcgI55C2fp8uS8/Itr8=
Received: by 10.216.139.102 with SMTP id b80mr29421835wej.27.1325366912285;
 Sat, 31 Dec 2011 13:28:32 -0800 (PST)
Received: by 10.216.19.82 with HTTP; Sat, 31 Dec 2011 13:28:11 -0800 (PST)
In-Reply-To: <7vsjk3vw67.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187816>

On Thu, Dec 29, 2011 at 5:40 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Antony Male <antony.male@gmail.com> writes:
>
>> Git submoule clone uses git clone --separate-git-dir to checkout a
>> submodule's git repository into <supermodule>/.git/modules,...
>
> This is misleading. The <superproject>/.git/modules/<name> is the loc=
ation
> of the $GIT_DIR for the submodule <name>, not the location of its che=
ckout
> at <superproject>/<path> that is outside <superproject>/.git/modules/
> hierarchy.

Yes, so I think a simple s/checkout/clone/ should fix it.

[...]

>> In the submodules scenario, neither the git repository nor the worki=
ng
>> copy will be moved relative to each other. However, the supermodule =
may
>> be moved,...
>
> Again, who said that you are allowed to move the superproject directo=
ry in
> the first place? I would understand that it might be nicer if it coul=
d be
> moved but I haven't thought this through thoroughly yet---there may b=
e
> other side effects from doing so, other than the relativeness of "git=
dir".

Previously it was accepted practice to clone a local repo with rsync.
This method continues to work well even with submodules before
git-files became the norm.  But now it breaks because of the absolute
paths.

Similarly, clones on network mounts and portable drives where absolute
paths may change from time to time or machine to machine will also
break now but worked before.

So, who said you were NOT allowed to move the superproject directory
directory in the first place?  It seems natural that you should be
able to do so, especially since the submodules are all contained
within the superproject path.


>> Previously, if git submodule clone was called when the submodule's g=
it
>> repository already existed in <supermodule>/.git/modules, it would
>> simply re-create the submodule's .git file, using a relative path.
>
> ... "to point at the existing <superproject>/.git/modules/<name>".
>
> Overall, I think I can agree with the goal, but the tone of the propo=
sed
> commit log message rubs the reader in a wrong way to see clearly what=
 this
> patch is proposing to do and where its merit lies. It is probably not=
 a
> big deal, and perhaps it may be just the order of explanation.
>
> I would probably explain the goal like this if I were doing this patc=
h,
> without triggering any need for revisionist history bias.
>
> =A0 =A0Recent versions of "git submodule" maintain the submodule <nam=
e> at
> =A0 =A0<path> in the superproject using a "separate git-dir" mechanis=
m. The
> =A0 =A0repository data for the submodule is stored in ".git/modules/<=
name>/"
> =A0 =A0directory of the superproject, and its working tree is created=
 at
> =A0 =A0"<path>/" directory, with "<path>/.git" file pointing at the
> =A0 =A0".git/modules/<name>/" directory.
>
> =A0 =A0This is so that we can check out an older version of the super=
project
> =A0 =A0that does not yet have the submodule <name> anywhere without l=
osing
> =A0 =A0(and later having to re-clone) the submodule repository. Remov=
ing

Revisionism nit: the real danger here is that you lose local commits.

> =A0 =A0"<path>" won't lose ".git/modules/<name>", and a different bra=
nch that
> =A0 =A0has the submodule at different location in the superproject, s=
ay
> =A0 =A0"<path2>", can create "<path2>/" and ".git" in it to point at =
the same
> =A0 =A0".git/modules/<name>".

This doesn't explain why one path is absolute and one is relative.
But I don't suppose this is the place for historical documentation
anyway.

> =A0 =A0When instantiating such a submodule, if ".git/modules/<name>/"=
 does
> =A0 =A0not exist in the superproject, the submodule repository needs =
to be
> =A0 =A0cloned there first. Then we only need to create "<path>" direc=
tory,
> =A0 =A0point ".git/modules/<name>/" in the superproject with "<path>/=
=2Egit",
> =A0 =A0and check out the working tree.
>
> =A0 =A0However, the current code is not structured that way. The code=
path to
> =A0 =A0deal with newly cloned submodules uses "git clone --separate-g=
it-dir"
> =A0 =A0and creates "<path>" and "<path>/.git". This can make the resu=
lting
> =A0 =A0submodule working tree at "<path>" different from the codepath=
 for
> =A0 =A0existing submodules. An example of such differences is that th=
is
> =A0 =A0codepath prepares "<path>/.git" with an absolute path, while t=
he
> =A0 =A0normal codepath uses a relative path.

I had to read this three times before I understood it. There are some
minor grammatical nits in it, but also the use of nearness and use of
"path" and "codepath" to mean two unrelated things was misleading me.
Here's my attempt to clean it up:

 =A0 =A0However, the current code is not structured that way. The code =
to
 =A0 =A0deal with newly cloned submodules is different from the code to
    checkout a workdir for existing submodules.  The "newly cloned
    submodule" code uses "git clone --separate-git-dir" to create
    "<path>" and "<path>/.git". The "existing submodules" code
    simply creates the "<path>/.git" internally, using a relative path.
    This makes the resulting submodule working tree at "<path>" differe=
nt
    depending on which code is used.  An example of such differences
    is that the "newly cloned submodule"=A0code prepares "<path>/.git"
    with an absolute path, while the "existing submodules" code
    prepares the same file using a relative path.


> When explained this way, the remedy is quite clear, and the change is=
 more
> forward-looking, isn't it? =A0If we later start doing more in the cod=
epath
> to deal with existing submodules, your patch may break without having
> extra code to cover the "newly cloned" case, too.


> I further wonder if we can get away without using separate-git-dir op=
tion
> in this codepath, though. IOW using
>
> =A0 =A0 =A0 =A0git clone $quiet -bare ${reference:+"$reference"} "$ur=
l" "$gitdir"
>
> might be a better solution.

You may be right about this one.  I still think the addition of a
--relative-path option to 'git-checkout --separate-work-dir' could be
useful and also easier to maintain/describe.

> For example (this relates to the point I mumbled "haven't thought thi=
s
> through thoroughly yet"), doesn't the newly cloned repository have
> core.worktree that points at the working tree that records the <path>=
,
> which would become meaningless when a commit in the superproject that
> binds the submodule at different path <path2>?

Ooh, yes it does.  Maybe that should be fixed in this case too.

Because submodule cloning with a separate work-dir is a special case
of git-files and work-dirs because we know that each is relative
(subordinate) to the superproject path.  Therefore, I think in this
special-case version of the "separate work-dir" scenario, we should
use super-project-relative paths for both cases.

How do we codify this so this functionality is reliably retained by
future developers?  I think moving the code into someplace more
explicit would help, but I haven't looked too deeply at the code.

> =A0git-submodule.sh | =A0 21 ++++++++-------------
> =A01 files changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3adab93..9a23e9d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -156,21 +156,16 @@ module_clone()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;;
> =A0 =A0 =A0 =A0esac
>
> - =A0 =A0 =A0 if test -d "$gitdir"
> + =A0 =A0 =A0 if ! test -d "$gitdir"
> =A0 =A0 =A0 =A0then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mkdir -p "$path"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "gitdir: $rel_gitdir" >"$path/.git=
"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rm -f "$gitdir/index"
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mkdir -p "$gitdir_base"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test -n "$reference"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git-clone $quiet "$refe=
rence" -n "$url" "$path" --separate-git-dir "$gitdir"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git-clone $quiet -n "$u=
rl" "$path" --separate-git-dir "$gitdir"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "$(eval_gettext "Clone of '\$url' i=
nto submodule path '\$path' failed")"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git clone $quiet -n ${reference:+"$refe=
rence"} \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --separate-git-dir "$gi=
tdir" "$url" "$path" ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "$(eval_gettext "Clone of '\$url' f=
or submodule '\$name' failed")
> =A0 =A0 =A0 =A0fi
> +
> + =A0 =A0 =A0 mkdir -p "$path"
> + =A0 =A0 =A0 echo "gitdir: $rel_gitdir" >"$path/.git"
> + =A0 =A0 =A0 rm -f "$gitdir/index"
> =A0}

Doesn't this avoid creating core.worktree in the first place?  I'm ok
with that because I assume it's never used in the submodule scenario,
but I also suspect that assumption could be wrong.  Any concerns?

Phil
