From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] upload-pack: implement protocol extension
 "symbolic-ref"
Date: Mon, 01 Dec 2008 06:03:41 -0800
Message-ID: <7vy6z0q9fm.fsf@gitster.siamese.dyndns.org>
References: <1228039053-31099-1-git-send-email-gitster@pobox.com>
 <1228039053-31099-2-git-send-email-gitster@pobox.com>
 <20081130180214.GA10375@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 15:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79PM-0004D7-6u
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbYLAOEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbYLAOEV
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:04:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbYLAOEV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:04:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE103830BE;
	Mon,  1 Dec 2008 09:04:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 551D7830B9; Mon,
  1 Dec 2008 09:03:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F2B88F98-BFB0-11DD-B483-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102036>

Jeff King <peff@peff.net> writes:

> On Sun, Nov 30, 2008 at 01:57:29AM -0800, Junio C Hamano wrote:
> ...
>> This is unfortunate because it forces an extra round trip (receiving end
>> sends a "please tell me symbolic-ref" packet, and then upload side sends
>> "here are the requested information" packet), but it has to be implemented
>> this way because (1) ls-remote may need to ask for this information, in
>> which case there is no "want" to be sent; and (2) the transport API
>> insists that transport_get_remote_refs() returns the final list, and does
>> not allow augmenting what was initially obtained from the call to it by
>> later calls to transport_fetch_refs() easily.
>
> Hrm. For (1), could we allow either interaction method? IOW, allow
> requesting a symref on the first want line, _or_ by separate "symbolic
> ref" packet? That would allow clients who are using "want" to
> piggy-back the symref request as an optimization, but not restrict those
> that just want to ask for it?

I think I found another hole in the protocol that we can use to carry the
"which branch does HEAD points at" information in a backward compatible
way, and it would be a much less intrusive although more sneaky way.  And
it would not have to suffer from the above issues at all.

A patchset follows shortly...
