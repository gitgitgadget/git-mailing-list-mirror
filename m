From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] git-subtree: Add prune mode
Date: Mon, 2 Aug 2010 12:41:03 +0200
Message-ID: <AANLkTi=U2=ZYXnxW3GVteB9GtxFP41GRzcTejzLE2S8w@mail.gmail.com>
References: <1280654756-9039-1-git-send-email-santi@agolina.net> 
	<AANLkTinLuMwGw_0gXDBBdgT=eg2T_eqtRCNHh2PgV-7U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 12:41:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfsSZ-0005qn-7C
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 12:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab0HBKlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 06:41:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59613 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab0HBKlY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 06:41:24 -0400
Received: by iwn7 with SMTP id 7so4050127iwn.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 03:41:23 -0700 (PDT)
Received: by 10.231.35.10 with SMTP id n10mr6668657ibd.137.1280745683222; Mon, 
	02 Aug 2010 03:41:23 -0700 (PDT)
Received: by 10.231.36.6 with HTTP; Mon, 2 Aug 2010 03:41:03 -0700 (PDT)
In-Reply-To: <AANLkTinLuMwGw_0gXDBBdgT=eg2T_eqtRCNHh2PgV-7U@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152403>

On Mon, Aug 2, 2010 at 4:54 AM, Avery Pennarun <apenwarr@gmail.com> wro=
te:
> On Sun, Aug 1, 2010 at 5:25 AM, Santi B=E9jar <santi@agolina.net> wro=
te:
>> Add prune mode (flag --prune) with the following properties:
>>
>> * The history must be as clean as possible
>> * The directory content must be equal to the external module,
>> =A0at least when you add/update it[b]
>> * The subproject should be able to switch back and forth between
>> =A0different versions.
>>
>> [b] A consequence of this is that it loses all changes
>> =A0 =A0made in the subtree. If they are important you have to extrac=
t
>> =A0 =A0them, apply them and add the subproject back.
>
> I think I started to reply to this before but I can't quite remember
> what happened. =A0Anyway, I have several concerns with this patch:
>
> - calling it "prune" is pretty incorrect. =A0It doesn't remove anythi=
ng
> from your history.

It removes the history of the subproject.
And --squash does not squash your history. We are talking about the
subproject, not the superproject.

> =A0It silently loses patches from your tree, but
> that's not "pruning" really. =A0I suggest "--squash
> --discard-local-changes" or something. =A0ie. it's a variant of squas=
h,
> and it throws things away. =A0We want both of those to be clear.

It's not a variant of squash, it is completely different, but it
shares some properties. One tries to keep your local changes, the
other no.

>
> - I'm not convinced this concept is even a good idea. =A0Who on earth
> wants to silently lose changes?

I want. I very much prefer do all the changes upstream than in the
subproject. I never modify the subtree, so it is not a issue for me,
but I really prefer to know that every time I add the subproject I get
exactly the content as the other project.

>=A0Default --squash behaviour is to
> merge the old branch with the new branch. =A0If you want to throw stu=
ff
> away, that should probably be an entirely separate operation from the
> merging. =A0ie. "git subtree discard-local-changes --prefix=3Dwhateve=
r" to
> create a new patch that undoes all the local changes to this branch;
> then "git subtree merge --squash" to update to a different upstream.

Maybe it is not clear from the docs/code, but with --prune you always
have to "git subtree add", so it is pretty clear that you discard all
the local changes.

I should add a check that --prune is only compatible with "git subtree =
add".

> - In what sense is the history from this any "cleaner" (or any
> different) from --squash?

With git-subtree you always have the subtree history (even if it is
squashed). So when you merge a second time the submodule you get the al=
ways
the history of the subtree (even with --squash). So you basically alway=
s have
at least two branches while examining the history. Compare this
squashed history:

$ git log --graph --oneline
*   bb2dc25 (HEAD, master) Merge commit
'08b917ee90ecfd7b666364fe4ebb92aee5cdd2f7'
|\
| * 08b917e Squashed 'latex/' changes from ea35faf..895916a
* |   9de91f1 Merge commit 'b1b4c36bb8358582a6a20bb500bf98421428e2ca' a=
s 'latex'
|\|
| * b1b4c36 Squashed 'latex/' content from commit ea35faf
* ea35faf Indent, whitespaces,...

with this pruned history:

$ git log --graph --oneline
* 8703aec (HEAD, master) Subtree 'latex/': 895916a Add files subcommand
* a942284 Subtree 'latex/': ea35faf Indent, whitespaces,...
* ea35faf Indent, whitespaces,...

> =A0It seems like, in fact, the history will be
> a *lie* since it talks about merging but actually reverts changes.

There is *no* merging with --prune, you get a new commit with a single
parent that changes the contents of the subtree in such a way that
reproduce the contents of the subproject.

>> As all the history is lost and you never merge commits
>> 'split' is not necessary, but it is basically:
>>
>> $ git filter-branch --subdirectory-filter $prefix
>
> Are you saying that 'git subtree split' doesn't work after the
> discard-local-changes operation? =A0If so, we should fix that, I thin=
k.
> Otherwise it's very confusing.

I tried but did not succeed.

But what I was trying to say is that I don=B4t see the necessity of it,
as you never merge the subproject (with history).

