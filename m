From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add a setting to require a filter to be successful
Date: Fri, 17 Feb 2012 16:07:05 -0800
Message-ID: <7vd39dqa1i.fsf@alter.siamese.dyndns.org>
References: <7vobsywck1.fsf@alter.siamese.dyndns.org>
 <4f3daaf7.e302440a.02ba.fffff463@mx.google.com>
 <4F3DFCD0.6070002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: jehan@orb.com
X-From: git-owner@vger.kernel.org Sat Feb 18 01:07:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyXq2-0001vP-Cm
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 01:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab2BRAHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 19:07:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab2BRAHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 19:07:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF2875324;
	Fri, 17 Feb 2012 19:07:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=31Cgc/pB1ElZ8uPPKY2kKKZ/cpU=; b=gMdbkR
	5RjZ5SfEIQu4N7HjMLF4pD11CZdHh5ba/Hs+SKK4xvxIKlZ/BImxrTKfYyjhMC7a
	gH88/7JeDmIdE8RZQHsoU14H+5jiLx4cSJczJosnt8SCxA6UTwzdJaMCFfRKuFns
	hJREhRgxGhaP1AhDujrBYgP4yYa8zj1DOdsuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oMiQsVt0p3bD2a4poz2NwJfUWssmfMGP
	XtMME3loONEH8/tK7oUDKuAlDA4eiU4HU+sqKxWUjHztDREv55A4E+MTBzeBMzT0
	gVKMbZfO5wLvWSrqMj0sz4h6+cyJYA1m86pqqMWuwxwQ4wW+MO503zr9OdDOei4m
	xiImOOXaugE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6F425323;
	Fri, 17 Feb 2012 19:07:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C304531D; Fri, 17 Feb 2012
 19:07:07 -0500 (EST)
In-Reply-To: <4F3DFCD0.6070002@viscovery.net> (Johannes Sixt's message of
 "Fri, 17 Feb 2012 08:08:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EDA9506-59C4-11E1-9E8B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190987>

A few test in t0021 use 'false' as the filter, which can exit without
reading any byte from us, before we start writing and causes us to die
with SIGPIPE, leading to intermittent test failure.  I think treating this
as a failure of running the filter (the end user's filter should read what
is fed in full, produce its output and write the result back to us) is the
right thing to do, and this patch needs more work to handle such a
situation better, probably by using sigchain_push(SIGPIPE) or something.
