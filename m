From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH] gitk: restore wm state to normal before saving geometry 
	information
Date: Tue, 15 Sep 2009 17:58:24 +0400
Message-ID: <e2480c70909150658p4293b596w6860d7cc9b3670ef@mail.gmail.com>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
	 <87eiq8ct40.fsf@users.sourceforge.net>
	 <e2480c70909150554p2e211d60y18049b5534f8922e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 15:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYYC-0003CA-Fy
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbZION6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 09:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbZION6X
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:58:23 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:59424 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbZION6W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 09:58:22 -0400
Received: by fxm17 with SMTP id 17so1581064fxm.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vS3BI9JXDVfGewu6WtP4SJfmnnNDy9Dp1CunNMAqc9A=;
        b=uH8foaOx5riezjUQlj6O+wwQ1oakp8sdWvHbFbXKW6aqmXQ0ngw9v92wI8p4/YlFfr
         p7th2aJG6Nc1gWBMeLRZ0RSm/pCn0MQiW5WK8o3nTBuPZoSwuBK9H5dRFwPQc2Da56jc
         wAw+IBD577JiH3M/evXc9iblp5MaRcKqTF+CY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TOrZ1DGpjl2ps5oPgoPxFfe8qTM3l1y27+tIvJkCUyjZKyVllJ1eej350poPeYN9to
         B4EUTw33kjajI2aY/RocfJo2NHvJ7aEtDw+V/m7ZKquFZP9t+mdN+/SeMP+DAUuSenoi
         GonQUGqw1uaWK9oCNMEGLjFwQRLwYbtsScOBc=
Received: by 10.223.7.21 with SMTP id b21mr2556138fab.104.1253023105023; Tue, 
	15 Sep 2009 06:58:25 -0700 (PDT)
In-Reply-To: <e2480c70909150554p2e211d60y18049b5534f8922e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128563>

On Tue, Sep 15, 2009 at 4:54 PM, Alexey Borzenkov <snaury@gmail.com> wrote:
> On the other hand, when I resize columns and then maximize/restore the
> window repeatedly I see that their sizes change in a strange way (and
> the smaller restored window they stranger are results) until hitting
> some sort of equilibrium, then maximize/restore doesn't have effect on
> their sizes anymore. So maybe there's a bug not in a way my patch
> restores the window, but in a way window resizes are handled.

It seems that I found what's the problem. When the window is very
small, and we maximize it, sash coords would initially be small. Then
we calculate their new positions and set it with $win sash place, but
unfortunately, tk limits them to the OLD pane size for some reason.
Initially I though that maybe Configure is fired too early (before
window is resized), but [winfo width $win] shows $win has the new
size. Here's some output that I got during debugging:

resizing 422 -> 1261 (winfo shows 1261)
    s0: 138 1
    s1: 288 1
    sash0: 412 -> 412 1
    sash1: 860 -> 417 1

I'm at a loss why this happens and how to lift this restriction.
