From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 4 Nov 2007 17:22:13 +0800
Message-ID: <46dff0320711040122o271b3da4wb16b0317224d3ac3@mail.gmail.com>
References: <1194004427-26934-1-git-send-email-pkufranky@gmail.com>
	 <7vd4us1jds.fsf@gitster.siamese.dyndns.org>
	 <46dff0320711021650q4e56d025q63a961176c682a14@mail.gmail.com>
	 <7vfxzoyz7f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 10:22:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iobgc-0004IY-Dv
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 10:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbXKDJWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 04:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbXKDJWP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 04:22:15 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:36279 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbXKDJWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 04:22:13 -0500
Received: by py-out-1112.google.com with SMTP id u77so2396712pyb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 01:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RFAFckLemnr34yV4bgLT+CYvrvm+7iBGoOH9Rr9GwC0=;
        b=gNBUuSJEbsVGY8gFdhDRqjAVE8baLUx12WP2qDOXGLbSug6A0tKoWjA9jLTCmbarv17ucHOSyQFRb+Pdna+lTb3gZd8Jgg1UNr27GZ4C8A+Qx87ygILRDXqZflfM+wWnwdaMs3OI5yApRs36nu4k56cDMgoOYU1RLnanYmRhpsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ubRYgRF9UgjEHf2qBW4pVFn+X7OUra3ZxXTZpzt1f56eFrEzdZduX4pGxpMS4Bdo0dPMOg6/mDZMFUM7T7RtTRMuU14WfSiAzAq4P1CiqbmgyFK7KGCJzQKEkmSt6BXmCgJR3U+xCyWQRQCONMFA7VbDuO8aFjOppO0BPdksJek=
Received: by 10.35.44.16 with SMTP id w16mr4556485pyj.1194168133051;
        Sun, 04 Nov 2007 01:22:13 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 4 Nov 2007 01:22:12 -0800 (PST)
In-Reply-To: <7vfxzoyz7f.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63368>

On 11/3/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Yin Ping" <pkufranky@gmail.com> writes:
>
> > On 11/3/07, Junio C Hamano <gitster@pobox.com> wrote:
> >> How does this work when you are a toplevel developer and do not
> >> have the submodule cloned and checked out?
> >>
> >> Our code should treat having the submodule directory and not
> >> having it when there is a mode 160000 entry in the index equally
> >> likely.  Cloning and checking-out is _not_ the norm (nor the
> >> exception).
> >>
> > When submodule is not cheched out, it is never modified.
>
> How so?  Can't you update the index alone?
>
Sorry i have been away and come back just now.

I think it's a rare case that the submodule entry in the index is
different from HEAD when the submodule is not checked out.

This may only happen when git-reset --soft is called. However, it may
be a wrong  operation to commit the changed submodule index entry
while the submodule is never checked out.

There is another similar case, 'git pull' update the submodule entry
in both HEAD and index, but the submodule checked out is not updated.
In this case, 'git-log since..until'  in the submodule directory will
fail since 'until' commit is not checked out yet. I think it may be
also a user mistake.

In both case, i think the user should be notified about the
inconsistence. My patch handle this by two warning messages as follows
(where $name is module name)

+                       cd $name >&/dev/null || { echo "  Warning:
fail to chdir to $name" && exit; }


+                       if echo "$left$right" | grep 'unknown
revision' >&/dev/null
+                       then
+                               echo "  Warning: $name is not a
repository or dosn't contains commit $headone/$indexone"
+                       else



-- 
franky
