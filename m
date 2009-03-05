From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone.txt: document that pushing from a shallow
 clone may work
Date: Wed, 04 Mar 2009 16:41:25 -0800
Message-ID: <7vr61c4x8q.fsf@gitster.siamese.dyndns.org>
References: <237967ef0902160200r2320687ai71e62047c3ead9ad@mail.gmail.com>
 <1236080017-13987-1-git-send-email-dato@net.com.org.es>
 <49AD1B22.6050201@viscovery.net> <20090303120856.GB15003@chistera.yi.org>
 <76718490903031127v7fcec124je7292c4c465208b8@mail.gmail.com>
 <20090304101939.GA7142@chistera.yi.org>
 <7vvdqp5zx9.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903041209070.8549@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>,
	Jay Soffian <jaysoffian@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Mikael Magnusson <mikachu@gmail.com>,
	Joey Hess <joey@kitenet.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 05 01:44:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf1gw-0003wO-N8
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 01:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630AbZCEAlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 19:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbZCEAlk
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 19:41:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZCEAlj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 19:41:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BDFB9F016;
	Wed,  4 Mar 2009 19:41:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1A8149F012; Wed,
  4 Mar 2009 19:41:27 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 628DEBAE-091E-11DE-8C0B-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112247>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 4 Mar 2009, Junio C Hamano wrote:
>
>> Isn't the rule more or less like:
>> 
>>     If your shallow repository's history does not extend long enough and
>>     the other repository forked before your truncated history, wyou cannot
>>     compute the common ancestor and you cannot push out.
>
> Exactly.

Actually, come to think of it, it is a lot stronger than "cannot compute
the common".

The history may look like this:

          R---R---R
         /
  --R---R---X---X---S---S---S

where S are the commits you have in your shallow repository, and R are the
commits that exist in the repository that receives your push.  Because
your history is shallow, neither repository has 'X' that are the commits
that need to exist in order to keep the history of recipient repository
complete; the recipient is not shallow to begin with, and we do not want
to make it shallow.

If you cloned shallowly some time ago, worked without communicating with
the other side while the other side progressed, *AND* if the other side's
progress included a rewind & rebuild of the history, you would see a
similar topology.  The leftmost 'S' in the above picture might have been
the tip of the branch when you shallowly cloned with depth 1, and since
then the remote end may have discarded topmost three commits and have
rebuilt its history that leads to the rightmost 'R'.  In such a case
pushing to the remote's HEAD will fail.
