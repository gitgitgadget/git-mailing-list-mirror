From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] fix start_command() bug when stdin is closed
Date: Mon, 25 Aug 2008 15:12:34 +0200
Message-ID: <48B2AFC2.20901@viscovery.net>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 15:16:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXbt9-00062J-Ar
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 15:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbYHYNMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 09:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbYHYNMi
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 09:12:38 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16129 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbYHYNMi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 09:12:38 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KXbs3-0000xF-5l; Mon, 25 Aug 2008 15:12:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D19684FB; Mon, 25 Aug 2008 15:12:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <E1KXawS-0001gg-Ty@fencepost.gnu.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93619>

Paolo Bonzini schrieb:
> There is a problem in the use of dup2+close in start_command()
> when one or more of file descriptors 0/1/2 are closed.

"Karl Chen pointed out a problem..." (just to give due credit).

>  int start_command(struct child_process *cmd)
>  {
>  	int need_in, need_out, need_err;
>  	int fdin[2], fdout[2], fderr[2];
>  
>  	/*
> +	 * Make sure that all file descriptors <= 2 are open, otherwise we
> +	 * mess them up when dup'ing pipes onto stdin/stdout/stderr.  Since
> +	 * we are at it, open a file descriptor on /dev/null to use it later.
> +	 */
> +	if (devnull_fd == -1)
> +	  {
> +	    devnull_fd = open("/dev/null", O_RDWR);
> +	    while (devnull_fd >= 0 && devnull_fd <= 2)
> +	      devnull_fd = dup(devnull_fd);
> +	    if (devnull_fd == -1)
> +	      die("opening /dev/null failed (%s)", strerror(errno));
> +	  }

Except for the insane GNU style indentation ;-) this makes a lot of sense.

Acked-by: Johannes Sixt <johannes.sixt@telecom.at>

The changes to the MINGW32 section are good (they pass the test suite).
Thanks for taking care of that.

-- Hannes
