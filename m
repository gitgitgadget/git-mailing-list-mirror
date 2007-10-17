From: "Richard Quirk" <richard.quirk@gmail.com>
Subject: Re: git-cherry-pick no longer detecting moved files in 1.5.3.4
Date: Wed, 17 Oct 2007 09:18:25 +0200
Message-ID: <cac9e4380710170018p26ae8935xc4d3218f4db5411d@mail.gmail.com>
References: <cac9e4380710161517m64ba737dj8711a6ce59b1b69@mail.gmail.com>
	 <200710170035.12482.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michele Ballabio" <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:18:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii3Ar-0006Ar-7A
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 09:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbXJQHS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 03:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754357AbXJQHS1
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 03:18:27 -0400
Received: from ag-out-0708.google.com ([72.14.246.247]:12894 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbXJQHS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 03:18:26 -0400
Received: by ag-out-0708.google.com with SMTP id 35so1647476aga
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 00:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SxUYFRt4+6gUHKR4gPEbG1yCp/rZhphULzXTOWuieSc=;
        b=rX6aS5qfZXwzU8j8+6b5cMcHhM7VePk572MCMwYgBwv9RgpOnTF9uq932MkrUg00Y6qD/br+fwuPEFzf7MCra9j4AvYvjmblmcCEa9faKnDjZTNkIr6X/QOBoFtfa8pnEwxflmLvr9qAa+irXW0Bi9W3kuWvBMXVbEfz8iywQMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bQBYXK67UWeslFRSf46PaxrmRql4Rk+OQtiYakYfAl9cDtuWp9tTyo4ZvFJBChodt3rlPq4vcQ6Irl2EKavcGqfOICIp2cxRxyl4/HhCic+9j767q7OA0UnW3yUdNcsHk1mFCfV6DTsB9sPjED57EOWpvYhjtZfOX+rn0dfg5iw=
Received: by 10.70.44.18 with SMTP id r18mr14538277wxr.1192605505244;
        Wed, 17 Oct 2007 00:18:25 -0700 (PDT)
Received: by 10.70.63.20 with HTTP; Wed, 17 Oct 2007 00:18:25 -0700 (PDT)
In-Reply-To: <200710170035.12482.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61344>

On 10/17/07, Michele Ballabio <barra_cuda@katamail.com> wrote:
> On Wednesday 17 October 2007, Richard Quirk wrote:
> > I tried setting diff.renamelimit to -1 but to no
> > avail.
>
> It should be
> diff.renamelimit = 0
>
> to set the "unlimited" limit.
>

This doesn't work either. Cherry picking is not triggering the loading
of this value at all.

This is because git-cherry-pick turns into a git-merge-recursive. This
calls get_renames() in merge-recursive.c, which calls diff_setup,
setting the renamelimit to -1, then calls diff_setup_done(), which
sets the renamelimit to diff_rename_limit_default since rename_limit
was < 0. diff_rename_limit_default is the hard-coded value of 100. At
no point does merge-recursive call git_diff_ui_config() in diff.c that
reads in the diff.renamelimit user defined value, so in the end the
cherry pick uses the hardcoded value of 100.
