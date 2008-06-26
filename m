From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Introduce leaky().
Date: Thu, 26 Jun 2008 11:46:43 -0700
Message-ID: <7vbq1oqbjg.fsf@gitster.siamese.dyndns.org>
References: <1214338474-16822-1-git-send-email-madcoder@debian.org>
 <1214338474-16822-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 20:48:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBwVg-00018U-7X
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 20:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbYFZSq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 14:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYFZSq7
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 14:46:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbYFZSq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 14:46:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C428D1E1AF;
	Thu, 26 Jun 2008 14:46:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 16BE61E1AD; Thu, 26 Jun 2008 14:46:50 -0400 (EDT)
In-Reply-To: <1214338474-16822-2-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Tue, 24 Jun 2008 22:14:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4096A948-43B0-11DD-B418-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86475>

I looked at the patch (and your updated parseopt series that depends on
this that is queued at madism.org) again, but I have to say I do not like
it, not because I do not want leaks, nor because I do not want explicit
markings.  The issue of helping valgrind sessions is worth addressing.

However.

First of all, it is unclear what the semantics of leaky() is.  Do you want
to mark all things that will be unreacheable from anywhere in the program
at the end, or do you want to mark all things that we have obtained from
malloc(3) and friends but have not free(3)ed?  Without a clear semantics
to use as the guiding principle, it would be hard for people to use this
macro properly to help debugging leaks.

Specifically, how would you envision to handle allocations of objects that
will be reachable from object.c::obj_hash at the program end?  We do not
have to (and we should not) mark them using the former semantics, but we
should with the latter semantics.

The user would also need to worry about not freeing the original
allocation pointer when something is realloc(3)ed, which means either
finding the last realloc(3) of the object (that is logically the same, but
just being extended) and mark the pointer as leaky() after that realloc,
or unregister the original pointer from leaks before calling realloc and
register what comes back.  It will easily get messy.

By the way, the series queued in your repository still has "s/pring/print/"
typo in 4/7 and "argv not NULL terminated" comment in 6/7.
