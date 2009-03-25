From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Add the --merged option to goto
Date: Wed, 25 Mar 2009 10:24:13 +0000
Message-ID: <b0943d9e0903250324j9ed0ed9k2d97cbacba6a7801@mail.gmail.com>
References: <20090320161233.28989.82497.stgit@pc1117.cambridge.arm.com>
	 <20090323084507.GA6447@diana.vm.bytemark.co.uk>
	 <b0943d9e0903230933n5b71a53elcfaa13f00883861d@mail.gmail.com>
	 <20090324131640.GB4040@diana.vm.bytemark.co.uk>
	 <b0943d9e0903240840m3f22b702qd48293caad4187e3@mail.gmail.com>
	 <20090325090541.GA24889@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 11:26:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmQJC-0004FZ-Lf
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 11:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885AbZCYKYT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 06:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756586AbZCYKYT
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 06:24:19 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39930 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764AbZCYKYS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 06:24:18 -0400
Received: by fxm2 with SMTP id 2so2675417fxm.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Hb+XUxC6cACWFuXw2aPwJ/dB2y3yoiE0U3Pvx/5znZo=;
        b=UvSXEpgSA7InJtRJRPnOvFtKZ8d3Zmr8GJHX+JqwjJ9oQxN1wu9Jjdyay/jpRMNHpz
         MQ9U2l5ATqt8CBAnz0q7kprm6pfHyoftl7kpOtnUbNE93HSC6zpsgW5I3WNsFKrX7Ryd
         c2nhqs9D2ujMeAqhLkN1UdMOqVBOr63AE1XiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mejpZO52fq0s9Bd6z0XnnMLcgR60PUHp+AJV6lE8Kr4SOoyKrH08whY1lokdLD0m4q
         ZlCA0HNdNgCDWDBK4yEotZ4K4QvgjAFHnpY5Ts+vIoEFzabdgsW1LAIq98HFS9jKRJIo
         lKZ2RGD4rKIAx/UiGfboCpgyOAXimzK9f/ibc=
Received: by 10.204.61.137 with SMTP id t9mr3293095bkh.204.1237976653897; Wed, 
	25 Mar 2009 03:24:13 -0700 (PDT)
In-Reply-To: <20090325090541.GA24889@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114580>

2009/3/25 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-03-24 15:40:10 +0000, Catalin Marinas wrote:
>> Whatever is in the index after the check_merged() function doesn't
>> correspond to any tree so it would need to be re-read.
>
> It does correspond to _some_ tree, but as we have no particular reaso=
n
> to expect that it might be a tree that we're going to need again
> immediately, we can set temp_index_tree to None to force re-reading,
> rather than pay the cost of write_tree.

Yes, that's what I meant by "doesn't correspond to any tree".

BTW, why don't we keep the tree information directly in the Index
object? Since this object is modified only via its own interface, it
can do all the checks and avoid the managing of temp_index_tree in the
Transaction object.

>> + =A0 =A0def check_merged(self, patches):
>> + =A0 =A0 =A0 =A0"""Return a subset of patches already merged."""
>> + =A0 =A0 =A0 =A0merged =3D []
>> + =A0 =A0 =A0 =A0self.temp_index.read_tree(self.stack.head.data.tree=
)
>> + =A0 =A0 =A0 =A0# The self.temp_index is modified by apply_treediff=
() so force
>> + =A0 =A0 =A0 =A0# read_tree() the next time merge() is used.
>> + =A0 =A0 =A0 =A0self.temp_index_tree =3D None
>> + =A0 =A0 =A0 =A0for pn in reversed(patches):
>> + =A0 =A0 =A0 =A0 =A0 =A0# check whether patch changes can be revers=
ed in the current index
>> + =A0 =A0 =A0 =A0 =A0 =A0cd =3D self.patches[pn].data
>> + =A0 =A0 =A0 =A0 =A0 =A0if cd.is_nochange():
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue
>> + =A0 =A0 =A0 =A0 =A0 =A0try:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.temp_index.apply_treediff(cd.t=
ree, cd.parent.data.tree,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 quiet =3D True)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0merged.append(pn)
>> + =A0 =A0 =A0 =A0 =A0 =A0except git.MergeException:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pass
>> + =A0 =A0 =A0 =A0return merged
>
> Some points here:
>
> =A01. Check if temp_index_tree already contains the tree you want
> =A0 =A0 instead of doing read_tree unconditionally. That is, change
>
> =A0 =A0 =A0 self.temp_index.read_tree(self.stack.head.data.tree)
>
> =A0 =A0 to
>
> =A0 =A0 =A0 if self.stack.head.data.tree !=3D self.temp_index_tree:
> =A0 =A0 =A0 =A0 =A0 self.temp_index.read_tree(self.stack.head.data.tr=
ee)
> =A0 =A0 =A0 =A0 =A0 self.temp_index_tree =3D self.stack.head.data.tre=
e
>
> =A02. If apply_treediff fails (raises MergeException), the index wasn=
't
> =A0 =A0 modified at all (but I guess you knew that, since your code
> =A0 =A0 relies on that fact), so there's no reason to set temp_index_=
tree
> =A0 =A0 to None in that case. So in order to not clear temp_index_tre=
e
> =A0 =A0 unnecessarily in case none of the patches reverse-apply (a ca=
se I
> =A0 =A0 personally encounter frequently, since I leave the -m flag on=
 all
> =A0 =A0 the time), move
>
> =A0 =A0 =A0 self.temp_index_tree =3D None
>
> =A0 =A0 to just after (or just before) "merged.append(pn)".

Yes. But it may be even better to do this in Index.
Index.apply_treediff() would set the tree to None and read_tree or
write_tree would set it to the corresponding tree.

> =A03. Why are empty patches considered not merged?

They would be reported as empty anyway and in general you don't submit
empty patches for upstream merging.

--=20
Catalin
