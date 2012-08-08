From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Sync production with Git
Date: Wed, 08 Aug 2012 16:20:00 +0200
Message-ID: <vpqlihpbh4f.fsf@bauges.imag.fr>
References: <1344431484059-7564617.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: kiranpyati <kiran.pyati@infobeans.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 16:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz77S-0003if-IK
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 16:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab2HHOUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 10:20:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54917 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756548Ab2HHOUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 10:20:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q78EHHQS001798
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 8 Aug 2012 16:17:17 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sz77A-0005cp-LH; Wed, 08 Aug 2012 16:20:00 +0200
In-Reply-To: <1344431484059-7564617.post@n2.nabble.com> (kiranpyati's message
	of "Wed, 8 Aug 2012 06:11:24 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 08 Aug 2012 16:17:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q78EHHQS001798
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1345040239.89827@K+mmwVNefhdxxqejKiWHSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203094>

kiranpyati <kiran.pyati@infobeans.com> writes:

> We want a way to seamlessly sync production and Git.

You should be aware that Git was not designed for this scenario. The
usual flow with Git (and actually with most revision control systems),
is to do the development with Git, then use your build system to
generate a package that can be used in production (e.g. generate a
.tar.gz, or a .jar, or whatever your platform needs), and then install
this package on your production server.

It can be tempting, however, to use your revision control system as a
deployment tool, so that an update on the production server be as simple
as "git pull". But in real-life applications, it usually has to be more
complicated: do you need to generate some files after you fetch the
latest version of the source? Do you need to update your database? Isn't
the .git/ directory harmfull here (e.g. do I want the full history
source of my project to be visible worldwide if this is a
webapplication?) ...

If you insist in using Git for deployment, then you should absolutely
stick to it. Whether for deployment or for anything else, trying to send
changes using both Git and other mechanism (e.g. uploading files
directly to a working tree as you did) puts you in trouble 99.9% of the
cases.

In your case, the damage is already done. If I were you, I'd do
something like

<do some backup>
<make sure the backup is OK>
<think twice "will I be able to restore the backup if it goes wrong?">
$ git fetch origin
$ git reset --hard origin/master

(actually, if I were you, I'd try reproducing the situation on a
non-production server first)

"git fetch" will download the revisions from the remote server, which
should be the repository where the version you want to run is located.
"git reset --hard" will discard any local change (committed or not) you
may have, and set your local working tree to the latest version in the
master branch of the remote repository. You may need a "git clean" to
remove untracked files too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
