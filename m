From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/15] daemon: use run-command api for async serving
Date: Thu, 21 Oct 2010 19:10:10 -0500
Message-ID: <20101022001010.GB13779@burratino>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
 <1287705944-5668-7-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com, schwab@linux-m68k.org,
	patthoyts@gmail.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 02:14:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P95Gq-00064V-UN
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 02:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab0JVAN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 20:13:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39981 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0JVAN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 20:13:57 -0400
Received: by ywk9 with SMTP id 9so201312ywk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zbuN9nMNMAH/Allg2ovipCTPNa3A7EEJuF0EBJd52JQ=;
        b=P28YA+LJxqixuALJhkgLgPczfBDzpF+SUX3oe6DxvvTy2P/3O1zAB80WbMg07piRsA
         5/SchwEC2xbaX026ezTN+o5zu0ry/v1dIt0KYEVEX5ecyywFAzmhyqIILEut750zNQmI
         aBG4Ndm/ZM/Rxw11eA8ECnZvyfWFB2Mj2eNrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GfKY1DFa0Qa+kwuYeZCw/hNZTR8fr2J4mjHvQ5P8on3FG5liUJ5bOkXmjhdDSlNVEC
         iNKrRxyb+GOIR7CaFVasXjyurcZW+ecz6kFqDgtr0zavLqY983WZzHMGXltXhDNUAYr6
         aE6oa8Gmms41WVr6pCCz++TbKB/DZrV+RIBRA=
Received: by 10.150.198.8 with SMTP id v8mr2029072ybf.115.1287706436381;
        Thu, 21 Oct 2010 17:13:56 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v12sm2830222ybk.23.2010.10.21.17.13.54
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:13:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287705944-5668-7-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159608>

Erik Faye-Lund wrote:

> --- a/daemon.c
> +++ b/daemon.c
[...]
> @@ -671,18 +658,26 @@ static void check_dead_children(void)
>  	int status;
>  	pid_t pid;
> =20
> -	while ((pid =3D waitpid(-1, &status, WNOHANG)) > 0) {
> +	struct child **cradle, *blanket;
> +	for (cradle =3D &firstborn; (blanket =3D *cradle);)
> +		if ((pid =3D waitpid(blanket->cld.pid, &status, WNOHANG)) > 1) {

What is this change (> 0 =E2=86=92 > 1) about?
