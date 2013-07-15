From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] cat-file: disable object/refname ambiguity check for batch mode
Date: Sun, 14 Jul 2013 20:45:37 -0700
Message-ID: <7vk3ksfpum.fsf@alter.siamese.dyndns.org>
References: <20130712061533.GA11297@sigill.intra.peff.net>
	<20130712062004.GA15572@sigill.intra.peff.net>
	<51DFC2B2.3080300@alum.mit.edu>
	<20130712092212.GA4859@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 15 05:46:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyZjq-0007fp-Px
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 05:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab3GODpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 23:45:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938Ab3GODpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 23:45:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9004F2940D;
	Mon, 15 Jul 2013 03:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XqyXUeJtcGQQz+GBALCpCcQfTaU=; b=Phqlux
	JCsfRVxtFUKE/XZIOKp5wAGU5Tm88Hc+lcnr7TpuqOxUS6w8GbLmmmNa1myfEMB5
	9tnvr4nflPAfeasYeQT2fXKk/oR2LjjEjPnJ3fCN115H1ngwHDL3JlgHY7oIapdO
	M7++age9Ji+4TJqOjikWIHnVtViQ2hU3LDh18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B+hveJdOnjpVDzuI2q3E3+ZPTMyglm6a
	dHYqI2RBPkCLAoBXV09VzBWWLb3rOMABQkJ74ZmQOJZkM5JOPcpB8arkd+6eN+z7
	MD3KAk0NPNhsZfmYawbLaDwNxXZgo9ad7glhIOJ4Vdg7fM5gzWe/ewvt1eWfjHg7
	RGRfhRIJ1SU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33AB229407;
	Mon, 15 Jul 2013 03:45:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F291829401;
	Mon, 15 Jul 2013 03:45:39 +0000 (UTC)
In-Reply-To: <20130712092212.GA4859@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 12 Jul 2013 05:22:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 047D4598-ED01-11E2-927E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230407>

Jeff King <peff@peff.net> writes:

>> To cat-file we could add an option like "--sha1-only" or "--literal" or
>> "--no-dwim" (... better names are failing me) which would skip *all*
>> dwimming of 40-character strings.  It would also assume that any shorter
>> strings are abbreviated SHA-1s and fail if they are not.  This would be
>> a nice feature by itself ("these are object names, dammit, and don't try
>> to tell me differently!") and would have the additional small advantage
>> of speeding up lookups of abbreviated SHA-1s, which (regardless of your
>> patch) otherwise go through the whole DWIM process.
>
> I can see in theory that somebody might want that, but I am having a
> hard time thinking of a practical use.

Would it be a good alternative to call get_sha1_hex() to catch the
most common case (reading from rev-list output, for example) and
then let the more general get_sha1() to let extended SHA-1 to be
handled?

> IOW, it seems like a poor default, and we are choosing it only because
> of backwards compatibility. I guess another option is to switch the
> default with the usual deprecation dance.

I agree that "did you mean the unreadable refname or 40-hex object?"
turned on everywhere get_sha1() is called is a very poor default.  I
wonder if we can limit it only to the end-user input somehow at the
API level.
