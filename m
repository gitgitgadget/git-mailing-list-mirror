From: Pavel Roskin <proski@gnu.org>
Subject: Re: http-fetch segfault fix?
Date: Wed, 07 Jun 2006 01:41:54 -0400
Message-ID: <1149658914.5648.5.camel@dv>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
	 <7vodx6zus2.fsf@assigned-by-dhcp.cox.net> <1149610759.27253.9.camel@dv>
	 <20060606164618.GC3938@reactrix.com> <1149619097.25298.6.camel@dv>
	 <7vlks9le8b.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Wed Jun 07 07:42:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnqnr-0003Cv-AC
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 07:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWFGFl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 01:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWFGFl7
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 01:41:59 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:6355 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750935AbWFGFl7
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 01:41:59 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fnqnm-0003ZZ-4a
	for git@vger.kernel.org; Wed, 07 Jun 2006 01:41:58 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fnqni-0001Vx-FG; Wed, 07 Jun 2006 01:41:54 -0400
To: git@vger.kernel.org
In-Reply-To: <7vlks9le8b.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21431>

On Tue, 2006-06-06 at 22:35 -0700, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > It's a different backtrace this time.  abort_object_request() has this code:
> >
> > if (obj_req->slot) {
> >      release_active_slot(obj_req->slot);
> >      obj_req->slot = NULL;
> > }
> >
> > Apparently just because obj_req->slot is not NULL doesn't mean it's a
> > valid pointer.  I'm going to use Valgrind now.
> 
> Nick's one-liner to explicitly initialize newreq->slot to NULL
> looks obviously correct to me.  Does it fix this problem for
> you?

I'm going to leave the tests running overnight, both with and without
USE_CURL_MULTI.

The Valgrind diagnostics confirms that obj_req->slot is not initialized
(as opposed to being a pointer to a freed area or something else):

==27182== Conditional jump or move depends on uninitialised value(s)
==27182==    at 0x4070EA: abort_object_request (http-fetch.c:1059)
==27182==    by 0x4071CE: fetch_object (http-fetch.c:1078)
==27182==    by 0x4073EC: fetch (http-fetch.c:1126)
==27182==    by 0x403125: loop (fetch.c:180)
==27182==    by 0x403369: pull (fetch.c:248)
==27182==    by 0x407A13: main (http-fetch.c:1271)

Line 1059 is:
if (obj_req->slot) {

-- 
Regards,
Pavel Roskin
