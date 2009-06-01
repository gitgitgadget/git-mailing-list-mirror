From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http*: cleanup slot->local after fclose
Date: Mon, 01 Jun 2009 09:13:16 -0700
Message-ID: <7vws7wkk4j.fsf@alter.siamese.dyndns.org>
References: <49F1EA6D.8080406@gmail.com> <20090530091755.GA13578@localhost>
	<be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com>
	<20090530093717.GA22129@localhost>
	<be6fef0d0905300352o33694420m9c988daa554420a3@mail.gmail.com>
	<20090530230153.527532b0.rctay89@gmail.com>
	<20090531000955.953725d9.rctay89@gmail.com>
	<7vy6sdssnk.fsf@alter.siamese.dyndns.org>
	<20090531175413.962a55c3.rctay89@gmail.com>
	<7vws7xqazi.fsf@alter.siamese.dyndns.org>
	<be6fef0d0906010652v4fc814f9j631795cbad61be9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 18:26:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBAL6-0005SJ-A4
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 18:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbZFAQ0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 12:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbZFAQ0L
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 12:26:11 -0400
Received: from fed1rmpop112.cox.net ([68.230.241.16]:60773 "EHLO
	fed1rmpop112.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbZFAQ0K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 12:26:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090601161316.TTBM2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 1 Jun 2009 12:13:16 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id ygDG1b00M4aMwMQ04gDGFG; Mon, 01 Jun 2009 12:13:16 -0400
X-Authority-Analysis: v=1.0 c=1 a=n6gMUD2reQ4A:10 a=OUZzaqIY_TkA:10
 a=pGLkceISAAAA:8 a=qjrwCw2FKjMWDySdPNcA:9 a=_b-vx9-eiL84qrgw6VCO7IYrLDQA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120475>

Tay Ray Chuan <rctay89@gmail.com> writes:

> the problem isn't triggered by fclose(slot->local) being done twice,
> but a ftell() being done on slot->local, which points to a FILE*
> handle that has already been fclose()'d (that is what the valgrind log
> provided by Clemens reported). The offending ftell() is found in
> http.c::run_active_slot(), and the code there does indeed depend on
> the NULLness of slot->local (it checks whether slot->local is NULL
> before doing the ftell()).
>
> run_active_slot() is used rather heavily, and users of slot->local
> always neglect to set it to NULL doing a fclose() on the FILE* handle
> it points to.

Thanks; that clearly indicates that you are fixing an existing bug.

I wish the commit log message explained that from the beginning without
being asked.

So what would we want to do?

No patch from your http-push topic is in 'next' yet, and I presume that
the same issue exists in 'maint', so I'd say:

 (0) queue your slimmed down fix to 'maint' (or rc/maint-http-local-slot-fix
     that is forked from 'maint', to later merge to 'maint');

 (1) create a new rc/http-push topic branch from 'master';

 (2) merge (0) into the result of (1);
 
 (3) re-apply the patches queued on the current rc/http-push topic on top
     of the result of (2).

to rebuild it, perhaps?
