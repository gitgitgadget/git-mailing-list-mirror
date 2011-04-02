From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] index-pack: Create .keep files with same permissions
 and .pack/.idx
Date: Fri, 01 Apr 2011 21:21:31 -0700
Message-ID: <7v39m1e110.fsf@alter.siamese.dyndns.org>
References: <201103311246.25645.johan@herland.net>
 <AANLkTimMJxni=Vuja+iHyMp8ydm7ZBvWnkSe68g6+pyH@mail.gmail.com>
 <7vk4fdehps.fsf@alter.siamese.dyndns.org>
 <201104020127.41774.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jeff King <peff@peff.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Apr 02 06:22:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5sLh-0005Lm-Iy
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 06:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756Ab1DBEVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 00:21:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab1DBEVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 00:21:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B44FA4775;
	Sat,  2 Apr 2011 00:23:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DaqKc5tgisnMOhQPTjZpzrtSF0g=; b=Rcs+Cd
	wmjecIS5mmXRA109H5ifnEkNLKQYV7wUL5kpjKyQfba/ryI5mJB4CySFBzcp9CNE
	jP0aidrlpj6lalkfapuWfvdUQ+Vp68lc1vogaaLokCAeXTqwoLg4SofA1OCjgyzo
	pXqRIUEd4+HUenGy1TlgUI3fjjL/a56LoUCGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AAVjacpCJkl63UVK7SyAb4+baNj5f4Dl
	2miKBwFOVbzlOd8IIyCAVHB0XJQKwj4+qaovvsA8QXCYoN8rP0RMyGTpdUnn2KQN
	CwViyCCJLMkB4dB8WbgAG/rUHPR0TLrwTWndU5YEojWT2OPezWNrRpxE8FzewgmT
	wtW545SfVMc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 73C5F4774;
	Sat,  2 Apr 2011 00:23:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E06D4773; Sat,  2 Apr 2011
 00:23:22 -0400 (EDT)
In-Reply-To: <201104020127.41774.johan@herland.net> (Johan Herland's message
 of "Sat, 02 Apr 2011 01:27:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F598BFB0-5CE0-11E0-88E5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170642>

Johan Herland <johan@herland.net> writes:

> Hmpf. I didn't know that clone --local --no-hardlinks was unsafe. If it's 
> not safe, should it still be the default behavior for a cross-filesystem 
> clone?

Unsafe is not quite the right word to use here in the sense that it
wouldn't lead to any repository _corruption_ per-se, but if you ended up
copying such a transient .keep file, the pack will stay forever in your
clone target unless you notice and remove it yourself.

Having said that, I expect that the majority of use of a filesystem level
local clone these days is to clone your own repository, likely on your own
machine, and you have absolute control on both ends (e.g. you wouldn't be
running a repack on the source while running a clone---you would more
likely to see the repack finish and then clone).  So in that sense I would
still think that file level clone being the default on a local machine is
a reasonable default.

> While pushing to a remote repo, Git transiently adds a .keep file for the
> pack being pushed, to protect it from a concurrent "git gc". Sometimes, when 
> the push fails or is aborted, the .keep file is left stale in the repo. This 
> causes problems for other users of the same repo, since the permissions on 
> the .keep file (0600) make it inaccessible even though the rest of the repo 
> is accessible (0444 modulo shared_repository setting).

I was also wondering why you initialized with 0444 in your patch and then
even adjusted for shared repository settings.

This is a tangent, but wouldn't it be wrong for index-pack to always leave
the idx and pack files in 0444 with an explicit chmod() in the first
place?  I suspect that we simply forgot to fix it when we introduced
adjust_shared_perm().
