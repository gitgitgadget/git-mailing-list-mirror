From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH/RFC 2/2] git-p4: Add complex test case for branch import
Date: Tue, 23 Aug 2011 23:02:05 +0100
Message-ID: <CAOpHH-V92CcWm1tCwvb=pJux5PKbYQoG=E8M_Pc2JGu00wnR8Q@mail.gmail.com>
References: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
 <1313712590-26876-3-git-send-email-vitor.hda@gmail.com> <20110820191203.GC7135@arf.padd.com>
 <20110822011319.0a013117@fenix.utopia.dhis.org> <20110823022713.GA6005@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 00:02:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvz3R-0001Ae-3W
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 00:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab1HWWCh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 18:02:37 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:45628 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab1HWWCf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 18:02:35 -0400
Received: by iye16 with SMTP id 16so838904iye.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OWS8tXMCsocWGYb1XGp2gOuhdkPwmHZ3rLQnZaUxrvE=;
        b=h9ORogkF5DVB8DLeQBjOlVvhC/upPeAjRCXHhmMo/F4TqnOfDnq7KgfRm5ZsvLG2EN
         bY7NEpj1A6BlQZHju1yLyQ6wCTQ9ivakyPBWpX4EmuT4FOqDXZJIOM4wI4grmwwLJ792
         Lyl315OzqpnWTewHE3MakFxPHGO24PbiYGkvI=
Received: by 10.231.57.103 with SMTP id b39mr8598302ibh.41.1314136955091; Tue,
 23 Aug 2011 15:02:35 -0700 (PDT)
Received: by 10.231.10.140 with HTTP; Tue, 23 Aug 2011 15:02:05 -0700 (PDT)
In-Reply-To: <20110823022713.GA6005@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179975>

On Tue, Aug 23, 2011 at 3:27 AM, Pete Wyckoff <pw@padd.com> wrote:
> I think I understand the problem now, and have a small test case
> to see what's going wrong. =A0Your solution is definitely
> sub-optimal. =A0:) =A0Is there anything that can be done with
> --import-marks and --export-marks?

Don't know if you agree, but I think it would be better to keep git-p4
from storing extra files in the filesystem. And, as far as I understood=
,
these two options require extra files.
But I don't think marks would help us that much. We already have
something similar: the changelist number in the commit log. The big
problem is that P4 does not store a pointer to the previous changelist.

> Could you guess at the branch point using p4? =A0I.e. for each file
> in the new branch, grab the change that caused its most recent
> revision (the #xx part). =A0Pick the max of those changes. =A0In git,
> find the commit whith "change =3D ..." that you just discovered.
> That's the parent.

Yes, I think this would work. Nevertheless, I would prefer not to do so
much pooling on the P4 server because when we're in a remote location i=
n
regards to the P4 proxy server this kind of command becomes rather slow=
=2E
And if the branch has many files this may become cumbersome.

> Even this won't be perfect, and I'm not even sure if it's less
> icky than diff-tree.

=46rom what I can see, the two possible solutions would be:

a) Running a "filelog" on all files. This may become slower when the
   branch has lots of files. There's also the problem in needing to
   contact the P4 proxy server every time.

b) Using diff-tree. This will be slower if the original changelist is
   very far from the latest one, but has the advantage of being run
   locally. It has the disadvantage of not having an apparent
   compatibility with fast-import.

In my personal point of view, diff-tree solution still looks better, if
it weren't for the fast-import issue. Now if we could just figure out
how to overcome this issue...

--=20
Vitor Antunes
