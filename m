From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Sun, 3 Aug 2008 20:59:21 -0700
Message-ID: <20080804035921.GB2963@spearce.org>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 06:01:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPrG4-0000ni-1e
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 06:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbYHDD7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 23:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbYHDD7W
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 23:59:22 -0400
Received: from george.spearce.org ([209.20.77.23]:39031 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbYHDD7W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 23:59:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 895FF38419; Mon,  4 Aug 2008 03:59:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vwsix7nhw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91312>

Junio C Hamano <gitster@pobox.com> wrote:
> But could you be a bit more explicit than application/x-git-refs magic?  I
> suspect very strongly that clueless server operators would advertise the
> type on repositories statically hosted there, and would defeat the point
> of your patch.

This is a very valid concern.  I started to worry about it myself
last night, but decided it was late enough and just wanted to start
the discussion on the list, extending JH's thread even further.
 
> Perhaps "#" comment line in info/refs that is ignored on the reading side
> but update-server-info never generates on its own?

This is a good idea.  I think anyone who consumes info/refs does
so with the understanding that "#" comment lines exist, and should
be skipped, but this is not something that has been heavily tested
in the wild yet.

My concern here goes back to the remark you made above. What if a
server owner mirrors a smart server by a non-Git aware device like
wget?  They will now have a copy of the info/refs content which will
suggest we have Git smarts on the backend, but really it isn't there.

Perhaps the smart server detection is something like:

	Smart Server Detection
	----------------------

	To detect a smart (Git-aware) server a client sends an
	empty POST request to info/refs; if a 200 OK response is
	received with the proper content type then the server can
	be assumed to be Git-aware, and the result contains the
	current info/refs data for that repository.

		C: POST /repository.git/info/refs HTTP/1.0
		C: Content-Length: 0

		S: HTTP/1.0 200 OK
		S: Content-Type: application/x-git-refs
		S:
		S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint

Then clients should just attempt this POST first before issuing
a GET info/refs.  Non Git-aware servers will issue an error code,
and the client can retry with a standard GET request, and assume
the server isn't a newer style.

-- 
Shawn.
