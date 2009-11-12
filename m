From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: t5541-http-push hanging
Date: Wed, 11 Nov 2009 20:49:06 -0800
Message-ID: <20091112044906.GQ11919@spearce.org>
References: <B17AB159-E217-4E1F-BEA3-97E5892C13F4@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 05:49:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8RcR-0007C0-95
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 05:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbZKLEtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 23:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbZKLEtA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 23:49:00 -0500
Received: from george.spearce.org ([209.20.77.23]:54308 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158AbZKLEtA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 23:49:00 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 30E9CE0005; Thu, 12 Nov 2009 04:49:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <B17AB159-E217-4E1F-BEA3-97E5892C13F4@gernhardtsoftware.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132736>

Brian Gernhardt <brian@gernhardtsoftware.com> wrote:
> My build script for git has been hanging at t5541.2 and I haven't had the tuits to discover why.  Here's what I've gotten so far, in case anyone can figure it out faster:
...
> 	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone
...
> [Wed Nov 11 06:19:39 2009] [error] [client 127.0.0.1] git-http-backend(59490) malloc: *** error for object 0x100200340: incorrect checksum for freed object - object was probably modified after being freed.
> [Wed Nov 11 06:19:39 2009] [error] [client 127.0.0.1] *** set a breakpoint in malloc_error_break to debug

I can't reproduce this on 10.5.8.  Can you try running it in the
debugger and putting a breakpoint where they suggest?  Maybe it
will help give us some context information:

  REQUEST_METHOD=GET \
  PATH_TRANSLATED=`pwd`/.git/info/refs \
  QUERY_STRING=service=git-upload-pack \
  gdb ./git-http-backend

  b malloc_error_break
  run

I suspect that's where our failure is, the code path for the actual
common negotiation and data transfer is shorter, and less likely
to need to do a memory allocation... and therefore a free.

-- 
Shawn.
