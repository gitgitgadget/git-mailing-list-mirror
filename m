From: Tuomas Suutari <tuomas.suutari@gmail.com>
Subject: Re: [PATCH 3/3] git-svn: Fix discarding of extra parents from svn:mergeinfo
Date: Mon, 22 Feb 2010 20:04:55 +0200
Message-ID: <201002222004.55898.tuomas.suutari@gmail.com>
References: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com> <1266825442-32107-4-git-send-email-tuomas.suutari@gmail.com> <201002221057.35088.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Eric Wong <normalperson@yhbt.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:05:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njcee-0005uI-GY
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 19:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab0BVSFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 13:05:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:62933 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab0BVSFC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 13:05:02 -0500
Received: by fg-out-1718.google.com with SMTP id e21so547797fga.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 10:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=CYs51TlKOcXHG7e+jhYoaIQMj08+a+DMb1jk/E6Dftg=;
        b=cKJAF6XO0vJ4uKeiK8LsdZzk/fQ5wo65heO4O4lvXxEczbJd8pF90Z6HvXZsecC8yA
         WB0DwXaGRd42YNs/aHDhqAEaByYOL/Hz3F0mAjlyx32RSDJZH8FejqUBxR/N469gNtWR
         ZlGvOsLtVI9ImOVPGXWiOljOGXn9dFrklvTKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=t1cqCTos5H5orUVGGHwmaSRQI/1ZXJ4DAhemMvNRPl6opij3D4mkMMehwowv/Myfgf
         6uihTxUVM/Ng4Iwh0eOmr4TkWFYFjjU4TT67nH2BMAXY9sizit2qdMEg0X13wiln8kiR
         oQblvBbRernEkCAk6hKw2Lcw5TNnXCVDIiiX4=
Received: by 10.86.236.26 with SMTP id j26mr7349941fgh.77.1266861901415;
        Mon, 22 Feb 2010 10:05:01 -0800 (PST)
Received: from mikrohiiri.localnet (ws-26-184.laitilanpuhelin.fi [188.123.26.184])
        by mx.google.com with ESMTPS id e3sm6367035fga.1.2010.02.22.10.04.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 10:04:57 -0800 (PST)
User-Agent: KMail/1.12.3 (Linux/2.6.31-gentoo-r6; KDE/4.3.3; i686; ; )
In-Reply-To: <201002221057.35088.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140701>

On Mon 2010-02-22 11:57:34 Thomas Rast wrote:
> On Monday 22 February 2010 08:57:22 Tuomas Suutari wrote:
> > Use merge-base rather than rev-list for detecting if a parent is an
> > ancestor of another, because rev-list gives incorrect results
> > sometimes.
> 
[...]
> 
> I think you swapped the test (or I got confused, which is entirely
> possible).

Ah, seems so. I was already writing a long reply explaining why rev-list 
can't be used but only merge-base just to realize that, indeed, rev-list can 
be used after all. The code just used to discard the wrong parent.

> Let I = $new_parents[$i] and J = $new_parents[$j].  The
> old one was
> 
>   test -z "$(git rev-list -1 I..J)"
> 
> which reads "unless there are any commits on J which are not on I",
> i.e., it fails unless J is an ancestor of I.
>
> But the new one is
> 
>   "$(git merge-base I J)" == I.
> 
> so suddenly I must be an ancestor of J.
>
> Is that what you were fixing?

Yes.

> Because I don't think the 'rev-list -1'
> test is any worse than the merge-base test.

You're right. I failed to see that I can get the same results by swapping $i 
with $j in the undef($new_parents[$i]) statement.

My pitfall was that I considered only changing the "if ( !$revs )" part to 
"if ( $revs )" with the rev-list approach. That wouldn't have worked, 
because then the other test case, included in PATCH 2, would have failed.
(When there are two distinct branches merged to one.)

> If it's not, please tell
> us what you are fixing.  Either way, please change the commit message
> appropriately.

Yes, the commit message was horrible. I was hoping that, by writing a test 
case as a "description" about the problem, I would avoid writing so much 
English... ;)

I will send another patch soon. Hopefully with better commit message.

-- 
Tuomas
