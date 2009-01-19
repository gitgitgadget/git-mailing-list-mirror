From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] Fix gitdir detection when in subdir of gitdir
Date: Mon, 19 Jan 2009 08:17:17 +0100
Message-ID: <497428FD.7050301@viscovery.net>
References: <1232120253-1551-1-git-send-email-szeder@ira.uka.de>	<alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de>	<4970BA2B.7090807@viscovery.net> <4970BAE5.8080006@viscovery.net>	<7vr63386rc.fsf@gitster.siamese.dyndns.org>	<7vhc3wuwxb.fsf@gitster.siamese.dyndns.org> <20090119020311.GA8753@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@fzi.de>
X-From: git-owner@vger.kernel.org Mon Jan 19 08:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOoPH-0005am-G8
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 08:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbZASHRW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 02:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbZASHRW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 02:17:22 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24364 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbZASHRW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 02:17:22 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LOoNo-0007QI-Ms; Mon, 19 Jan 2009 08:17:16 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 701BF6D9; Mon, 19 Jan 2009 08:17:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20090119020311.GA8753@neumann>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106330>

SZEDER G=E1bor schrieb:
>  		if (is_git_directory(".")) {
> +			char gd_rel_path[PATH_MAX];
>  			inside_git_dir =3D 1;
>  			if (!work_tree_env)
>  				inside_work_tree =3D 0;
> -			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
> +			if (cdup_count) {
> +				char *p =3D gd_rel_path;
> +				while (cdup_count-- > 1) {
> +					*p++ =3D '.'; *p++ =3D '.'; *p++ =3D '/';
> +				}
> +				*p++ =3D '.'; *p++ =3D '.';
> +				*p =3D '\0';
> +			} else {
> +				gd_rel_path[0] =3D '.';
> +				gd_rel_path[1] =3D '\0';
> +			}
> +			setenv(GIT_DIR_ENVIRONMENT, gd_rel_path, 1);
>  			check_repository_format_gently(nongit_ok);
>  			return NULL;
>  		}

This does not make sense because you don't chdir back to where you
started, so the relative path would be incorrect.

I have the feeling that it is not worth to support this particular
use-case with so many lines of code.

-- Hannes
