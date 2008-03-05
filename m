From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] improve 'bad default revision' message for empty repo
Date: Wed, 05 Mar 2008 00:48:39 -0800
Message-ID: <7vwsoho8t4.fsf@gitster.siamese.dyndns.org>
References: <3f4fd2640803011140o38ba0830l7775c8528f812779@mail.gmail.com>
 <20080303081021.GA6578@sigill.intra.peff.net>
 <3f4fd2640803041351k6debe788xbf5e818951f70146@mail.gmail.com>
 <20080305010701.GB20007@sigill.intra.peff.net>
 <7v7igh51rm.fsf@gitster.siamese.dyndns.org>
 <20080305043319.GA9074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Reece Dunn <msclrhd@googlemail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 09:49:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWpJu-0006zM-RG
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 09:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894AbYCEItM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 03:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756139AbYCEItL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 03:49:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbYCEItJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 03:49:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BCB212BE7;
	Wed,  5 Mar 2008 03:49:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 004572BE5; Wed,  5 Mar 2008 03:49:03 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76197>

Jeff King <peff@peff.net> writes:

> I'm not sure it's this easy. We're basically just ignoring the error
> return from get_sha1_with_mode, but do we really want to ignore _all_
> errors? Specifically, should "git log --default foobar" silently produce
> no commits?

Sure.

The thing is, nobody uses "--default" with random crap (i.e. risk of typo
running from the command line).  It is really about scripted use, and I can
guarantee majority of --default argument is HEAD, and in people's custom
scripts that are specially tailored for specific workflows, they would
use concrete commit object names that their workflow is built around as
convention (e.g. "alias.recent = git log --since=1.day --default master").

We could enhance the --default mechanism to say that its argument is
optional when it begins with a '?', and change our internal callers to
pass the equivalent of "--default ?HEAD", and keep the traditional die()
behaviour for non-optional defaults to catch breakages in end-user
scripts.

> I think a tighter rule that would accomplish the same thing is "if we
> resolve to a ref that is yet-to-be-born, then ignore." But unfortunately
> that information is lost deep within the bowels of get_sha1_with_mode.

Yes and no.  It is in the error path, so you can afford to redo resolving
the symref _after_ seeing get_sha1_with_mode() fail.  
