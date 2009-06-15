From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] daemon: send stderr of service programs to the syslog
Date: Mon, 15 Jun 2009 07:57:16 -0700
Message-ID: <20090615145716.GW16497@spearce.org>
References: <200906142238.51725.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jun 15 16:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGDck-0005GF-DQ
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 16:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZFOO5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 10:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbZFOO5N
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 10:57:13 -0400
Received: from george.spearce.org ([209.20.77.23]:36324 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbZFOO5N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 10:57:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0ADA5381FE; Mon, 15 Jun 2009 14:57:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906142238.51725.j6t@kdbg.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121611>

Johannes Sixt <j6t@kdbg.org> wrote:
> If git-daemon is run with --detach or --inetd, then stderr is explicitly
> redirected to /dev/null. But notice that the service programs were spawned
> via execl_git_cmd(), in particular, the stderr channel is inherited from
> the daemon. This means that errors that the programs wrote to stderr (for
> example, via die()), went to /dev/null.
> 
> This patch arranges that the daemon does not merely exec the service
> program, but forks it and monitors stderr of the child; it writes the
> errors that it produces to the daemons log via logerror().
> 
> A consequence is that the daemon process remains in memory for the full
> duration of the service program, but this cannot be avoided.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I don't know whether service programs like upload-archive or upload-pack
>  write progress report to stderr or not, for example, if a client does not
>  support side-bands. In this case this patch is probably not enough since
>  this would fill the log with unneeded progress information. Any hints
>  are appreciated.

They could, if they were broken.  :-)

IIRC only upload-pack produces progress (from pack-objects).
It does so by using a pipe on fd 2, and either copying it down
to the client via side-band, or discarding it.  So progress data
shouldn't ever appear on upload-pack's own fd 2, which means you
won't get it in this syslog thing.

But I have to wonder, why are we doing this?  Why can't we teach the
individual server program to record its error to the syslog before
it aborts?  Are we looking for SIGSEGV or something?  Its only the
daemon program staying around in memory, but that's a lot of little
daemons doing nothing waiting for their children to terminate.
Seems like a waste to me.
 
-- 
Shawn.
