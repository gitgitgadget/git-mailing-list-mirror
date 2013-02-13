From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Wed, 13 Feb 2013 15:56:25 +0100
Message-ID: <vpqtxpgb6ue.fsf@grenoble-inp.fr>
References: <5104E738.602@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 13 15:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5dlm-0005O2-QA
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 15:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759204Ab3BMO4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 09:56:46 -0500
Received: from mx1.imag.fr ([129.88.30.5]:52958 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755886Ab3BMO4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 09:56:45 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1DEuOYK024435
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Feb 2013 15:56:24 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U5dl3-0000uo-JN; Wed, 13 Feb 2013 15:56:25 +0100
In-Reply-To: <5104E738.602@alum.mit.edu> (Michael Haggerty's message of "Sun,
	27 Jan 2013 09:37:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Feb 2013 15:56:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1DEuOYK024435
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361372190.32535@N1Ls0qe2aNaY3MDpl5UScA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216259>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> A while ago, I submitted an RFC for adding a new email notification
> script to "contrib" [1].  The reaction seemed favorable and it was
> suggested that the new script should replace post-receive-email rather
> than be added separately, ideally with some kind of migration support.

I think replacing the old post-receive-email is a sane goal in the long
run, but a good first step would be to have git-multimail merged in
contrib, and start considering the old script as deprecated (keeping the
old script doesn't harm IMHO, it's a one-file, 3 commits/year script,
not really a maintainance burden).

I started playing with git-multimail. In short, I do like it but had to
fight a bit with python to get it to work, and couldn't get it to do
exactly what I expect. Pull request attached :-).


Installation troubles:

I had an old python installation (Red Hat package, and I'm not root),
that did not include the email.utils package, so I couldn't use my
system's python. I found no indication about python version in README,
so I installed the latest python by hand, just to find out that
git-multimail wasn't compatible with Python 3.x. 2to3 can fix
automatically a number of 3.x compatibility issues, but not all of them
so I gave up and installed Python 2.7.

I think adding a short "dependencies" section in the README (or in an
INSTALL file) saying which Python version works could save new users the
trouble (I see the sheebang inside the scripts says python2 but since I
couldn't use my system's python and called
"path/to/python git_multimail.py", this didn't help). Making the script
portable with python 2 and 3 would be awesome ;-).


Missing feature:

git-multimail can send a summary for each push, with the "git log --oneline"
of the new revisions, and then 1 mail per patch with the complete log
and the patch.

I'd like to have the intermediate: allow the summary email to include
the complete log (not just --oneline). My colleagues already think they
receive too many emails so I don't think they'd like the "one email per
commit" way, but the 1 line summary is really short OTOH.

I wrote a quick and hopefully not-too-dirty implementation of it,
there's a pull request here:

https://github.com/mhagger/git-multimail/pull/6

essentially, it boils down to:

@@ -835,6 +837,17 @@ class ReferenceChange(Change):
                 for line in self.expand_lines(NO_NEW_REVISIONS_TEMPLATE):
                     yield line
 
+            if adds and self.showlog:
+                yield '\n'
+                yield 'Detailed log of added commits:\n\n'
+                for line in read_lines(
+                        ['git', 'log']
+                        + self.logopts
+                        + ['%s..%s' % (self.old.commit, self.new.commit,)],
+                        keepends=True,
+                        ):
+                    yield line
+
             # The diffstat is shown from the old revision to the new
             # revision.  This is to show the truth of what happened in
             # this change.  There's no point showing the stat from the

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
