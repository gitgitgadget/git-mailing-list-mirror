From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] fast-import: show a warning for non-existent files.
Date: Mon, 01 Sep 2008 12:04:30 -0700
Message-ID: <7vwshvvgap.fsf@gitster.siamese.dyndns.org>
References: <1220275214-6178-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 21:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaEid-0001N0-Pa
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 21:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbYIATEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 15:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYIATEh
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 15:04:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbYIATEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 15:04:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C3A165D945;
	Mon,  1 Sep 2008 15:04:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D918F5D943; Mon,  1 Sep 2008 15:04:32 -0400 (EDT)
In-Reply-To: <1220275214-6178-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Mon, 1 Sep 2008 16:20:14 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D17A455A-7858-11DD-8684-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94599>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is useful in certain SCMs like monotone, where each 'merge revision' has
> the changes of all the micro-branches merged. So it appears as duplicated commands.

The patch appears to add warning to when you try to 'D'elete something
that should not exist in the revision, whose moral equivalents are
implemented in the codepath to deal with 'R'enaming and 'C'opying an
non-existent path.

But instead of making it die(), it merely warns, and even worse, you are
demoting an existing die() in Rename/Copy codepath to mere warning
unconditionally.  Why?

"This" that begins your proposed commit log message needs to be clarified,
but I am guessing that you are defending your change to demote existing
error check to die on inconsistent input to a mere warning.  I do not find
it a particularly good defending argument.  It sounds more like you are
papering over bugs in _one_ broken converter that produces and feeds an
incorrect input to fast-import, breaking a safety valve for everybody else.

> The delete command was ignoring the issue completely. The rename/copy commands
> where throwing a fatal exception.

Yes.  I think this has to be two patch series, that:

 (1) Adds the equivalent "you cannot delete what you do not have" die() in
     the delete codepath; and

 (2) Adds an option that demotes *all* the "don't touch (rename, modify,
     copy or delete) what you do not have" die()s to warning().

provided if we can give a good rationale to the latter.  Otherwise we
should just do (1) and forget about (2).
