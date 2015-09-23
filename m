From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 5/8] branch: drop non-commit error reporting
Date: Wed, 23 Sep 2015 22:10:10 +0200
Message-ID: <vpq6130ucbh.fsf@grenoble-inp.fr>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<1443031873-25280-6-git-send-email-Karthik.188@gmail.com>
	<xmqqfv25x80c.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:10:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeqN8-0000QM-Cv
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 22:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbbIWUKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 16:10:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37227 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084AbbIWUKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 16:10:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8NKA773013981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 23 Sep 2015 22:10:07 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8NKAAoF010575;
	Wed, 23 Sep 2015 22:10:10 +0200
In-Reply-To: <xmqqfv25x80c.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 23 Sep 2015 12:14:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 23 Sep 2015 22:10:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8NKA773013981
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443643809.90868@Jj128J6uNXdzBmR+61k94w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278510>

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Remove the error reporting variable to make the code easier to port
>> over to using ref-filter APIs.
>>
>> This also removes the error from being displayed. As branch.c will use
>> ref-filter APIs in the following patches, the error checking becomes
>> redundant with the error reporting system found in the ref-filter
>> (ref-filter.c:1336).
>
> Hmm, do you mean these lines by the above reference?
>
> 	if (filter->merge_commit || filter->with_commit) {
> 		commit = lookup_commit_reference_gently(oid->hash, 1);
> 		if (!commit)
> 			return 0;

Note: the test becomes

      if (filter->merge_commit || filter->with_commit || filter->verbose) {

When the code starts using ref-filter, so the condition of the if
becomes the same as it is here. Not related to your concern, but I was
worried about "verbose" being used on one side but not the other, and
it's actually OK.

> That is "silently return ignoring it if it is not a commit", i.e.  I
> do not think that deserves to be called error REPORTING system.
>
> Do you really understand what the error message you are removing is
> trying to diagnose?  A branch ref must not point at a blob or any
> non-commit object, and if we find such a branch ref, we report it as
> error.

More precisely: if we find such a branch ref and we're used with an
option that requires us to lookup the commit, then we report it as an
error.

To be sure, I tried:

  echo ee0f5eeeae36cd1b5a346a1e2ae5c8cb841cd5da > .git/refs/heads/broken

where the sha1 is the one of a blob.

$ git branch   
  broken
* master
$ git branch -v
error: branch 'broken' does not point at a commit
* master 5cc76d7 foo
error: some refs could not be read

After the series, I get:

$ git branch
  broken
* master
$ git branch -v
* master 5cc76d7 foo

So I agree with Junio that the commit message is not sufficient: there
is a behavioral change. I'm OK with it, but the commit message shouldn't
claim that there isn't.

Porting to ref-filter drops the commit before we get an opportunity to
complain, so we stop complaining because it's not worth the trouble.

BTW, this looks like an fsck bug:

$ git fsck --strict
Checking object directories: 100% (256/256), done.
error: refs/heads/broken: not a commit
$ echo $?
0

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
