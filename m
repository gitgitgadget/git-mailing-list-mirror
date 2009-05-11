From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [BUG] fatal error during merge
Date: Mon, 11 May 2009 09:39:35 +0200
Message-ID: <81b0412b0905110039l280b69acje4f9704c81028bcc@mail.gmail.com>
References: <20090510163336.GA27241@blimp.localdomain>
	 <alpine.DEB.1.00.0905110106370.27348@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 11 09:39:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Q6z-0001Jz-2U
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 09:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbZEKHjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 03:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbZEKHjg
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 03:39:36 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51422 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbZEKHjg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 03:39:36 -0400
Received: by fxm2 with SMTP id 2so2483496fxm.37
        for <git@vger.kernel.org>; Mon, 11 May 2009 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hjORHcb639WePhI45N3meq7iUA2J9QRYcK0bJT/OMPg=;
        b=W4xOxmG9zi8rsU3fAiZ6a2x3mkI6B4O4UBg01UvnRDqdc/8rSYGIHdHg8N1eH8Ta2v
         ieWnl6plJlrgkjvsuBIzIhVHSi5y79WheWgI/4l5VAX8jRsITGnQBlmtONaWYyLzJ1JG
         kRTBSNTMUKKAGWLrrIPq4P1GscdIKrsDwuM4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K2HnY41L8EDMfsfkE/M/KV2+l7B1Tf0A3xoEeHzrOVhNIMEE27T70ICg9DaseefmBa
         75CqQbbh4ItCJd1Oofb3qrsrtnk7IEhHfRs2XSPHNoGSzKbjRgA+UlEtzd00UZYwH5sx
         PUo0AaWNvSPxfL5hz1qb3msqYisHziKmCQfBc=
Received: by 10.204.54.19 with SMTP id o19mr4542435bkg.72.1242027575741; Mon, 
	11 May 2009 00:39:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905110106370.27348@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118781>

2009/5/11 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> If I read the message right, the file revision is supposed not to be
> changed from HEAD. =C2=A0Is unpack_trees() invalidating the "cleannes=
s" of that
> file?

I think it is the D/F (or F/D?) conflict. A file in one branch is renam=
ed into
a directory. The script in the original post still works (err... fails)=
=2E

> =C2=A0(I would really love to have a better idea what's going on than
> what I get from both the commit message and the patch before giving m=
y
> ACK.)

Ah, scrap that. The patch is no good, and does not fix the original pro=
blem
at all. In fact, it makes it even worse - hides the problem by removing=
 conflict
information from the index and _deletes_ the problematic file.
That's why it wasn't included - the brokenness was noticed.
Pity that then I run out of time, too.

The script to reproduce (note GIT_EXEC_PATH!):

#!/bin/sh

rm -rf merge-rename-fail
mkdir merge-rename-fail || exit
cd merge-rename-fail || exit
export GIT_MERGE_VERBOSITY=3D5
export GIT_EXEC_PATH=3D$HOME/projects/git
$GIT_EXEC_PATH/git init
mkdir before
echo FILE >before/one
echo FILE >after
$GIT_EXEC_PATH/git add .
$GIT_EXEC_PATH/git commit -mfirst

rm -f after
$GIT_EXEC_PATH/git mv before after
$GIT_EXEC_PATH/git commit -mmove

$GIT_EXEC_PATH/git checkout -b para HEAD^
echo COMPLETELY ANOTHER FILE >another
$GIT_EXEC_PATH/git add .
$GIT_EXEC_PATH/git commit -mpara

echo '***
*** MERGE ***
***'
echo export GIT_EXEC_PATH=3D$GIT_EXEC_PATH
echo $GIT_EXEC_PATH/git merge master
