From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: Show the committer ident when is different
	from the parent
Date: Wed, 30 Apr 2008 10:50:17 -0400
Message-ID: <20080430145017.GA922@sigill.intra.peff.net>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com> <1209545236-4266-4-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 16:51:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrDeH-00059a-De
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 16:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757737AbYD3OuV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2008 10:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756801AbYD3OuV
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 10:50:21 -0400
Received: from peff.net ([208.65.91.99]:3965 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757049AbYD3OuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 10:50:20 -0400
Received: (qmail 18009 invoked by uid 111); 30 Apr 2008 14:50:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Apr 2008 10:50:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2008 10:50:17 -0400
Content-Disposition: inline
In-Reply-To: <1209545236-4266-4-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80838>

On Wed, Apr 30, 2008 at 10:47:16AM +0200, Santi B=C3=A9jar wrote:

>   it does not work with the initial commit, I don't know why.
>   Even with this:
> 	if (!commit)
> 		return NULL;
>=20
>   Can someone help me? Thanks

It segfaults for me, since you try to strdup NULL. I think you want to
return "" if there is no initial commit, so you can strcmp against the
current committer (or alternatively, explicitly check for NULL).

> +		parent_ident =3D xstrdup(get_parent_ident());
> +		if (strcmp(parent_ident, committer_ident))
> +			fprintf(fp,
> +				"# Committer: %s\n",
> +				committer_ident);
> +

Why strdup at all here, which leaks? Nobody else uses this variable, so
it should be sufficient to strcmp(get_parent_ident(), committer_ident)
once get_parent_ident promises to always return a valid string. Or
alternatively:

  parent_ident =3D get_parent_ident();
  if (!parent_ident || strcmp(parent_ident, committer_ident))


A few other comments (I like the idea overall):

  - I haven't looked at the code organization, so maybe it is not
    feasible, but it seems like this stuff should go into wt-status's
    implementation, which would show up in a git-status.

  - The output looks very cluttered. It would be nice to have

    # enter your commit message...
    #
    # Author: whatever
    # Committer: whatever
    #
    # other stuff

    IOW, put in a blank line on either side, but not between the two
    identities if both are shown.

-Peff
