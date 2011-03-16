From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to
 itself
Date: Wed, 16 Mar 2011 16:08:28 +0100
Message-ID: <1300288108.7214.37.camel@bee.lab.cmartin.tk>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
	 <1300130318-11279-2-git-send-email-cmn@elego.de>
	 <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
	 <1300140128.4320.39.camel@bee.lab.cmartin.tk>
	 <7vpqptb976.fsf@alter.siamese.dyndns.org>
	 <1300190396.19100.31.camel@bee.lab.cmartin.tk>
	 <1300192832.19100.35.camel@bee.lab.cmartin.tk>
	 <7vd3lsb9m3.fsf@alter.siamese.dyndns.org>
	 <AANLkTimvVd8VrAvcuT9Qww07-Gg1JtyA=+8nr4EeU0_D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 16:08:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzsL1-0008D9-IE
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 16:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931Ab1CPPIf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 11:08:35 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:42219 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1CPPId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 11:08:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id E68A51B4B01;
	Wed, 16 Mar 2011 16:08:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fnwjKiXv3Rxp; Wed, 16 Mar 2011 16:08:27 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 703641B4B00;
	Wed, 16 Mar 2011 16:08:27 +0100 (CET)
In-Reply-To: <AANLkTimvVd8VrAvcuT9Qww07-Gg1JtyA=+8nr4EeU0_D@mail.gmail.com>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169162>

On mi=C3=A9, 2011-03-16 at 21:04 +0700, Nguyen Thai Ngoc Duy wrote:
> On Wed, Mar 16, 2011 at 12:02 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
> > Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> >
> >> On mar, 2011-03-15 at 12:59 +0100, Carlos Mart=C3=ADn Nieto wrote:
> >>> On lun, 2011-03-14 at 15:58 -0700, Junio C Hamano wrote:
> >>> > Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> >> [...]
> >>> >
> >>> > >  There is however the extra functionality the function offers=
, namely
> >>> > > resolving links. It might be good to split it into two functi=
ons so each
> >>> > > caller can specify what it wants.
> >>> >
> >>> > Probably.
> >>>
> >>>  With the changes mentioned earlier, if you want an absolute path=
name,
> >>> you'd call absolute_path/make_nonrelative_path and if you want to=
 make
> >>> sure you have the real path of the target file, you'd use real_pa=
th just
> >>> as you'd use realpath on a sane system, with
> >>
> >>  ... a comment on the functions and maybe some documentation in
> >> Documentation/techncal, as it doesn't seem to exist yet.
> >
> > We probably should involve Nguy=E1=BB=85n in this thread as his fin=
gers are
> > everywhere on the codepaths related to setup.
>=20
> Thanks, my attempt to fix up setup code leaves more traces that I exp=
ect.
>=20
> Splitting functions is fine, but is there any use of
> absolute_path/make_nonrelative_path alone? Most setup code uses
> make_absolute_path() for $GIT_{DIR,WORK_TREE}. For GIT_DIR, a
> resolved/normalized path is preferred. For GIT_WORK_TREE, I'm not
> sure. I tend to treat it the same way as GIT_DIR, but you guys may
> have a special case.

 There only real use for absolute_path/make_nonrelative_path would be
for paths that are written to disk (as we should respect the user's pat=
h
preferences). For paths we never write out, real_path/make_absolute_pat=
h
makes sense.

 The way I want to split it up is to have real_path use a simplistic
approach, and use a resolve_link function if it needs to. From logging
what paths make_absolute_path is called with, all I could find were
directories ("." is used very often as well). This should make real_pat=
h
very easy to understand. I'll start a new thread with the renaming
patches and then split up the function.
