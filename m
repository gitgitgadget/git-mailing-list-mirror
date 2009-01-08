From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Wrap inflateInit to retry allocation after releasing
 pack memory
Date: Wed, 07 Jan 2009 21:23:52 -0800
Message-ID: <7vbpui8j6f.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
 <1231314099.8870.415.camel@starfruit>
 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
 <1231368935.8870.584.camel@starfruit>
 <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
 <1231374514.8870.621.camel@starfruit>
 <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain>
 <20090108030115.GF10790@spearce.org>
 <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain>
 <20090108031314.GG10790@spearce.org> <20090108031655.GH10790@spearce.org>
 <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?utf-8?Q?Kr=C3=BC?= =?utf-8?Q?ger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 06:25:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKnOk-0001LO-Lk
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 06:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbZAHFYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 00:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbZAHFYM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 00:24:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZAHFYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 00:24:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 859CC1C0DA;
	Thu,  8 Jan 2009 00:24:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0019C1C0A2; Thu, 
 8 Jan 2009 00:23:54 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain>
 (Linus Torvalds's message of "Wed, 7 Jan 2009 19:54:47 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 91D4DBDA-DD44-11DD-BBD9-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104889>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> +int git_inflate(z_streamp strm, int flush)
> +{
> +...
> +	/* Z_BUF_ERROR: normal, needs a buffer output buffer */
> +	case Z_BUF_ERROR:

Thanks, but "needs a buffer output buffer" made me scratch my head
somewhat.

  ... Z_BUF_ERROR if no progress is possible or if there was not enough
  room in the output buffer when Z_FINISH is used. Note that Z_BUF_ERROR
  is not fatal, and inflate() can be called again with more input and more
  output space to continue decompressing.
