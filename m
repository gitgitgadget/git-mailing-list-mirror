From: Mike Hommey <mh@glandium.org>
Subject: Re: git-http-fetch segfault, curl 7.18.0
Date: Sun, 2 Mar 2008 21:03:09 +0100
Organization: glandium.org
Message-ID: <20080302200309.GA2070@glandium.org>
References: <20080302190857.11027.qmail@28c5bbafb32cb2.315fe32.mid.smarden.org> <20080302192355.GA625@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 21:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVuM6-0007zy-QD
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 21:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbYCBT73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYCBT73
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 14:59:29 -0500
Received: from vuizook.err.no ([194.24.252.247]:44086 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752915AbYCBT72 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 14:59:28 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVuL6-0006OG-CS; Sun, 02 Mar 2008 20:59:22 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVuOr-0001qY-Vu; Sun, 02 Mar 2008 21:03:10 +0100
Content-Disposition: inline
In-Reply-To: <20080302192355.GA625@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75833>

On Sun, Mar 02, 2008 at 08:23:55PM +0100, Mike Hommey wrote:
> On Sun, Mar 02, 2008 at 07:08:57PM +0000, Gerrit Pape wrote:
> > Hi, as reported through http://bugs.debian.org/468836, I can reproduce
> > with current maint branch on Debian/unstable, but I don't know whether
> > it's a problem in curl, or in git.  Maybe anyone with some experience
> > in curl can help on this?
> > 
> > gdb gives this
> (...)
> 
> valgrind gives better insight:
> ==862== Invalid read of size 4
> ==862==    at 0x493B32: fill_active_slots (http.c:441)
> ==862==    by 0x493CF9: step_active_slots (http.c:459)
> ==862==    by 0x493D6E: run_active_slot (http.c:479)
> ==862==    by 0x493F8B: http_cleanup (http.c:296)
> ==862==    by 0x494CA8: cleanup (http-walker.c:900)
> ==862==    by 0x4911D6: walker_free (walker.c:315)
> ==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
> ==862==    by 0x404247: handle_internal_command (git.c:248)
> ==862==    by 0x4049D4: main (git.c:412)
> ==862==  Address 0x7c7c558 is 16 bytes inside a block of size 72 free'd
> ==862==    at 0x4C20B2E: free (vg_replace_malloc.c:323)
> ==862==    by 0x493F47: http_cleanup (http.c:301)
> ==862==    by 0x494CA8: cleanup (http-walker.c:900)
> ==862==    by 0x4911D6: walker_free (walker.c:315)
> ==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
> ==862==    by 0x404247: handle_internal_command (git.c:248)
> ==862==    by 0x4049D4: main (git.c:412)
(...)
> 
> It seems there is something wrong going on with slots...

And the problem lies in the fact we run_active_slot() during cleanup,
which can end up going through all the slots starting at
active_queue_head, while we have freed the first slots...

Now, why do we need to run slots when cleaning up ?

Mike
