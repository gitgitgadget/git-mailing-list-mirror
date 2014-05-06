From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] add a reflog_exists and delete_reflog abstraction
Date: Tue, 6 May 2014 12:29:12 -0700
Message-ID: <CAL=YDWnyKHSj8ZtD0t84Pg=uoHumGv2zgtOC0NAzP+Y+CanJ_w@mail.gmail.com>
References: <1399330677-17930-1-git-send-email-sahlberg@google.com>
	<xmqq1tw6g1mp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 21:34:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whl3F-0004D1-MR
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbaEFT3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:29:14 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:39970 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbaEFT3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:29:13 -0400
Received: by mail-vc0-f180.google.com with SMTP id hq16so1623565vcb.11
        for <git@vger.kernel.org>; Tue, 06 May 2014 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0YaCTVq+5qWcy8WV9yo01CmWyzz4H7iqBOPbj22MA1M=;
        b=W9ac9WH0hoQHzAMO0fLOrf0/TyciS4Srdx7PZhRFuiMkGcqGTBoZk59xxD9Jn7ojHh
         XMmsIO/eUgs+0eY/GAD7mVjowANpT1KKiwuT08wMF78j6vRXQgOw0csfwzCLIdK99RMt
         RHc2sejTVRgupG1U9YiVK3NOaAhx02VDePZMt9Da+XlQIX/ajIe/z/JKo+7qPQqRAJZi
         wJnUqJso690v3n7R/yE6/GwexiXSh8HPZ1+zwP1L/VCYv6n5Ua37KSF1dsL6WGpg4l4E
         mhADcQO7b0v2BYXseBJpMhx+TfP8JmNIShLrI+Zq36h9tBDljfgKbOTqOLJ1s6sXRECJ
         8i5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0YaCTVq+5qWcy8WV9yo01CmWyzz4H7iqBOPbj22MA1M=;
        b=Wm3pcFr6NF/1tw00C/nigEzs1NqQkqp+vkSriElO7qtbhDzjdKd2zsBlzMywVH4kVl
         nTPc1b6zjGUE0XGDmqMjOHatYOFsBY15DLHjghFI762hikt6Bi8Y+IsYWy6N+1g5EDFY
         c8esLIHGOqK7ZSRhsmtzYsuOM+kB02T/hxao+0kemkh9wy9x7ieTRFsKKCEZlm52YAWb
         t71NfO1+QPCS3ikabb/q/FD07ESKKRn1Ocy6Vha8GpuS6H/4DwLzwePLP7WiSxsj6/iQ
         RPLn9SxBhW1ogpXcX52rF4nB0UxqPvtw2i9GgW1wvrEnIK5cnaboLCIfiCAmwYxNGRiA
         iu4w==
X-Gm-Message-State: ALoCoQmCBEPvysWb/smpw/81JV+dKcX71CKtpqO1nU7D4s046oWvk6o/aZLzB3c8Pb962kAvMdLb
X-Received: by 10.58.94.135 with SMTP id dc7mr76583veb.66.1399404552653; Tue,
 06 May 2014 12:29:12 -0700 (PDT)
Received: by 10.52.0.139 with HTTP; Tue, 6 May 2014 12:29:12 -0700 (PDT)
In-Reply-To: <xmqq1tw6g1mp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248222>

On Tue, May 6, 2014 at 12:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> It currently has a hard assumption that the loose ref file must exist at this
>> stage or else it would end up deleting the reflog which is true today, as far
>> as I can tell, but would break if git would change such that we could have
>> a branch checked out without having a loose ref file for that branch.
>
> Hmmmm.  Do you mean this sequence will break?

As Michael suggested, this is already broken :-(
This sequence will delete the reflog from master :

    $ git init-db
    $ git config core.logallrefupdates true
    $ git commit -m Initial --allow-empty
        [master (root-commit) bb11abe] Initial
    $ git reflog master
        [8561dcb master@{0}: commit (initial): Initial]
    $ find .git/{refs,logs} -type f | grep master
        [.git/refs/heads/master]
        [.git/logs/refs/heads/master]
    $ git branch foo
    $ git pack-refs --all
    $ find .git/{refs,logs} -type f | grep master
        [.git/logs/refs/heads/master]
    $ git checkout foo
    $ find .git/{refs,logs} -type f | grep master
        ... reflog file is missing ...
    $ git reflog master
        ... nothing ...

I am adding a test for this in the next set of patches :

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 236b13a..8cab06f 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -245,4 +245,12 @@ test_expect_success 'gc.reflogexpire=false' '

 '

+test_expect_success 'checkout should not delete log for packed ref' '
+       test $(git reflog master | wc -l) = 4 &&
+       git branch foo &&
+       git pack-refs --all &&
+       git checkout foo &&
+       test $(git reflog master | wc -l) = 4
+'
+
 test_done





>
>         : gitster x; git init lo
>         Initialized empty Git repository in /var/tmp/x/lo/.git/
>         : gitster x; cd lo
>         : gitster lo/master; git commit --allow-empty -m initial
>         [master (root-commit) db2b430] initial
>         : gitster lo/master; git branch next
>
> Now we have two branches, master and next, and we are on master.
>
>         : gitster lo/master; git pack-refs --all
>         : gitster lo/master; ls .git/refs/heads
>         ./  ../
>         : gitster lo/master; cat .git/packed-refs
>         # pack-refs with: peeled fully-peeled
>         db2b43072749258d1e3c119c9570349d77c26b3a refs/heads/master
>         db2b43072749258d1e3c119c9570349d77c26b3a refs/heads/next
>
> And loose refs are fully packed.
>
>         : gitster lo/master; git checkout next
>         Switched to branch 'next'
>         : gitster lo/next; ls .git/refs/heads
>         ./  ../
>
