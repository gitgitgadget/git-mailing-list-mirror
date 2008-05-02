From: Junio C Hamano <gitster@pobox.com>
Subject: Re: To page or not to page
Date: Fri, 02 May 2008 11:18:02 -0700
Message-ID: <7v1w4ky3hh.fsf@gitster.siamese.dyndns.org>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org>
 <20080502054508.GA28506@sigill.intra.peff.net>
 <20080502060930.GA1079@sigill.intra.peff.net>
 <7vd4o5xm62.fsf@gitster.siamese.dyndns.org>
 <20080502125553.GB2923@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 20:19:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrzqd-0004xk-LO
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 20:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762761AbYEBSSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 14:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756804AbYEBSSS
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 14:18:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762758AbYEBSSR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 14:18:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B8FD14469;
	Fri,  2 May 2008 14:18:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 03F104468; Fri,  2 May 2008 14:18:10 -0400 (EDT)
In-Reply-To: <20080502125553.GB2923@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 2 May 2008 08:55:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2173314C-1874-11DD-B331-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81015>

Jeff King <peff@peff.net> writes:

> My bigger worry is that this affects only builtins. Which makes it
> sufficient for turning off the pager for anything that does USE_PAGER.

Hmm. How about doing things this way?

 - at the beginning of handle_options() remember argv[0]

 - restructure handle_options() so that it does not run setup_pager() and
   setenv("GIT_PAGER", "cat", 1) inside the loop, but instead remember
   what we had on the command line;

 - after the handle_options() loop, if we saw an explicit --pager,
   --no-pager, that's the decision;

 - otherwise:

   - look at argv[0] to see what the command is;

   - do the config thing to see if there is user preference; if there is
     one, that setting decides;

   - otherwise:

     - see the built-in defaults;

 - and finally use or not use pager depending on what we found above.

I suspect we would want a similar restructure of handle_options() loop
about --git-dir and --git-work-tree so that the loop is only used to
decide what to do and action is carried out after the loop exits, but that
is a separate topic.
