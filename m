From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: Re: tig show <commit> not working anymore?
Date: Sat, 18 Sep 2010 00:01:22 -0500
Message-ID: <20100918050122.GA24656@bluemoon.alumni.iitm.ac.in>
References: <20100916125337.GG5785@bowser.ece.utexas.edu>
 <4C922112.404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonas Fonseca <fonseca@diku.dk>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 07:01:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwpYK-0001Zw-KJ
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 07:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab0IRFB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 01:01:27 -0400
Received: from irongate.mail.utexas.edu ([146.6.25.6]:13357 "EHLO
	irongate.mail.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab0IRFB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 01:01:26 -0400
X-IronPort-MID: 55544528
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao0GAGrkk0yAU36K/2dsb2JhbACUPo1zccJqhUAEhEw2
Received: from wb3-a.mail.utexas.edu ([128.83.126.138])
  by irongate.mail.utexas.edu with ESMTP; 18 Sep 2010 00:01:24 -0500
Received: (qmail 24085 invoked from network); 18 Sep 2010 05:01:24 -0000
Received: from cpe-24-27-28-128.austin.res.rr.com (HELO bluemoon.WORKGROUP) (a.kumar@24.27.28.128)
  by wb3.mail.utexas.edu with (RC4-SHA encrypted) ESMTPSA; 18 Sep 2010 05:01:24 -0000
Received: from kumar by bluemoon.WORKGROUP with local (Exim 4.72)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)
	id 1OwpYA-000792-PY; Sat, 18 Sep 2010 00:01:22 -0500
Mail-Followup-To: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>,
	Michael J Gruber <git@drmicha.warpmail.net>
Content-Disposition: inline
In-Reply-To: <4C922112.404@drmicha.warpmail.net>
X-OS: Linux bluemoon 2.6.32-5-amd64 x86_64
X-Operating-System: Linux bluemoon 2.6.32-5-amd64 x86_64
X-Editor: GNU Emacs 22.3.1
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156429>

On Thu, Sep 16, 2010 at 03:52:18PM +0200, Michael J Gruber wrote:
> > I observed that, since commit
> > 53c089443cd9885fa677becee4bf7ffd56c3c357, tig show <commit> doesn't
> > seem to work the same way as I had expected it to. The documentatio=
n
> > update doesn't seem to indicate that this was to be expected (or I
> > didn't understand it properly). Could someone please confirm that
> > tig show <commit> should actually do something similar to git show =
<commit> | tig ?
>=20
> It seems that since that tig commit, "tig show <commit>" shows HEAD
> rather than <commit>. OTOH, "tig <commit>" does navigate to <commit>.
>=20
> The reason is that tig passes %(commit), not %(revargs), to git show =
for
> the "show" subcommand, but the obvious simple patch breaks diff view.=
 I
> guess somewhere in the codepath one has to differentiate between thos=
e.
> cc'ing Mr. Tig...

Please bear in mind that I am totally new to the code, and not a power
user of git either. So please don't club me! ;-)

Well, I was exploring the code a little, and I could not understand
some aspects fully. First, I discovered that the following hack fixes
the problem to an extent:

diff --git a/tig.c b/tig.c
index e0e812c..aa38e71 100644
--- a/tig.c
+++ b/tig.c
@@ -7864,7 +7864,7 @@ parse_options(int argc, const char *argv[])

        if (filter_argv)
                filter_options(filter_argv);
-
+       if (!strcmp(subcommand, "show") && opt_rev_args && opt_rev_args=
[0]) { string_copy_rev(ref_commit, opt_rev_args[0]); }
        return request;
 }

However, I am pretty certain that that is not the intended use of
opt_rev_args and ref_commit, and that they should be used in a
different way. For example, tig show HEAD^^^..HEAD should show me
three commits combined, but it shows me only one, since I haven't run
it through rev-list or the like=B8 probably.

I'll continue to try getting at a fix, unless someone comes to it
before me.

Thanks!

Kumar
