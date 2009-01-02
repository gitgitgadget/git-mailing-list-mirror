From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: support full URI in handle_remote_ls_ctx()
Date: Thu, 01 Jan 2009 23:26:45 -0800
Message-ID: <7v7i5edv7u.fsf@gitster.siamese.dyndns.org>
References: <20081229071710.GA19175@glandium.org>
 <7vmyekag6p.fsf@gitster.siamese.dyndns.org>
 <1230517935-11299-1-git-send-email-catap@catap.ru>
 <1230879195-8567-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Fri Jan 02 08:28:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIeSS-0001NK-B8
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 08:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221AbZABH05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 02:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbZABH04
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 02:26:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbZABH0z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 02:26:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 573ED1B954;
	Fri,  2 Jan 2009 02:26:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 398301B953; Fri, 
 2 Jan 2009 02:26:47 -0500 (EST)
In-Reply-To: <1230879195-8567-1-git-send-email-catap@catap.ru> (Kirill A.
 Korinskiy's message of "Fri, 2 Jan 2009 09:53:15 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B922537A-D89E-11DD-8F20-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104363>

"Kirill A. Korinskiy" <catap@catap.ru> writes:

> @@ -1424,9 +1425,19 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
>  				ls->userFunc(ls);
>  			}
>  		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
> -			ls->dentry_name = xmalloc(strlen(ctx->cdata) -
> +			char *path = ctx->cdata;
> +			if (*ctx->cdata == 'h') {
> +				path = strstr(path, "://");
> +				if (path) {
> +					path = strchr(path+3, '/');
> +				}
> +			}

Is this "://" (and +3) the only change from the previous one that has
already been queued?  I didn't have a problem with the old "//" one.

The check to see if it begins with 'h' bothers me much much more.

If you want to be defensively tight, you should be checking if it begins
with either "http://" or "https://", the only two protocols you are
prepared to handle, and nothing else, so that you won't trigger this
codepath when the other end gave you "hqrt://..", on the basis that your
code won't know if hqrt:// protocol works the same way as http and https.

On the other hand, if you want to be optimistically loose, expecting
whatever people would implement that can be handled with the existing DAV
code would behave the same way as http and https, you shouldn't be
limiting yourself to an unknown protocol name that happens to begin with
an 'h', only accepting "hqrt://" but not "ittp://" URLs.

Your "first byte of the protocol name must be 'h'" does not do either.
