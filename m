From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Optimize common pattern of alloc_ref from string
Date: Sun, 11 May 2008 11:39:34 -0700
Message-ID: <7vskwo3ct5.fsf@gitster.siamese.dyndns.org>
References: <1210462018-47060-1-git-send-email-kkowalczyk@gmail.com>
 <20080510233918.GA315@sigill.intra.peff.net>
 <7ce338ad0805101730n5b964a0em39d9fdcd9fc45f00@mail.gmail.com>
 <20080511080709.GA6971@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Krzysztof Kowalczyk <kkowalczyk@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 11 20:40:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvGTP-0001nN-S9
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 20:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849AbYEKSjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 14:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756750AbYEKSjt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 14:39:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572AbYEKSjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 14:39:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 826EE261B;
	Sun, 11 May 2008 14:39:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D33852619; Sun, 11 May 2008 14:39:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A1B8B810-1F89-11DD-8A61-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81810>

Jeff King <peff@peff.net> writes:

> But really my main worry is that now we have _two_ functions which
> allocate refs, so if "struct ref" ever grows a new field that needs
> initializing, it has to go in two places (whereas if alloc_ref_from_str
> calls alloc_ref, it works automatically).

This is a very good point.  We really do not want a micro-optimization in
a way that hurts maintainability.

Krzysztof's patch has the new function with the duplicated allocation
implementation between the base allocator function and the existing
copy_ref() function which also has yet another duplicated allocation
implementation.  When somebody needs to modify one, it is likely to be
noticed that these three go hand-in-hand, hopefully ;-).

By the way, why isn't alloc_ref() doing xcalloc(), I have to wonder...
