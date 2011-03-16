From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to
 itself
Date: Wed, 16 Mar 2011 15:49:30 +0100
Message-ID: <1300286976.7214.27.camel@bee.lab.cmartin.tk>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
	 <1300130318-11279-2-git-send-email-cmn@elego.de>
	 <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
	 <1300140128.4320.39.camel@bee.lab.cmartin.tk>
	 <7vpqptb976.fsf@alter.siamese.dyndns.org>
	 <1300190396.19100.31.camel@bee.lab.cmartin.tk>
	 <1300192832.19100.35.camel@bee.lab.cmartin.tk>
	 <7vd3lsb9m3.fsf@alter.siamese.dyndns.org>
	 <1300210062.19100.46.camel@bee.lab.cmartin.tk>
	 <AANLkTimQ81mwYhWLzGunimQzapEUkMmvKj47PuPWPgm0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:49:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzs2t-0006JF-6N
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 15:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab1CPOtm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 10:49:42 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:39869 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab1CPOtl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 10:49:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id B92411B4B01;
	Wed, 16 Mar 2011 15:49:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OaxLiETforba; Wed, 16 Mar 2011 15:49:35 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 2302E1B4B00;
	Wed, 16 Mar 2011 15:49:35 +0100 (CET)
In-Reply-To: <AANLkTimQ81mwYhWLzGunimQzapEUkMmvKj47PuPWPgm0@mail.gmail.com>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169160>

On mi=C3=A9, 2011-03-16 at 21:16 +0700, Nguyen Thai Ngoc Duy wrote:
> 2011/3/16 Carlos Mart=C3=ADn Nieto <cmn@elego.de>:
> > I've been changing this a bit, trying to make all the paths normali=
zed,
> > but it'll take a bit longer. I'll send a partial patch when I've
> > finished something worth seeing (for the moment, the test fail if t=
here
> > is a symlink somewhere in the tree, as I've mixed
> > real_path/make_absolute_path and absolute_path/make_nonrelative_pat=
h a
> > bit).
> >
> >  Is it a good idea to normalize the paths? Otherwise, everything co=
uld
> > be replaced by real_path/make_absolute_path (as most calls already =
are).
> > As it's transitive and these paths aren't stored permanently (other=
 than
> > with clone), as long as we agree on one representation, it should b=
e
> > fine.
>=20
> I think the question is whether it's _necessary_ to do that. Any gain=
?
> make_absolute_path() calls are not in critical path, I don't think we
> should bother much, unless there are bugs like one you fixed in your
> patch.

 I was under the wrong impression that non-normalized paths were what
was causing is_inside_dir not to recognize the paths (this with a patch
using non-resolved absolute paths as given by make_nonrelative_path
rather than make_absolute_path).
 As it turns out, getcwd resolves the links for us, so is_inside_dir
would say e.g. that /home/cmn/two/git/t wasn't under /home/cmn/two/git,
because getcwd said the cwd was /home/cmn/one/git (two is a symlink to
one).

 At any rate, I think make_absolute_path is mis-named and it should be
called real_path (or make_real_path). The difference between
make_nonrelative_path and make_absolute_path is certainly not clear
without looking at the implementation.

>=20
> >  Is there a performance hit if we resolve links all the time? If we=
 run
> > everything through normalize_path(_copy), is it slower than resolvi=
ng
> > links?
>=20
> What paths are you talking about? If they are inside $GIT_DIR, we
> touch them quite often. But there are not many of them (unless you
> spread loose objects all over the place), resolving links should not
> be an issue.

 There aren't in fact that many calls to these functions, so resolving
should be fine. More on this as an answer to your other mail.
