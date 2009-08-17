From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 19:49:22 +0700
Message-ID: <fcaeb9bf0908170549w26b008bdhe67f113a58ecb4eb@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> 
	<200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org> 
	<200908160137.30384.jnareb@gmail.com> <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de> 
	<alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 14:49:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md1eo-0003Sa-Jy
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 14:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbZHQMtm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 08:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbZHQMtm
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 08:49:42 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:37745 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbZHQMtl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 08:49:41 -0400
Received: by yxe5 with SMTP id 5so3539751yxe.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Y0dXuz/+rc1Xa01JJ5SOyi+HCmsLhDkGUuOTp8iSTAg=;
        b=VHbU7JZnJDlFmCzEktEBzVBzk/ppSgkxWvu0i5hnORNllZH09bQmwXC4YAKlxzhueU
         pupuhrqqeQfdHDCgo51P8ZiSW2U4gQUtuA10xARFVNr7EWr2GhnW0k8A/ehknYfAjPX6
         sPtOqIpCsmRRrPu8NIFDmD/3Xr61XdbrNx+qY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Hm+fdgeZZnQ5e0oJKVPikfPcXK9K79VF9ZEsWc7s5XIcEoPvXJ2HeTirt1uLGDpjLE
         9HGfv8KV1ZfpyGD++pFlqoBLnihmQcEu5mte3dvkoVDqJooW2iTBse3YbWCnSfW0fI0l
         f8BeLOtkRZtKsJHrySymFSq12jfeOn5nUULYg=
Received: by 10.101.85.15 with SMTP id n15mr3279988anl.139.1250513382118; Mon, 
	17 Aug 2009 05:49:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126174>

On Mon, Aug 17, 2009 at 4:08 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Turns out that somebody on IRC had a problem that requires to have
> sparse'd out files which _do_ have working directory copies.
>
> So just having the assume-changed bit may not be enough.
>
> The scenario is this: the repository contains a file that users are
> supposed to change, but not commit to (only the super-intelligent inv=
entor
> of this scenario is allowed to). =C2=A0As this repository is original=
ly a
> subversion one, there is no problem: people just do not switch branch=
es.
>
> But this guy uses git-svn, so he does switch branches, and to avoid
> committing the file by mistake, he marked it assume-unchanged.

Hmm.. never thought of this use before. If he does not want to commit
by mistake, should he add to-be-committed changes to index and do "git
commit" without "-a" (even better, do "git diff --cached" first)?

> Only that a branch switch overwrites the local changes.

I don't think branch switch overwrites changes in this case. Whenever
Git is to touch worktree files, it ignores assumed-unchanged bit and
does lstat() to make sure worktree files are up to date.

> I suggested the use of the sparse feature, and mark this file (and th=
is
> file alone) as sparse'd-out.

Sparse checkout only removes a file if its assume-unchanged bit
changes from 0 to 1. If it's already 1, it does not care whether there
is a corresponding file in worktree. So something like this should
work:

git checkout my-branch
git update-index --assume-unchanged that-special-file
echo that-special-file > .git/info/sparse
# edit that-special-file
git commit -a
# do whatever you want, git pull/checkout/read-tree... won't touch
that-special-file because it's assume-unchanged already

Too subtle?

Anyway I would not recommend this. the versions of that-special-file
in worktree and and in index will diverse. When you unmark
assume-unchanged (be it sparse checkout or plain assume-unchanged),
you may have already forgot what changes you made to this file and
"git diff" would not help.

> Is this an intended usage scenario? =C2=A0Then we cannot reuse the
> assume-changed bit [*1*].

It'd be great if people tell us all the scenarios they have. My use
could be too limited.
--=20
Duy
