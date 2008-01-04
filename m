From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-diff-* --color oddness
Date: Fri, 04 Jan 2008 00:46:18 -0800
Message-ID: <7vsl1ekmg5.fsf@gitster.siamese.dyndns.org>
References: <20080104081429.GA30635@coredump.intra.peff.net>
	<7vabnmm1ww.fsf@gitster.siamese.dyndns.org>
	<20080104083252.GB3300@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:47:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAiCh-0002VG-NL
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbYADIqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbYADIqc
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:46:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052AbYADIqc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:46:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AB6814F39;
	Fri,  4 Jan 2008 03:46:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E6F3A4F38;
	Fri,  4 Jan 2008 03:46:24 -0500 (EST)
In-Reply-To: <20080104083252.GB3300@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 4 Jan 2008 03:32:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69566>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 04, 2008 at 12:26:55AM -0800, Junio C Hamano wrote:
>
>> > The first two lines of meta-info will be in the stock colors, but
>> > everything after will be in the custom colors. So we are actually
>> > reading the diff_ui options _during_ the diff. The culprit is
>> > funcname_pattern, which calls read_config_if_needed.
>> 
>> Yuck.  Why is funcname_pattern do ui-config stuff?  I know it
>> wants to get custom regexp crap, but that should belong to the
>> plumbing part, not Porcelain-only thing, shouldn't it?
>
> It's for user diff drivers, and it looks like the funcname pattern. Not
> sure why we want to demand-load that stuff at all...I wonder if it
> should just go into git_default_config (or a git_basic_diff_config).

Yeah, moving some to the diff-basic-config sounds sane.

 * I'd prefer to keep low-level produce consistent diff that can
   be reliably applied with git-apply without getting broken by
   user configuration while Porcelain level diff can be tweaked
   by the user to do whatever "human readable" crap they would
   want to see on the screen (such as "side by side"), and my
   gut feeling is that we should keep the user-level driver
   definition in ui-config, never to affect plumbing.

 * using or not-using colors should stay in ui-config;

 * funcname-pattern can go either way; that affects what appears
   at the end of @@ context @@ lines, and would not have risk to
   corrupt the patch for plumbing.

 * color choice can also go either way, but probably is better
   to be in the low-level.  Cnce color is used the output cannot
   be fed sanely to patch or git-apply _anyway_ so we can be
   sure that "git diff-plumbing --color" is run to produce human
   readable output.
