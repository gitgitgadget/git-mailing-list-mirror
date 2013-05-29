From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 09:13:46 -0400
Message-ID: <20130529131346.GA28198@hmsreliant.think-freely.org>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
 <1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
 <20130528110014.GA1264@hmsreliant.think-freely.org>
 <7vobbv2fze.fsf@alter.siamese.dyndns.org>
 <51a568db9c9b8_807b33e18996fa@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:14:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgCV-0001Ev-5l
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966118Ab3E2NNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:13:55 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:38738 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934233Ab3E2NNy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:13:54 -0400
Received: from 99-127-245-201.lightspeed.rlghnc.sbcglobal.net ([99.127.245.201] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1UhgCK-00020l-La; Wed, 29 May 2013 09:13:50 -0400
Content-Disposition: inline
In-Reply-To: <51a568db9c9b8_807b33e18996fa@nysa.mail>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225809>

On Tue, May 28, 2013 at 09:32:59PM -0500, Felipe Contreras wrote:
> Junio C Hamano wrote:
> > Neil Horman <nhorman@tuxdriver.com> writes:
> > 
> > > On Mon, May 27, 2013 at 11:52:18AM -0500, Felipe Contreras wrote:
> > >> We should free objects before leaving.
> > >> 
> > >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > >> ---
> > >>  sequencer.c | 7 +++++--
> > >>  1 file changed, 5 insertions(+), 2 deletions(-)
> > >> 
> > >> diff --git a/sequencer.c b/sequencer.c
> > >> index ab6f8a7..7eeae2f 100644
> > >> --- a/sequencer.c
> > >> +++ b/sequencer.c
> > >> @@ -626,12 +626,15 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
> > >>  		rerere(opts->allow_rerere_auto);
> > >>  	} else {
> > >>  		int allow = allow_empty(opts, commit);
> > >> -		if (allow < 0)
> > >> -			return allow;
> > >> +		if (allow < 0) {
> > >> +			res = allow;
> > >> +			goto leave;
> > >> +		}
> > >>  		if (!opts->no_commit)
> > >>  			res = run_git_commit(defmsg, opts, allow);
> > >>  	}
> > >>  
> > >> +leave:
> > >>  	free_message(&msg);
> > >>  	free(defmsg);
> > >>  
> > >> -- 
> > >> 1.8.3.rc3.312.g47657de
> > >> 
> > >> 
> > > Acked-by: Neil Horman <nhorman@tuxdriver.com>
> > 
> > This is better done without "goto" in general.
> > 
> > The other patch 2/2/ adds one more "we need to exit from the middle
> > of the flow" and makes it look handier to add an exit label here,
> > but it would be even better to express the logic of that patch as a
> > normal cascade of if/else if/..., which is small enough and we do
> > not need the "leave:" label.
> 
> Linux kernel developers would disagree. In C 'goto' is quite of then the only
> sane option, and you can see 'goto' used in the Linux kernel all over the place
> for that reason.
> 
> In this particular case it also makes perfect sense.
> 
I agree with Felipe here.  Setting asside coding practice in other projects,
while its nice to follow coding convention in a project, a jump label just makes
more sense here.  To not use it either requires you to duplicate the free
statements (undesireable), or to change the sense of theif clause here and nest
your if statements (makes for ugly reading).

> > It probably is better to fold this patch into the other one when it
> > is rerolled to correct the option name gotcha "on the tin".
> 
> Why? This patch is standalone and fixes an issue that is independent of the
> other patch. Why squash two patches that do *two* different things?
> 
I agree here as well.  This fixes a bug that has nothing to do with the other
patch, save for it being in the same C file.  Fix them separately.

> Anyway, I'll happily drop this patch if you want this memory leak to remain.
> But then I'll do the same in the other patch.
> 
> This mantra of avodiing 'goto' is not helping anybody.
> 
> -- 
> Felipe Contreras
> 
