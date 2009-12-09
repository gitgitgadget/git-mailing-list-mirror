From: Eric Wong <normalperson@yhbt.net>
Subject: Re: error: git-svn died of signal 13
Date: Tue, 8 Dec 2009 21:58:24 -0800
Message-ID: <20091209055824.GA22941@dcvr.yhbt.net>
References: <20091209053602.GA2739@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 06:58:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIFZG-0002NG-SV
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 06:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbZLIF6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 00:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbZLIF6S
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 00:58:18 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44725 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbZLIF6S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 00:58:18 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8451F1FA9D;
	Wed,  9 Dec 2009 05:58:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091209053602.GA2739@progeny.tock>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134940>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>=20
> Just wanted to pass on a few reports about git-svn dying with SIGPIPE
> when trying to fetch large repositories.  It seems to fetch a few
> revisions, then die; the repositories can eventually be fetched
> successfully by restarting 'git svn fetch' again and again.
>=20
> Some bug reporters have been very patient, but I don=E2=80=99t really=
 know
> where to look or ask in solving this.  Attempts at tracing so far hav=
e
> given either too little or too much information to make any sense.
>=20
> The problem goes back at least to v1.5.6.5.

Hi Jonathan,

Thanks for taking the time to look into this.  This has been a
problem for a long time and very difficult to track down.

One factor is that git svn continues happily afterwards so it's hard to
reproduce and there's less incentive to look for a fix.

> At the end of the git-svn process=E2=80=99s life, the last few functi=
on calls
> are these:
>=20
>  - SVN::Ra::Reporter::finish_report and related functions
>  - _p_apr_pool_t::DESTROY (libsvn-perl cleaning up, presumably)
>  - SVN::Ra::Callbacks::open_tmp_file, called from
>    SVN::_Ra::svn_ra_do_update, called from
>    Git::SVN::Ra::do_update, called from
>    Git::SVN::Ra::gs_do_update
>  - Git::SVN::_set_repos_root
>  - starting a 'git update-index -z --index-info' to feed commands to
>=20
> Maybe /tmp is filling up?  It is hard to know, since the SIGPIPE stop=
s
> everything and we do not get any nice, simple error message describin=
g
> what read or write would have received EPIPE.
>=20
> See <http://bugs.debian.org/526989>, <http://bugs.debian.org/540150>,
> <http://thread.gmane.org/gmane.comp.version-control.git/85868/>.
>=20
> Any insights?

Can somebody get an strace or core dump for the "git update-index"
call?  Or even an strace -f of the entire git svn invocation as well...

--=20
Eric Wong
