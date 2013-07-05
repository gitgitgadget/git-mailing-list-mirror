From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unexpected file deletion after using git rebase --abort
Date: Fri, 05 Jul 2013 00:07:02 -0700
Message-ID: <7vd2qxa3jd.fsf@alter.siamese.dyndns.org>
References: <20130703224402.GF9016@localhost.localdomain>
	<20130703225642.GU408@google.com>
	<7vip0rckjs.fsf@alter.siamese.dyndns.org>
	<20130704193550.GA4183@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: "Paul A. Kennedy" <pakenned@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 09:07:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv06r-0002SK-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 09:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757006Ab3GEHHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 03:07:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32836 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176Ab3GEHHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 03:07:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B76742998A;
	Fri,  5 Jul 2013 07:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=kHQgnB9bHH20ohOeDWSm7XJhDFs=; b=stq3R+w2n23kZ5ID+CgK
	k325oyUyT7cMvEXRwDZkWRI9SZzozaf5Ky0hdf4Xd7tjgpQrKLbCv34oEtdlymHc
	APSaSNVze27ax5LQ9499VBslOds+ZVpuv/qA2QfhemsMium5bq4E0xywS69FwdMM
	Hu+veyqWGj7qoTqtTQF8MI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RdRIs7ctY9pvEUpbit0JxBtNLZbGYdkL4wJijVzYr3e/fx
	7LSwnV3ixcqc2a1ptQU8sjmtNSHQSku05gPeTvenzS308Y0wkhUKRkTul+kFfzoP
	Bjw3iNTT/vIB0d6pM5b/VuQGaV7fBuyfNtzA/sKUvQuLG0RgESuY2M+h7fbDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAE5F29989;
	Fri,  5 Jul 2013 07:07:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD2D429985;
	Fri,  5 Jul 2013 07:07:03 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EE5C1D8-E541-11E2-9046-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229630>

"Paul A. Kennedy" <pakenned@pobox.com> writes:

>> "rebase --abort" is typically used to get rid of conflicted mess the
>> user does not want to resolve right now, and "stash" would not be a
>> sensible thing to use in such a situation, I think.  Doesn't it even
>> refuse to work if there is a conflicted entry in the index?
>
> Thanks for thinking about this with me.  
>
> After contemplating your messages, I think that it's unreasonable to
> expect git rebase --abort to be able to properly handle content from
> completely outside the repo and only placed in the index.

The essense of "--abort" is to bring your index and the working tree
state back to the state you had before you got into a conflicted
mess.

For paths that still have higher/conflicted stages in the index, it
is easy to decide what should happen.  Because we do not even allow
rebase to start with an index with conflicted paths, they must have
come from the rebase operation itself, so matching them to what is
in the HEAD (and removing such conflicted paths that are not in the
HEAD) is always the right thing.

But for paths in the index that are already resolved at stage #0,
it is not simple.  They can come from

 (1) a clean automatic resolution (including the case where the
     rebase did not even touch the path).

 (2) a conflict that was resolved manually and then "git add"ed.

 (3) manual "git add" of a path that a mechanical part of the rebase
     operation did not touch at all.

For (1) and (2), it is the right thing to match with HEAD and
to remove the path if it is not in HEAD (e.g. the path may have
appeared by attempting to replay a change to add it).

For (3), a change may update existing files in HEAD or it may add a
new path not in HEAD.  Ideally, the former should be reverted to
HEAD, and the latter should be only reverted in the index but leave
the file in the working tree untracked.

But there is no good way to tell these three classes apart,
unfortunately.  With recent Git, I think you can tell paths in
category (2) by noticing that they have "REUC" entries for them in
the index extension section.

The only case we may want to behave differently is "git add" that
adds a path that does not exist (at any stage) to the index, so
theoretically, we could teach the end-user facing "git add" to leave
a new extension entry to the index, teach "git reset --no-so-hard"
to notice the index extension to leave the path in the working tree
when reverting to a HEAD that does not have such a path and use it
in "rebase --abort" codepath.  Which would also allow us to be less
aggressive in a case like this:

	... have many untracked and unignored paths
        $ git add .
        ... oops, I did not mean it
        $ git reset --hard
	... double-oops, these untracked paths are all gone

But that is "theoretical" primarily because it is unclear what the
exhaustive set of situations where we must clear such a "this is
newly added" mark to avoid false positives.  After "git commit" that
records such a path in a commit is obviously one of them, but that
is not the only one, and every place we forget to clear the mark
will be a cause of confusion.

Alternatively, perhaps we could create the "REUC" extension for
category (1) paths as well.  Then "git reset --not-so-hard $commit"
could be changed to behave the same way as it does today, except
that it would not remove paths without "REUC" extension entry from
the working tree.

> +	Untracked files added to the index will not be unstaged, and
> +	therefore, not present in the working directory upon abort.
> +	Unstage files before the abort, or stash untracked content before
> +	starting the rebase (see linkgit:git-stash[1]).

"Unstage files" is a less than ideal suggestion.

	$ git rebase
        ... oops conflicted
        ... ouch, this is too much for me to resolve
        $ git reset
        $ git rebase --abort

would leave a path that was introduced by the change being replayed
in the working tree, which may later interfere when you try to
checkout a branch that does have that path.  At least it has to be
"Unstage such files that were untracked and added by you" to be
helpful, I think.
