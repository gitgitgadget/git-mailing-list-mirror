From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: refactor request url creation
Date: Wed, 28 Jan 2009 14:51:27 -0800
Message-ID: <7vvdrzjb80.fsf@gitster.siamese.dyndns.org>
References: <4980D9FF.7020307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 23:53:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSJHJ-0007vO-8s
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 23:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbZA1Wvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 17:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbZA1Wve
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 17:51:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbZA1Wve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 17:51:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 443D11D81D;
	Wed, 28 Jan 2009 17:51:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 351F01D81A; Wed,
 28 Jan 2009 17:51:29 -0500 (EST)
In-Reply-To: <4980D9FF.7020307@gmail.com> (Tay Ray Chuan's message of "Thu,
 29 Jan 2009 06:19:43 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 35AD2ECA-ED8E-11DD-9FCF-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107592>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Currently, functions that deal with objects on the remote repository have to allocate and do strcpys to generate the URL.
>
> This patch saves them this trouble, by providing two functions, "append_remote_object_url" and "get_remote_object_url".
>
> Both generate a URL, with either the object's 2-digit hex directory (eg. /objects/a1/), or the complete object location (eg. /objects/a1/b2).
>
> However, they differ in that "append_remote_object_url" appends this URL to a strbuf, while "get_remote_object_url" wraps around the former and returns the URL directly in char*. Users usually would use "get_remote_object_url", but may find "append_remote_object_url" useful if they require further string operations on the URL.
>
> PS. In "start_fetch_loose", the variable "url" which is passed to "curl_easy_setopt" is removed, and in its place "request->url" is used. This is safe, since curl strdup's it.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Acked-by: Junio C Hamano <gitster@pobox.com>

What's with these loooooooooooooooooooooooooooooong lines?

I thought at least you did not have these overlong lines in your earlier
attempts, and Dscho may have acked one of those, but I doubt he would give
his Ack to this one.  I certainly wouldn't Ack it myself.

By the way, aren't you sending format="flowed"?  Please don't.  It damages
whitespaces.

Daniel Stenberg did a research on the safety of your "since curl stdrup's
it" claim, and found that it unsafe for earlier versions of the library
before 7.17.0.

It seems that we earlier found out that anything older than 7.16 were not
usable for git-http-push (see Release Notes for 1.5.4), but 7.16 is still
older than 7.17, so either we declare you _must_ have 7.17 or newer to use
http-push, or keep an extra copy around and free it later like the
original code does.

Even Debian is at 7.18.2 these days, so requiring 7.17 or newer may not be
an issue in practice, but there are people who keep running things on
older distros with proven stability (and known features limitation).

The refactoring looked sane otherwise, but I think we would want to opt
for safety by keeping an extra string around.

Thanks.
