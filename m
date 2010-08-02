From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] git-subtree: Add prune mode
Date: Sun, 1 Aug 2010 22:54:25 -0400
Message-ID: <AANLkTinLuMwGw_0gXDBBdgT=eg2T_eqtRCNHh2PgV-7U@mail.gmail.com>
References: <1280654756-9039-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Aug 02 04:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OflB0-0005gb-7D
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 04:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab0HBCyr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Aug 2010 22:54:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54090 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab0HBCyq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Aug 2010 22:54:46 -0400
Received: by wyb39 with SMTP id 39so2844559wyb.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 19:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=924L5/F1LQN7LUkh651oSMWpgKPHOHLD0cd8f9gmyp4=;
        b=rKAI2UTf4CJzh6O9j7FpjisUslAUd8vG+ZcicFUf8qlNLp9bZi7qf0EWeHUE3HXl1h
         qvhzUm+OJTPaVv9ZDrtX0fj/7dFeGK+AxEs8KEBVr7S947yHJDMUCJUBi1mjfxudQt1P
         da8e43OJXadzY+yo0jNFS8u72psL6uiI5BC5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Psyy7sn+VEEhNwuKlOxRmVram6C+r4M+swi896pogF6fOmdA+QFWbRiJ/wgqbF+ZVL
         cIZxR5aFJ2P0YNHQA1U8LLqgloIaby4iWwjdZ7oZBgOe2Nc241d+UY6EjsV4ggN1xMM1
         bE+i1piAkHQd8EhccQV6jsEQCaBqLVhMdjjZE=
Received: by 10.216.236.42 with SMTP id v42mr2232678weq.10.1280717685190; Sun, 
	01 Aug 2010 19:54:45 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Sun, 1 Aug 2010 19:54:25 -0700 (PDT)
In-Reply-To: <1280654756-9039-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152387>

On Sun, Aug 1, 2010 at 5:25 AM, Santi B=E9jar <santi@agolina.net> wrote=
:
> Add prune mode (flag --prune) with the following properties:
>
> * The history must be as clean as possible
> * The directory content must be equal to the external module,
> =A0at least when you add/update it[b]
> * The subproject should be able to switch back and forth between
> =A0different versions.
>
> [b] A consequence of this is that it loses all changes
> =A0 =A0made in the subtree. If they are important you have to extract
> =A0 =A0them, apply them and add the subproject back.

I think I started to reply to this before but I can't quite remember
what happened.  Anyway, I have several concerns with this patch:

- calling it "prune" is pretty incorrect.  It doesn't remove anything
from your history.  It silently loses patches from your tree, but
that's not "pruning" really.  I suggest "--squash
--discard-local-changes" or something.  ie. it's a variant of squash,
and it throws things away.  We want both of those to be clear.

- I'm not convinced this concept is even a good idea.  Who on earth
wants to silently lose changes?  Default --squash behaviour is to
merge the old branch with the new branch.  If you want to throw stuff
away, that should probably be an entirely separate operation from the
merging.  ie. "git subtree discard-local-changes --prefix=3Dwhatever" t=
o
create a new patch that undoes all the local changes to this branch;
then "git subtree merge --squash" to update to a different upstream.

- In what sense is the history from this any "cleaner" (or any
different) from --squash?  It seems like, in fact, the history will be
a *lie* since it talks about merging but actually reverts changes.

> As all the history is lost and you never merge commits
> 'split' is not necessary, but it is basically:
>
> $ git filter-branch --subdirectory-filter $prefix

Are you saying that 'git subtree split' doesn't work after the
discard-local-changes operation?  If so, we should fix that, I think.
Otherwise it's very confusing.

