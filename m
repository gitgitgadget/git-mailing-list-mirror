From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Tue, 26 Sep 2006 22:09:10 -0700
Message-ID: <7vmz8lj3pl.fsf@assigned-by-dhcp.cox.net>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 07:09:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSRfX-0003Lx-4P
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 07:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965324AbWI0FJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 01:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbWI0FJM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 01:09:12 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:7159 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965324AbWI0FJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 01:09:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927050911.WQVS2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 01:09:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TH971V00a1kojtg0000000
	Wed, 27 Sep 2006 01:09:08 -0400
To: David Rientjes <rientjes@cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu> (David
	Rientjes's message of "Tue, 26 Sep 2006 20:11:32 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27873>

David Rientjes <rientjes@cs.washington.edu> writes:

> Again with the constant placement in a comparison expression.

I won't comment on this one.  See list archives ;-).

>>  		if (max_change < width)
>>  			;
>> +		else if (non_linear_scale) {
>> +			total = scale_non_linear(total, width, max_change);
>> +			add = scale_linear(add, total, add + del);
>> +			del = total - add;
>> +		}
>>  		else {
>>  			total = scale_linear(total, width, max_change);
>>  			add = scale_linear(add, width, max_change);
>> 
>
> if (...)
> 	;
> else if {
> 	...
> }
>
> is _never_ necessary.

What's happening here in this particular case is:

	if the changes fits within the alloted width
		; /* we do not have to do anything */
	else if we are using non-linear scale {
               	scale it like this
	}
	else {
               	scale it like that
	}

so the code actually matches the flow of thought perfectly well.

I first tried to write it without "if () ;/*empty*/ else" chain
like this:

	if given width is narrower than changes we have {
        	if we are doing non-linear scale {
                	scale it like this
                }
                else {
                	scale it like that
		}
	}


It made the indentation unnecessarily deep.
