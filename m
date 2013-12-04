From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC/WIP PATCH 0/4] less ignorance of submodules for
 ignore=all
Date: Thu, 5 Dec 2013 00:19:32 +0100
Message-ID: <20131204231932.GG7326@sandbox-ub>
References: <20131122215454.GA4952@sandbox-ub>
 <20131122220953.GI4212@google.com>
 <52910BC4.1030800@web.de>
 <20131124005256.GA3500@sandbox-ub>
 <52922962.3090407@web.de>
 <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
 <20131125174945.GA3847@sandbox-ub>
 <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
 <20131204221659.GA7326@sandbox-ub>
 <xmqq7gbkjlgx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Sharybin <sergey.vfx@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 00:19:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoLjL-0002nY-OC
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 00:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295Ab3LDXTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 18:19:40 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.104]:43601 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab3LDXTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 18:19:39 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VoLjB-0001O1-M5; Thu, 05 Dec 2013 00:19:33 +0100
Content-Disposition: inline
In-Reply-To: <xmqq7gbkjlgx.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238827>

On Wed, Dec 04, 2013 at 02:32:46PM -0800, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > This is my current work in progress. Sergey it would be awesome if you
> > could test these and tell me whether the behaviour is what you would
> > expect. Once that is settled I will add some tests and possibly clean up
> > some code.
> >
> > Since nobody spoke against this change of behavior I assume that we
> > agree on the general approach I am taking here. If not please speak up
> > now so we can work something out and save me implementation time ;-)
> >
> > Whats still missing is:
> 
> Before listing what's missing, can you describe what "the general
> approach" is?  After all, that is what you are assuming that has got
> a silent concensus, but without getting it spelled out, others would
> easily miss what they "agreed" to.

Definitely, sorry I missed that (isn't it obvious ;-)):

This series tries to achieve the following goals for the
submodule.<name>.ignore=all configuration or the --ignore-submodules=all
command line switch.

 * Make git status never ignore submodule changes that got somehow in the
   index. Currently when ignore=all is specified they are and thus
   secretly committed. Basically always show exactly what will be
   committed.

 * Make add ignore submodules that have the ignore=all configuration when
   not explicitly naming a certain submodule (i.e. using git add .).
   That way ignore=all submodules are not added to the index by default.
   That can be overridden by using the -f switch so it behaves the same
   as with untracked files specified in one of the ignore files except
   that submodules are actually tracked.

 * Let diff always show submodule changes between revisions or
   between a revision and the index. Only worktree changes should be
   ignored with ignore=all.

 * Generally speaking: Make everything that displays diffs in history,
   diffs between revisions or between a revision and the index always
   show submodules changes (only the commit ids) even if a submodule is
   specified as ignore=all.

 * If ignore=all for a submodule and a diff would usually involve the
   worktree we will show the diff of the commit ids between the current
   index and the requested revision.

> I do think that it is a good thing to make what "git add ." does and
> what "git status ." reports consistent, and "git add ." that does
> not add everything may be a good step in that direction (another
> possible solution may be to admit that ignore=all was a mistake and
> remove that special case altogether, so that "git status" will
> always report a submodule that does not match what is in the HEAD
> and/or index).

I think it was too early to add ignore=all back then when the ignoring
was implemented. We did not think through all implications. Since people
have always been requesting the floating model and as it seems started
using it I am not so sure whether there is not a valid use case. Maybe
Sergey can shed some light on their actual use case and why they do not
care about the precise revision most of the time.

For example the case that all developers always want to work with some
HEAD revision of all submodules and the build system then integrates
their changes on a regular basis. When all went well it creates commits
with the precise revisions. This way they have some stable points as
fallback or for releases. Thats at least the use case I can think of but
maybe there are others.

Cheers Heiko
