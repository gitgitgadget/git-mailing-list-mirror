From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REROLL PATCH 6/8] Support remote helpers implementing smart
 transports
Date: Tue, 08 Dec 2009 15:38:41 -0800
Message-ID: <7vein5594u.fsf@alter.siamese.dyndns.org>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-7-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 09 00:40:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI9dy-00070y-GT
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 00:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965941AbZLHXis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 18:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbZLHXir
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 18:38:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965281AbZLHXip (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 18:38:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 987BE86336;
	Tue,  8 Dec 2009 18:38:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=SldBNCxIZtwqpIHSSfKIIsRDcyw=; b=Ij/OBCJQY28UiVDQIU12xyk
	+/LjHqAJ6YmgBzkXt1gncyQEFIaqh3u5Zoti0HkUfGzUgq6+djIRcJCcUikw4bq0
	cjp96BiPmmCCs869Vtnul1x4GZ+UjWuRfzIIKG1ER8LVZRQUqWhfjnDVMSbwcrcJ
	jrnC1Toy0SdrV9K0vVzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ZogHWteUyhm3TwDuUuKbVNs4ooWj3TiDWEq5FSiXPbc+G+7IX
	xI/aSWBgJTY7kkjWNBTkWXV+m6BEWEsYg26K0zOHDvKmvItiUMgagJ7URs9LfWw1
	3YrvRBxP92/saVJCE2DsReQIblafgZbJ1Wv6Yevdr10AEUgLsCpmSc0/zY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BBA4286332;
	Tue,  8 Dec 2009 18:38:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CC148632E; Tue,  8 Dec
 2009 18:38:42 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3ABF636-E452-11DE-9A3C-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134925>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> ---
>  Documentation/git-remote-helpers.txt |   25 +++++++-
>  transport-helper.c                   |  126 ++++++++++++++++++++++++++++++++--
>  2 files changed, 144 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
> index 20a05fe..b957813 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -93,6 +93,20 @@ Supported if the helper has the "push" capability.
>  +
>  Supported if the helper has the "import" capability.
>  
> +'connect' <service>::
> +	Connects to given service. Stdin and stdout of helper are

A minor point, but in prose, unless it explains how to use "stdin" and
"stdout" as a variable, keyword, etc. in code, I'd prefer to see these
spelled out, like so:

	The standard input and output of helpers are connected to ...

> @@ -34,12 +36,12 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
>  		die_errno("Full write to remote helper failed");
>  }
>  
> -static int recvline(struct helper_data *helper, struct strbuf *buffer)
> +static int _recvline(FILE *helper, struct strbuf *buffer)
>  {

Not a good naming for two reasons.

 - Somebody new to the code wouldn't be able to tell which of recvline()
   and _recvline() take helper_data and FILE easily.

 - A function name that starts with an underscore, even if it is file
   scoped static, is something we tend to avoid.  This applies to
   _process_connect() in the earlier patch as well.

recvline_fh() vs revline() might be better as most of the interaction in
this layer are done on helper_data, which makes the name recvline() pair
nicely with sendline that also takes helper_data; and the oddball one that
is _not_ an implementation detail (i.e. you have calls outside recvline()
implementation that call _recvline()) hints that it takes filehandle
instead.
