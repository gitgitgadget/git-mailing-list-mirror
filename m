From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] Run hooks with a cleaner environment
Date: Tue, 6 Dec 2005 17:43:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512061716030.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 23:44:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjlWX-0001gW-Lw
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 23:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbVLFWmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 17:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbVLFWmv
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 17:42:51 -0500
Received: from iabervon.org ([66.92.72.58]:24334 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932650AbVLFWmu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 17:42:50 -0500
Received: (qmail 10036 invoked by uid 1000); 6 Dec 2005 17:43:28 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Dec 2005 17:43:28 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13301>

Currently, hooks/post-update is run in the environment that receive-pack 
is run. This means that there are a number of things that are 
unpredictable. I'd like to make it set things up in a more predictable and 
useful way. The things I know are odd:

stdout and stdin are connected to send-pack, either by broken pipes (for 
local pushes) or an ignored socket (via ssh). stdin should probably be 
/dev/null, and stdout should be either a log file or /dev/null. stderr is 
still the push's stderr, which may or may not be desired.

GIT_DIR is set to the repository that got the push, which may surprise 
people who only use it in "GIT_DIR=foo git ..." form and don't expect it 
ever to be set from outside. Of course, it's potentially useful to know 
what repository is running the hook, but that doesn't have to be 
communicated in such a way that git programs will pick it up directly. 
Other environment variables could potentially be purged, too, but I don't 
think that's as important, since the user probably knows about them.

cwd is set to the push's cwd if it's local, maybe $HOME if it's over ssh. 
It should probably always be $HOME, unless we want it to be $GIT_DIR.

Is there anything else we want to regularize? Is there some sort of 
standard behavior we should match, like CVS or cron?

	-Daniel
*This .sig left intentionally blank*
