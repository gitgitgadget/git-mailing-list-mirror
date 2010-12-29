From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] setup: translate symlinks in filename when using absolute paths
Date: Wed, 29 Dec 2010 20:44:11 +0700
Message-ID: <AANLkTi=VQZH01i9bpem7AhSaNv3BMr3__rLKsQ3bO1Rz@mail.gmail.com>
References: <1293447277-30598-1-git-send-email-carenas@sajinet.com.pe> <7vr5d1wuh0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 14:44:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXwKe-0000eX-Ok
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 14:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab0L2Non convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Dec 2010 08:44:43 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49835 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab0L2Nom convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Dec 2010 08:44:42 -0500
Received: by wwa36 with SMTP id 36so10695989wwa.1
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 05:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lWUh2wcPvQeD5mSfFueL5Arqa3FVLCAHxg4Iu8CHwXI=;
        b=BtclUXnZCxBUATMd1Mh7B0pfQ6e3s+Da1ysV9APm7F6wJo7R2jGdEv6MciqPaarHC8
         Ptr4STZIRwwfv1oNGj+EoA/poBOvsbsOV2jT8XLKZfxufM19mZB/SNfbKoWZPMc8zV0K
         VHZ/9/3ARED0ID3dP3rg+womHf4/QGBW10hRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RhMTpbsu0seQ/1AyYZcfOfiwVXsk/ZJtYkwCE29ORyEuz/i8YfEexXchlw4bTtJiEg
         bP/hzYik2HcJ+/E37P/T5A2acOGnQ9+zElYOr/XA2aiww3Is3TUTPkpqZLCZJuXInBwv
         /eZGVW/PE/TQVNIDKyMGHoXWidlsM4DX31E8E=
Received: by 10.216.24.134 with SMTP id x6mr18911025wex.34.1293630281727; Wed,
 29 Dec 2010 05:44:41 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Wed, 29 Dec 2010 05:44:11 -0800 (PST)
In-Reply-To: <7vr5d1wuh0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164309>

2010/12/29 Junio C Hamano <gitster@pobox.com>:
> Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe> writes:
>
>> otherwise, comparison to validate against work tree will fail when
>> the path includes a symlink and the name passed is not canonical.
>>
>> Signed-off-by: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
>
> I take that "path" and "name passed" refer to the same thing (i.e. "p=
ath"
> parameter) in the above.
>
> I think you are trying to handle the case where:
>
> =C2=A0- you give "/home/carenas/one" from the command line;
> =C2=A0- $PWD is "/home/carenas"; and
> =C2=A0- "/home/carenas" is a symlink to "/net/host/home/carenas"
>
> and the scan-from-the-beginning-of-string check done between
> "/home/carenas/one" and the return value of get_git_work_tree() which
> presumably is "/net/host/home/carenas" disagrees. =C2=A0I wonder if a=
 more
> correct solution might be to help get_git_work_tree() to match the no=
tion
> of where the repository and its worktree are to the idea of where the=
 user
> thinks they are, i.e. not "/net/host/home/carenas" but "/home/carenas=
", a
> bit better?

I tend to agree. Will cause less surprises (such as this one).

> That would involve tweaking make_absolute_path() I guess?

Hm.. can we avoid converting work_tree to absolute path unless people
explicitly set it (via --work-tree and GIT_WORK_TREE)? Basically
worktree will be relative to cwd. Usually it's just ".". When people
run commands outside worktree, it's the relative "cwd/to/worktree".
I'm wondering if we can just avoid the use of make_absolute_path()
completely in get_git_work_tree()..

> Note that your patch is the right thing to do either case, i.e. with =
or
> without such a change to make_absolute_path(), as the function is use=
d to
> set up the return value from get_git_work_tree(). =C2=A0Anything we c=
ompare
> with it should have passed make_absolute_path() at least once.

Yes, I think that should that be done inside normalize_path_copy(),
not prefix_path().

>> =C2=A0setup.c | =C2=A0 11 +++++++----
>> =C2=A01 files changed, 7 insertions(+), 4 deletions(-)

Also Carlo, tests should be good for illustration and regression
purposes. I know you described in detail in another mail. But mails
tend to get lost.
--=20
Duy
