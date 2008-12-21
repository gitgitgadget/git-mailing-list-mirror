From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] handle_remote_ls_ctx can parsing href starting at
 http://
Date: Sun, 21 Dec 2008 01:42:42 -0800
Message-ID: <7vr641rhil.fsf@gitster.siamese.dyndns.org>
References: <1229772213-11932-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Sun Dec 21 10:47:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEKuV-0008Dz-JH
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 10:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbYLUJmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 04:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYLUJmx
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 04:42:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbYLUJmv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 04:42:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 637D61AC6C;
	Sun, 21 Dec 2008 04:42:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2CB361AC6B; Sun,
 21 Dec 2008 04:42:44 -0500 (EST)
In-Reply-To: <1229772213-11932-1-git-send-email-catap@catap.ru> (Kirill A.
 Korinskiy's message of "Sat, 20 Dec 2008 14:23:33 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BAC100DC-CF43-11DD-82E5-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103693>

"Kirill A. Korinskiy" <catap@catap.ru> writes:

> The program call remote_ls() to get remote objects over http;
> handle_remote_ls_ctx() is used to parse it's response to populated
> "struct remote_ls_ctx" that is returned from remote_ls().
>
> The handle_remote_ls_ctx() function assumed that the server will
> returned local path in href field, but RFC 4918 demand of support full
> URI (http://localhost/repo.git for example).

Do you mean "the client should support both server-relative '/repo.git'
and full 'http://localhost/repo.git'", or "the client should reject
'/repo.git' and insist on full 'http://localhost/repo.git'"?  I am
guessing the former but it is not quite clear.  Where in 4918 is this
specified?

> This resulted in push failure (git-http-push ask server
> PROPFIND /repo.git/alhost:8080/repo.git/refs/) when a server returned
> full URI.

This is an interesting but confusing example.

Do you mean the bug is:

 (1) the client asks PROPFIND /repo.git/;

 (2) the server gives http://localhost/repo.git/refs back;

 (3) the client incorrectly assumes that the response would start with
     /repo.git/ (e.g. "/repo.git/refs"), so strips 10 bytes from the
     beginning of this result and uses the remainder as the "new"
     information to dig deeper; i.e. "alhost/repo.git/refs";

 (4) the new part is appended to the original path and the client forms
     the next request "PROPFIND /repo.git/alhost/repo.git/refs/";

 (5) instead, the client should strip the proto://host part (if exists)
     and request "PROPFIND /repo.git/refs/".

> @@ -1424,9 +1425,10 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
>  				ls->userFunc(ls);
>  			}
>  		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
> -			ls->dentry_name = xmalloc(strlen(ctx->cdata) -
> +			char *path = strstr(ctx->cdata, remote->path);
> +			ls->dentry_name = xmalloc(strlen(path) -
>  						  remote->path_len + 1);

What if you are talking to http://repo.git/repo.git/?  Doesn't this
strstr() misbehave?  Instead, shouldn't you be checking if the response
begins with proto://host/ and stripping it iff so?