> +prune_msg()
> +{
> + =A0 =A0 =A0 dir=3D"$1"
> + =A0 =A0 =A0 newsub=3D"$2"
> +
> + =A0 =A0 =A0 git show -s --pretty=3D"tformat:Subtree '$dir/': %h %s"=
 $newsub
> + =A0 =A0 =A0 echo
> + =A0 =A0 =A0 echo "git-subtree-dir: $dir"
> + =A0 =A0 =A0 echo "git-subtree-split: $newsub"
> +}
> +

Hmm.  I'm rather concerned about this one.  What's the top line of the
commit message?  add_msg, add_squashed_msg, rejoin_msg, and squash_msg
are all much clearer than this.  It also seems that it doesn't honour
the -m flag here.

> =A0cmd_add()
> =A0{
> - =A0 =A0 =A0 if [ -e "$dir" ]; then
> + =A0 =A0 =A0 if [ -e "$dir" -a -z "$prune" ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die "'$dir' already exists. =A0Cannot =
add."
> =A0 =A0 =A0 =A0fi

This is the 'add' command.  I'm not sure it should have special
behaviour with prune.

(Arguably 'add' should let you optionally overwrite an existing
directory if it already exists.  But if so, I don't think this should
only happen with --prune; it should probably be a special --overwrite
or --force option.)

> =A0 =A0 =A0 =A0debug "Adding $dir as '$rev'..."
> + =A0 =A0 =A0 if [ -d "$dir" ]; then
> + =A0 =A0 =A0 =A0 =A0 git rm -r -q $dir
> + =A0 =A0 =A0 fi
> =A0 =A0 =A0 =A0git read-tree --prefix=3D"$dir" $rev || exit $?

Isn't there some plumbing command we can use instead of 'git rm'?  I
don't really know what.  Does anyone have any suggestions?

> =A0 =A0 =A0 =A0A new commit is created automatically, joining the imp=
orted
> =A0 =A0 =A0 =A0project's history with your own. =A0With '--squash', i=
mports
> =A0 =A0 =A0 =A0only a single commit from the subproject, rather than =
its
> - =A0 =A0 =A0 entire history.
> + =A0 =A0 =A0 entire history. With '--prune', imports only the conten=
ts of
> + =A0 =A0 =A0 the commit from the subproject without any history.

This is unclear.  "Without any history" isn't really accurate, since a
new commit message is generated; actually the history importing is
precisely the same as what happens with --squash.

> +--prune::
> + =A0 =A0 =A0 Instead of merging the history (full or squashed) from =
the
> + =A0 =A0 =A0 subtree project, produce only a single commit that
> + =A0 =A0 =A0 reproduce the exact content in the preffix as in the
> + =A0 =A0 =A0 subtree.

s/preffix/prefix/

> + =A0 =A0 =A0 It has similar features as the --squash option, namely
> + =A0 =A0 =A0 reduces the clutter (althougth --prune reduce it even
> + =A0 =A0 =A0 more), helps avoiding problems when the same subproject=
 is
> + =A0 =A0 =A0 include multiple time and can switch back and forth
> + =A0 =A0 =A0 between different version of a subtree.

s/althougth/although/
s/include multiple/included multiple/

I don't understand how --prune supposedly "reduces it even more" than
--squash.  What clutter?  How does it reduce it *more*?  How does it
avoid problems when the same subproject is included multiple times?
What problems are those?

You can switch back and forth between different versions of a subtree,
but this is true of --squash as well - that's why I think this
operation should be a subcommand of --squash instead.

> + =A0 =A0 =A0 The main difference is that with --prune the content of
> + =A0 =A0 =A0 the prefix always matches the content of the subproject=
,
> + =A0 =A0 =A0 while with --squash it merges you changes with the chan=
ges
> + =A0 =A0 =A0 from the subtree. If you want to keep your changes you
> + =A0 =A0 =A0 have to extract them, apply them in the external
> + =A0 =A0 =A0 repository and add the subproject back.

s/you changes/your changes/

This last part is especially strange: if you want to keep your own
changes, why do you want to use --prune at all?  --squash does that
automatically.

Have fun,

Avery
