From: Pete Wyckoff <pw@padd.com>
Subject: Re: open files limit
Date: Fri, 12 Aug 2011 10:26:00 -0700
Message-ID: <20110812172600.GA15896@padd.com>
References: <20110812151548.GA14385@padd.com>
 <CAJo=hJsj8_VjD5wN9Gge_Me-eXKK-P7nLAxERiiLp0+ayiEBbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 19:26:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrvUk-0006Gf-U8
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 19:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab1HLR0D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Aug 2011 13:26:03 -0400
Received: from honk.padd.com ([74.3.171.149]:44458 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab1HLR0A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 13:26:00 -0400
Received: by honk.padd.com (Postfix, from userid 7770)
	id 0D6875B31; Fri, 12 Aug 2011 10:26:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJo=hJsj8_VjD5wN9Gge_Me-eXKK-P7nLAxERiiLp0+ayiEBbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179238>

spearce@spearce.org wrote on Fri, 12 Aug 2011 09:09 -0700:
> On Fri, Aug 12, 2011 at 08:15, Pete Wyckoff <pw@padd.com> wrote:
> > Somebody at $work found this problem:
> >
> > =A0 =A0$ git ls-files -s | wc
> > =A0 =A0error: packfile .git/objects/pack/pack-1627e77da82bbb3611876=
2649c8aa88c05664b1e.pack cannot be accessed
> > =A0 =A0[..lots more similar errors..]
> >
> > Turns out his shell's open file descriptor limit was 500. =A0And
> > there are 1600 pack files in the repo.
> >
> > Increasing the descriptor limit to 1024 fixed it. =A0I could
> > probably get him to repack, which may also fix it.
> >
> > Does it seem feasible to look for EMFILE errors and close
> > some packs? =A0Or at least spit out a more intuitive error?
>=20
> What version of Git? I remember fixing this already.... :-)

Initially 1.7.5.4.  Same problem on 1.7.6 and master. =20

I have your "Limit file descriptors used by packs" (c793430, 28
feb 2011).

It fails here:

	if (!is_pack_valid(p)) {
		error("packfile %s cannot be accessed", p->pack_name);
		goto next;
	}

because p->pack_fd is -1, because an earlier git_open_noatime()
got EMFILE.  The function unuse_one_window() is never able to
find anything to close.

I'll do some more debugging this weekend.  Thanks for pointing
out that it _should_ be fixed.

		-- Pete
