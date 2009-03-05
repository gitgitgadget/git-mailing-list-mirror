From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
 configured
Date: Thu, 05 Mar 2009 14:43:49 -0800
Message-ID: <7vmybzy4ii.fsf@gitster.siamese.dyndns.org>
References: <20090305221529.GA25871@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Andreas Ericsson <ae@op5.se>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 23:45:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfMJo-0002ma-T8
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 23:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbZCEWoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 17:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbZCEWoC
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 17:44:02 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbZCEWoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 17:44:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8210A9F191;
	Thu,  5 Mar 2009 17:43:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D6DEE9F18F; Thu,
  5 Mar 2009 17:43:51 -0500 (EST)
In-Reply-To: <20090305221529.GA25871@pvv.org> (Finn Arne Gangstad's message
 of "Thu, 5 Mar 2009 23:15:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1CE5066E-09D7-11DE-8684-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112356>

If you want to pursue this, you at least need three patches, preferably
four:

 (1) Add a configuration option the existing users can use to ask for
     "with nothing else, please continue to default to matching refs".

     Add a logic to tell "nothing is configured, hence we default to
     matching refs" and "the user explicitly told us either via the
     command line, or in the configuration file to use matching refs"
     cases.  Use the logic to issue a *warning* upon the former case that
     tells the users the following, very loudly:

     - "default to push matching" may be changed in a future version of
       git to "default to push nothing";

     - The user can squelch the warning by various ways:

       - If you want to keep the "matching refs" behaviour, do $this...
       - If you want to have $this behaviour, do $that...
       - ...

     Keep the default for the unconfigured case, after issuing the
     warning, to the matching refs.

 (2) Add a deprecation notice to Documentation/RelNotes-1.6.3.txt similar
     to the way denyCurrentBranch was announced in 1.6.2 release notes (I
     need to carry that part forward to the draft release notes to 1.6.3).

     Mention that these two patches are proposed to be applied immediately.

 (3) Flip the default for unconfigured case to "nothing".  Update the
     warning message you wrote in (1) to explain that:

     - The default used to be "matching refs", but it now is "nothing".
       This message is given loudly because a silent change of default 
       is dangerous to users.

     - The user can squelch the warning by doing ... (I expect the
       instructions will stay the same as in (1)).

     Mention that this patch is proposed to be applied in the next major
     update (perhaps 1.7.0).

 (4) Remove the warning but keep the default to "nothing".  Mention that
     this is to be applied long after (3).

I won't comment on code quality other than hinting that you do not want to
reinvent has_multiple_bits().
