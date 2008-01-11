From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Fri, 11 Jan 2008 09:37:02 +0000
Message-ID: <e1dab3980801110137o2440ccafxa4d3cc84630ce13b@mail.gmail.com>
References: <874pdmhxha.fsf@rho.meyering.net>
	 <alpine.LSU.1.00.0801101204120.31053@racer.site>
	 <87myrdhnn5.fsf@rho.meyering.net>
	 <alpine.LSU.1.00.0801101234580.31053@racer.site>
	 <87hchlhm3k.fsf@rho.meyering.net>
	 <7vejco4xv5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jim Meyering" <jim@meyering.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 10:37:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDGKU-0005tt-J0
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 10:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377AbYAKJhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 04:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbYAKJhF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 04:37:05 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:15698 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177AbYAKJhD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 04:37:03 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1644447wah.23
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 01:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UtmeG8UiKwh5L2phL7aWQ/ag8dsz8qbCMjEwd5DfnNs=;
        b=VAQcPLZJLVDvEl8jZv2HGl1jJyVWXa0Ztf63aGaTqZ3R2ZojyOVng1xsg2kkumtROUcyOYNVmQRmnD/gvDXq4vLZTjgdshk4/cTYoJjBh8LwayjutFCYAjS7c94aiW5GH0U4yjKizCHBv+oj0jqyeu5rQxIpsQS+oq8A+Pb1Alg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qjzoYewpr0TQ+n6alFcObVfAXJrfrPfnqPwL5IZJNpGvc7PhWkB3q7YXpXFsOEVvKvDKJTr65EFhbGNAPHcuTk6Gx/v1mxGBjdVCfPwMoAiWUgFOQnbX0tBDvJQq1Uhjp10UW87CuCDmN4Fg6l9bZF/JmwQL2CelIy38m34cG0Q=
Received: by 10.114.158.1 with SMTP id g1mr3450526wae.97.1200044222429;
        Fri, 11 Jan 2008 01:37:02 -0800 (PST)
Received: by 10.114.201.17 with HTTP; Fri, 11 Jan 2008 01:37:02 -0800 (PST)
In-Reply-To: <7vejco4xv5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70143>

On Jan 11, 2008 7:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> In this case, a failure while closing that small .keep file is
> highly unlikely, and if we ever mange to trigger such a highly
> unlikely failure, I think we would rather want to *know* about
> it, as it is likely there is something more seriously wrong
> going on.

On a slightly related note: I've got a patch that handles the issue
that I reported a couple of months back that tmp pack/index objects
where a write fails partway through are not deleted by any git
processing, ie, when for example during git gc --prune we get

fatal: sha1 file '/media/usbdiskc/v.git/objects/tmp_pack_QCYYAi' write
error (No space left on device)
error: failed to run repack

but the tmp_pack_* isn't deleted. I put my patch on the back burner
when Junio declared a moratorium on new behaviours until after 1.5.4
gets released, but will post once things open up again.

As it relates to this discussion: one of the awkward things is that
the die stuff doesn't leave any programatic indication (ie, not just a
message to stderr) that a file is malformed due to a writing failure.
Per Nicolas Pitre's suggestion to delete failed tmp_ files during a
"git gc --prune", I just delete ALL tmp_ files at that time. This
approach seems a bit risky -- can something like a git-svn fetch which
generated tmp_ files by a different route be going on at the same time
as a git gc? -- but I couldn't think of another way to do it.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
