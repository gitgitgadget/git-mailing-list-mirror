From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC][StGit PATCH] Add support for merge-friendly branches
Date: Thu, 28 May 2009 15:38:44 +0100
Message-ID: <b0943d9e0905280738n51476ab7vd0498ea7a236c4a7@mail.gmail.com>
References: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com>
	 <20090528124817.GA22262@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu May 28 16:38:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9gkx-0002rc-4Y
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 16:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbZE1Oiq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 10:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbZE1Oip
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 10:38:45 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:53930 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbZE1Oio convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 10:38:44 -0400
Received: by ewy24 with SMTP id 24so5451988ewy.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yjgo8VS6Gj/Tuh2pehlgcVCeu7uSJ0RZR9TPPQYhw3I=;
        b=h+z06bkNa77pfcZuomTUr5WV38WC0m9J0PfGMViYTQumS5NSJy1XAqFUTTyNaAVfVM
         Dp38NYiUZju305vGjloiN1YD7isq++yvEn5oS0T/3vwcCm4LmMhOvnwD6GLXRVJJQh+E
         wndSanjxsmKmjswaFSxryDxqRSACkMKFohofA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S7eujjZRBOY4IRznhYKoiDy2Skt2NEFu5YAhMS4FH+4gEavG/6VAjHwOYsG/AUUH3A
         D/Jex7FeYb0vVCPQ0YciTFaIBo44mLvVLQwy1XdhztRmyYUyjo1gPXD2veoSLt06C+zr
         zb361Po30ha2acDN95VrZfeXnwJpLhp4TZTrY=
Received: by 10.216.29.210 with SMTP id i60mr523787wea.84.1243521524780; Thu, 
	28 May 2009 07:38:44 -0700 (PDT)
In-Reply-To: <20090528124817.GA22262@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120190>

2009/5/28 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-05-28 12:12:42 +0100, Catalin Marinas wrote:
>
>> The patch proposes a new StGit command called "publish". This
>> command allows one to develop patches normally on a StGit branch but
>> publish the stack changes to a separate, merge-friendly branch whose
>> history is not re-writable.
>
> Hmm, interesting. I don't think I'd want to use a command like this
> myself, but I can see how it might be useful.

=46or me it is useful. I publish a kernel tree with over 100 patches.
Later I find that one patch is buggy. The current merge-friendly
solution is to add another patch but I may want to just update the
buggy patch as it's easier when time comes to submit upstream. This,
however, rewrites the history. So with the "publish" command I just
generate another commit on top of the public branch and I always end
up with the same tree as on my stack.

>> + =A0 =A0# check for same tree (already up to date)
>> + =A0 =A0if public_tree.sha1 =3D=3D stack.head.data.tree.sha1:
>> + =A0 =A0 =A0 =A0out.info('"%s" already up to date' % public_ref)
>> + =A0 =A0 =A0 =A0return
>> +
>> + =A0 =A0# check for rebased stack. In this case we emulate a merge =
with the stack
>> + =A0 =A0# base by setting two parents.
>> + =A0 =A0merge_base =3D repository.get_merge_base(public_head, stack=
=2Ebase)
>> + =A0 =A0if merge_base.sha1 !=3D stack.base.sha1:
>> + =A0 =A0 =A0 =A0public_head =3D __create_commit(repository, stack.h=
ead.data.tree,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0[public_head, stack.base], options)
>> + =A0 =A0 =A0 =A0repository.refs.set(public_ref, public_head, 'publi=
sh')
>> + =A0 =A0 =A0 =A0out.info('Merged the stack base into "%s"' % public=
_ref)
>> + =A0 =A0 =A0 =A0return
>
> Hmm. Couldn't the merge base conceivably be higher up in the stack?
> Like, right at the beginning, don't we have public_head =3D=3D stack.=
head?
> That would be caught by the "same tree" check" a bit earlier, but
> after adding another patch, don't we have public_head =3D=3D stack.he=
ad^ ?
> Which would give merge_base =3D=3D public_head.

We could have public_head =3D=3D stack.head^... but that's not an issue=
=2E
The merge_base above is checked against the base of the stack rather
than the top as we assume that the base isn't volatile. So even if
public_head is the same as some patch commit, the merge_base above
would always be the base of the stack. Only if the stack base was
updated, we get a different merge_base (equal to the previous stack
base).

>> + =A0 =A0def get_merge_base(self, commit1, commit2):
>> + =A0 =A0 =A0 =A0"""Return the merge base of two commits."""
>> + =A0 =A0 =A0 =A0sha1 =3D self.run(['git', 'merge-base',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit1.sha1, comm=
it2.sha1]).output_one_line()
>> + =A0 =A0 =A0 =A0return self.get_commit(sha1)
>
> This funcion should probably return a list of zero or more merge
> bases. See the --all flag to git merge-base.

OK, I'll add this and check the stack base against this set(list).

--=20
Catalin
