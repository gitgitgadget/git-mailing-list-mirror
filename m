From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] submodule: Allow tracking of the newest revision of a
 branch in a submodule
Date: Thu, 11 Dec 2008 16:59:06 -0800
Message-ID: <7v8wqmb44l.fsf@gitster.siamese.dyndns.org>
References: <1229009982-2701-1-git-send-email-git@fabian-franz.de>
 <7vbpvicuk2.fsf@gitster.siamese.dyndns.org>
 <8c5c35580812111631k54657bdcme8f048c77b6765eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Fabian Franz" <git@fabian-franz.de>, git@vger.kernel.org,
	j.sixt@viscovery.net
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 02:00:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAwOS-00035P-8h
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 02:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbYLLA7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 19:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756743AbYLLA7S
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 19:59:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753AbYLLA7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 19:59:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D8468652E;
	Thu, 11 Dec 2008 19:59:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C3F7F86528; Thu,
 11 Dec 2008 19:59:08 -0500 (EST)
In-Reply-To: <8c5c35580812111631k54657bdcme8f048c77b6765eb@mail.gmail.com>
 (Lars Hjemli's message of "Fri, 12 Dec 2008 01:31:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 189F6904-C7E8-11DD-8487-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102854>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On Thu, Dec 11, 2008 at 21:42, Junio C Hamano <gitster@pobox.com> wrote:
>> I wonder if you can just set "assume unchanged" bit for the subproject
>> gitlink in the index to achieve the same goal.
>
> Using assume-unchanged works, in the sense that the modification to
> the submodule is not detected in the containing repo. But running `git
> submodule update` will checkout the sha1 recorded in HEAD, and I
> suspect Fabian wants something like the hypothetical command `git
> submodule update -b [branch]` which could do `(cd sub && git fetch &&
> git reset --hard origin/$branch)`.

Yeah, that would *also* make sense, but I think that is orthogonal issue.

You can update the state of the checkouts of subproject repositories in
any way you want.  Doing so however makes "git commit -a" inconvenient to
use without assume-unchanged.  The magic 0{40} which Fabian's patch
addresses the same issue in a different way.

Although I would probably detach the head at that point, rather than
resetting whatever branch happens to be checked out:

	( cd sub && git fetch && git checkout origin/$branch^0 )

We also need to make sure that whatever we do we should not break
workflows that do not check out submodules that are uninteresting.  So
doing the above unconditionally to all the submodules is out.  In such a
sparsely populated superproject, "cd sub" would go to an empty directory,
and "git fetch" step would error out.

I did not read Fabian's patch too deeply, and do not remember what checks
it did before running "git pull".  Perhaps it pulled unconditionally?
