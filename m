From: Petr Baudis <pasky@suse.cz>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 16:03:45 +0200
Message-ID: <20080625140345.GA12567@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Jeske <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 16:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBVcC-0006St-T2
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 16:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430AbYFYODy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 10:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756436AbYFYODy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 10:03:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57881 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756366AbYFYODx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 10:03:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 336DB1E4C02C; Wed, 25 Jun 2008 16:03:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86280>

  Hi,

On Wed, Jun 25, 2008 at 12:36:03AM -0000, David Jeske wrote:
> The purpose of this mechanism is to host a distributed source repository in a
> world where most most developer contributors are behind firewalls and do not
> have access to, or do not want to configure a unix server, ftp, or ssh to
> possibly contribute to a project. The model of allowing less-authoritative
> developers to make their changes available for more-authoritative users to pull
> is accepted as superior. However, no users are assumed to be authoritative over
> each-other, or an entire tree, and many users should have authority only to
> supply new deltas to their own branches. The ability to handle emailed patches
> is an asset, but is deemed too manual for this need.

  BTW, have you read about git-bundle(1)?

> design assumptions:
> 
> - all developers are firewalled and can not be "pulled" from directly.
> - there can be one or more well-connected servers which all users can access.
> - .. but which they cannot have ssh, ftp, or other dangerous access to
> - .. and whose protocol should be layered on http(s)

  Please note that we support pushing using the HTTP DAV extensions. It
seems to be only rarely used in practice though, since developers seem
to either work at sane companies, are tunneling through the firewalls or
the firewalls are adjusted if this is required for development of their
day-job applications. There are some cases where this is useful, but I
don't tihnk they are very numerous (in practicular, I've had more
requests (about three?) for git-cvsserver than for HTTP DAV (zero to
one?) at repo.or.cz). Do _you_ have any real large-scale scenario where
this is an actual issue?

> - there is a shared namespace for branches, and tags
> - .. users are not-trusted to change the branches or tags of other users
> - .. only certain users are trusted to change the shared origin branches
> - .. also allow directory ACLS on shared branch commits
> - all their DAGs should be in a single repository for space efficiency
> - users generally want to follow well-named branches
> - .. will be free to follow any branch, and pull changes from any branch

  Of course, if pushing through the DAV extensions this can get hairy;
if you allow push access for users, you better trust them since they can
touch the objects database. If you don't care about possible DoS attack
vectors, I assume you could configure refs permissions for various users
using some fancy Apache configuration.

  As previously noted though, I believe the space efficiency is not an
issue in real world. Are you familiar with Git's alternates? In a Git
repository, you can specify alternate locations for searching objects,
so you can create a "sub-repository" for each user, where an alternate
is set up pointing to the object database of the main project
repository. Then, the bulk of the objects will be in the main repository
and the sub-repositories will carry only tiny amount of objects specific
to the local development of the given person.

  This is exactly how (and large reason of why) the repo.or.cz forks are
set up, by the way.

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
