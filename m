From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Prefer sysconf(_SC_OPEN_MAX) over getrlimit(RLIMIT_NOFILE,...)
Date: Wed, 22 Aug 2012 20:06:23 +0200
Message-ID: <003f01cd8090$d7e50990$87af1cb0$@schmitz-digital.de>
References: <002301cd807f$4e19ad80$ea4d0880$@schmitz-digital.de> <7v4nnualjf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4FKA-0003zP-JV
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952Ab2HVSGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:06:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:49291 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293Ab2HVSGb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:06:31 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MOiCE-1SzGym0oLu-00638q; Wed, 22 Aug 2012 20:06:30 +0200
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHOiusSIXDAUa9faihh7VBbAY6g5wI3HcjRl1JN1RCAAASssA==
Content-Language: de
X-Provags-ID: V02:K0:oY/PeIdsec2g7c/Tzw9PAsq4HDRWESt1l23vg46+WBu
 xCtd/V3x1gbumjiPOAcpwrNUAyDcFPAioPYgh1tqXaTxUFILjc
 TCbrJNXuiQht4ld2uqtEtKar5J8RR8pxIVS0Ivqyzs6oMT4HDx
 20Ov0lfReV/uatYOvG6eXqS9dsthTV73OgbU55tGrXX97n+aIb
 aRAXPoc88O0QNQdNLfbHL8pGGuct2s9AsKFcj933jqwS2LMe8B
 N8EqmSrmnafVQN2d+eAwTwlkfiRKs4hWX9gK0X4p0V+8KF8P1Y
 Zrs+04EpctUQ+23UqayoS+4tJywIaOM2hm82LfcKTkhOhPzGfO
 48qYrlXQF0LG/KIhdTYXXnx8bso9sDTCCo2AIFCuuX5BxpVdXB
 t2oALMWJReI6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204054>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Wednesday, August 22, 2012 7:53 PM
> To: 'Junio C Hamano'
> Cc: 'git@vger.kernel.org'
> Subject: RE: [PATCH] Prefer sysconf(_SC_OPEN_MAX) over
> getrlimit(RLIMIT_NOFILE,...)
> 
> > From: Junio C Hamano [mailto:gitster@pobox.com]
> > Sent: Wednesday, August 22, 2012 7:23 PM
> > To: Joachim Schmitz
> > Cc: git@vger.kernel.org
> > Subject: Re: [PATCH] Prefer sysconf(_SC_OPEN_MAX) over
> > getrlimit(RLIMIT_NOFILE,...)
> >
> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >
> > > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> > > ---
> > >  sha1_file.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/sha1_file.c b/sha1_file.c index af5cfbd..76714ad 100644
> > > --- a/sha1_file.c
> > > +++ b/sha1_file.c
> > > @@ -747,6 +747,9 @@ static int open_packed_git_1(struct packed_git *p)
> > >                 return error("packfile %s index unavailable",
> > > p->pack_name);
> > >
> > >         if (!pack_max_fds) {
> > > +#ifdef _SC_OPEN_MAX
> > > +               unsigned int max_fds = sysconf(_SC_OPEN_MAX); #else
> > >                 struct rlimit lim;
> > >                 unsigned int max_fds;
> > >
> > > @@ -754,6 +757,7 @@ static int open_packed_git_1(struct packed_git *p)
> > >                         die_errno("cannot get RLIMIT_NOFILE");
> > >
> > >                 max_fds = lim.rlim_cur;
> > > +#endif
> > >
> > >                 /* Save 3 for stdin/stdout/stderr, 22 for work */
> > >                 if (25 < max_fds)
> > > --
> > > 1.7.12
> >
> > Looks sane but it would be more readable to make this a small helper
> > function, so that we do not need to have #ifdef/#endif in the primary
flow of
> the code.
> 
> Hmm, in compat/? Worth the effort fort hat single occrence?
> 
> > By the way, I noticed that you seem to be sending patches out of git,
> > instead of "diff -ru", which is a good sign ;-).
> 
> Not quite, I'm generating them with "git format-patch origin", on the
NonStop
> machine, but can't send email from there (a) behind a firewall and b) no
email
> client available), so I copy/paste the resulting file into Outlook.
> 
> >But all of your patches are whitespace
> > damaged and cannot be applied X-<.
> 
> May well be Outlooks fault? How to solve?

Let's try this then:
---

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 sha1_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index af5cfbd..76714ad 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -747,6 +747,9 @@ static int open_packed_git_1(struct packed_git *p)
 		return error("packfile %s index unavailable", p->pack_name);
 
 	if (!pack_max_fds) {
+#ifdef _SC_OPEN_MAX
+		unsigned int max_fds = sysconf(_SC_OPEN_MAX);
+#else
 		struct rlimit lim;
 		unsigned int max_fds;
 
@@ -754,6 +757,7 @@ static int open_packed_git_1(struct packed_git *p)
 			die_errno("cannot get RLIMIT_NOFILE");
 
 		max_fds = lim.rlim_cur;
+#endif
 
 		/* Save 3 for stdin/stdout/stderr, 22 for work */
 		if (25 < max_fds)
-- 
1.7.12

OK this way?

Bye, Jojo
