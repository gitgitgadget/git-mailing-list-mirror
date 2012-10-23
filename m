From: Joey Jiao <joey.jiaojg@gmail.com>
Subject: Git push slowly under 1000M/s network
Date: Tue, 23 Oct 2012 14:27:44 +0800
Message-ID: <CAKOmCvp23fALGsDe4Ck7ZXpMJmOAq+YWCXPe_xb6GfQcjJi_kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 08:28:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQXyN-0002j5-8E
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 08:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012Ab2JWG2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 02:28:06 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61821 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab2JWG2F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 02:28:05 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2518370pad.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 23:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=ZLKzTGc4VptWYUB8iRqK/i6USUAZCfoiAFbUDUCBuoY=;
        b=LP1Rt0R0X/gQYyC6twH0PyuhAsHw9Xw+7/JKylLVCz5hTCtbIUZus8od6rSSzMioEI
         GW5PaomAs9mkM79BkYoXDbFMqh25XrOsmeZa9s9aVoABhtZh8JbMPvrFmvh0veWABITG
         /fbKpYLaK2rInwCNIsfg1XEb9XxYjQfQFL1rgr+TAeO+AxjKnLnD2RWDedZGQ8FN8q8f
         lspJfXGdRgo1o0k98U+SXWn11wOnP6v07AIChtGfxov4DVCVKxv05JMaIhI/zklqk/Wq
         vN9SmTmt+/QvFEWJGORqb8eQzw9o2lAlPv3B1g3Q7yJ9Yn2KMTEK73KpYaaGIuaTW2p6
         ZRSA==
Received: by 10.68.136.229 with SMTP id qd5mr36874444pbb.154.1350973684422;
 Mon, 22 Oct 2012 23:28:04 -0700 (PDT)
Received: by 10.66.219.166 with HTTP; Mon, 22 Oct 2012 23:27:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208215>

Hi Git Listeners,
I'm facing one problem when pushing to git repository via gerrit port.
Don't stop to look into the below content, as I doubt it might be a
git problem.

The pushing takes me 7mins~11mins each time every I had git gc on remote.
The remote server is 24 core with scsi disk. And the connection is
within 1000M/s intranet.
The pushing is only slowly on this kernel project, but faster on other
android projects, takes seconds only.
I tried on 4 core and 24 core clients to do the push, the time is
almost the same. So I think it's not the client problem.

The command I use as below. I also tried to pushing to git repository
directly, it is also slow, only some seconds benifit. So I think it
might be not the gerrit problem.
$ git push -v ssh://remote_url:29418/kernel/msm.git HEAD:refs/changes/33599
The stderr stops at remote: Resolving deltas:   0% (0/2) for 99% of the time.

I added some timestamp in the git source code, Like git version 1.8.0.
The receive_status called by send_pack inside send-pack.c takes the
99% of the time.

It looks like the client is waiting the pushing result status from
server although by checking server side, the real object has already
been upload succeed.

Below is the log after adding time info.
$ time git push -v ssh://git.qrd.qualcomm.com:29418/kernel/msm.git
HEAD:refs/changes/33599 2>&1|tee -a log.txt
Pushing to ssh://git.qrd.qualcomm.com:29418/kernel/msm.git
error: Time start packet_flush: Tue Oct 23 14:14:47 2012

error: Time finish packet_trace: Tue Oct 23 14:14:47 2012

error: Time finish safe_write: Tue Oct 23 14:14:47 2012

error: Time start receive_status: Tue Oct 23 14:14:47 2012

remote: Resolving deltas:   0% (0/2)
remote: (W) afafdad: no files changed, message updated
error: Time start packet_read_line: Tue Oct 23 14:24:41 2012
, len=10
error: Time packet_read_line: Tue Oct 23 14:24:41 2012
, len=22
error: Time packet_read_line: Tue Oct 23 14:24:41 2012
, len=0
error: Time finish receive_status: Tue Oct 23 14:24:41 2012

To ssh://git.qrd.qualcomm.com:29418/kernel/msm.git
 * [new branch]      HEAD -> refs/changes/33599

real	9m56.928s
user	0m0.364s
sys	0m0.160s
-- 
-Joey Jiao
