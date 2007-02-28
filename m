From: Simon Josefsson <simon@josefsson.org>
Subject: gitco - replacement for cvsco
Date: Wed, 28 Feb 2007 15:08:02 +0100
Message-ID: <87bqje74u5.fsf_-_@latte.josefsson.org>
References: <877iu3q13r.fsf@latte.josefsson.org>
	<Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227174035.f85e8643.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Wed Feb 28 15:08:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMPTn-00020A-89
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 15:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbXB1OIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 09:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbXB1OIY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 09:08:24 -0500
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:38396
	"EHLO yxa.extundo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536AbXB1OIX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 09:08:23 -0500
Received: from extundo.com (yxa.extundo.com [217.13.230.178])
	(authenticated bits=0)
	by yxa.extundo.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l1SE84u1024463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Feb 2007 15:08:04 +0100
OpenPGP: id=B565716F; url=http://josefsson.org/key.txt
X-Hashcash: 1:22:070228:vsu@altlinux.ru::jGLqv2Y2zmhVX8NE:4gii
X-Hashcash: 1:22:070228:johannes.schindelin@gmx.de::VXutfWJhynYgkq8Q:F4gQ
X-Hashcash: 1:22:070228:git@vger.kernel.org::clhTPBLVRJZWVdHj:gUHG
In-Reply-To: <20070227174035.f85e8643.vsu@altlinux.ru> (Sergey Vlasov's
	message of "Tue\, 27 Feb 2007 17\:40\:35 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
X-Spam-Status: No, score=-2.0 required=4.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.1
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on yxa-iv
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on yxa.extundo.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40924>

Sergey Vlasov <vsu@altlinux.ru> writes:

> On Tue, 27 Feb 2007 13:37:23 +0100 (CET) Johannes Schindelin wrote:
>
>> On Tue, 27 Feb 2007, Simon Josefsson wrote:
>>
>> > Hi!  I'm considering switching to git for my projects (shishi, gsasl,
>> > gnutls, libtasn1, opencdk, ...) and I have some questions:
>> >
>> > * How do I discard all locally modified or added files?  'cvs upd -C'
>> >   does some of that, but I've been using a tool 'cvsco' which quickly
>> >   restore a CVS checkout into a pristine state.
>>
>> The command in git is called "git reset --hard". Beware: this really,
>> really loses _all_ local changes. And no need to worry when it completes
>> much faster than you expected it to... See "git status" to see that it
>> worked, indeed.
>
> But "git reset --hard" won't touch untracked files (this command is
> similar to "cvs update -C", but does not save old contents anywhere).
> If what is really needed is to clean out build products, editor backups
> and other files which are not tracked by git, "git clean -d -x" will do
> it (but this command will keep local changes to tracked files - an
> additional "git reset --hard" is needed to restore them to the last
> committed state).

Thanks!  This script solve my original question:

#!/bin/sh
# gitco - cruel checkout.  Discards everything that has not been
# committed, and checkout missing files.
git-clean -d -x
git-reset --hard

However, one problem with that, compared to 'cvsco', is that
'git-reset --hard' does not tell me tell me which files were deleted
and which file were restored.  May I suggest a --verbose or similar?

Here is how to use "gitco":

jas@mocca:~/src/libtasn1$ sha1sum foo Makefile.am  gendocs.sh
sha1sum: foo: No such file or directory
e14704b0c3fe4a07e86e4f66df7c6888f619e7dc  Makefile.am
ea44aed92044fdafffae08a8ec4191ed357e4321  gendocs.sh

# Ok, so we have two files, one which doesn't exists.

jas@mocca:~/src/libtasn1$ echo hej > foo; echo hej >> Makefile.am ; rm gendocs.sh
jas@mocca:~/src/libtasn1$ sha1sum foo Makefile.am  gendocs.sh
32a0617aab4c9fe725f1b5bc441291180ad25b73  foo
e83aa94eb841a329289395f9a88bd5f89a725535  Makefile.am
sha1sum: gendocs.sh: No such file or directory

# Ok, one file deleted, one new created, and one modified.

jas@mocca:~/src/libtasn1$ gitco
Removing foo

# It isn't that informative...

jas@mocca:~/src/libtasn1$ sha1sum foo Makefile.am  gendocs.sh
sha1sum: foo: No such file or directory
e14704b0c3fe4a07e86e4f66df7c6888f619e7dc  Makefile.am
ea44aed92044fdafffae08a8ec4191ed357e4321  gendocs.sh

# Ok, back to where we started.

Regards,
Simon
