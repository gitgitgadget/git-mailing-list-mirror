From: Andre Masella <andre@masella.no-ip.org>
Subject: Re: Repository Security
Date: Tue, 23 Jan 2007 08:23:15 -0500
Message-ID: <200701230823.16021.andre@masella.no-ip.org>
References: <200701221433.13257.andre@masella.no-ip.org> <20070122205304.GB29739@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 14:23:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9LcS-00087O-M6
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 14:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbXAWNXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 08:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbXAWNXV
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 08:23:21 -0500
Received: from tomts40.bellnexxia.net ([209.226.175.97]:58311 "EHLO
	tomts40-srv.bellnexxia.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965066AbXAWNXU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jan 2007 08:23:20 -0500
Received: from masella.no-ip.org ([74.14.39.184])
          by tomts40-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20070123132318.XOER1750.tomts40-srv.bellnexxia.net@masella.no-ip.org>;
          Tue, 23 Jan 2007 08:23:18 -0500
Received: by masella.no-ip.org (Postfix, from userid 1003)
	id 1BE9E508FA; Tue, 23 Jan 2007 08:23:17 -0500 (EST)
To: "Shawn O. Pearce" <spearce@spearce.org>
User-Agent: KMail/1.9.5
In-Reply-To: <20070122205304.GB29739@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37515>

> > As I understand it, none of the repository backends allow any per-user
> > per-branch access control. SSH and HTTP come the closest with the right
> > hooks, but since the repository is writeable by those users, there is
> > little to stop them from changing the repository directly.
>
> Yes.  But hooks cannot be run in the HTTP case, can they?

Err...yes. I don't know what I was thinking when I wrote that.

> However in the HTTP case we use WebDAV to update the remote 
> server, which means security controls in the WebDAV server are
> probably sufficient to prevent unauthorized object upload or ref updates.

Apache has fairly limited authorization when it comes to WebDAV. I can 
authenticate users, but then there is no easy way to determine if they should 
be allowed to modify a particular file and the underlying file system can't 
help because all the users are mapped to a single one. Controlling access to 
directories would require creating .htaccess files everywhere with a list of 
allowed users.

> In the SSH case I fixed it by installing git-receive-pack setuid
> to the repository owner.  I locally patched receive-pack.c so it
> disables hook execution if that particular hook isn't owned by the
> repository user (to prevent rogue users from running arbitrary things
> as the repository owner).  This way nobody can change anything in
> a repository except through git-receive-pack.

That is very clever.

> Rather draconian.  But in a corporate world with some strict legal
> requirements placed upon you by your contracts with your customers
> sometimes you do have to verify that Bob really is Bob, or at least
> knows Bob's password.

Even without the legal requirements, management may resist a system where a 
developer from one project can view, let alone modify, another project.

> > I could also make the HTTP less dumb, if I had a better idea what that
> > might involve. 
> The HTTP push client is dumb because it needs to send loose objects
> to the remote repository.

Okay. And HTTP is the only dumb protocol right now?

> A "smart" plugin to Apache is unnecessary I think.  A CGI which
> splits the main() method of git-receive-pack into two halves (one
> to write_head_info, the other to do the rest of the work) is all
> that is required here to make HTTP push smart.

I see. I wonder about building this into gitweb. Adding a little check of the 
User-Agent can make it decide if it is going to display pretty things or 
allow repository access.

> Then have the HTTP client make one GET request to obtain the head info,
> then a POST request to upload the pack to git-receive-pack.

This would break exisiting HTTP repositories though. Perhaps it should get a 
different name.

In recieve-pack, are the commands read in read_head_info (which would be the 
POST request) all unidirectional?

> Since the hooks are then running as the web server user, and inherit
> the entire HTTP environment, you can do authentication in the web
> server but do authorization from within the hook, where you have
> much finer control to inspect what is occurring.  And only the web
> server needs to have write access to the repository.

All of which is fairly easy to do.
-- 
--Andre Masella (andre at masella.no-ip.org)
