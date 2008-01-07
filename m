From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] First step, making setup (somewhat) reentrant
Date: Mon, 07 Jan 2008 01:22:43 -0800
Message-ID: <7v4pdq0z30.fsf@gitster.siamese.dyndns.org>
References: <1199684855-14246-1-git-send-email-ct@pipapo.org>
	<1199684855-14246-2-git-send-email-ct@pipapo.org>
	<alpine.LSU.1.00.0801070845270.10101@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Thaeter <ct@pipapo.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 10:23:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBoCd-0001Ho-0H
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 10:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbYAGJW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 04:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754060AbYAGJW7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 04:22:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbYAGJW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 04:22:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 86FDBAFEB;
	Mon,  7 Jan 2008 04:22:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CB1A4AFE9;
	Mon,  7 Jan 2008 04:22:51 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801070845270.10101@racer.site> (Johannes
	Schindelin's message of "Mon, 7 Jan 2008 08:50:40 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69775>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Which brings me to a more fundamental question: what do you need reentrant 
> setup_directory() for?  If it is just to allow multiple calls to that 
> function for the _same_ repository, I say clean up your code.

IIRC, he is writing a set-of-repositories browser.

But I think the right approach of cleaning up is to design a
layer of containers like we did for "the_index" libification
[*1*].  We would probably want:

 * a container that abstracts accesses to a single repository
   that includes:

    - set of refs;

    - object database and object hash (because different
      repositories can have different notion of who is parent of
      whom);

 * a container that abstracts accesses to a state of the index
   (we already have this -- the_index).

 * a container that abstracts a manipulation state in a single
   repository, that points at the first one but somehow knows
   what in-core objects are rewritten during its operation
   (e.g. history simplification rewrites parents list in in-core
   commit objects).

and a relatively low impact approach to transition to such a
scheme would be to use "the_index" libification as the model.
I.e. make the real API to take an explicit container as one of
their parameter, but define the default container to work on for
each level, and express the existing API in terms of the updated
API that works on the default container.


[Reference]

  228e94f93570b580da388069900c56b813c91953 (Move index-related
  variables into a structure.)

  4aab5b46f44a7ba860e07a52be506b7b57b2bd5f (Make read-cache.c
  "the_index" free.)
