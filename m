From: Junio C Hamano <gitster@pobox.com>
Subject: 1.5.4-rc2 plans
Date: Thu, 20 Dec 2007 16:32:28 -0800
Message-ID: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 01:33:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Vox-0006Pm-GB
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 01:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912AbXLUAce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2007 19:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755569AbXLUAce
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 19:32:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220AbXLUAcd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 19:32:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 53BC63A9D;
	Thu, 20 Dec 2007 19:32:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A55323A9C;
	Thu, 20 Dec 2007 19:32:30 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69033>

I've tagged -rc1 last night.  The changes are mostly fixes.  There are
some remaining issues I'd like to see fixed/decided before 1.5.4.

One important issue is to identify and fix regressions since 1.5.3
series.  No "rewrite scripted git-foo completely in C" can be regressio=
n
free, and we had quite a few internal changes during 1.5.4 cycle (not
just rewrite to C, but C level uses new and improved API such as strbuf
and parse-options).  Currently I am aware of these regressions:

 * handling of options, "--abbrev 10 HEAD", "--abbrev=3D10 HEAD" and
   "--abbrev HEAD".  The last one does not work for commands that use
   parse-options.  Pierre is on top of this, I hope.

 * handling of EDITOR in git commit and git tag is currently different.
   It expects "vi" not "vi --some-funny-option".  I sent out a
   for-discussion patch after seeing Steven's and Luciano's.

but I am sure there must be others that we haven't even identified.

Also there have been handful usability issues, which can be solved
without incompatible changes:

 * Should "git stash" stop doing anything useful?  I think the patch
   from Nana today may be a reasonable compromise, although I still
   think fundamentally different behaviour for the same command
   configurable per-user is not very nice (we have precedent in "git
   clean" already, though, but "git clean" is inherently dangerous
   command, and "git stash" is much more useful and the issue impacts
   more people).

 * Introduction of "<tree>:./path" (Dscho).  I could be talked into
   accepting the patch if it is useful to people who live deep within
   subdirectories.

 * Making commit log message cleansing optionally less aggressive.  I d=
o
   not think we have seen the end of the thread yet, but I think Linus'=
s
   "three cleansing levels" approach is on the right track.

I'd like to see the above resolved and hopefully 12 other regressions
identified and fixed before the end of the year, when -rc2 can hopefull=
y
happen.

The following technical issues have been raised but not resolved and I
do not expect the resolution to be part of 1.5.4.

 * Authenticated pserver (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason).  It =
needs security
   audit of the code and also the password storage needs to be decided.
   This can wait post 1.5.4.

 * Threaded "repack -a -d -f" when having a verify tight pack suffers
   from massive malloc(3) memory fragmentation, which we cannot do much
   about.

 * Rebase using "format-patch | am" machinery has issues when dealing
   with a mostly-text change that includes NUL (or anything you cannot
   e-mail patch for).  The workaround is "rebase -m" which unfortunatly
   is slow.  I am working on rewriting cherry-pick whenever I find time
   to address it, though.

 * Handling of trailing blank lines does not mesh well with the way dif=
f
   and apply whitespace logic is done.
