From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: run-command: output owner picking strategy
Date: Fri, 20 May 2016 20:29:20 +0200 (CEST)
Message-ID: <390486239.5813961.1463768960439.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <906110267.5791524.1463748828183.JavaMail.zimbra@ensimag.grenoble-inp.fr> <401208017.5792558.1463749910970.JavaMail.zimbra@ensimag.grenoble-inp.fr> <CAGZ79kZ1LTF4h_WVV9mMCAQCVtH667GU011LiRNtkTmi9ygUYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 20 20:22:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3p4X-0001lW-IB
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 20:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbcETSWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 14:22:49 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:58184 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750893AbcETSWt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2016 14:22:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 32377253C;
	Fri, 20 May 2016 20:22:45 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qs28iHnakAhY; Fri, 20 May 2016 20:22:45 +0200 (CEST)
Received: from zm-int-mbx5.grenet.fr (zm-int-mbx5.grenet.fr [130.190.242.144])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 2108B252D;
	Fri, 20 May 2016 20:22:45 +0200 (CEST)
In-Reply-To: <CAGZ79kZ1LTF4h_WVV9mMCAQCVtH667GU011LiRNtkTmi9ygUYw@mail.gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: run-command: output owner picking strategy
Thread-Index: IMuv+mGj9QIUnC7u593drCcsTpNI/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295201>

> When running in parallel we already may be out of order
> (relative to serial processing). See the second example in the
> commit message to produce a different order.

Right, I could (should) have understood that by myself.
 
> Consider we scheduled tasks to be run in 3 parallel processes:
> (As we NEEDSWORK comment only addresses the ouput selection,
> let's assume this is a fixes schedule, which we cannot alter.
> Which is true if we only change the code you quoted. That picks
> the process to output.)
> 
> [...]
 
> The output is produced by the current algorithm:
> (1) Start with process 1 (A) whose output will be live
> (2) Once A is done, flush all other done things, (B)
> (3) live output will be round robin, so process 2 (D)
> (4) Once D is done, flush all other done things (C, F, E)
>     in order of who finshed first
> 
> 
> (1) is uncontroversial. We have no information about tasks A,B,C,
>     so pick a random candidate. We hardcoded process 1 for now.
> 
> (2) also uncontroversial IMHO. There is not much we can do different.

Agreed
 
> (3) is what this NEEDSWORK comment is about. Instead of outputting D
>     we might have choosen C. (for $REASONS, e.g.: C is running longer than
>     D already, so we expect it to finish sooner, by assuming
>     any task takes the same expected time to finish. And as C
>     is expected to finish earlier than D, we may have smoother
>     output. "Less buffered bursts")
> 
> [...]
> 
> This seems to be better than the current behavior as we have more
> different tasks with "live" output, i.e. you see stuff moving.
> I made up the data to make the point though. We would need to use
> live data and experiment with different strategies to find a
> good/better solution.

We should probably settle on what is the behavior we want to obtain, 
before trying to find a strategy to implement (or approximate) it:
- Do we want to be as close as possible to a serial processing output? 
- Do we want to see as much live output as possible?

I do not think that being close to serial processing is a relevant 
behavior: we applied an arbitrary order to tasks when naming them for
explanations (A, B, C...), but the tasks aren't really sorted in any
way (and that's why the parallelization is relevant).Neither the user
nor git have any interest in getting these ouputs in a specific order.

Therefore, a "as much live output as possible" behavior would be more
sensible. But I wonder: is there a worthy benefit in optimizing the
output owner strategy? I'm not used to working with submodules, but I
don't think that having a great number of submodules is a common thing.
Basically: we could solve a problem, but is there a problem?
I'm not trying to bury this NEEDSWORK, I'd be happy to look into it if
need be!
