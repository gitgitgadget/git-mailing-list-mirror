From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: git-diff-tree crashes on ubuntu kernel git repository
Date: Tue, 23 May 2006 01:09:43 +0200
Message-ID: <e7bda7770605221609h7c18c2ccpe92db34050d46f9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 23 01:09:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJX2-0001Sq-3O
	for gcvg-git@gmane.org; Tue, 23 May 2006 01:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWEVXJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 19:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWEVXJp
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 19:09:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:42472 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751280AbWEVXJo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 19:09:44 -0400
Received: by nf-out-0910.google.com with SMTP id c31so525327nfb
        for <git@vger.kernel.org>; Mon, 22 May 2006 16:09:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rgza+KJ+XnzYOHH/+PCZeW5dQHG8zTBgWt3p5TMtNRqQmwN7IN2iYd4IliIOGEt+dKl00Q+73L0DMUGGWLbzp1tKv4nXVoo3dD/OYoTiW8HQwz3UYJEnaeheKLf2jADeExaPbMjWvdGRC2rVmZAEKA6vJASvVg2ILh1+m46HLIw=
Received: by 10.49.20.8 with SMTP id x8mr4234309nfi;
        Mon, 22 May 2006 16:09:43 -0700 (PDT)
Received: by 10.48.80.6 with HTTP; Mon, 22 May 2006 16:09:43 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20546>

Hi

It seems like git-diff-tree has some problems with moved files:

$ git-diff-tree -p --stat --summary -M
348f179e3195448cea49c98a79cce8c7f446ce26
343ca16424ba031b37e4df49afddaee098a8f347 | wc -l
*** glibc detected *** free(): invalid pointer: 0x12ecbbf0 ***
6101

As can be seen below there is some obvious error in the output just
prior to the crash:
 drivers/w1/{masters => }/ds_w1_bridge.c            |   38

This file is moved into "w1/masters" by commit
bd529cfb40c427d5b5aae0d315afb9f0a1da5e76

$ git --version
git version 1.3.3.g5e36

$ cat .git/remotes/origin
URL: git://git.kernel.org/pub/scm/linux/kernel/git/bcollins/ubuntu-2.6
Pull: refs/heads/master:refs/heads/origin

 $ gdb git-diff-tree
(gdb) run -p --stat --summary -M
348f179e3195448cea49c98a79cce8c7f446ce26
343ca16424ba031b37e4df49afddaee098a8f347

<...lots of files...>

 drivers/video/w100fb.c                             |  162
 drivers/video/w100fb.h                             |  748 -
 drivers/w1/Kconfig                                 |   62
 drivers/w1/Makefile                                |   10
 drivers/w1/{masters => }/ds_w1_bridge.c            |   38
*** glibc detected *** free(): invalid pointer: 0x12ecbbf0 ***

Program received signal SIGABRT, Aborted.
0xffffe410 in __kernel_vsyscall ()
(gdb) bt
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7d7e9a1 in raise () from /lib/tls/i686/cmov/libc.so.6
#2  0xb7d802b9 in abort () from /lib/tls/i686/cmov/libc.so.6
#3  0xb7db287a in __fsetlocking () from /lib/tls/i686/cmov/libc.so.6
#4  0xb7db8fd4 in malloc_usable_size () from /lib/tls/i686/cmov/libc.so.6
#5  0xb7db934a in free () from /lib/tls/i686/cmov/libc.so.6
#6  0x08056902 in show_stats (data=0x8deff80) at diff.c:392
#7  0x08058466 in diff_flush (options=0x80686b0) at diff.c:1999
#8  0x0805b143 in log_tree_diff_flush (opt=0x8068680) at log-tree.c:82
#9  0x08049d11 in main (argc=0, argv=0xbfcf8a14) at diff-tree.c:130
(gdb)

As shown above I can easily recreate the crash if you want more info.
Thank you for a wonderful tool.

//Torgil
