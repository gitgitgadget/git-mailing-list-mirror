From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 02/11] Use Set instead of array to keep track of
	change listeners
Date: Thu, 5 Feb 2009 07:48:15 -0800
Message-ID: <20090205154815.GG26880@spearce.org>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <1233795618-20249-2-git-send-email-torarnv@gmail.com> <1233795618-20249-3-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 16:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV6U4-0007h1-6a
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 16:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbZBEPsQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 10:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbZBEPsQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 10:48:16 -0500
Received: from george.spearce.org ([209.20.77.23]:46060 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbZBEPsP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 10:48:15 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3152C38210; Thu,  5 Feb 2009 15:48:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233795618-20249-3-git-send-email-torarnv@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108572>

Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
> +	public static synchronized void removeRepositoryChangeListener(
> +			final RepositoryChangeListener objectThatCares) {
> +		repositoryChangeListeners.remove(objectThatCares);
>  	}
> =20
>  	/**
> @@ -131,13 +133,8 @@ public static synchronized void addRepositoryCha=
ngeListener(
>  	 *            the repository which has had changes occur within it.
>  	 */
>  	static void fireRepositoryChanged(final RepositoryMapping which) {
> -		final RepositoryChangeListener[] e =3D getRepositoryChangeListener=
s();
> -		for (int k =3D e.length - 1; k >=3D 0; k--)
> -			e[k].repositoryChanged(which);
> -	}
> -
> -	private static synchronized RepositoryChangeListener[] getRepositor=
yChangeListeners() {
> -		return repositoryChangeListeners;
> +		for (RepositoryChangeListener listener : repositoryChangeListeners=
)
> +			listener.repositoryChanged(which);

See anything wrong here, like that the Set can be modified while
GitProjectData's class lock is held, but its being read here without
any locking?

The array trick worked before because we always made a copy anytime
the array was modified.  So we could safely return the array to the
caller and let the caller iterate it unlocked; we just had to read
the current array using a synchronized method to ensure we had a
stable read.

You'll need to copy the Set somehow while inside of a synchronized
method, then return the copy to the fireRepositoryChanged() method
so it can iterate the copy to fire the events.

--=20
Shawn.
