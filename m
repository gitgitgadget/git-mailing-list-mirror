From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] unpack-objects abnormal exit when pushing
Date: Mon, 09 Nov 2009 12:56:19 +0100
Message-ID: <vpqhbt3ap3w.fsf@bauges.imag.fr>
References: <vpqeio8eou4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 12:59:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Stw-0003if-RP
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 12:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbZKIL7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 06:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbZKIL7C
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 06:59:02 -0500
Received: from imag.imag.fr ([129.88.30.1]:47864 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbZKIL7B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 06:59:01 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nA9BuJ5i011529
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Nov 2009 12:56:21 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N7Sr5-0007B0-7O; Mon, 09 Nov 2009 12:56:19 +0100
In-Reply-To: <vpqeio8eou4.fsf@bauges.imag.fr> (Matthieu Moy's message of "Sun\, 08 Nov 2009 21\:36\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 09 Nov 2009 12:56:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132457>

Hi again,

I just found a way to reproduce the problem using plain SSH, and not
Git:

$ ssh localhost cat < random.bin | wc
    249    1460   65536
$ cat < random.bin | wc
    796    4545  204800

So, sshd is broken on this machine, and I don't think Git is the one
to blame.

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Hi,
>
> I'm hitting a bug when git-push-ing to a Linux PPC machine. In
> general, pushing works well, but pushing some particular commits
> breaks reproducibly with :
>
> fatal: early EOF
> error: unpack failed: unpack-objects abnormal exit
> To ssh://localhost//home/perms/moy/prive/dest
>  ! [remote rejected] master -> master (n/a (unpacker error))
>
> I've put the guilty files on my website and wrote a reproduction
> script:
>
> #!/bin/sh
>
> rm -fr source dest
> git init source
> git init --bare dest
> dest=$PWD/dest
> cd source
> echo foo > bar.txt
> git add .
> git commit -m init
> git push ssh://localhost/$dest master
> wget 'http://www-verimag.imag.fr/~moy/tmp/git-bug/Conception Manual.docx'
> wget 'http://www-verimag.imag.fr/~moy/tmp/git-bug/Extreme Programming.doc'
> git add .
> git commit -m "bug"
> git push ssh://localhost/$dest master
>
> The full output is attached (the error message for the last push is
> given above). The machine on which I get this (let's call it "A")
> says :
>
> $ ssh -Version
> OpenSSH_4.3p2, OpenSSL 0.9.8e-fips-rhel5 01 Jul 2008
> $ uname -a
> Linux A 2.6.18-128.7.1.el5 #1 SMP Wed Aug 19 04:08:13 EDT 2009 ppc64 ppc64 ppc64 GNU/Linux
> $ cat /etc/redhat-release                                                                                                                                           
> Red Hat Enterprise Linux Server release 5.4 (Tikanga)
> (it's a 32-bit distribution although the machine is 64bits)
> $ git --version
> git version 1.6.5.2
> (compiled myself, "make test" passes)
>
> According to my experiments, the problem is on the receiver side. If I
> do the same as above, with source/ and dest/ directories on two
> different machines, then if source/ in on A and dest/ anywhere else,
> it works, and if dest/ is on machine A, I get the same error.
>
> If I push using "file://" instead of "ssh://", then everything works
> well.
>
> If instead of push-ing, I go to dest/ and do a fetch, then it works
> well too.
>
> Does anyone have any idea on what's going on?
>
> If anyone has a machine similar to mine (ppc64), can he/she run my
> reproduction script and tell me if the bug happens?
>
> Thanks a lot,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
