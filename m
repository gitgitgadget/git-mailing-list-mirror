From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Thu, 03 Jan 2008 01:45:14 +0100
Message-ID: <477C301A.9020001@lsrfire.ath.cx>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>	<Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>	<477BC2DA.6000105@lsrfire.ath.cx> <7v1w90xdpe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 01:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAEDh-0006si-R6
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 01:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbYACApe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 19:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754306AbYACApe
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 19:45:34 -0500
Received: from india601.server4you.de ([85.25.151.105]:58802 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbYACApd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 19:45:33 -0500
Received: from [10.0.1.201] (p57B7FA27.dip.t-dialin.net [87.183.250.39])
	by india601.server4you.de (Postfix) with ESMTP id 37A1B2F8037;
	Thu,  3 Jan 2008 01:45:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7v1w90xdpe.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69502>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> prefixcmp() was already optimized before -- only for a different use
>> case.  At a number of callsites the prefix is a string literal, whic=
h
>> allowed the compiler to perform the strlen() call at compile time.
>>
>> The patch increases the text size considerably: the file "git" is
>> 2,620,938 without and 2,640,450 with the patch in my build (there ar=
e
>> 136 callsites in builtin*.c).  The new version of prefixcmp() should=
n't
>> be inlined any more, as the benefit of doing so is gone.
>=20
> Yuck, you are absolutely right.  The late thread may have been
> well intentioned but resulted in this regression.  Sorry about
> that.
>=20
> I presume that all callers with constant prefix are outside
> performance critical parts?  Can we simply uninline the function
> in that case?

Most of them seem to be non-critical performance-wise.  They are part o=
f
code to parse parameters or config files.  Exceptions are the commit
message parsing code used for --pretty=3Dformat (which can't be an issu=
e
given that prefixcmp() was made the way it's now to speed up this code
path) and half of the callsites in fast-import.c.

Ren=C3=A9
