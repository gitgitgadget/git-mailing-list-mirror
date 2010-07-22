From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] t2017: redo physical reflog existance check
Date: Thu, 22 Jul 2010 15:58:42 -0300
Message-ID: <AANLkTilt5gx3Wj4eANfkIFm869Olns1rsMpCS81hS2BV@mail.gmail.com>
References: <1279763190-32757-1-git-send-email-erick.mattos@gmail.com> 
	<7vlj93h120.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 20:59:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc0zE-0000hU-0R
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 20:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab0GVS7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 14:59:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33544 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab0GVS7I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 14:59:08 -0400
Received: by iwn7 with SMTP id 7so8080542iwn.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bBt7Qg10NRURWYhLieDLptPM7fHnO0OzxSi7VZxQIhw=;
        b=ZYH9ubgNuU4Mb0X3jQPBVQ2U+4otOT44zmHOmSlsUnVdvN4PM76PILW0ilQRGRUz8H
         /5p7fAOgg3VOMpbXRXRyXm3VEUsgDTZ/8uCoxbFk0ERS8TbAYxHt0Gi1n7Fs8HSMCART
         5BWxv8eP5Wy+97nsv3dFy7GRBgKEwy4tLBQg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kWX0BGLzURsqkHcCYwvpKaRw9PenW/NaBuvchrun8z7T+1ktVjzCtmeEZw2QeSAO/F
         6tWsGEqN/2DiPXrr51vzh8kfBi581UenTQXEQwFILQQC9ntBn9jK7401fxaIIQj314lp
         qZVChWp5gQwi8jj3R6TJokqTixk4x2Y/tgYzM=
Received: by 10.231.14.136 with SMTP id g8mr2202446iba.146.1279825146709; Thu, 
	22 Jul 2010 11:59:06 -0700 (PDT)
Received: by 10.231.178.36 with HTTP; Thu, 22 Jul 2010 11:58:42 -0700 (PDT)
In-Reply-To: <7vlj93h120.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151471>

Hi,

2010/7/22 Junio C Hamano <gitster@pobox.com>
> I thought about it a bit when I sent out my patch, but I do not think=
 that
> is necessary.
>
> The things you care about, after running "-l --orphan eta", are:
>
> =C2=A0- If you make a commit, you get eta@{...} reflog that records i=
t; and
>
> =C2=A0- If you leave the still-to-be-born eta branch without making a=
 commit,
> =C2=A0 you do not leave eta@{...} reflog behind.
>
> Your zeta@{...} test is about the former, and your eta@{...} test is =
about
> the latter. =C2=A0I think they already check what they want to see ha=
ppen.

You have separate my concerns in the scripts very well but the result
you pointed out is not quite true.

=46or zeta, not testing physical existence of reflog file is not really
important because at the end you will have the reflog created anyway,
which is well tested by latter "git rev-parse --verify".  But that is
not the case of eta therefore the check is necessary.

The solution to the problem of creating reflogs when using -l and
--orphan while configured core.logAllRefUpdates=3Dfalse was a simple
trick, completely based on actual implementation of reflog saving:
reflogs are saved when there is already a reflog file.

To make the new orphan branch ready to have a reflog on that config
was as simple as creating a "touch file" for reflog.  This is the goal
achieved by code.  Testing this goal by checking the touch reflog file
is important while in zeta case redundant, because of the final result
of having a reflog saved and consequently the touch file filled with
real reflog data.

But this clean solution should not leave a bogus file in case it is
not being used by canceling the creation of the new orphan branch and
doing a checkout to another branch.

So in eta case it is important to check if the reflog physical file is
really deleted.  No reflog will be created anyway in eta case so "git
ref-parse --verify" is not even relevant.  I have added formal reflog
check just in case.

Testing more is always better than testing less so I prefered to be
redundant and test thoroughly in all levels of detail.

> I also am afraid that the "test -f" check would expose the implementa=
tion
> detail more than necessary. =C2=A0We may want to come up with a diffe=
rent
> implementation of this behaviour later that may not create an empty f=
ile
> there.

No exposure is being done by using "test -f" inside a script which its
sole purpose is to check a controlled event for developers.  Folder t
has "test -f" being employed in 92 scripts.

The only reason for the t folder is to let the developers be aware of
what they are possibly breaking, isn't it?!

I think this implementation is quite good.  I don't see a reason for
changing it.

The point is that you give a command (-l --orphan on
core.logAllRefUpdates=3Dfalse config) that have to save the preference
of creating the reflog for later.  Data need to be saved once git is a
simple call-run-quit software.  And the way it is being saved is, at
minimum, very efficient.  No outside file or special config is being
created and no memory persistent variable/objects is being left
behind.  The implementation is working as expected and the subject is
only the testing script.

We have to remember that all we are talking here is about a very
uncommon situation when core.logAllRefUpdates is set to false.  I
personally don't even foresee a possible reason for not having reflogs
saved automatically anyway. :-|

Regards
