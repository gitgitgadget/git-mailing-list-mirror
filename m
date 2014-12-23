From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to
 warnings
Date: Tue, 23 Dec 2014 17:30:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412231723480.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de> <xmqqoarbidv7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
 <xmqqfvc78hwq.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222330080.21312@s15462909.onlinehome-server.info> <xmqqy4pz71g7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222348040.21312@s15462909.onlinehome-server.info>
 <xmqqlhlz6zti.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231051320.21312@s15462909.onlinehome-server.info> <xmqqr3vq49w5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 17:30:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3SLg-0004Oq-Et
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 17:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501AbaLWQaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 11:30:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:55280 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756189AbaLWQaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 11:30:08 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Ln8gj-1XOKEj2h8H-00hPRZ;
 Tue, 23 Dec 2014 17:30:04 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqr3vq49w5.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:4MZKNiGeRWE3XfXVFQur9ESV3rH2gaIqKoozIHk4Vfi6kZPt1v1
 B+K4mpJCsqEL7buRL1nqyKy/ez50OxC+a+MkNBpFSxF9Jpz6liBX1JTWtXXhIZg32JIt83P
 NpYrRdk+7M8rUElmJlfULmAeBqKATCKH38Tuy1qQJKJq9fd0uvD/fKcR8ApVg/mZdIfvlZe
 QSqpwoHlaV11xc2z3ZKJg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261737>

Hi Junio,

On Tue, 23 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > However, if we had to change the lookup such that it uses an array
> > always, we would have to introduce a function to initialize the
> > struct, always, in particular we would have to find a place to call
> > that initialization function in, say, builtin/fsck.c (actually, in
> > every code path that calls into the fsck machinery).
> 
> You would need to call a function to "initialize" the table if you
> support customization by reading the configuration files anyway.

Yes, this is the config machinery. But I need employ that only if I want
to let the caller customize the severity levels. However, the fsck
machinery is also called from places where such a customization is not
offered. They would now need to be changed, too.

> Also I suspect that you can tell the compiler to initialize the
> array in place with default values, perhaps like this?
> 
> -- >8 --
> #include <stdio.h>
> 
> /* sorted by the default severity (lowest impact first) */
> #define EVENT_LIST(F) \
> 	F(EVENT_A), \
> 	F(EVENT_B), \
> 	F(EVENT_C), \
> 	F(EVENT_D)
> 
> #define ID_(event) ID_ ## event
> enum event_id {
> 	EVENT_LIST(ID_)
> };
> 
> 
> enum severity_level {
> 	severity_info, severity_warn, severity_error
> };
> 
> /* below this one are INFO */
> #define FIRST_WARN_EVENT_ID		ID_EVENT_B
> /* below this one are WARN */
> #define FIRST_ERROR_EVENT_ID		ID_EVENT_C
> 
> #define STRING_(s) #s
> #define DESC_(event) \
> 	{ \
> 		ID_ ## event, \
> 		STRING_(event), \
> 		(ID_ ## event < FIRST_WARN_EVENT_ID \
> 		? severity_info \
> 		: ID_ ## event < FIRST_ERROR_EVENT_ID \
> 		? severity_warn \
> 		: severity_error) \
> 	}

This is exactly the ugly, ugly preprocessor construct I thought you would
meet with contempt. I mean, compared to this, my FUNC() hack is outright
pretty ;-)

And *still*, this is *just* a global table with defaults. I would *still*
need to copy-on-write when the first customization of the severity level
takes place because I cannot allow the global defaults to be modified by
one caller (that would defeat the whole purpose of having per-caller
settings bundled in the fsck_options struct).

You see, I still would need to have a lazy initialization, the complexity
in that part would not be reduced at all.

So I am afraid that this approach really adds complexity rather than
replacing it with something simpler than my current code.

Ciao,
Dscho
