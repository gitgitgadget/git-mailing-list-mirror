From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Poor push performance with large number of refs
Date: Tue, 9 Dec 2014 21:41:28 -0800
Message-ID: <CAJo=hJvKBvQvN=EV4y=ACz5pou9A0tD+txAn_8VR9L3KKtQSiA@mail.gmail.com>
References: <20141210003735.GA124293@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 06:41:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xya26-0006tP-K6
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 06:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbaLJFlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 00:41:50 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44686 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbaLJFlt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 00:41:49 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so2037349iec.16
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 21:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=Jxa1ttlc111O07cV9o/jSFx+oxfBv07wBxZdHODzEj0=;
        b=f4pI28G5rRqog6sDNm4bh+0ckayrUzyge676q8zn8zLPu7xiaCK6rPXuyXjMByzBzb
         slTYZvRBYYr8cyjY7SJuZxS9MD4s/YTsmEvHQg7tT8DcVqXAres5TPbqoqp2BDY2FoT/
         kivN38DtQPWKP6YzTj85IN3w9DVHq0DGwrTZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=Jxa1ttlc111O07cV9o/jSFx+oxfBv07wBxZdHODzEj0=;
        b=hqeBG41lPn5qQRx5qA+IdbP2F/z0Y44n+P7GSM6II9DR6/m5qSPllQZkiJuH9kX6N4
         KndBvMTbtYjHvrT8DX+usRExqoZsR6DoUl5reQ4eq6Zgaqb1gpLZMZXKAq3BOc8gQup6
         17kFUkEFcoxwBGKgMlfhlxf+o1dfPXH3g4YqOa5STdQyGDlzKkmBuEsOLfhiXVb0FBrJ
         Czm/ktnue9qwxVIbFOO58I30OxRIgwVm+WNTiqjT1JlyMBPwS9hae3Kuz9DphbrE4Zth
         pQE88qGx0woa2Xq9OrJ3tn3xZEpMiOZuHoeDPvSISOD2k5p1OH+9rfvUa55dSwUjoJdK
         nxKg==
X-Gm-Message-State: ALoCoQlyL6o3nB1aTQd/PDQZnJUcexQj8yOWX72nP6WXrHRD5m+c4y+j0YRd/uUaKeck1utAL2PD
X-Received: by 10.50.103.3 with SMTP id fs3mr23782660igb.6.1418190109144; Tue,
 09 Dec 2014 21:41:49 -0800 (PST)
Received: by 10.64.226.161 with HTTP; Tue, 9 Dec 2014 21:41:28 -0800 (PST)
In-Reply-To: <20141210003735.GA124293@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261189>

On Tue, Dec 9, 2014 at 4:37 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> I have a repository that's just under 2 GiB in size and contains over
> 20000 refs, with a copy of it on a server.  Both sides are using Git
> 2.1.2.  If I push a branch that contains a single commit, it takes about
> 15 seconds to push.  However, if everything is up-to-date, it completes
> within 2 seconds.  Notably, HTTPS performs the same as SSH.
>
> Most of the time is spent between the "Pushing to remote machine" and
> "Counting objects", running git pack-objects:
>
>   git pack-objects --all-progress-implied --revs --stdout --thin --delta-base-offset --progress
>
> Unfortunately, -vvv doesn't provide any helpful output.  I have some
> suspicions what's going on here, but no hard data.  Where should I
> be looking to determine the bottleneck?

My guess is the revision queue is struggling to insert 20,000 commits
that the remote side "has", are uninteresting, and should not be
transmitted. This queue insertion usually requires parsing the commit
object out of the local object store to get the commit timestamp, then
bubble sort inserting that commit into the queue.
