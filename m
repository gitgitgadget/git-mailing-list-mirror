From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Fri, 20 Feb 2015 11:40:08 +0100
Message-ID: <vpqvbiwamt3.fsf@anie.imag.fr>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
	<vpqtwyl90mx.fsf@anie.imag.fr>
	<340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com>
	<vpqiof14qu8.fsf@anie.imag.fr>
	<13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
	<vpqr3tozzs5.fsf@anie.imag.fr>
	<20150219200833.GB5021@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fairuzan Roslan <fairuzan.roslan@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, tboegi@web.de
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:40:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOl0b-0007fD-GI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbbBTKk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:40:29 -0500
Received: from mx2.imag.fr ([129.88.30.17]:48193 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731AbbBTKk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:40:29 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KAe7cG019063
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Feb 2015 11:40:08 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KAe8qX031885;
	Fri, 20 Feb 2015 11:40:08 +0100
In-Reply-To: <20150219200833.GB5021@vauxhall.crustytoothpaste.net> (brian m.
	carlson's message of "Thu, 19 Feb 2015 20:08:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 20 Feb 2015 11:40:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1KAe7cG019063
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1425033608.93546@HZ0NaW+zXAPoPGu5Z6pTpA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264159>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Tue, Feb 17, 2015 at 09:51:38AM +0100, Matthieu Moy wrote:
>> This should be fixable from Git itself, by replacing the calls to
>> "unlink" with something like
>> 
>> int unlink_or_chmod(...) {
>> 	if (unlink(...)) {
>> 		chmod(...); // give user write permission
>> 		return unlink(...);
>> 	}
>> }
>> 
>> This does not add extra cost in the normal case, and would fix this
>> particular issue for afp shares. So, I think that would fix the biggest
>> problem for afp-share users without disturbing others. It seems
>> reasonable to me to do that unconditionnally.
>
> This can have security issues if you're trying to unlink a symlink, as 
> chmod will dereference the symlink but unlink will not.  Giving the file 
> owner write permission may not be sufficient, as the user may be a 
> member of a group with write access to the repo.  A malicious user who 
> also has access to the repo could force the current user to chmod an 
> arbitrary file such that it had looser permissions.

Ouch, indeed. I don't think that would be so problematic in practice (if
the attacker has access to the repo, it's easier to write arbitrary code
in hooks or config), but clearly we don't want to take the risk.

So, the right solution should be stg like Junio's

 * in init-db.c, autoprobe by doing something like this:

    create a test file with 0444 permission bits;
    if (unlink(that test file)) {
	chmod(that test file, 0644);
        if (!unlink(that test file)) {
		broken_unlink = 1;
		git_config_set("core.brokenunlink", broken_unlink);
	} else {
        	die("aaargh");
	}
    }

But when core.brokenunlink is set, just use 0666 instead of 0444 as
default mode for object files.

But right now, I'm not sure we're actually to work around an issue with
AFP shares or only one particular case of problematic configurtion for
one user.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
