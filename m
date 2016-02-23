From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] credential-cache--daemon: change to the socket dir on startup
Date: Tue, 23 Feb 2016 13:09:44 -0800
Message-ID: <xmqqbn77yvzb.fsf@gitster.mtv.corp.google.com>
References: <20160223071427.GA7489@sigill.intra.peff.net>
	<20160223071604.GC8395@sigill.intra.peff.net>
	<xmqqfuwjyw59.fsf@gitster.mtv.corp.google.com>
	<20160223210725.GA25854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jon Griffiths <jon_p_griffiths@yahoo.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:09:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYKDP-0007dY-8R
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbcBWVJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:09:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755279AbcBWVJr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:09:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4014B4619B;
	Tue, 23 Feb 2016 16:09:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ebNQ6eDmaKSmJo8cjXeGgjqXmJY=; b=oKqljX
	GOjbr4igHczRYqdcWyfCSZ8VYvAZcQrzpEsuoTL7fTl/qzOn/wBnfOEO/7yvGP0w
	O+AderKjMIv4oe8uDItSKl0sPzlYiY6nSWKhApsVC/kDu0jUnh9+Iym6MQFhBgP6
	PRnOrqYJ1t2PPvs8ImmULuPNSjS8xi8SpRzmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HKoDRtJdj94O6T2zB1mwnjYSJWr5FGie
	+cW4hIERkrG5HZmZlKdaCtwVHQ4u1b0uzAb+HVTAopdbMeyUnq4a5Zoufmsi8kjN
	wSpnpPDpZWXO2lelTy9t5xjll5Fw75AFaOSjrbG92CbF1fvwFZmmNa4IdvKDH2MV
	MfE9jH6VkT0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 364F34619A;
	Tue, 23 Feb 2016 16:09:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AD85946199;
	Tue, 23 Feb 2016 16:09:45 -0500 (EST)
In-Reply-To: <20160223210725.GA25854@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 23 Feb 2016 16:07:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3E2C2AE-DA71-11E5-8895-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287124>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 23, 2016 at 01:06:10PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > +	/*
>> > +	 * We don't actually care what our cwd is; we chdir here just to
>> > +	 * be a friendly daemon and avoid tying up our original cwd.
>> > +	 * If this fails, it's OK to just continue without that benefit.
>> > +	 */
>> > +	chdir(dir);
>> 
>> I fully do agree with this comment, but my copy of gcc and system
>> headers doesn't, unfortunately.
>> 
>> credential-cache--daemon.c: In function 'init_socket_directory':
>> credential-cache--daemon.c:245:7: error: ignoring return value of 'chdir', declared with attribute warn_unused_result [-Werror=unused-result]
>>   chdir(dir);
>>        ^
>> cc1: all warnings being treated as errors
>> make: *** [credential-cache--daemon.o] Error 1
>
> Ugh. Is:
>
>   (void)chdir(dir);
>
> enough? Or do we have to do:
>
>   if (chdir(dir))
> 	; /* nothing */
>
> ?
>
> -Peff

I tentatively squashed this, which I think reads better.

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 9a3a7a3..6b00ee0 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -237,12 +237,13 @@ static void init_socket_directory(const char *path)
 			die_errno("unable to mkdir '%s'", dir);
 	}
 
-	/*
-	 * We don't actually care what our cwd is; we chdir here just to
-	 * be a friendly daemon and avoid tying up our original cwd.
-	 * If this fails, it's OK to just continue without that benefit.
-	 */
-	chdir(dir);
+	if (chdir(dir))
+		/*
+		 * We don't actually care what our cwd is; we chdir here just to
+		 * be a friendly daemon and avoid tying up our original cwd.
+		 * If this fails, it's OK to just continue without that benefit.
+		 */
+		;
 
 	free(path_copy);
 }
