From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 03/11] Allow programs to not depend on remotes having urls
Date: Mon, 27 Jul 2009 11:55:27 -0700
Message-ID: <7v1vo2j6qo.fsf@alter.siamese.dyndns.org>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
 <1248656659-21415-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:55:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVVMO-0001On-Mw
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 20:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbZG0Szg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbZG0Szg
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 14:55:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbZG0Szg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 14:55:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE89F139CC;
	Mon, 27 Jul 2009 14:55:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D54CD139C9; Mon, 27 Jul 2009
 14:55:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 115D3F36-7ADF-11DE-B327-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124184>

Johan Herland <johan@herland.net> writes:

> diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
> index 78a88f7..4c6fc58 100644
> --- a/builtin-ls-remote.c
> +++ b/builtin-ls-remote.c
> @@ -87,9 +87,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  	remote = nongit ? NULL : remote_get(dest);
> -	if (remote && !remote->url_nr)
> +	if (!nongit && !remote)
>  		die("remote %s has no configured URL", dest);

It appears to me that remote_get() calls make_remote() that never returns
NULL, thus this check will never trigger.  At least, the die() message
needs to be updated, since remote_get() may return NULL for some reason
other than "no configured URL", but the condition the message says is not
what this code checks.

It is Ok if the new world order is that the URL does not have to be known
before transport_get() is called, but if that is the case, it should be
made clear by removing this check from here (and possibly having a new
check elsewhere where it really matters, e.g. somewhere in transport
code).

> -	transport = transport_get(remote, remote ? remote->url[0] : dest);
> +	transport = transport_get(remote, remote ? NULL : dest);
>  	if (uploadpack != NULL)
>  		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
