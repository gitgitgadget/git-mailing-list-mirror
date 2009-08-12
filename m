From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/6] transport_get(): Don't SEGFAULT on missing url
Date: Wed, 12 Aug 2009 15:24:43 -0700
Message-ID: <7vab24wtzo.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
 <1249985426-13726-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	benji@silverinsanity.com, Johannes.Schindelin@gmx.de
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 13 00:25:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbMFo-0007PV-T1
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 00:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbZHLWYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 18:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbZHLWYv
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 18:24:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbZHLWYv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 18:24:51 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 098348DE6;
	Wed, 12 Aug 2009 18:24:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26A4E8DE4; Wed, 12 Aug
 2009 18:24:45 -0400 (EDT)
In-Reply-To: <1249985426-13726-3-git-send-email-johan@herland.net> (Johan
 Herland's message of "Tue\, 11 Aug 2009 12\:10\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3A1603C-878E-11DE-A48A-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125752>

Johan Herland <johan@herland.net> writes:

> Signed-off-by: Johan Herland <johan@herland.net>

How does url end up to be NULL?  At the beginning of transport_get(), you
do this:

	ret->remote = remote;
	if (!url && remote && remote->url)
		url = remote->url[0];
	ret->url = url;
	if (remote && remote->foreign_vcs) {
		transport_helper_init(ret);
		return ret;
	}

and the case where remote.$name.vcs is defined, we do not need
remote.$name.url.

When (!url && remote && remote->url), is remote->url[0] allowed to be
NULL?  I am guessing it would be a bug in whoever prepared the remote, and
if that is indeed the case, the patch shifts the symptoms without fixing
the cause.

When (remote && remote->foreign_vcs) does not hold, iow, if no remote is
defined or the remote is defined but lacks remote.$name.url, you will go
to the last else clause in the function that sets up a git_transport_data
for the native transport, but it has ret->url == NULL.  

Whom does that transport talk with?  Is such a transport of any use, or
does it cause a segfault downstream in the call chain?

In other words, I am wondering if this patch should just diagnose the case
as an error, instead of pretending all is well.
