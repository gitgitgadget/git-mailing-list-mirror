From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL characters
Date: Thu, 22 May 2008 10:44:31 -0700
Message-ID: <7v8wy2w7wg.fsf@gitster.siamese.dyndns.org>
References: <482BE5F7.2050108@thorn.ws>
 <alpine.DEB.1.00.0805161139530.30431@racer>
 <alpine.DEB.1.00.0805161148010.30431@racer>
 <alpine.DEB.1.00.0805161403130.30431@racer>
 <7v8wy34jj3.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805221136230.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tommy Thorn <tommy-git@thorn.ws>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 22 19:46:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzErE-0001xk-Sn
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 19:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbYEVRor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 13:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755066AbYEVRor
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 13:44:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbYEVRoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 13:44:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 30F7443EE;
	Thu, 22 May 2008 13:44:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C1C5943ED; Thu, 22 May 2008 13:44:38 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805221136230.30431@racer> (Johannes
 Schindelin's message of "Thu, 22 May 2008 11:38:34 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C3535AF2-2826-11DD-9551-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82640>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Looking at what handle_body() does for TE_BASE64 and TE_QP cases, I have 
>> to wonder if this is enough.  The loop seems to stop at (*op == NUL) 
>> which follows an old assumption that each line is terminated with NUL, 
>> not the new assumption you introduced that each line's length is kept in 
>> local variable len.
>
> Of course!  But does BASE64 and QP contain NULs?

The loop in question iterates over bytes _after_ decoding these encoded
lines, and a typical reason you would encode the payload is because it
contains something not safe over e-mail transfer, e.g. NUL.

I think decode_transfer_encoding() also needs to become safe against NULs
in the payload.
