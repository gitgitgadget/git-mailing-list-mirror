From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Large-scale configuration backup with GIT?
Date: Sun, 02 Sep 2007 14:49:49 -0700
Message-ID: <7vd4x0pwjm.fsf@gitster.siamese.dyndns.org>
References: <20070902201724.GB10567@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 23:50:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRxKU-0005jw-Fy
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 23:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbXIBVt5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 17:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbXIBVt4
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 17:49:56 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:41716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbXIBVt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 17:49:56 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 80C9C12D37F;
	Sun,  2 Sep 2007 17:50:13 -0400 (EDT)
In-Reply-To: <20070902201724.GB10567@lug-owl.de> (Jan-Benedict Glaw's message
	of "Sun, 2 Sep 2007 22:17:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57393>

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> I'm just thinking about storing our whole company's configuration into
> GIT, because I'm all too used to it. That is, there are configuration
> ...
> In both cases, I'd be left with a good number of GIT repos, which
> should probably be bound together with the GIT subproject functions.
> However, one really interesting thing would be to be able to get the
> diff of two machine's configuration files. (Think of machines that
> *should* be all identical!)  For this, it probably would be easier to
> not put each machine into its own GIT repo, but to use a single one
> with a zillion branches, one for each machine.
>
> Did anybody already try to do something like that and can help me with
> some real-life experience on that topic?

This is something similar to what I and others in my group did
long time before git was even invented.  I'd suggest you go in
the opposite direction.

If you have 5 configurations, each of which have 20 machines
that _should_ share that configuration (modulo obvious
differences that come from hostname, IP address assignment,
etc), then

 - You keep track of 5 configurations; in git, you would
   probably maintain them as 5 branches.

 - You have a build mechanism to create systemic variation among
   20 machines that shares one configuration; this can be
   different per branch.  So if you have 20 solaris machines all
   should share logically the same configuration, you would:

	$ git checkout solarisconf

        ... tweak the config for machine #27, adjusting for
        ... hostname, IP address variation, etc...
        $ make target=solaris27 output=../solaris27.expect

   Make that makefile produce the output in named directory;

 - You get the config dump from your machines (your "staging
   area"), as you planned.  Then after running the above, you
   could:

	$ cd ..
        $ diff -r solaris27.expect solaris27.actual

   if your "staging area" for machine #27 is "solaris27.actual".

The difference you would see is something done by *hand* on the
machine, which you would want to propagate back to the solaris
configuration *source* you keep track in git.  For some changes,
you may even want to adjust that single manual change done on
machine #27 so that you do not have to do that on other 19
solaris boxes manually, by adjusting the build procedure in the
solarisconf branch.



 
