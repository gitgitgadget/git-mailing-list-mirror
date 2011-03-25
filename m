From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing error message due to Git trusting is_bare_repository()
Date: Fri, 25 Mar 2011 10:57:50 -0700
Message-ID: <7vwrjn5bhd.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=9CpMU9aZs2zuvRyv3rpECkRAvYA0Srnc61whg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:58:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3BH2-0006Eg-CM
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 18:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414Ab1CYR6G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 13:58:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab1CYR6E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 13:58:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 51376487C;
	Fri, 25 Mar 2011 13:59:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=btTbRO37u9nz
	v7+OEs+LrLTt+24=; b=b2wLwbpvTcpzgIWgWf1QjP2WDu4JlAkQIMUENepoEJ10
	kB/wHlfnleXDGCN1Rt8PV1zWwyG22Xbt4yteHhrilYnKpfbbMx76QM4/xRy1ILtM
	PyjZwUal4xdNbh3nnzaeEf094bS+QYv0R7Sw0Tz15pgOVVfTA1XzE7/a4+Z2oDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NyD6/C
	lX7mYwesgG82DGL6HwstRX/42IdUf0afq0J4WEIMg03W8Kf0ME5PDUGTNEXdONLQ
	kYNmegdzrUPXeWxmsPYB9xoq54K9NJLB5b0TAlMxCCU2BnOdQiTMNhl9995RbEAy
	ndW8sa5+FHO0Ww3e8OawH9QCSCA1lfmYvrW4E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EF02487B;
	Fri, 25 Mar 2011 13:59:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2E0F24876; Fri, 25 Mar 2011
 13:59:33 -0400 (EDT)
In-Reply-To: <AANLkTi=9CpMU9aZs2zuvRyv3rpECkRAvYA0Srnc61whg@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 25 Mar
 2011 11:56:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5EAD43A-5709-11E0-AC4F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170005>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I had a co-worker git this well-known error message:
>
>     error: refusing to update checked out branch: refs/heads/master
>     error: By default, updating the current branch in a non-bare repo=
sitory
>     error: is denied, because it will make the index and work tree in=
consistent
>     error: with what you pushed, and will require 'git reset --hard' =
to match
>     error: the work tree to HEAD.
>
> It *was* a bare repo, but the config file had bare=3Dfalse because
> someone had simply copied a .git tree from a non-bare repo to make it=
=2E
>
> The issue is that we just use this:
>
>     int is_bare_repository(void)
>     {
>         /* if core.bare is not 'false', let's see if there is a work =
tree */
>         return is_bare_repository_cfg && !get_git_work_tree();
>     }
>
> For the purposes of the error message it would be helpful if we also
> detected whether something didn't have a working tree, but was set to
> bare=3Dfalse, and tell the user to updatet he bare=3Dfalse to bare=3D=
true
> for his almost-bare repository.

The only reason we have it as a config variable is because there isn't =
a
way to make that determination.

How would you propose to detect that?

As a trivial and obvious example, is the result "git clone -n" a bare
repository?

Note that it is a perfectly valid workflow to:

	$ git clone -n github.com:gitster/git.git temp
        $ cd temp ;# no checkout, but is .git/ in it a bare repository?
        $ git read-tree origin/master ;# now with the index, but no che=
ckout
        $ git merge origin/jc/diff-dotdot
	$ git show -m --first-parent

to make a merge with minimum number of paths checked out in a temporary
repository that should still be considered non-bare.

Of course, you cannot base the determination on "do we see $GIT_DIR/ind=
ex
file there?"  Most likely people who renamed foo/.git to foo.git and th=
en
removed foo directory didn't bother to remove foo.git/index.
