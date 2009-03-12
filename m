From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] bisect: use "rev-list --bisect-skip" and remove
 "filter_skipped" function
Date: Thu, 12 Mar 2009 01:26:34 -0700
Message-ID: <7viqmfkuyt.fsf@gitster.siamese.dyndns.org>
References: <20090312085140.c22cd336.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 12 09:28:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhgH1-0007h3-QA
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 09:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbZCLI0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 04:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbZCLI0r
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 04:26:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbZCLI0p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 04:26:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E540A1117;
	Thu, 12 Mar 2009 04:26:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E8BBFA1108; Thu,
 12 Mar 2009 04:26:35 -0400 (EDT)
In-Reply-To: <20090312085140.c22cd336.chriscool@tuxfamily.org> (Christian
 Couder's message of "Thu, 12 Mar 2009 08:51:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 84AF34F6-0EDF-11DE-9A99-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113020>

These (except for the first one which I do not think belongs to the
series) look more or less straightforward changes.

One worrysome thing that the series introduces is that you used to hold
all the skipped ones in a shell variable $skip and fed it internally to
the filter_skipped shell function, but now you give them from the command
line.  When you have tons of skipped commits, this can easily bust the
command line length limit on some system, while the shell may still be Ok
with such a large string variable.

Because the operations in rev-list related to bisect are very closely tied
to the implementation of the bisect Porcelain anyway, I am wondering if it
makes more sense to just feed the name of the toplevel refname hierarchy,
i.e. "refs/bisect", as a rev-list parameter and let rev-list enumerate
what is skipped, which commits are good and which ones are bad.
