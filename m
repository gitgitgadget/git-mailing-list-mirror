From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 17 Sep 2012 17:49:40 +0200
Message-ID: <vpqvcfcps2z.fsf@grenoble-inp.fr>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
	<vpqy5k8raig.fsf@grenoble-inp.fr>
	<CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
	<vpqd31kr7v4.fsf@grenoble-inp.fr>
	<CALkWK0=ROz8fxXgnqt-+AthU-hgq_mzFg0GhBQCrAshH_mRBPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 17:49:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDda8-0006v4-Fk
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 17:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145Ab2IQPts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 11:49:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43549 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932093Ab2IQPtr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 11:49:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8HFivo4012389
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Sep 2012 17:44:57 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TDdZs-0005ar-Ca; Mon, 17 Sep 2012 17:49:40 +0200
In-Reply-To: <CALkWK0=ROz8fxXgnqt-+AthU-hgq_mzFg0GhBQCrAshH_mRBPQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 17 Sep 2012 08:25:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 17 Sep 2012 17:44:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8HFivo4012389
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1348501501.84989@4j8eiU4X6EdSMo3uC1Q8Kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205703>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi again,
>
> Matthieu Moy wrote:
>> Does this user have the same UID as your usual user
>> (id kseygold; id $LOGNAME)?
>
> Yes.  What do you propose we do about the test?

On a GNU system, something like this should do the trick:

--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -31,9 +31,9 @@ fi
 
 check_perms_and_acl () {
        test -r "$1" &&
-       getfacl "$1" > actual &&
+       getfacl --numeric "$1" > actual &&
        grep -q "user:root:rwx" actual &&
-       grep -q "user:${LOGNAME}:rwx" actual &&
+       grep -q "user:$(id -u):rwx" actual &&
        egrep "mask::?r--" actual > /dev/null 2>&1 &&
        grep -q "group::---" actual || false
 }

but it seems FreeBSD's getfacl doesn't have --numeric
(http://www.unix.com/man-page/FreeBSD/1/getfacl/), so to be portable, we
need some more surgery, like this:

--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -33,7 +33,10 @@ check_perms_and_acl () {
        test -r "$1" &&
        getfacl "$1" > actual &&
        grep -q "user:root:rwx" actual &&
-       grep -q "user:${LOGNAME}:rwx" actual &&
+       grep "user:.*:rwx" actual | grep -v 'user:root:' | \
+           cut -d : -f 2 | xargs id -u > acl-uid &&
+       id -u > actual-uid &&
+       test_cmp acl-uid actual-uid &&
        egrep "mask::?r--" actual > /dev/null 2>&1 &&
        grep -q "group::---" actual || false
 }

Can you check that this second patch fixes your problem?

I'm a bit hesitant to submit it to git.git, as I find it a bit too
hacky. What do other people think?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
