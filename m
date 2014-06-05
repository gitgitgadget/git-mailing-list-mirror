From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [msysGit] [PATCH v2] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 05 Jun 2014 10:32:44 +0200
Message-ID: <53902B2C.7050807@web.de>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com> <20140605080317.GA28029@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>,
	Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 10:33:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsT6g-0007QA-Ku
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 10:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbaFEIcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 04:32:54 -0400
Received: from mout.web.de ([212.227.17.11]:59794 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbaFEIcw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 04:32:52 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lhedd-1WO45v2mOn-00mok3; Thu, 05 Jun 2014 10:32:46
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140605080317.GA28029@camelia.ucw.cz>
X-Provags-ID: V03:K0:x3UFKcePYAbnGSyUP/CH1wSUUfcUnfelrBqFXbGTcIdz+TeWpy3
 /kftAShz4ZXZAThd5EfzgwcIHaFwAAiK9r2PqpWcB2AvaRSCfDhH0gmzvwNK5lwJbZplpmE
 dH+KrO1Ywz3GEEKteMffDBTqT5dzPvW8uSv6PWqYNYyvK+GTa8M+DJ/DN5KPq9VLn2yel8r
 Pf2aAab+MpihFbbo+aNPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250825>

On 2014-06-05 10.03, Stepan Kasal wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Wed, 2 Jun 2010 00:41:33 +0200
> 
> If HOME is not set, use $HOMEDRIVE$HOMEPATH
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
> 
> Hello Karsten,
> thanks for your explanation.  There are more things to be done, but
> I hope you can ack this patch as a step forward.
> 
> Hello Dscho,
> I hope you can ack this as well: it is basically equivalent with your
> patch, tailored according to current upstream fashion,  ;-)
> 
> Stepan
> 
>  compat/mingw.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index a0e13bc..e108388 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1181,6 +1181,11 @@ char *mingw_getenv(const char *name)
>  		if (!result)
>  			result = getenv_cs("TEMP");
>  	}
> +	if (!result && !strcmp(name, "HOME")) {
> +		struct strbuf buf = STRBUF_INIT;
> +		strbuf_addf(&buf, "%s%s", getenv_cs("HOMEDRIVE"), getenv_cs("HOMEPATH"));
should we have a NULL pointer check here?
What happens if %HOMEPATH% is not set for any reason ?
getenv_cs will return NULL, and strbuf_addf() does not like that, as far as I know.
And even if it converts a NULL pointer into "<NULL>" or "NULL", the result is not what we want.
If HOMEDRIVE is set, but not HOMEPATH, we can fall back into the root of HOMEDRIVE:

	if (!result && !strcmp(name, "HOME")) {
		const char *homedrive = getenv_cs("HOMEDRIVE");
		const char *homepath = getenv_cs("HOMEPATH");
		if (!homepath)
			homepath = "";
        	if (homedrive) {
			struct strbuf buf = STRBUF_INIT;
			strbuf_addf(&buf, "%s%s", homedrive, homepath);
			result = strbuf_detach(&buf, NULL);
		}
	}
	return result;
}  
 
