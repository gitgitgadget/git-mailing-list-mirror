From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH] Make --follow support --find-copies-harder.
Date: Wed, 21 Apr 2010 12:17:22 +0800
Message-ID: <h2l41f08ee11004202117nc56510d4y29e39631fdff0923@mail.gmail.com>
References: <1271762875-16548-1-git-send-email-struggleyb.nku@gmail.com>
	 <7vtyr5cxnz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, torvalds@linux-foundation.org,
	trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 06:17:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4RNd-0000Ml-8U
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 06:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862Ab0DUERY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 00:17:24 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:53521 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab0DUERY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 00:17:24 -0400
Received: by qyk9 with SMTP id 9so8659718qyk.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 21:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zWXs9JAUFgXi4UN0aMFVHU2Q7+hVzPssdcG2ZanmANo=;
        b=ltR4bxfoeyVSyz5HNNWFlnMjbeJNvrqOPuPzaSRGDPjsHvgwiSeW7wcz6rn+Z7rW3T
         y8J4ZJb8jruADtNdMktLFjquAg5z5AcwOMFiHE3SJdN3q2nLxpRc3WTtYQQJEGSxHkxq
         6GLz4b8/Vd+kQzXRCwcdntqNoJ+rya+UPyBwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d3E9p81vgPpUXZkTYb4ez80MOmCF5srmFcQhIBn/uMjBAjQBLCXZ0inbsiSZFGP1Pu
         8vR4KMOxIZ5GZSUKDWLyzjYOwJ4lwkUS30Uw5evl2tU1A7PcSCUIDuAZF6epGhaQxFAW
         zcy2eiwqfKfBzHjJIVsO9N7S7i3DHgGkRddVg=
Received: by 10.229.98.196 with HTTP; Tue, 20 Apr 2010 21:17:22 -0700 (PDT)
In-Reply-To: <7vtyr5cxnz.fsf@alter.siamese.dyndns.org>
Received: by 10.229.217.206 with SMTP id hn14mr4336289qcb.70.1271823442677; 
	Tue, 20 Apr 2010 21:17:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145405>

On Wed, Apr 21, 2010 at 11:05 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Because the "--follow" hack was done primarily as a "checkbox" item, =
and
> also because it is not an option for the "diff" family (it is an opti=
on
> for the "log" family), I would personally think that it is actually a=
 bug
> that "git diff" accepts "--follow" and pretends as if it is doing use=
ful
> work, but does so only some of the time.

Ah, sorry for the confusion. I mean, I have found the bug when I use
git log. And take a look at:

git log --follow --find-copies-harder -p t/t4013/diff.show_--first-pare=
nt_master

This will report the file  t/t4013/diff.show_--first-parent_master as
a new file but it is copied from t/t4013/diff.show_master indeed.
'--find-copies-harder' should detect this, but it didn't. With this
patch it will find such copy and go on following
t/t4013/diff.show_master history.

And I locate the bug in the format of a diff test case and this cause
the confusion. What I really try to fix is,
1. --follow should support --find-copies-harder when using git-log
2. git-diff should support --find-copies-harder, I mean, diff should
find copies in unmodified files.

=46or 2, I find the --follow option works for git-diff, so I just take
consideration that it is the right way to support the
--find-copies-harder in git-diff. (and now I don't think so...) ;-)

> =A0 =A0$ git diff --follow --name-status maint master -- builtin/log.=
c
> =A0 =A0R089 =A0 =A0 =A0 =A0builtin-log.c =A0 builtin/log.c
> =A0 =A0$ git diff --follow --name-status -R maint master -- builtin/l=
og.c
> =A0 =A0D =A0 builtin/log.c
> =A0 =A0$ git diff --follow --name-status master maint -- builtin/log.=
c
> =A0 =A0D =A0 builtin/log.c
>
> As we can see, it doesn't quite work, and it is not a fault of 750f7b=
6
> (Finally implement "git log --follow", 2007-06-19) by Linus, exactly
> because the feature wasn't designed to work with "diff" to begin with=
=2E

Hmm, really.

> If we were to add a support of "--follow" to "diff" family, I suspect=
 that
> we need to
>
> =A0(1) make sure we get only one path, just like "log" family does;
>
> =A0(2) add a logic to notice the reverse situation as demonstrated ab=
ove and
> =A0 =A0 deal with it in a sensible way, without any --find-copies opt=
ion
> =A0 =A0 given by the user.

En, as above. I just want to teach git-diff to find copies among
unmodified files with '--find-copies-harder' option. Maybe, '--follow'
is the good choice to use for control whether git-diff will detect
file move/copy, and '--find-copies-harder' is the option to control
how hard we find the copies.

I will try to make this patch into two, one for fixing the git-log
--follow --find-copies-harder one, and the other try to make a sane
logic for '--follow' for git-diff.

Thanks for your advice!

Regards!
Bo
--=20
My blog: http://blog.morebits.org
