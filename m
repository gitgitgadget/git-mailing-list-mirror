From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <carlos@cmartin.tk>
Subject: Re: [PATCH] format-patch: don't pass on the --quiet flag
Date: Wed, 13 Apr 2011 11:26:20 +0200
Message-ID: <20110413092620.GA3649@bee.lab.cmartin.tk>
References: <7v8vvgv5dm.fsf@alter.siamese.dyndns.org>
 <4DA36D95.6060108@windriver.com>
 <1302622538-7535-1-git-send-email-cmn@elego.de>
 <7vk4ezpacr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 11:26:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9wLE-0007oW-GL
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 11:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757972Ab1DMJ0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 05:26:23 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:60925 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab1DMJ0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 05:26:22 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id D78C54612C;
	Wed, 13 Apr 2011 11:26:07 +0200 (CEST)
Received: (nullmailer pid 10437 invoked by uid 1000);
	Wed, 13 Apr 2011 09:26:20 -0000
Content-Disposition: inline
In-Reply-To: <7vk4ezpacr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171436>

On Tue, Apr 12, 2011 at 11:56:20AM -0700, Junio C Hamano wrote:
> Carlos Mart=EDn Nieto <cmn@elego.de> writes:
>=20
> >> A patch to make --quiet not to squelch the patch output, and inste=
ad
> >> silence any progress output would be a good addition.
> >
> > Something like this? I guess the only use case would be together wi=
th
> > -o.
>=20
> When the user gives -q without giving -o to a new or an empty directo=
ry,
> the user deserves to get what was asked on the command line, so I wou=
ldn't
> worry about this particular case.  For a casual user, it is perfectly=
 a
> sensible thing to say "I'll eyeball; I don't have other files whose n=
ames
> begin with [0-9]{4}- in my working tree" and I don't think we need sa=
fety
> against doing that.
>=20

 Agreed.

> I however wonder if we should audit other commands in the "log" famil=
y to
> see what they do when "--quiet" is given.  I know what they do curren=
tly
> is whatever they happen to do for a nonsense request, and in no way i=
s a
> designed behaviour.  We simply did never think about that case.
>=20
> For example, what should "git show master^2 next^2" do with "--quiet"=
?  Of
> course the standard way to squelch diff output in the output from "sh=
ow"
> is to use "-s" (coming from "git diff-tree"), but giving "--quiet" sh=
ould
> at least be a no-op.
>=20

 We get a similar effect to format-patch, and a line disappears

    carlos@bee:~/apps/git$ git show --oneline origin/master^2 origin/ne=
xt^2
    9973d93 t2021: mark a test as fixed
    diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overw=
rite.sh
    index 27db2ad..5da63e9 100755
    --- a/t/t2021-checkout-overwrite.sh
    +++ b/t/t2021-checkout-overwrite.sh
    @@ -39,7 +39,7 @@ test_expect_success SYMLINKS 'create a commit whe=
re dir a/b changed to symlink'
	[...] Diff here
    9db1941 Merge branch 'js/checkout-untracked-symlink'

and

    carlos@bee:~/apps/git$ git show --oneline --quiet origin/master^2 o=
rigin/next^2
    9973d93 t2021: mark a test as fixed

so we certainly should catch it.

I'm not so sure what we should do with it, though. We shouldn't
squelch all the output, because then it just makes the command useless
(though I guess the user asked for it in that case). Maybe making it
behave like a --no-diff option would make sense (i.e. pretend the user
passed -s) in order to make it behave like a prettier version of
rev-parse.

Looking at the other cmd_ functions in builtin/log.c I see:
 - reflog ignores it
 - cherry complains that it doesn't know about the option
 - log -p --quiet is the same as log
 - whatchanged --quiet shows the same as log but skips every second
   commit
 - show --quiet skips one of the commits

and I don't see any others, so whatchanged should be tought not to
skip the commits. I'll what cmd_log does differently from
cmd_whatchanged when passing options.

   cmn
