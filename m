From: Sebastien Gross <seb-git@chezwam.org>
Subject: Re: sync() slowdown
Date: Mon, 26 May 2008 18:32:17 +0200
Message-ID: <20080526163217.GB3082@kali.thurne.chezwam.org>
References: <20080526142607.GA3082@kali.thurne.chezwam.org> <g1en6g$vuc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 18:33:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0fdM-0007tR-Kl
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 18:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbYEZQcX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 May 2008 12:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754500AbYEZQcW
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 12:32:22 -0400
Received: from thurne.chezwam.org ([82.245.152.156]:36099 "EHLO
	kali.thurne.chezwam.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753878AbYEZQcU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 12:32:20 -0400
Received: from sjg by kali.thurne.chezwam.org with local (Exim 4.69)
	(envelope-from <seb@chezwam.org>)
	id 1K0fcP-0002xL-Tg
	for git@vger.kernel.org; Mon, 26 May 2008 18:32:17 +0200
Content-Disposition: inline
In-Reply-To: <g1en6g$vuc$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82941>

On Mon, May 26, 2008 at 04:06:41PM +0000, kt-usenet@squeakydolphin.com =
wrote:
> On Mon, 26 May 2008 16:26:07 +0200, Sebastien Gross wrote:
>=20
> > I do understand that syncing filesystem is usefull and needed.
> >=20
> > But is there a good idea to add a --no-sync option to prevent that
> > behaviour ?
>=20
> Just a user here, but I would prefer it if it didn't sync at all.  If=
 I=20
> want to sync it, I will, or the operating system will handle it like =
it=20
> does with all other file accesses. =20

Well I guess I missed something in my explanation.

I do my backup to an usb stick (somewhere like /media/usb0) and I work
in git dirs (somewhere in /srv/git-repo). Obviously these 2 mount point=
s
are in different physical devices.

In a common run the system would sync cache and storage media when
needed.
But git (both prune and prune-packed command) call the sync() function
before pruning objects and packs:

builtin-prune-packed.c:

int cmd_prune_packed(int argc, const char **argv, const char *prefix)
=2E..
  sync();
  prune_packed_objects(opts);
  return 0;
}

The code is exactly the same in builtin-prune.c.

calling sync is a good way to be sure that no unsaved data remains in
ram and then everything would be included in the packs.

This must remain the default behaviour.

But in some case, sync() would also act on usb storage (which is my
case) and would be very slow.

I do repack a lot of repositories something such as:
for d in *.git; do cd $d; git repack -a -d; cd ..; done

In the same time if I use the usb stick to do some backup on it, it
would change all the time then sync() would flush a changed cache for
each call.

That's why I suggested to add a --no-sync option to bypass the sync()
call.

In any case this would be a dangerous option to not use unless you know
what you are doing.

Cheers


--=20
S=C3=A9bastien Gross
