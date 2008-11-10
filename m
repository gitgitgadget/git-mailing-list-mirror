From: Junio C Hamano <gitster@pobox.com>
Subject: Re: overly smart rebase - bug or feature?
Date: Mon, 10 Nov 2008 15:14:42 -0800
Message-ID: <7vod0n41i5.fsf@gitster.siamese.dyndns.org>
References: <20081110212333.GU6799@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman.Shaposhnick@Sun.COM, git@vger.kernel.org
To: Fedor Sergeev <Fedor.Sergeev@Sun.COM>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:17:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzg03-0004fY-Mv
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbYKJXPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbYKJXPf
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:15:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbYKJXPe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:15:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C43E69517F;
	Mon, 10 Nov 2008 18:15:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5929D9516C; Mon,
 10 Nov 2008 18:14:48 -0500 (EST)
In-Reply-To: <20081110212333.GU6799@sun.com> (Fedor Sergeev's message of
 "Tue, 11 Nov 2008 00:23:34 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7878C3DA-AF7D-11DD-9380-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100586>

Fedor Sergeev <Fedor.Sergeev@Sun.COM> writes:

> I have recently hit a behavior which might well be a feature, 
> but it was very surprising (in a bad sense) to me.

It is a feature misfiring.

Rebase is essentially a repeated cherry-pick, and a cherry-pick of commit
A on top of commit B is done by a simplified 3-way merge between A and B
using the parent of A as the common ancestor.

     A                          A'
    /                          /
   A^... pseudo history ...---B

When your history has renamed Makefile to Makefile2 (thereby losing
Makefile) while transition from A^ to A modified Makefile, the difference
between A^ to A that is applied to B to produce A' contains only the
change about Makefile (and does not talk about the unchangedness of
Makefile1 nor Makefile2 --- in fact, when A' is created, the machinery
does not even know if A^ and A had Makefile1 or Makefile2).

When applying the change to Makefile, it notices that B does not have
Makefile, but there is a path that is _identical_ to the preimage your
change applies to (namely, Makefile2).  To support people who rename
Makefile to Makefile2 in the history that led to B, rebase (actually the
underlying "am -3" it calls is where this rename detection smart lies)
applies the changes to the "renamed" path.

You might be able to work this around by forcing rebase not to use the
simplified 3-way merge, by saying "rebase -m".
