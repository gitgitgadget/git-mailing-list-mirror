From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] pack-objects: Allow setting the #threads equal to
 #cpus automatically
Date: Tue, 12 Feb 2008 06:53:00 +0100
Message-ID: <47B1343C.8070405@op5.se>
References: <47B01FE7.8010207@op5.se> <47B10A9D.7000702@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 12 06:53:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOo5P-0004mY-Pt
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 06:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYBLFxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 00:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbYBLFxI
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 00:53:08 -0500
Received: from mail.op5.se ([193.201.96.20]:52415 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbYBLFxH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 00:53:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 3E4031F0884E;
	Tue, 12 Feb 2008 06:53:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V8rEp8E+mnct; Tue, 12 Feb 2008 06:53:03 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id BACC81F08048;
	Tue, 12 Feb 2008 06:53:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <47B10A9D.7000702@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73628>

Brandon Casey wrote:
> Allow pack.threads config option and --threads command line option to
> accept '0' as an argument and set the number of created threads equal
> to the number of online processors in this case.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> 
> 
> I was preparing this patch when I saw your email. I looked up your
> the old email you were talking about. Your function is better since
> it is cross platform.
> 
> When you redo your patch, you may want to adopt one aspect of this
> one. I used a setting of zero to imply "set number of threads to
> number of cpus". This allows the user to specifically set pack.threads
> in the config file to zero with the above mentioned meaning, or to
> override a setting in the config file from the command line with
> --threads=0. This is rather than having to delete the option from the
> config file.
> 

That make sense. Perhaps even go so far as to allow 'auto' as a
keyword would be nifty.

>  
> +#ifdef THREADED_DELTA_SEARCH
> +	if (!delta_search_threads) {
> +#if defined _SC_NPROCESSORS_ONLN
> +		delta_search_threads = sysconf(_SC_NPROCESSORS_ONLN);
> +#elif defined _SC_NPROC_ONLN
> +		delta_search_threads = sysconf(_SC_NPROC_ONLN);
> +#endif
> +		if (delta_search_threads == -1)
> +			perror("Could not detect number of processors");
> +		if (delta_search_threads <= 0)
> +			delta_search_threads = 1;
> +	}
> +#endif
> +

But this is not so good. For one thing you've dropped windows support
entirely. The last comment on my own patch was that get_num_active_cpus()
should live in a file of its own. You've taken one step back from that
and not even kept it in its own function.

I think perhaps it's time to introduce thread-compat.[ch] to deal with
thread-related cross-platform things like this.

I'll recook my patch and send it in a few minutes, using your suggestions
and Nicolas combined.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
