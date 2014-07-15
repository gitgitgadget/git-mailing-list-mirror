From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 1/2] add `config_set` API for caching config-like files
Date: Tue, 15 Jul 2014 13:32:54 +0200
Message-ID: <vpqiomy3li1.fsf@anie.imag.fr>
References: <1405049655-4265-1-git-send-email-tanayabh@gmail.com>
	<1405049655-4265-2-git-send-email-tanayabh@gmail.com>
	<vpqlhs02cz7.fsf@anie.imag.fr> <53C50859.5070209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 13:33:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X70z1-0007dw-FC
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 13:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758708AbaGOLdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 07:33:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40424 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758628AbaGOLdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 07:33:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6FBWrv9023112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jul 2014 13:32:53 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6FBWtk0004961;
	Tue, 15 Jul 2014 13:32:55 +0200
In-Reply-To: <53C50859.5070209@gmail.com> (Tanay Abhra's message of "Tue, 15
	Jul 2014 16:24:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 15 Jul 2014 13:32:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6FBWrv9023112
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406028774.28891@bXuIQZOc1MF7veHL6IbLbg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253555>

Tanay Abhra <tanayabh@gmail.com> writes:

> I checked the whole codebase and in all of the cases if they cannot read a file
> they return -1 and continue running.

More precisely: in git_config_from_file, any fopen failure results in
"return -1". But in git_config_early (one caller of
git_config_from_file()), the file is checked before access, e.g.:

	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
		ret += git_config_from_file(fn, git_etc_gitconfig(),
					    data);
		found += 1;
	}

Essentially, if a config file does not exist, it's skipped (obviously
desirable), but if some really weird error occur (if "err == ENOENT ||
err == ENOTDIR || ((flag & ACCESS_EACCES_OK) && err == EACCES" is false,
from access_eacces_ok() in wrapper.c), then the process dies.

"Permission denied" errors are allowed for user-wide config, but not for
others. Read the log for commit 4698c8feb for more details.

Anyway, this is the part of the code you're not touching.

(I actually consider it as a bug that "git config --file no-such-file
foo.bar" and "git config --file unreadable-file foo.bar" fail without
error message, but your commit does not change this).

> I think if the file is unreadable. we must continue running as no harm has been
> done yet, worse is parsing a file with wrong syntax which can cause reading
> wrong config values. So the decision to die on syntax error sounds alright
> to me.

In the case of git_config_check_init(), I think it makes sense to die,
because file accesses are protected with access_or_die(), so the return
value can be negative only if something really went wrong.

If you chose not to die, then you should check the return value in the
callers of git_config_check_init().

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
