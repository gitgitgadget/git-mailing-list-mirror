From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 12:49:24 -0700
Message-ID: <7v7i92tzgb.fsf@gitster.siamese.dyndns.org>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com>
 <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>
 <48D8983C.7070506@op5.se>
 <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com>
 <48D8A97E.8070003@op5.se>
 <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com>
 <alpine.LNX.1.00.0809231216350.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mario Pareja <mpareja.dev@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Sep 23 21:51:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiDua-0002BE-5S
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 21:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbYIWTti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755539AbYIWTth
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 15:49:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46385 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbYIWTtg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 15:49:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E90E9641C1;
	Tue, 23 Sep 2008 15:49:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C2099641BB; Tue, 23 Sep 2008 15:49:27 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0809231216350.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 23 Sep 2008 13:32:15 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF62ECA8-89A8-11DD-BDD7-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96587>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I think the right tool on the git side is actually a "smudge/clean" 
> script. When you check something out, git converts it from the 
> repository-stored form to a working tree form using a script (if there is 
> one configured); this could check whether you've got the appropriate lock, 
> and make the file unwritable if you don't.

An obvious question is "how would such a script check the lock when you
are 30,000 ft above ground"; in other words, this "locking mechanism"
contradicts the very nature of distributed development theme.  The best
mechanism should always be on the human side.  An SCM auguments
inter-developer communication, but it is not a _substitute_ for
communication.

But if you limit the use case to an always tightly connected environment
(aka "not distributed at all"), I agree the above would be a very
reasonable approach.

Such a setup would need a separate locking infrastructure and an end user
command that grabs the lock and when successful makes the file in the work
tree read/write.  The user butchers the contents after taking the lock,
saves, and then when running "git commit", probably the post-commit hook
would release any relevant locks.

All these can be left outside the scope of git, as they can be hooked into
git with the existing infrastructure. Once a BCP materializes it could be
added to contrib/ just like the "paranoid" update hook.
