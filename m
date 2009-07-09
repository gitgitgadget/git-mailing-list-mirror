From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] quickfetch(): Prevent overflow of the rev-list command
 line
Date: Thu, 09 Jul 2009 14:22:24 +0200
Message-ID: <4A55E100.9010700@viscovery.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se> <200907091107.46838.johan@herland.net> <4A55B54D.4080601@viscovery.net> <200907091134.45492.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 14:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOseD-0007p0-AU
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 14:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498AbZGIMWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 08:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756117AbZGIMWc
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 08:22:32 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:65369 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbZGIMWb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 08:22:31 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MOsdt-00047A-7l; Thu, 09 Jul 2009 14:22:25 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E179B6B7; Thu,  9 Jul 2009 14:22:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200907091134.45492.johan@herland.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122970>

Johan Herland schrieb:
> However, using rev-list --stdin is not entirely straightforward: rev-list
> terminates immediately when encountering an unknown object, which can
> trigger SIGPIPE if we are still writing object's to its standard input.
> We therefore ignore SIGPIPE so that the fetch process is not terminated.

I removed the "signal(SIGPIPE, SIG_IGN)", but the test suite still passes.
IOW, there is no test case that has the configuration that you describe
here. Would you please add such a test (perhaps in t5502)? It would also
help me verify the patch works as intended on Windows.

> Signed-off-by: Johan Herland <johan@herland.net>
> Improved-by: Johannes Sixt <j.sixt@viscovery.net>

Please make this <j6t@kdbg.org> despite the email address I'm using right now.

> Improved-by: Alex Riesen <raa.lkml@gmail.com>
> Tested-by: Peter Krefting <peter@softwolves.pp.se>

> +	for (ref = ref_map; ref; ref = ref->next) {
> +		if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) < 0 ||
> +		    write_in_full(revlist.in, "\n", 1) < 0) {
> +			err = errno;
> +			if (err != EPIPE && err != EINVAL)
> +				error("failed write to rev-list");
> +			break;
> +		}
> +	}
> +
> +	if (close(revlist.in)) {
> +		err = errno;
> +		error("failed to close rev-list's stdin");
> +	}
> +	return finish_command(&revlist) || err;

The call site of quickfetch() is not interested in the errno, only on
whether the return value is non-zero: You can just assign -1 to err
(that's our convention for failure). OTOH, it would be helpful to include
strerror(errno) in the error message.

Shouldn't you reset signal(SIGPIPE) to its previous value?

-- Hannes
