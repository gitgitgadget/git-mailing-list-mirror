From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gitignore matching "git add" wildcard prevents operation
Date: Fri, 15 Jan 2010 10:17:26 -0800
Message-ID: <7v7hrj1bd5.fsf@alter.siamese.dyndns.org>
References: <4B4F6000.4070005@sofistes.net>
 <20100114195234.GA26684@coredump.intra.peff.net>
 <7vljg0bfox.fsf@alter.siamese.dyndns.org>
 <20100114203928.GA26883@coredump.intra.peff.net>
 <20100115153419.GA12982@vidovic>
 <20100115154816.GA1579@coredump.intra.peff.net>
 <20100115161107.GC12982@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Marko Poutiainen <regs@sofistes.net>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:17:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVqjv-0004ue-GT
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 19:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757974Ab0AOSRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 13:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757940Ab0AOSRj
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 13:17:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757963Ab0AOSRi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 13:17:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 00B6C9199E;
	Fri, 15 Jan 2010 13:17:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=n74E82r83nOhqaFEoEkdYsTiX0g=; b=kg3cDBaAnuJkjzwTb56WBYL
	jGmkT9MM5uwDXPiBgOmtNfAuj2IBYRFPiEr9N+pukiL4MXuxy8s73jZ/On56zSw+
	CrcpnMIhl45hTmo9JudFC7P/JcF0KgWe8Nwbvov3NLBW1DGcN18A/GIipCKkhCnY
	rvv0lNci2fWG0UC7VvWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uTAN0MoeSRAuljjbHIQthNGLcGbXDS1gSgSWa56WXl8fYmfOw
	6HMPiMQn5pxcq1uQXlT4p1gWesmkS9V2oiEbxbTMBwsAjgKTHOWaRnPqvGGkM6MZ
	85yvzMp48dA+x1kJ8HWyJInG7YfAYUQTiGHXn8agAFm/ywCNXejLoYzJ+E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B221F9199D;
	Fri, 15 Jan 2010 13:17:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B05D99199C; Fri, 15 Jan
 2010 13:17:27 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4056A98A-0202-11DF-B1B4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137092>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

>> My complaint was more that as a user, I am not likely to see this
>> problem and think "I'll bet git-specific globbing can solve it."
>
> Yes. My point is that we are not talking about a Git specific issue.

Actually it is.  The thing is, git subcommands do *not* take individual
filenames in general from their command line.  They _always_ take pathspecs,
find files in the work tree that match the pathspecs (but excludes ignored
ones), and work on them [*1*].

Other commands usually don't do that.

So "git add ." and "git add 'a.*'" behave exactly the same way.  Both find
files that match their respective pathspecs.  The former knows that "."
matches "all files that exist in the cwd (excluding ignored ones)" and the
latter knows that "a.*" matches "all files that fnmatch(3) 'a.*' glob
(excluding ignored ones)".  Hence you will not get "don't try to add a
file that you said you want to ignore; use -f if you mean it".


[Footnote]

*1* There are exceptions, such as parameters to the "--file" option, and
"git blame".
