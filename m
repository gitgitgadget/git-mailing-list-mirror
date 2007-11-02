From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Implement parsing for new core.whitespace.* options.
Date: Fri, 02 Nov 2007 13:02:30 -0700
Message-ID: <7v3avo2z6x.fsf@gitster.siamese.dyndns.org>
References: <11940160932021-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:03:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io2jF-0002Z4-Bw
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbXKBUCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 16:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039AbXKBUCi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:02:38 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:47230 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbXKBUCh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 16:02:37 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 224152EF;
	Fri,  2 Nov 2007 16:02:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 98361912D5;
	Fri,  2 Nov 2007 16:02:54 -0400 (EDT)
In-Reply-To: <11940160932021-git-send-email-dsymonds@gmail.com> (David
	Symonds's message of "Sat, 3 Nov 2007 02:08:12 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63162>

David Symonds <dsymonds@gmail.com> writes:

> Each of the new core.whitespace.* options (enumerated below) can be set to one
> of:
> 	* okay (default): Whitespace of this type is okay
> 	* warn: Whitespace of this type should be warned about
> 	* error: Whitespace of this type should raise an error
> 	* autofix: Whitespace of this type should be automatically fixed

Many problems at the conceptual level (I haven't look at the
patch yet).

We call these options (nowarn,warn,error,strip) in
apply.whitespace.  "strip" is a bit of misnomer, as we only
handled the trailing whitespace initially.  We should add "fix"
as a synonym to "strip".

The intention is to define what is an anomaly with
core.whitespace and then define what to do with it with
apply.whitespace.

And that is a good distinction.  You may usually use "fix", but
occasionally you would want to override it one-shot (when you do
want to have byte-to-byte identical application of the patch),
and the command line option "--whitespace=" lets you do so.
At least you need to extend --whitespace command line option
handling to allow these overridden.

Adding the "error" and "fix" to "diff" is a mistake --- there is
no error condition nor fixing there.  That shows how the
approach of your patch is inappropriate by trying to mix what
core.whitespace (give the definition of what is an error) and
apply.whitespace (specify what to do with an error) are designed
to do.

Defaulting to "nowarn" is wrong.  Trailing whitespace errors and
space before tab errors should be turned on by default as
before.
