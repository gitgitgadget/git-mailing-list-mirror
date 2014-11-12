From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Clean stale environment pointer in
 finish_command()
Date: Wed, 12 Nov 2014 11:45:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411121142480.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <cover.1415630072.git.johannes.schindelin@gmx.de> <df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.1411101539091.13845@s15462909.onlinehome-server.info>
 <20141111031636.GE21328@peff.net> <xmqqr3x97mv4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 11:45:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoVQa-0001Qa-Lw
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 11:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbaKLKp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 05:45:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:62606 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbaKLKpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 05:45:25 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LzbXq-1Y1JA23bta-014ogo;
 Wed, 12 Nov 2014 11:45:20 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqr3x97mv4.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:mYVQJ8SC4WCSBIfy/ZpIKzZjWfW36/Fvuw4LOLvLtptqttIk5TV
 lAQeTqrfqtRkkGM+GasNt9OLKBSOxXcuoPq7sCjBq3ILCF+4CgGQ2jD5yfzeNYzFGnXJ3L7
 pZiz3XhbIWYQ3JLOk9QsNizo8zoZksdzDpfLgYwkG8RKMr0X883tMAzt51RC0/aEWApKFTL
 bjG5vOeiJ3OKsW/1QzJJA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 11 Nov 2014, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't think this is "unfortunately"; freeing the memory was the entire
> > purpose in adding env_array. If you want to easily reuse the same
> > environment in multiple commands, it is still perfectly fine to use
> > "env" directly, like:
> >
> >   struct argv_array env = ARGV_ARRAY_INIT;
> >   struct child_process one = CHILD_PROCESS_INIT;
> >   struct child_process two = CHILD_PROCESS_INIT;
> >
> >   ... setup env with argv_array_push ...
> >
> >   one.argv = foo;
> >   one.env = env.argv;
> >   run_command(&one);
> >
> >   two.argv = bar;
> >   two.env = env.argv;
> >   run_command(&two);
> >
> >   argv_array_clear(&env);
> >
> > You do not get the benefit of the auto-cleanup (you have to call
> > argv_array_clear yourself), but that is less bad than repeating the
> > setup of "env" twice.
> 
> Yeah, the above looks like the best option, better than using a
> single child_process and having to re-initialize fds and envs.

Okay, I have to say that I was led to believe that reusing the
child_process struct is okay because argv_array_clear() explicitly
reinitializes the env_array field, something that is useless churn unless
you plan to reuse the memory.

However, my personal taste says that reusing the same memory is more
elegant than to waste extra memory unnecessarily, so I will go with the
child_process_init() solution.

Ciao,
Dscho
