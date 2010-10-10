From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v3 01/14] mingw: add network-wrappers for daemon
Date: Sun, 10 Oct 2010 15:40:50 -0400
Message-ID: <4CB216C2.1060608@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com> <1286716854-5744-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 21:41:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P51lW-0000bB-88
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 21:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab0JJTk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 15:40:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44330 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab0JJTkz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 15:40:55 -0400
Received: by pzk34 with SMTP id 34so841631pzk.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=vz7b/gydSkhxnwD6FF/k1fInO/1zTTRt73OijnK0Cmc=;
        b=NLvSbJ3UHu3RQx6Yonf/otGEhJkvB93H3XsC37u6b4TISp1jZ41/tjZdF8vvoIB1tL
         Etq66uEwrgo9CvvI8mijVJZi/5K34rj4AUvzw37OA0rKFTtei/kiIel+HLcorZPCAaZN
         3qYfh9T7pwvdhwXxNdekQD1CoFQ/I5dbLSTPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Vu2stPCU8MO+aCOoCuijnbkX49zlY2+Xcx+7KdMDBJlAyi2T8gCn/VgFILRjtqsGzI
         OUkngVZmbKKKDoLHhvjWYGECtNW74CQSqRLQojM0jzmd6MrDctGoriTSqW0cXoU5BC8T
         vQuSWninYLVXOc+bVpVmR7fI8WWKOI4ksD/sA=
Received: by 10.114.66.8 with SMTP id o8mr6000869waa.215.1286739655134;
        Sun, 10 Oct 2010 12:40:55 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id r37sm11484613wak.23.2010.10.10.12.40.52
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 12:40:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <1286716854-5744-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158690>

On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
> From: Mike Pape<dotzenlabs@gmail.com>
>
> git-daemon requires some socket-functionality that is not yet
> supported in the Windows-port. This patch adds said functionality,
> and makes sure WSAStartup gets called by socket(), since it is the
> first network-call in git-daemon. In addition, a check is added to
> prevent WSAStartup (and WSACleanup, though atexit) from being
> called more than once, since git-daemon calls both socket() and
> gethostbyname().
>
> Signed-off-by: Mike Pape<dotzenlabs@gmail.com>
> Signed-off-by: Erik Faye-Lund<kusmabite@gmail.com>
> ---
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 6590f33..563ef1f 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> +#undef accept
> +int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
> +{
> +	int sockfd2;
> +
> +	SOCKET s1 = (SOCKET)_get_osfhandle(sockfd1);
> +	SOCKET s2 = accept(s1, sa, sz);
> +
> +	/* convert into a file descriptor */
> +	if ((sockfd2 = _open_osfhandle(s2, O_RDWR|O_BINARY))<  0) {
> +		closesocket(s2);
> +		return error("unable to make a socket file descriptor: %s",
> +			strerror(errno));

Is 'errno' from _open_osfhandle() still valid when handed to strerror() 
or has it been clobbered by closesocket()?

Corollary: Does _open_osfhandle() indeed set 'errno', or is it more 
appropriate to call WSAGetLastError()? (The documentation I read for 
_open_osfhandle() did not say anything about how to determine the reason 
for failure.)

-- ES
