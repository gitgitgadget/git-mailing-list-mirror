From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 4 Nov 2007 17:25:15 +0800
Message-ID: <46dff0320711040125v111c75davb49e9822537f4b19@mail.gmail.com>
References: <1194004427-26934-1-git-send-email-pkufranky@gmail.com>
	 <7vd4us1jds.fsf@gitster.siamese.dyndns.org>
	 <46dff0320711021650q4e56d025q63a961176c682a14@mail.gmail.com>
	 <7vfxzoyz7f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 10:25:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IobjY-00053X-IP
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 10:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbXKDJZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 04:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbXKDJZS
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 04:25:18 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:37089 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935AbXKDJZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 04:25:16 -0500
Received: by py-out-1112.google.com with SMTP id u77so2397419pyb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 01:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UxW0vTtjrMMImvKSgRkZQkxMT/iT56c+bhMwxLZqbnM=;
        b=U0gMZaHfzMrZJkQaqqElMTWXAfWseLRvdSw0ddGbd2LSotVeKMcwZIrB1jMcel2pKWupYuBJONWA08q7+rcahtzI9AQemNZy8LPHhBIzlrdj22Oc5bglI+7VZ2jNVWJ3fWB/WLl0RVtx3i5IVZHX1NGGMFeC0ITmh2ihY6NdMhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VI+v6oepFJkYHJsrVRrdXEIXbhTmbPBEoGA/H/A6sgXD5haYaikq2xiKpeHOw9YX4KUQ5fLnEnrNjPQTdssPebZ1OrhRY9fWjoyKnBpkeZ284JPbC4T2GbdDmIUimH95EsOge7j0Unr7YmKIE7MQ20pyo7j43d1r43bAue6Vt2U=
Received: by 10.35.41.12 with SMTP id t12mr4571198pyj.1194168315684;
        Sun, 04 Nov 2007 01:25:15 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 4 Nov 2007 01:25:15 -0800 (PST)
In-Reply-To: <7vfxzoyz7f.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63369>

sorry, this is the reformated message of last one
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
repository or doesn't contains commit $headone/$indexone"
+                       else

-- 
franky
