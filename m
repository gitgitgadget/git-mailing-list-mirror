From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Add sideband status report to git-archive protocol
Date: Tue, 12 Sep 2006 16:44:12 -0700
Message-ID: <7vhczcejlf.fsf@assigned-by-dhcp.cox.net>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
	<45053BA2.6050502@innova-card.com>
	<7vzmd5eedk.fsf@assigned-by-dhcp.cox.net>
	<45066CFD.5040202@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 01:43:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNHuM-0001iO-RV
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 01:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWILXnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 19:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWILXnM
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 19:43:12 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:6863 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030383AbWILXnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 19:43:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060912234311.JPP12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Sep 2006 19:43:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Mbj01V00q1kojtg0000000
	Tue, 12 Sep 2006 19:43:01 -0400
To: Franck <vagabon.xyz@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26895>

Franck Bui-Huu <vagabon.xyz@gmail.com> writes:

>> I was uncomfortable letting waitpid() there to wait forever.
>> When does poll() return?  (1) we have data ready in which case
>> we process; (2) the child somehow closed the pipe but without
>> dying, which is an error in the child.  In the latter case even
>> not hanging in waitpid() and retrying the poll would not give
>> any useful input so that would not help either.
>
> your case (2) is not totaly right. If you look a the trace above,
> for the normal case, you can see that the child close the pipe then 
> _after_ a while die. So there's a time when the child is not died
> but the pipe is closed.
>
> I think it's safe to assume that if the child closes the pipe, either
> because it has finished to write or something wrong going on, then
> it's going to die pretty soon. 

I am essentially saying the same thing (and perhaps one more).
Something is wrong with the child, and either it's going to die
pretty soon in which case waitpid() to wait forever is fine, or
even if it is not going to die soon, going back to poll() would
not give us any useful information anyway, so WNOHANG was
pointless.

So we are in agreement.

> I think calling send_sideband() with sz = 0 should be fine,

I just coded it defensively -- no point calling send() when you
already know there is nothing to be sent.
