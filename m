From: Joey Jiao <joey.jiaojg@gmail.com>
Subject: Re: Git push slowly under 1000M/s network
Date: Tue, 23 Oct 2012 18:11:50 +0800
Message-ID: <CAKOmCvrn8rs7STwu8jdbwWvre6Gpa9PxvDvtpAM=N_W6=Up5TA@mail.gmail.com>
References: <CAKOmCvp23fALGsDe4Ck7ZXpMJmOAq+YWCXPe_xb6GfQcjJi_kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 12:12:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQbTK-0003nm-GJ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 12:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973Ab2JWKMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 06:12:14 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52617 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932949Ab2JWKML (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 06:12:11 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2643033pad.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=AhGdZkzQZLldGxCzOFft/m7FuciarbQZ2OzK6aB0Xdo=;
        b=YcAXgPqheZCXoLKwWQlmEgUpHDbFtojwzTnR8NIgdBaFN+s7FGWK0noZArgMhFoICH
         LW5o0pJ2bsSnpBNYkuw/068ULcElrnh/uvao8So2npTaPnJ3Qrw4D0rRcyYz5Kq5UpQs
         oJ2wA3ERifpJsCLjjFAcBj8mcrlI5lGieWbx1fpIFSZJrcEbFA05D+2c0qLm/+9oqkFo
         ON4MPAolJPiN9Ih2pHrWdY9Y0yPgZ4zyBNrQqBsBWtCgEyZA6U2/2iUvYsXM6e9h7+D+
         WsMFgLraDzEIrtTKVfMrgD5JfjAwyRZevRx1MGUOWW1O7HDvyE3U5bsNjRLOEzCGwqBn
         lzLA==
Received: by 10.68.226.167 with SMTP id rt7mr38770904pbc.94.1350987130422;
 Tue, 23 Oct 2012 03:12:10 -0700 (PDT)
Received: by 10.66.219.166 with HTTP; Tue, 23 Oct 2012 03:11:50 -0700 (PDT)
In-Reply-To: <CAKOmCvp23fALGsDe4Ck7ZXpMJmOAq+YWCXPe_xb6GfQcjJi_kQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208220>

Well, after checked pushing directly to git which takes only 6
seconds. So it should be not a issue of git in c. But might be an
issue with jgit or gerrit.

2012/10/23 Joey Jiao <joey.jiaojg@gmail.com>:
> Hi Git Listeners,
> I'm facing one problem when pushing to git repository via gerrit port.
> Don't stop to look into the below content, as I doubt it might be a
> git problem.
>
> The pushing takes me 7mins~11mins each time every I had git gc on remote.
> The remote server is 24 core with scsi disk. And the connection is
> within 1000M/s intranet.
> The pushing is only slowly on this kernel project, but faster on other
> android projects, takes seconds only.
> I tried on 4 core and 24 core clients to do the push, the time is
> almost the same. So I think it's not the client problem.
>
> The command I use as below. I also tried to pushing to git repository
> directly, it is also slow, only some seconds benifit. So I think it
> might be not the gerrit problem.
> $ git push -v ssh://remote_url:29418/kernel/msm.git HEAD:refs/changes/33599
> The stderr stops at remote: Resolving deltas:   0% (0/2) for 99% of the time.
>
> I added some timestamp in the git source code, Like git version 1.8.0.
> The receive_status called by send_pack inside send-pack.c takes the
> 99% of the time.
>
> It looks like the client is waiting the pushing result status from
> server although by checking server side, the real object has already
> been upload succeed.
>
> Below is the log after adding time info.
> $ time git push -v ssh://git.qrd.qualcomm.com:29418/kernel/msm.git
> HEAD:refs/changes/33599 2>&1|tee -a log.txt
> Pushing to ssh://git.qrd.qualcomm.com:29418/kernel/msm.git
> error: Time start packet_flush: Tue Oct 23 14:14:47 2012
>
> error: Time finish packet_trace: Tue Oct 23 14:14:47 2012
>
> error: Time finish safe_write: Tue Oct 23 14:14:47 2012
>
> error: Time start receive_status: Tue Oct 23 14:14:47 2012
>
> remote: Resolving deltas:   0% (0/2)
> remote: (W) afafdad: no files changed, message updated
> error: Time start packet_read_line: Tue Oct 23 14:24:41 2012
> , len=10
> error: Time packet_read_line: Tue Oct 23 14:24:41 2012
> , len=22
> error: Time packet_read_line: Tue Oct 23 14:24:41 2012
> , len=0
> error: Time finish receive_status: Tue Oct 23 14:24:41 2012
>
> To ssh://git.qrd.qualcomm.com:29418/kernel/msm.git
>  * [new branch]      HEAD -> refs/changes/33599
>
> real    9m56.928s
> user    0m0.364s
> sys     0m0.160s
> --
> -Joey Jiao



-- 
-Joey Jiao
