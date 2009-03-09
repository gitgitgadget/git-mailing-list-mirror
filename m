From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/2] Move push logic to transport.c
Date: Sun, 8 Mar 2009 21:06:01 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903082046280.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:07:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgTxv-0001Qc-Q8
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbZCIBGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 21:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbZCIBGG
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:06:06 -0400
Received: from iabervon.org ([66.92.72.58]:43449 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768AbZCIBGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 21:06:05 -0400
Received: (qmail 4828 invoked by uid 1000); 9 Mar 2009 01:06:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2009 01:06:01 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112657>

Currently, send_pack() does the work of figuring out what the refspecs 
mean before pushing (with the help of functions from remote.c), updating 
local state afterwards, and reporting what it did.

Transports other than the native protocol use the same logic for the first 
of these, and don't do the other two at all. In order to be able to share 
more code and make it easier to be consist, move the logic to 
transport_push. This is also more similar to how fetch is organized, 
although fetch puts most of the logic in builtin-fetch, which isn't really 
feasible until all of the transports are converted to the new functions, 
and may be less convenient anyway.

This series only goes as far as adding a new "push_refs" method to struct 
transport and using it for the git native transport. It doesn't convert 
http-push or the rsync transports, largely because I don't have test 
setups for rsync or webdav to make sure that they're still working.

It also leaves copies of matching, updating, and reporting code in 
builtin-send-pack, but these are only used for "git send-pack", and are 
not used in the code paths for "git push". Hopefully, we can deprecate the 
protocol-specific command at some point in favor of just using "git push".

This is on top of next for Jay's patch to make get_local_heads() common.

Daniel Barkalow (2):
  Use a common function to get the pretty name of refs
  Move push matching and reporting logic into transport.c

 builtin-fetch.c     |    6 +-
 builtin-send-pack.c |  153 +++++++++++++--------------
 refs.c              |   10 ++
 refs.h              |    2 +
 send-pack.h         |    6 +-
 transport.c         |  283 +++++++++++++++++++++++++++++++++++++++++++++++----
 transport.h         |    3 +-
 7 files changed, 356 insertions(+), 107 deletions(-)
