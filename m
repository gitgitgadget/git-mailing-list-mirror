From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Fix bunch of fd leaks in http-fetch
Date: Sat, 12 Nov 2005 09:38:28 -0800
Message-ID: <20051112173828.GG4051@reactrix.com>
References: <dd9dee136a573d72fc7332373cfd8ac1@freescale.com> <20051111235516.GY30496@pasky.or.cz> <7vk6feiflx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 18:40:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EazKv-0006l8-DB
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 18:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVKLRik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 12:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKLRik
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 12:38:40 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:30386 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932427AbVKLRij (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 12:38:39 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jACHcSle024713;
	Sat, 12 Nov 2005 09:38:28 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jACHcSc9024711;
	Sat, 12 Nov 2005 09:38:28 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6feiflx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11696>

On Fri, Nov 11, 2005 at 09:45:30PM -0800, Junio C Hamano wrote:

> It strikes me somewhat odd that these close() are not tied to
> the lifetime rule of the transfer_request structure.  When the
> program falls back from an individual object to alternates, the
> same request structure is reused, but in that case ->local stays
> the same.  Otherwise, the original request structure is released
> so I wonder if would make things cleaner to close ->local inside
> request_release()...

That is the intent of the fd close in finish_request() - but that isn't
called if the server returns a 404 and there are no alternates left to
try.

The following patch should fix it.




Added a call to finish_request to clean up resources if the server
returned a 404 and there are no alternates left to try.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

applies-to: 8bae950cd42c1d615fafdf63f4c96f6b665f1e0e
fe26837d08627fbb2f5f57879ebb573474680c4a
diff --git a/http-fetch.c b/http-fetch.c
index cbb9690..78becce 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -632,6 +632,8 @@ static void process_curl_messages(void)
 						request->repo =
 							request->repo->next;
 						start_request(request);
+					} else {
+						finish_request(request);
 					}
 				} else {
 					finish_request(request);
---
0.99.9.GIT
