From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 10/13] bash prompt: combine 'git rev-parse' executions
Date: Tue, 18 Jun 2013 02:05:35 -0400
Message-ID: <20130618060535.GE5916@sigill.intra.peff.net>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
 <1371521826-3225-11-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 18 08:05:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uop31-0000ZA-3e
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 08:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab3FRGFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 02:05:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:34464 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab3FRGFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 02:05:38 -0400
Received: (qmail 22873 invoked by uid 102); 18 Jun 2013 06:06:35 -0000
Received: from mobile-032-141-227-127.mycingular.net (HELO sigill.intra.peff.net) (32.141.227.127)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Jun 2013 01:06:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2013 02:05:35 -0400
Content-Disposition: inline
In-Reply-To: <1371521826-3225-11-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228157>

On Tue, Jun 18, 2013 at 04:17:03AM +0200, SZEDER G=C3=A1bor wrote:

> The whole series speeds up the bash prompt on Windows/MSysGit
> considerably.  Here are some timing results in two scenarios, repeate=
d
> 10 times:
>=20
> At the top of the work tree, before:
>=20
>     $ time for i in {0..9} ; do prompt=3D"$(__git_ps1)" ; done
>=20
>     real    0m1.716s
>     user    0m0.301s
>     sys     0m0.772s
>=20
>   After:
>=20
>     real    0m0.686s
>     user    0m0.075s
>     sys     0m0.287s
>=20
> In a subdirectory, during rebase, stash status indicator enabled,
> before:
>=20
>     real    0m3.557s
>     user    0m0.495s
>     sys     0m1.767s
>=20
>   After:
>=20
>     real    0m0.702s
>     user    0m0.045s
>     sys     0m0.409s

Very nice speedup (or perhaps it is a testament to how bad fork() is on
msys). Reading patches 8 and 9, I can't help but feel that "git status"
is letting us down a little by making us parse all of this data
ourselves. In theory, __git_ps1() could just be something like:

  eval "$(git status --shell)"
  printf ...

and the heavy lifting could be done in a single C process which does no=
t
have to worry about fork overhead. But that is quite far from where we
are now, so while it might be an interesting place to go in the future,
I do not think such dreams would want to hold up current work.

-Peff
