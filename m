From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] Fix gitdir detection when in subdir of gitdir
Date: Fri, 16 Jan 2009 17:47:39 +0100
Message-ID: <4970BA2B.7090807@viscovery.net>
References: <1232120253-1551-1-git-send-email-szeder@ira.uka.de> <alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 17:49:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNrss-0003eH-TN
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 17:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935252AbZAPQrq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 11:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1770085AbZAPQrp
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 11:47:45 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48865 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935187AbZAPQrn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2009 11:47:43 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LNrr9-0002SF-PJ; Fri, 16 Jan 2009 17:47:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 634146C4; Fri, 16 Jan 2009 17:47:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105974>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Fri, 16 Jan 2009, SZEDER G=C3=A1bor wrote:
>=20
>>   I'm not sure about setting an absolut path instead of a relative o=
ne=20
>>   (hence the RFC), although I think it should not make any differenc=
e.=20
>>   Of course I could have count the number of chdir("..") calls and t=
hen=20
>>   construct a "../../..", but that would have been more intrusive th=
an=20
>>   this two-liner.
>=20
> IIRC the absolute paths were shot down already... for performance rea=
sons.
>=20
> So we try very hard to keep relative paths instead of absolute ones.

This is a different matter.

The question is basically: How should git behave if $PWD is inside a ba=
re
repository? And if you are inside .git/refs, than for git this looks as=
 if
it were a bare repository.

The current behavior is that we chdir() up into .git, but do not set a
prefix. Nor do we chdir() back where we started after the discovery.

G=C3=A1bor's patch needs a better justification which misbehavior it tr=
ies to
fix, and the spot that it changes:

		if (is_git_directory(".")) {
			inside_git_dir =3D 1;
			if (!work_tree_env)
				inside_work_tree =3D 0;
			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
			check_repository_format_gently(nongit_ok);
			return NULL;
		}

needs a comment why it does what it does (and that this if-branch is on=
ly
about bare repositories).

-- Hannes
