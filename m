From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 0/6] Add PCRE support to git-grep
Date: Mon,  9 May 2011 23:52:02 +0200
Message-ID: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 23:52:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYNa-0000B9-OW
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 23:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055Ab1EIVwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 17:52:33 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43749 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab1EIVwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 17:52:32 -0400
Received: by wwa36 with SMTP id 36so6215970wwa.1
        for <git@vger.kernel.org>; Mon, 09 May 2011 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=Yv3GPwKmO5bGL48g25Y06V8t8fKcwBvHmLNYGO6rpkM=;
        b=vAYWgP6D9hc3cEkO4pOkiSaOaeu2JySogvqvWapMJJaaTS9VRtgxPSm6yCnyq+R3VL
         l6VQwHbSd+oNBmnSZwnklh+2tDFOZLAQjF1qnp6838GG1+VbkzLihNrdHe/xvUhFrzfu
         fSIE5NEcp/KcAxWcX3rz8wd7dwsP8JnS+11mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=JuAPrKoNHckW/drUQB2ewGCj6UB248vGu9oCxHVa+qidmzNxz9EfRP99D4qcvuUVnt
         P0AHaVA9C+iS+YtY86/RUT+fFLZCuJJ+uprvlP+29ft+SxTdHez7kAGAGNCT9dmRzfK4
         pBhsjxmD0mq27a56YB1JGyfYlPoowjM+6VTEo=
Received: by 10.227.100.219 with SMTP id z27mr339971wbn.45.1304977949481;
        Mon, 09 May 2011 14:52:29 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id ed10sm4017202wbb.66.2011.05.09.14.52.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 14:52:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173256>

This is the 3rd attempt to add PCRE support to git-grep.

Changes from v2:

* Replaced NO_LIBPCRE with USE_LIBPCRE. This makes libpcre support
optional. I also considered WITH_LIBPCRE but I see most #defines start
with USE_.

* Renamed 'pcre_extra *extra' with 'pcre_extra *pcre_extra_info'. Now
this variable is more descriptive.

* Reworded description of USE_LIBPCRE in Makefile and configure.ac

* I _didn't_ change the die() message to contain only "Perl-compatible
regexes not supported", but left "cannot use Perl-compatible regexes
when not compiled with USE_LIBPCRE". In my opinion this is more
informative to the user. However, it's OK for me to change that if more
people prefer shorter version.

* Removed die() from pcrematch() and free_pcre_regexp(), because die()
is first called from compile_pcre_regexp(). I left die() there and not
moved it to option parsing because I'd like to keep as few '#ifdef
USE_LIBPCRE' as possible.

* Added compile_regexp_failed() which handles both regcomp() and
pcre_compile() failures.

* Added basic testcases. I'm not sure if I should repeat all
git-grep tests with -P enabled, this seems to be officiousness. Beyond
testing -P/--perl-regexp and their interaction with -i and -w,  I also
check if `git grep -F -P` and `git grep -E -P` was called, but do not
protect from `git grep -G -P` nor `git grep -E -G -P`. Fixing this
would require changing the way -G -E are parsed (currently they
set/unset REG_EXTENDED bit in opts.regflags). Personally, if I were
fixing this, I'd remove regflags completely from grep_opt and use it
only in functions which call regcomp()/regexec() directly. That would
make code more general. But it's also possible to just convert option
parsing code to properly detect used flags. That said, I don't think th=
e
end result is worth the effort.

I'd like to thank for all comments!

Micha=C5=82 Kiedrowicz (6):
  grep: Fix a typo in a comment
  grep: Extract compile_regexp_failed() from compile_regexp()
  git-grep: Learn PCRE
  configure: Check for libpcre
  grep: Add basic tests
  git-grep: Bail out when -P is used with -F or -E

 Documentation/git-grep.txt             |    6 ++
 Makefile                               |   15 +++++
 builtin/grep.c                         |    6 ++-
 config.mak.in                          |    1 +
 configure.ac                           |   40 ++++++++++++
 contrib/completion/git-completion.bash |    1 +
 grep.c                                 |  102 ++++++++++++++++++++++++=
++++----
 grep.h                                 |    9 +++
 t/README                               |    5 ++
 t/t7810-grep.sh                        |   54 +++++++++++++++++
 t/test-lib.sh                          |    1 +
 11 files changed, 228 insertions(+), 12 deletions(-)

--=20
1.7.3.4
