From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add git-grep threads-num param
Date: Fri, 23 Oct 2015 15:40:53 -0700
Message-ID: <xmqqbnbpnr7u.fsf@gitster.mtv.corp.google.com>
References: <1445591717-5998-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Victor Leschuk <vleschuk@accesssoftek.com>
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 00:41:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zpl1K-0002GR-Tx
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 00:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbbJWWlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 18:41:04 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752209AbbJWWlB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 18:41:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 434D425D20;
	Fri, 23 Oct 2015 18:40:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=YX28oEtrBlyPhWC+9MGV7TbNIEQ=; b=Wt0QUKevMLn3A1u92Air
	zacRrcI6wGLvHucOh+eOYBOi52fHo6S+pLS9G8rL/JG2NSV+BCzTHxuuPe5nfBSk
	sbGYruZHq+dy7bVrXx9496dBzqjl95OnzqIewrnNbhg77RuVCjRWdsq1JfBIqTtU
	PXjc/Lb3TETYexh4B47ZzYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=EJOuev68yppq4h3/AhvtfDgz7nbzRwFvPdf7kY/7KaHYji
	pSKndaBrNgU1e6MyTFr55NRjEKKdL+c1/3m25N43kMoM9lp7XfA9vKgAqkW8OFQz
	0I3Ld5Y93OgWprRG6LmsUfbTpDcC5MA3gVA+3HlmhR2BI+DPt7yhnTiuooJAs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3998F25D1D;
	Fri, 23 Oct 2015 18:40:55 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B7E5425D1C;
	Fri, 23 Oct 2015 18:40:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1EE11436-79D7-11E5-B8C5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280110>

Please pay attention to your title.  It no longer matches what the
patch does.

It may also be beneficial to study recent titles and log messages
from other developers (you can find them in "git log --no-merges"
and "git shortlog --no-merges") and learn and imitate their format,
style and tone.  We want our log to tell a story in a consistent
voice, no matter who the authors of individual commits are.

Victor Leschuk <vleschuk@gmail.com> writes:

> It's a follow up to "[PATCH] Add git-grep threads-num param":

Do you think anybody wants to see this line in the output from "git
log" six months from now?  I doubt it.  The previous one will not be
committed to my tree anyway, so the readers would not know (nor
care) what other patch you are talking about.

> @@ -832,7 +836,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	}
>  
>  #ifndef NO_PTHREADS
> -	if (list.nr || cached || online_cpus() == 1)
> +	if (list.nr || cached || online_cpus() == 1 || opt.num_threads <= 1)
>  		use_threads = 0;

This avoid --threads=0 to take the threading codepath and spawning
no threads, which would have happend in the previous patch.

But it makes me wonder if the logic should be more like this:
    
 - Because the code is not prepared to go multi-thread when
   searching in the object data (not working tree), we always
   disable threading if 'list' is not empty or 'cached' is given;
   otherwise

 - If the user explicitly said that she wants N threads, we use that
   many threads; otherwise

 - If there is only one CPU, we do not do multi-thread; otherwise

 - We use the default number of threads.

IOW, I'd suggest making opt.num_threads an "int" (not "unsigned"),
initialize it to -1 (unspecified), and then make this part more like
this, perhaps?

	if (!opt.num_threads)
        	use_threads = 0; /* the user tells us not to use threads */
	else if (list.nr || cached)
        	use_threads = 0; /* cannot multi-thread object lookup */
	else if (opt.num_threads >= 1)
		use_threads = 1; /* the user explicitly wants this many */
	else if (online_cpus() <= 1)
        	use_threads = 0;
	else {
        	use_threads = 1;
                opt.num_threads = GREP_NUM_THREADS_DEFAULT;
	}

Something like this code structure makes it very clear what needs to
be changed when we want to add some sort of auto-scaling (instead of
assigning the DEFAULT constant, you'd see how many cores you have,
how many files you will be grepping in, etc. and come up with a good
number dynamically).

> @@ -150,6 +159,8 @@ void grep_init(struct grep_opt *opt, const char *prefix)
>  	opt->pathname = def->pathname;
>  	opt->regflags = def->regflags;
>  	opt->relative = def->relative;
> +	if(!opt->num_threads)

You forgot a required SP between a keyword for a syntactic construct
and its open parenthesis.

Thanks.
