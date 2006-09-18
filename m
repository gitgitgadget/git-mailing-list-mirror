From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: What's in git.git
Date: Mon, 18 Sep 2006 16:23:12 +0200
Message-ID: <450EABD0.1040102@innova-card.com>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net> <7vu035u4c3.fsf@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>, franck.bui-huu@innova-card.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 16:23:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPK1V-0007Za-6O
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 16:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWIROWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 10:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWIROWn
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 10:22:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:63633 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964978AbWIROWm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 10:22:42 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2768425nfa
        for <git@vger.kernel.org>; Mon, 18 Sep 2006 07:22:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=JQnykUYnQQ6b6l0P6579q5Kdypq8+R85M5qfbxj9r2z1hlTN8dMc31PgxIpZP/XkRjC5hbxkuKw4cR0w1OjTkzzZhiPWGRlStcqIoNxUYc+lhvMHHi1tv1MhL662RszGZ4p3e+VqJj4dowzYTZAjTHxA248ymNeUYiCUt4W8rtg=
Received: by 10.49.26.18 with SMTP id d18mr16976908nfj;
        Mon, 18 Sep 2006 07:22:40 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id k23sm205032nfc.2006.09.18.07.22.39;
        Mon, 18 Sep 2006 07:22:39 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu035u4c3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27248>

Junio C Hamano wrote:
> 
>   - Franck Bui-Huu and Rene Scharfe added 'git-archive' command,
>     that will eventually supersede 'git-tar-tree' and
>     'git-zip-tree'.
> 

I still have one issue, but haven't found out the solution yet.
Actually I even don't know if its related to 'archive/upload-archive'
commands. Could someone give it a try to tell me if he can at least
reproduce it ?

Here is the scenario (git-daemon and git-archive are executed on the
same machine):

git-daemon is started with the following command:

$  git daemon --verbose --syslog --export-all  \
   --enable=upload-archive --base-path=/home/fbuihuu/tmp/ --reuseaddr

git-archive is run to archive a small repo located in ~/tmp/test-git.
This is done in an endless loop:

$ while true; do
> git archive --format=tar --remote=git://localhost/test-git HEAD | tar tf -
> done
a
b
a
b
a
b
a
b
a
b
a
b
a
b # stuck !!!

So after a couple of loops, git-archive is stuck waiting for git-daemon but
daemon seems to be stuck somewhere.

Syslog shows something interesting here:

[...]
Sep 18 16:11:42 25-fbuihuu git-daemon: [16549] Connection from 127.0.0.1:30373
Sep 18 16:11:42 25-fbuihuu git-daemon: [16549] Extended attributes (16 bytes) exist <host=localhost>
Sep 18 16:11:42 25-fbuihuu git-daemon: [16549] Request upload-archive for '/test-git2'
Sep 18 16:11:42 25-fbuihuu git-upload-archive: finished
Sep 18 16:11:42 25-fbuihuu git-daemon: [16549] Disconnected
Sep 18 16:11:42 25-fbuihuu git-daemon: [16553] Connection from 127.0.0.1:30629
Sep 18 16:11:42 25-fbuihuu git-daemon: [16553] Extended attributes (16 bytes) exist <host=localhost>
Sep 18 16:11:42 25-fbuihuu git-daemon: [16553] Request upload-archive for '/test-git2'
Sep 18 16:11:42 25-fbuihuu git-upload-archive: finished
[END]

It looks like git-daemon never receives the SIGCHLD signal that is
normally sent by upload-archive once it has finished its job.

		Franck
