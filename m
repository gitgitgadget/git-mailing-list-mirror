From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] fdopen_lock_file(): access a lockfile using stdio
Date: Thu, 02 Oct 2014 11:29:22 +0200
Message-ID: <542D1AF2.8050508@web.de>
References: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu> <1412162089-3233-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershaus?= =?windows-1252?Q?en?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 11:29:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZchd-0005Ui-VU
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 11:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbaJBJ3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 05:29:33 -0400
Received: from mout.web.de ([212.227.15.14]:56866 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbaJBJ3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 05:29:32 -0400
Received: from billy.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MVcvn-1XjsTX3EtD-00YyFR; Thu, 02 Oct 2014 11:29:28
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <1412162089-3233-2-git-send-email-mhagger@alum.mit.edu>
X-Provags-ID: V03:K0:/XML/1fbtpOJCJ0WtvaWDqObjDyWVSrO1ZIvCPIkW0cHSYRoTUv
 pRsn+c8M623SAlRwWTF3xULSZMpKHO24vsCzzqG9agRf6FwiqMHcBP5uUXAK5zgkGJnLesj
 ayCmufM9zpyZYR/l090av8OWFrUzXW7KhhagzlZi+npB2ouRC5dvXjvGerZbl8BJA1009/F
 xgpfDlpV1RMFCvvZS5zOA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257796>


On 01.10.14 13:14, Michael Haggerty wrote:
[]
Nice done, small comments inline
> diff --git a/lockfile.c b/lockfile.c
> index d27e61c..e046027 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -7,20 +7,29 @@
>  
>  static struct lock_file *volatile lock_file_list;
>  
> -static void remove_lock_files(void)
> +static void remove_lock_files(int skip_fclose)
Even if the motivation to skip is clear now and here,
I would consider to do it the other way around,
and actively order the fclose():

static void remove_lock_files(int call_fclose)


>  {
>  	pid_t me = getpid();
>  
>  	while (lock_file_list) {
> -		if (lock_file_list->owner == me)
> +		if (lock_file_list->owner == me) {
> +			/* fclose() is not safe to call in a signal handler */
> +			if (skip_fclose)
> +				lock_file_list->fp = NULL;
>  			rollback_lock_file(lock_file_list);
> +		}
>  		lock_file_list = lock_file_list->next;
>  	}
>  }
>  
> +static void remove_lock_files_on_exit(void)
> +{
> +	remove_lock_files(0);
What does "0" mean ?

remove_lock_files(LK_DO_FCLOSE) ?

> +}
> +
>  static void remove_lock_files_on_signal(int signo)
>  {
> -	remove_lock_files();
> +	remove_lock_files(1);
And what does this "1" mean ?

remove_lock_files(LK_SKIP_FCLOSE) ?

We can even have an emum, or use #define
>
