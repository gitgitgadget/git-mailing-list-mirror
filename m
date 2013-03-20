From: Junio C Hamano <gitster@pobox.com>
Subject: Re: USE_NSEC bug?
Date: Wed, 20 Mar 2013 10:04:14 -0700
Message-ID: <7vppyuf1f5.fsf@alter.siamese.dyndns.org>
References: <CABFQKmP6=Thhph4Ug+4LOBmzsVK42qBQYW2QHw87QD3019n+Kw@mail.gmail.com>
 <20130320075344.GA8159@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Rodland <andrew@cleverdomain.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:04:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIMRQ-0004Dc-Vi
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab3CTRER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:04:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082Ab3CTREQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:04:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35B71A837;
	Wed, 20 Mar 2013 13:04:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=az5nvXCr9jDzo396n8z/poEUOMU=; b=ALiqcX
	ufmZhNvg29hzi3wEl9JXn0rhrXFJNHUoQ6NQ8QqN+tURlxmfh+9VVo1ugfpRDj43
	41+DQcBkwgA9PDw6DHCGxpuQ7+ZGnBpMPa/D5wBng4rDe/qcaZd3ccWCfeFXdtOz
	hw7/7RjRW2Fcx6MyrG3+Z+NT0QZnBK6JNqKhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fPzgxs60o0e4SElCLtUIUtHAYRMMS9uf
	XLTZugFYyzHv4k2sdyblhvmiAkY+qaF4wweNFP0/fcNN6qEwbD/RU/a3hrWW62MB
	FWkGFTY8QnGHArgH2GWxBIEg9b+eGReBCZD+l0ZuylHGfbz1J63nEaATvOpHUd5w
	NWlpmlgoHzg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E8B5A835;
	Wed, 20 Mar 2013 13:04:16 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D90FA834; Wed, 20 Mar 2013
 13:04:15 -0400 (EDT)
In-Reply-To: <20130320075344.GA8159@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Mar 2013 03:53:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3209D92C-9180-11E2-AA5E-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218618>

Jeff King <peff@peff.net> writes:

> But maybe there is some subtle reason I'm missing for having the two
> options separate.

The closest I found was c06ff4908bf9 (Record ns-timestamps if
possible, but do not use it without USE_NSEC, 2009-03-04).

commit c06ff4908bf9ad8bf2448439a3574321c9399b17
Author: Kjetil Barvik <barvik@broadpark.no>
Date:   Wed Mar 4 18:47:40 2009 +0100

    Record ns-timestamps if possible, but do not use it without USE_NSEC
    
    Traditionally, the lack of USE_NSEC meant "do not record nor use the
    nanosecond resolution part of the file timestamps".  To avoid problems on
    filesystems that lose the ns part when the metadata is flushed to the disk
    and then later read back in, disabling USE_NSEC has been a good idea in
    general.
    
    If you are on a filesystem without such an issue, it does not hurt to read
    and store them in the cached stat data in the index entries even if your
    git is compiled without USE_NSEC.  The index left with such a version of
    git can be read by git compiled with USE_NSEC and it can make use of the
    nanosecond part to optimize the check to see if the path on the filesystem
    hsa been modified since we last looked at.
