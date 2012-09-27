From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Thu, 27 Sep 2012 14:33:01 -0700
Message-ID: <7vfw63p2wi.fsf@alter.siamese.dyndns.org>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
 <20120927172037.GB1547@sigill.intra.peff.net>
 <CAJo=hJuXCYa=MKSqCRsxmwFdFYZamK_94zc3fE0tmvwUAVA2Ow@mail.gmail.com>
 <20120927182233.GA2519@sigill.intra.peff.net>
 <CAJo=hJs4NXatb2vsZWWCamLGLmi+FoWkTaf3Ky-nereXkHEptA@mail.gmail.com>
 <20120927185229.GD2519@sigill.intra.peff.net>
 <20120927201809.GA11772@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>,
	David Barr <barr@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 23:33:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THLhs-0007yP-1B
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 23:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab2I0VdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 17:33:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39140 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754815Ab2I0VdD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 17:33:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 767079B2C;
	Thu, 27 Sep 2012 17:33:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G1BJIgR93vJ7jqN9x9LbsQ9V93Y=; b=xt1tmZ
	+klvf0Rci/ohittFYV0xBe752POTs6C4xO4+YexgvIwdpP30OamC87R+X7HF3lJV
	Oh7a7vgXW4yiLpRNiRPXS4+EMlYZQt8dEw8kzqUEfun6jyioxPJ/Mig3Nfe6fI+4
	yeQxC+pE+Xu1Xl6aYn+z2bcgT52CBdKg9TBfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WpL9Z3k9kyc4sf3Nux5SPBcLdi3yXGB8
	S8h6xjz3l0Do+JuzcdWvLFNi3CNCMa82MtUrH6VzsWn8y0sZb8pPreRELNbMbcwl
	Lb84sEAY5j6EYc3/pkdk/dHyBI+k/cze32icAp2ngPY7kIDkhzgOBOWi0g7PmZBV
	RM71IlNFmr4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 637599B2B;
	Thu, 27 Sep 2012 17:33:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6BA59B2A; Thu, 27 Sep 2012
 17:33:02 -0400 (EDT)
In-Reply-To: <20120927201809.GA11772@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 27 Sep 2012 16:18:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EAC80688-08EA-11E2-8F8E-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206521>

Jeff King <peff@peff.net> writes:

> So yeah, we would want to put the pack trailer sha1 into the
> supplementary index file, and check that it matches when we open it.
> It's a slight annoyance, but it's O(1).

Yes.  If I am not mistaken, that is exactly how an .idx file makes
sure that it describes the matching .pack file (it has packfile
checksum in its trailer).  Otherwise you can repack the same set of
objects into a new .pack file and make existing .idx very confused.