>
>> +prune_msg()
>> +{
>> + =A0 =A0 =A0 dir=3D"$1"
>> + =A0 =A0 =A0 newsub=3D"$2"
>> +
>> + =A0 =A0 =A0 git show -s --pretty=3D"tformat:Subtree '$dir/': %h %s=
" $newsub
>> + =A0 =A0 =A0 echo
>> + =A0 =A0 =A0 echo "git-subtree-dir: $dir"
>> + =A0 =A0 =A0 echo "git-subtree-split: $newsub"
>> +}
>> +
>
> Hmm. =A0I'm rather concerned about this one. =A0What's the top line o=
f the
> commit message? =A0add_msg, add_squashed_msg, rejoin_msg, and squash_=
msg
> are all much clearer than this.

I see it is very different from all the others. It is:

Subtree '$dir/': $hash $subject

I=B4ll change it to match what add_msg does:

Add '$dir/' from commit '$latest_new'


> =A0It also seems that it doesn't honour
> the -m flag here.

I=B4ll fix it. I took squash_msg as model...

>
>> =A0cmd_add()
>> =A0{
>> - =A0 =A0 =A0 if [ -e "$dir" ]; then
>> + =A0 =A0 =A0 if [ -e "$dir" -a -z "$prune" ]; then
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die "'$dir' already exists. =A0Cannot=
 add."
>> =A0 =A0 =A0 =A0fi
>
> This is the 'add' command. =A0I'm not sure it should have special
> behaviour with prune.

With prune mode you don=B4t merge new commits but add them.

>
> (Arguably 'add' should let you optionally overwrite an existing
> directory if it already exists. =A0But if so, I don't think this shou=
ld
> only happen with --prune; it should probably be a special --overwrite
> or --force option.)

This is sensible, and prune mode should use it when available.

>
>> =A0 =A0 =A0 =A0debug "Adding $dir as '$rev'..."
>> + =A0 =A0 =A0 if [ -d "$dir" ]; then
>> + =A0 =A0 =A0 =A0 =A0 git rm -r -q $dir
>> + =A0 =A0 =A0 fi
>> =A0 =A0 =A0 =A0git read-tree --prefix=3D"$dir" $rev || exit $?
>
> Isn't there some plumbing command we can use instead of 'git rm'? =A0=
I
> don't really know what. =A0Does anyone have any suggestions?

I tried it, but I didn=B4t found a command to remove from the index and
the working dir at the same time.

And I found "git checkout --" used after the "git read-tree".

>
>> =A0 =A0 =A0 =A0A new commit is created automatically, joining the im=
ported
>> =A0 =A0 =A0 =A0project's history with your own. =A0With '--squash', =
imports
>> =A0 =A0 =A0 =A0only a single commit from the subproject, rather than=
 its
>> - =A0 =A0 =A0 entire history.
>> + =A0 =A0 =A0 entire history. With '--prune', imports only the conte=
nts of
>> + =A0 =A0 =A0 the commit from the subproject without any history.
>
> This is unclear. =A0"Without any history" isn't really accurate, sinc=
e a
> new commit message is generated; actually the history importing is
> precisely the same as what happens with --squash.

No, with --squash you always have a side branch with the history of
the subtree as viewed from the superproject.

With --prune the only history you get is a new commit in the superproje=
ct.

See above for a "git log --graph" example of each.

Would it be clearer if "without any history" is gone?

>
>> +--prune::
>> + =A0 =A0 =A0 Instead of merging the history (full or squashed) from=
 the
>> + =A0 =A0 =A0 subtree project, produce only a single commit that
>> + =A0 =A0 =A0 reproduce the exact content in the preffix as in the
>> + =A0 =A0 =A0 subtree.
>
> s/preffix/prefix/

OK

>
>> + =A0 =A0 =A0 It has similar features as the --squash option, namely
>> + =A0 =A0 =A0 reduces the clutter (althougth --prune reduce it even
>> + =A0 =A0 =A0 more), helps avoiding problems when the same subprojec=
t is
>> + =A0 =A0 =A0 include multiple time and can switch back and forth
>> + =A0 =A0 =A0 between different version of a subtree.
>
> s/althougth/although/
> s/include multiple/included multiple/
>

OK.

> I don't understand how --prune supposedly "reduces it even more" than
> --squash. =A0What clutter? =A0How does it reduce it *more*?

See above for a "git log --graph" example.

> =A0How does it
> avoid problems when the same subproject is included multiple times?

You just add/have the content in different subdirectories. You don=B4t
have problems with the history/merging/... because it does keep the
history, does not merge,...

> What problems are those?

I suppose it is about history and merging, the same problems with
plain "git subtree" without --squash.

>
> You can switch back and forth between different versions of a subtree=
,
> but this is true of --squash as well - that's why I think this
> operation should be a subcommand of --squash instead.

The fact that it shares some properties with --squash does not make it
a subcommand of it. But you cannot merge, you don=B4t have a side branc=
h
with the subproject "history",...

>
>> + =A0 =A0 =A0 The main difference is that with --prune the content o=
f
>> + =A0 =A0 =A0 the prefix always matches the content of the subprojec=
t,
>> + =A0 =A0 =A0 while with --squash it merges you changes with the cha=
nges
>> + =A0 =A0 =A0 from the subtree. If you want to keep your changes you
>> + =A0 =A0 =A0 have to extract them, apply them in the external
>> + =A0 =A0 =A0 repository and add the subproject back.
>
> s/you changes/your changes/
>
> This last part is especially strange: if you want to keep your own
> changes, why do you want to use --prune at all? =A0--squash does that
> automatically.

If you want to keep your own changes you better upstream them, like
you would do with "git submodules".

If the changes are upstream, all the superprojects using the subtree
will benefit from it.

I try to "push" everything (changes, merging,whatever) upstream (or a
forked upstream).

Have fun,
Santi
