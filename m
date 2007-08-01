From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and
 Mercurial
Date: Wed, 1 Aug 2007 10:03:37 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708010937050.3582@woody.linux-foundation.org>
References: <200708010216.59750.jnareb@gmail.com>
 <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
 <7vodhrby6f.fsf@assigned-by-dhcp.cox.net> <20070801092428.GB28106@thunk.org>
 <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
 <87tzrjfe5h.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 19:04:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGHc8-0006WZ-90
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 19:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbXHARDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 13:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755549AbXHARDz
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 13:03:55 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37015 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754890AbXHARDy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 13:03:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l71H3hi8027798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Aug 2007 10:03:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l71H3bAW007777;
	Wed, 1 Aug 2007 10:03:37 -0700
In-Reply-To: <87tzrjfe5h.wl%cworth@cworth.org>
X-Spam-Status: No, hits=-2.422 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_63
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54453>



On Wed, 1 Aug 2007, Carl Worth wrote:
>
> On Wed, 01 Aug 2007 03:15:25 -0700, Junio C Hamano wrote:
> >
> > Are you suggesting to make -l the default for local, in other
> > words?  I personally do not make local clone often enough that I
> > am not disturbed having to type extra " -l" on the command line.
> 
> Personally, I think it would be a great default.

I suspect it probably *would* make sense to default to "-l". Even if it 
makes me get goose-bumps. I freely admit that my worries are totally 
illogical.

We might make it something like: "if you use an url, we don't default to 
local", so the difference would be that

	git clone file:///directory/to/repo

would work the way it does now, but

	git clone /directory/to/repo

would default to "-l" behaviour. That kind of would make sense (and should 
be easy to implement: it would be a trivial fixup to "connect.c".

Something like this adds support for "file://". And then git-clone could 
just do something like

	# if the source is a local directory, default to local
	if [ -d "$src" ]; then
		use_local=yes
	fi

or similar.

		Linus

---
 connect.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index 715cdc0..ae49c5a 100644
--- a/connect.c
+++ b/connect.c
@@ -145,6 +145,8 @@ static enum protocol get_protocol(const char *name)
 		return PROTO_SSH;
 	if (!strcmp(name, "ssh+git"))
 		return PROTO_SSH;
+	if (!strcmp(name, "file"))
+		return PROTO_LOCAL;
 	die("I don't handle protocol '%s'", name);
 }
 
@@ -498,13 +500,13 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 		end = host;
 
 	path = strchr(end, c);
-	if (c == ':') {
-		if (path) {
+	if (path) {
+		if (c == ':') {
 			protocol = PROTO_SSH;
 			*path++ = '\0';
-		} else
-			path = host;
-	}
+		}
+	} else
+		path = end;
 
 	if (!path || !*path)
 		die("No path specified. See 'man git-pull' for valid url syntax");
