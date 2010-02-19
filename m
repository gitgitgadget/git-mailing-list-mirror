From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/7] Re: 'git svn log' no longer uses the pager
Date: Fri, 19 Feb 2010 00:50:10 -0600
Message-ID: <20100219065010.GA22258@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 07:50:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiMh6-0001a4-7b
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 07:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022Ab0BSGu1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 01:50:27 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:40622 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab0BSGu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 01:50:26 -0500
Received: by yxe38 with SMTP id 38so7196614yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 22:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=9zHrFDmvX4U78g4/L5gSS0IVsEFz2P+9dm/uBrTKKVs=;
        b=DgonHW++sN2XkGL1Qtd2ShmAmepEET9ZU4douSq4WzARQxrj/O3pu2mMvChQxmT9Lz
         A8JrXWw++57Fcu0N66X65foB+nWDNkrqZucmnY+2/tnlGiBHht/PWc8jdiDfsAgBwZBC
         N1szJxOxPhoFl+FKHTC5uKqtVgKCohE8z/CaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=NYGOh0jDy6FyvmUy++ApaG4jsxs4g4ammVTSaRWxGi3N3UcTJED4g9m/ovoCZVd799
         AmfEZ10vnVbIdUyNxxPfSCMNHZIlZhZUcYoyA1JFDs+YICLdl2ulfsM1kTLNzvCqyERq
         fHzBKvK0EhvlHqnnBb04xukZKLBC4EbhPkG0U=
Received: by 10.90.62.2 with SMTP id k2mr4460944aga.56.1266562205146;
        Thu, 18 Feb 2010 22:50:05 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3999918yxe.57.2010.02.18.22.50.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 22:50:03 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140416>

Here is a replacement for the jn/maint-fix-pager series currently in
pu.  As for the previous version, the point is to fix the breakage
from dec543 (am -i, git-svn: use "git var GIT_PAGER", 2009-10-30)=20
reported at http://thread.gmane.org/gmane.comp.version-control.git/1398=
31
I also added some new tests to make sure pagination works in other
ways.

In this version, patches 1-5 are the same fixes as before, with
commit messages tweaked to take into account feedback from the
previous round.  You can see what they fix by using 'git svn log'
and the '(v)iew' option of 'git am --interactive', which both
stopped paginating output in commit dec543.  You can see what they
don=E2=80=99t break by running some other command such as 'git log' in
circumstances where its output is not supposed to be paginated.

The test in patch 6 has some fixes that didn=E2=80=99t make it to pu la=
st
time.  To avoid risk of spewing useless output to /dev/tty, the
tests requiring a terminal only run with the --verbose option.

Patch 7 is the one I am most interested in feedback about.  It allows
automatic runs of tests without a real terminal by creating its own
pty as needed.  But it might be a portability nightmare: is
posix_openpt widely available?  Will open("/dev/ptmx", ...) do just
as well most places?  And how important is it that these tests run
on the most obscure platforms?

Because these questions are still up in the air for me, I do not
think patch 7 is suitable for use outside pu yet.  What I would most
like to hear is that /dev/ptmx works often enough, because that is
a condition that can be tested for at runtime without adding
complication to the Makefile.  But if that is not the case, there
are other options.

Jonathan Nieder (7):
  Fix 'git var' usage synopsis
  Make 'git var GIT_PAGER' always print the configured pager
  git.1: Clarify the behavior of the --paginate option
  git svn: Fix launching of pager
  am: Fix launching of pager
  tests: Add tests for automatic use of pager
  t7006-pager: if stdout is not a terminal, make a new one

 .gitignore                |    1 +
 Documentation/git-var.txt |    2 +-
 Documentation/git.txt     |    8 ++-
 Makefile                  |    6 ++
 builtin-var.c             |    4 +-
 cache.h                   |    2 +-
 git-am.sh                 |    5 +-
 git-sh-setup.sh           |   13 ++++
 git-svn.perl              |    9 ++-
 pager.c                   |    6 +-
 t/t7006-pager.sh          |  171 +++++++++++++++++++++++++++++++++++++=
++++++++
 test-terminal.c           |   62 ++++++++++++++++
 12 files changed, 274 insertions(+), 15 deletions(-)
 create mode 100644 t/t7006-pager.sh
 create mode 100644 test-terminal.c
