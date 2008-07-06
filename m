From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] Build in merge
Date: Sun, 06 Jul 2008 02:43:41 -0700
Message-ID: <7v4p73gxf6.fsf@gitster.siamese.dyndns.org>
References: <0cde1e7c930589364318b2d0344b345453e23586.1214918017.git.vmiklos@frugalware.org> <7vej67jt1e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 06 11:44:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFQnZ-00016q-IO
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 11:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYGFJnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 05:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbYGFJnw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 05:43:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbYGFJnv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 05:43:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F6C21DEEB;
	Sun,  6 Jul 2008 05:43:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 77BED1DEE8; Sun,  6 Jul 2008 05:43:43 -0400 (EDT)
In-Reply-To: <7vej67jt1e.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 06 Jul 2008 01:50:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 09A04A1A-4B40-11DD-83EA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87510>

Junio C Hamano <gitster@pobox.com> writes:

> You would perhaps define:
>
> 	#define DEFAULT_TWOHEAD (1<<0)
> 	#define DEFAULT_OCTOPUS (1<<1)
> 	#define NO_FAST_FORWARD (1<<2)
> 	#define NO_TRIVIAL	(1<<3)
>
> 	static struct strategy {
>         	char *name;
>                 unsigned attr;
> 	} all_strategy[] = {
>                 { "octopus",    DEFAULT_OCTOPUS },
>                 { "ours",       (NO_FAST_FORWARD | NO_TRIVIAL) },
>                 { "recur",      NO_TRIVIAL },
>                 { "recursive",  (DEFAULT_TWOHEAD | NO_TRIVIAL) },
>                 { "resolve",    0 },
>                 { "stupid",     0 },
>                 { "subtree",    (NO_FAST_FORWARD | NO_TRIVIAL) },
>         };
>
> And "unsorted_path_list_lookup()" can now become much more natural,
> perhaps:
>
> 	static struct strategy *get_strategy(const char *name);
>
> which has a more natural function signature and much better name.
>
> Then, you would keep an array of pointers into all_strategy[] array to
> represent the list of "-s strategy" given by the user:
>
> 	static struct strategy *use_strategy;
> 	static int use_strategy_alloc, use_strategy_nr;

Sorry, I have an obvious typo here.  "use_strategy" will be dynamic array
of pointers into all_strategy[] so its definition would be:

	static struct strategy **use_strategy;

> and have a function that use s the standard ALLOC_GROW() and friends to
> grow this.  The function will be named and written more naturally
> (i.e. path_list_append_strategy() can go) --- this does not have anything
> to do with path_list, but it is about "merge strategy".
