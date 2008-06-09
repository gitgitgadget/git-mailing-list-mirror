From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Mon, 09 Jun 2008 12:59:30 -0700
Message-ID: <7vlk1egz19.fsf@gitster.siamese.dyndns.org>
References: <200805232221.45406.trast@student.ethz.ch>
 <200806090032.27516.trast@student.ethz.ch>
 <alpine.DEB.1.00.0806090018350.1783@racer>
 <200806090746.22512.johan@herland.net>
 <20080609122938.GA12210@sigill.intra.peff.net>
 <alpine.DEB.1.00.0806091709350.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:00:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5nXx-0001nB-J1
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424AbYFIT7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 15:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbYFIT7x
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 15:59:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbYFIT7w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 15:59:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B6AD19AD;
	Mon,  9 Jun 2008 15:59:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ECE6219A0; Mon,  9 Jun 2008 15:59:37 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806091709350.1783@racer> (Johannes
 Schindelin's message of "Mon, 9 Jun 2008 17:13:08 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9AAEF354-365E-11DD-BCC3-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84415>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But like I said, Junio convinced me that it makes not much sense to split 
> somewhere else than common lines, and you have that already with the "s" 
> command in add -i.

That needs clarifying.  What I would have convinced you is not quite
"somewhere else than common lines".  It is more like "don't split between
two deleted lines that is followed by addition, or two added lines that
immediately follow deletion, without thinking".

Splitting the left into the right:

         1               1
        -2              -2
        +two            +two
         3               3
        -4
        +four
         5

so that only the first change is applicable makes sense and can easily be
explained.  This is "common lines" case.

The example I gave you long time ago about split that does not make much
sense was to split this:

         1      
        -2      
        -3      
        -4
        +two, three
        +four
         5

anywhere between "-2 .. +four" without giving the user any other ways to
control the result.

But you _can_ give users a meaningful split by reordering lines.

         1      
        -2      
        -3      
        +two, three
        -4
        +four
         5

It makes sense to then split this immediately before "-4" to apply "only
the first change that is to remove two lines and rewrite it with one
line", i.e.:

         1      
        -2      
        -3      
        +two, three
         4

with the leftover part, whose lines differ if the above is applied or not,
presented as the next hunk to the user:

 (if the above is unused) (if the above is used)

         3                   two, three 
        -4                  -4          
        +four               +four       
         5                   5          
