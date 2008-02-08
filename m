From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening
 a file
Date: Fri, 8 Feb 2008 15:36:05 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802081526350.13593@iabervon.org>
References: <20080208174654.2e9e679c@pc09.procura.nl> <e2b179460802080925s61270036q81896010c76236ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:37:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNZyw-0004Bd-LR
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761528AbYBHUgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933707AbYBHUgR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:36:17 -0500
Received: from iabervon.org ([66.92.72.58]:35399 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933656AbYBHUgI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:36:08 -0500
Received: (qmail 24064 invoked by uid 1000); 8 Feb 2008 20:36:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Feb 2008 20:36:05 -0000
In-Reply-To: <e2b179460802080925s61270036q81896010c76236ae@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73137>

On Fri, 8 Feb 2008, Mike Ralphson wrote:

> On Feb 8, 2008 4:46 PM, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> > HP-UX allows directories to be opened with fopen (path, "r"), which
> > will cause some translations that expect to read files, read dirs
> > instead. This patch makes sure the two fopen () calls in remote.c
> > only open the file if it is a file.
> >
> > Signed-off-by: H.Merijn Brand <h.m.brand@xs4all.nl>
> 
> Many thanks, this is also required for AIX. I had got some way to
> tracking it down, but I thought it was an issue with strbuf. So...

Does the following help? We really ought to know that ".." must be a path 
literal (and there obviously should be more limitations on nicknames for 
remotes, but I haven't figured out what they should be yet).

	-Daniel
*This .sig left intentionally blank*

diff --git a/remote.c b/remote.c
index 0e00680..83a3d9d 100644
--- a/remote.c
+++ b/remote.c
@@ -348,7 +348,7 @@ struct remote *remote_get(const char *name)
        if (!name)
                name = default_remote_name;
        ret = make_remote(name, 0);
-       if (name[0] != '/') {
+       if (name[0] != '/' && strcmp(name, "..")) {
                if (!ret->url)
                        read_remotes_file(ret);
                if (!ret->url)
