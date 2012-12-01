From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] fast-export: Allow pruned-references in mark file
Date: Sat, 1 Dec 2012 11:10:04 +0100
Message-ID: <CALWbr2yfBoMRSiRwUB04gjcPSypfMw5u+q2nGWw+e0GDTHzqUw@mail.gmail.com>
References: <1353750432-17373-1-git-send-email-apelisse@gmail.com>
	<7vd2z1xb6c.fsf@alter.siamese.dyndns.org>
	<CAMP44s0iSkqcOW0YsD=Jm_=x1tuoRbFQ+EbVvkROa_yY2-WFcA@mail.gmail.com>
	<CALWbr2yZpAT=eSahGcGKw5weoz1MjTzbb16pdQndKDFcn_3VJg@mail.gmail.com>
	<7vhaoctg6i.fsf@alter.siamese.dyndns.org>
	<CALWbr2x4aia4DcdnmfEEBsZwCYasTEp2Jc0jwJgvsUqWSDaWTQ@mail.gmail.com>
	<7vobikqelo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 11:10:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tek1t-000224-10
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 11:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036Ab2LAKKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 05:10:09 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37431 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab2LAKKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 05:10:07 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so737193eek.19
        for <git@vger.kernel.org>; Sat, 01 Dec 2012 02:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IkTNLPj8+oG/5jO4+QwwC+vbimQb9fRGS2cob8zzc+8=;
        b=XkHcRjQDU/oCmGtdLmEWdb4STsWuf2j/RgANG96qB4m9B8ldAppIDJLwSSoLsUTW9V
         2p7mYpoxoLC/QG7Gr3j6X8W+xUYpawfS1cLM7BBSQJhNxkVOuSfvF3G0AWRDyLIWvDNw
         da5lTJjiLm0WNAf5I0QavRg2eOFgryZnvyWCNw0T64l4YPJHXC/vfMSBazUqjFFv+pua
         IDBcMJ2DNTZ39AVeO7KUIcKKjmfJ887vvbArpFPuKeDlIhKebZiacGgaIdCcL3FRRFTA
         CmpDcX6BWrJpFA8Q7l7lSIkcGneZNaKlJcYrI014Lqos/puU/4ddvq8QGO0owfskHWcp
         5qlQ==
Received: by 10.14.199.134 with SMTP id x6mr14536546een.31.1354356605190; Sat,
 01 Dec 2012 02:10:05 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Sat, 1 Dec 2012 02:10:04 -0800 (PST)
In-Reply-To: <7vobikqelo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210957>

> Yeah, I think I agree that you would need to make sure that the
> other side does not use the revision marked with :2, once you retire
> the object you originally marked with :2 by pruning. Shouldn't the
> second export show :1 and :3 but not :2? It feels like a bug in the
> exporter to me that the mark number is reused in such a case.

It depends what you call a bug.

If the last item from the list is pruned, and no new objects
are exported, you will lose both reference and count to mark :2.
In this situation, incrementing last_idnum was pointless.

Assuming that we can't do anything about that, marks should be
considered mutable (and I don't think there is any way it
shouldn't). Then incrementing last_idnum is always useless.

Now, if marks can change, I don't understand why we use them at all.
(or don't provide the possibility to not use them at least).

In the "hg <-> git" case, it seems like an unecessary step:

hg revs <-> git marks <-> git sha1

Potentially forces the remote-helper to re-read the "marks <-> sha1"
everytime.

Also in the remote-helper, the "list" command requires sha1 for each
heads, while "import/export" can't work with sha1 but only marks, which
seems inconsistent.

My last point is about "git-remote-hg" and still mutable revs.
It seems like Felipe is using revs() rather than node() or hex() to
refer to mercurial changeset while those revs are also mutable, and
there exists immutable references: hex.

To sum up, the whole idea is, why would we use unsafe mutable marks
when we can use safer immutable references ?

Cheers,
Antoine
