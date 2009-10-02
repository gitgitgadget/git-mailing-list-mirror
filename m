From: skillzero@gmail.com
Subject: Re: Figuring out which patches have been applied
Date: Fri, 2 Oct 2009 12:16:00 -0700
Message-ID: <2729632a0910021216v7b3c5dadi14a6f8c0ea41b6b9@mail.gmail.com>
References: <9e4733910910020736n539f4331nfd61175b275c7d28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 21:17:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtncb-0000TB-9k
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 21:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbZJBTQB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Oct 2009 15:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756572AbZJBTP7
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 15:15:59 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:39939 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193AbZJBTP5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2009 15:15:57 -0400
Received: by iwn8 with SMTP id 8so763840iwn.33
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4seLDRDGw368bOWZwZKoBRz1gAvGfwQbGIPbbjrtq3Y=;
        b=QvtCj8ey8NqaLYawNww7bmo3vGuWpgkSVyyO71i/9B24TRwfsTJUsKADMFPMysSEFb
         /oPPyNerlorSuUO3K1fXEW+Wk/Rq9V3QVIc4HzrRTFL5zGb/Dye3cgCLw79JvhpT3wF0
         ZbZ/PG8KOIN09DrWwF6EycGwE/7v68VPD7/kY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rX1NAyZBUBVGfKxEv7RQ+K+2SKVg2MODK37WeB8z0ZnqTQEN0ScGt5u5hT/VsY2e4C
         kHZlDVicv6L9vVZHAr1EkmQJZK8Whwz6qQwY4Fr8vlsc5rqobLJk3FnIZSuRuXy6FW8J
         udO8RUqfHqop/UAtvRAMIgB2u/70xTN10dMvk=
Received: by 10.231.123.216 with SMTP id q24mr5674915ibr.43.1254510960957; 
	Fri, 02 Oct 2009 12:16:00 -0700 (PDT)
In-Reply-To: <9e4733910910020736n539f4331nfd61175b275c7d28@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129456>

On Fri, Oct 2, 2009 at 7:36 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> I have a stack of 100 patches against 2.6.30. A lot of these got
> merged between 2.6.30-32. =C2=A0How can I tell which ones have been
> applied?
>
> It doesn't work to check if patch A has been applied to 2.6.32. Other
> patches may have been applied on top of patch A obscuring it.
>
> Once solution would be to rebase the patch stack forward one commit a=
t
> a time. That solves the problem of later patches obscuring patch A. I=
s
> there a better way to do this?

There may be a better way, but I needed to do a similar thing with
commits that were cherry-pick'd so I wrote a simple
git-contains-equivalent script to search for equivalent patch ID's
given a commit ID. You could do something like that, but using
git-patch-id as the source instead getting it from an existing commit
like the following script does.

#!/bin/bash

set -o pipefail
searchCommitID=3D`git rev-parse $1`
searchPatchID=3D`git show $searchCommitID | git patch-id`
if [ $? -ne 0 ]; then
	exit 1
fi
searchPatchID=3D${searchPatchID% *}

echo "Searching for equivalents to commit $searchCommitID (patch
$searchPatchID)..."
git log --all -p | git patch-id | grep $searchPatchID |
while read patchID commitID; do
	if [ "$commitID" =3D "$searchCommitID" ]; then
		echo "Exact commit $commitID is on the following branches:"
	else
		echo "Equivalent commit $commitID is on the following branches:"
	fi
	git branch -a --contains $commitID
done
