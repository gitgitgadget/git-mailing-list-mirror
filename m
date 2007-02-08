From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] Empty reflogs and "git log -g"
Date: Thu, 8 Feb 2007 20:36:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702082022200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
 <8aa486160702072325q1d63c5d2mc1c6a492392802c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-982537615-1170963363=:22628"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 20:36:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFF43-0001GV-AI
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 20:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423272AbXBHTgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 14:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423271AbXBHTgI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 14:36:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:32851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423272AbXBHTgE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 14:36:04 -0500
Received: (qmail invoked by alias); 08 Feb 2007 19:36:03 -0000
X-Provags-ID: V01U2FsdGVkX19FXR8mHkZFTQ/mlEIEvMTbHe4vOiz1XjBqUEkEGt
	drEw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <8aa486160702072325q1d63c5d2mc1c6a492392802c6@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39077>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-982537615-1170963363=:22628
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 8 Feb 2007, Santi Béjar wrote:

> On 2/8/07, Santi Béjar <sbejar@gmail.com> wrote:
> > Hi *,
> > 
> >   when a reflog entry do not have a reflog message the refs@{num}
> > syntax gives a different result than with 'git log -g'. Actually 'git
> > log -g' just skips this ref.
> > 
> 
> Also:
> 
> $ git log origin/master
> 
> works, but
> 
> $ git log -g origin/master
> 
> does not. You have to put the remotes prefix.

I hesitate "fixing" that. I mean, if you want to know about the remote 
branch "master" why not be precise? Yes, "git log" _is_ nice if you want 
to be sloppy.

But if you _have_ to have it, see attached patch. I will not push for it 
in time for 1.5.0, though, since I have a track record of not getting 
patches right on the first try.

Ciao,
Dscho

---

 reflog-walk.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 653ec95..430faef 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -174,6 +174,19 @@ void add_reflog_for_walk(struct reflog_walk_info *info,
 			branch = xstrdup(head);
 		}
 		reflogs = read_complete_reflog(branch);
+		if (!reflogs || reflogs->nr == 0) {
+			unsigned char sha1[20];
+			char *b;
+			if (dwim_ref(branch, strlen(branch), sha1, &b) == 1) {
+				if (reflogs) {
+					free(reflogs->ref);
+					free(reflogs);
+				}
+				free(branch);
+				branch = b;
+				reflogs = read_complete_reflog(branch);
+			}
+		}
 		if (!reflogs || reflogs->nr == 0)
 			die("No reflogs found for '%s'", branch);
 		path_list_insert(branch, &info->complete_reflogs)->util
---1148973799-982537615-1170963363=:22628--
