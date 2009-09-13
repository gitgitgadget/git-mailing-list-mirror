From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper.c: don't leak fdopen'd stream buffers
Date: Sat, 12 Sep 2009 19:27:01 -0700
Message-ID: <7vtyz760lm.fsf@alter.siamese.dyndns.org>
References: <87hbv833kd.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 04:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmeoF-0004Lz-MZ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 04:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbZIMC1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 22:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbZIMC1N
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 22:27:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbZIMC1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 22:27:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4F4624E494;
	Sat, 12 Sep 2009 22:27:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JeWNmv8A+phPWwMNbgjyPGPMe0o=; b=XDUVYG
	+lBRw2P19CHcmxW7Z7n3rOZ1fbvc0YUWK5EjyQaRdRtuTfV8lyP73aaIl04qgPbQ
	bhqJo3xUntZPAltQ2fsujtF8tsQ4LSIcoUzO0KO+KAFcCL3/KlaVZhEN5Od7Nvyg
	DP6MB02viZDekFZLHSxdX9tTCCX2LTYdiz/uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AM8/o7C6FcrOIz/z+Lg29sSW4oIcgTfD
	TUH48ndSWUJKtWdXD4iHYqq9z59qXhU4Dpie9/aOSbveT8JQkwAtdCHQZ/ESd56M
	JU3B44zO/fR6qIJenviw5fHTV+rtPMUxcc2F2mM9g/TPTbIdboHcoC0ZuJCiRHaQ
	/8ocDH4XYck=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13F974E493;
	Sat, 12 Sep 2009 22:27:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 526B44E492; Sat, 12 Sep 2009
 22:27:02 -0400 (EDT)
In-Reply-To: <87hbv833kd.fsf@meyering.net> (Jim Meyering's message of "Sat\,
 12 Sep 2009 11\:38\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EFC317F8-A00C-11DE-9FA6-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128322>

Jim Meyering <jim@meyering.net> writes:

> diff --git a/transport-helper.c b/transport-helper.c
> index f57e84c..0bbd014 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -49,6 +49,7 @@ static struct child_process *get_helper(struct transport *transport)
>  		if (!strcmp(buf.buf, "fetch"))
>  			data->fetch = 1;
>  	}
> +	fclose (file);
>  	return data->helper;
>  }
>
> @@ -88,6 +89,7 @@ static int fetch_with_fetch(struct transport *transport,
>  		if (strbuf_getline(&buf, file, '\n') == EOF)
>  			exit(128); /* child died, message supplied already */
>  	}
> +	fclose (file);
>  	return 0;
>  }

The callchain of fetch_with_fetch() looks like:

    fetch_with_fetch()
        helper = get_helper();
        --> get_helper()
            - start helper with start_command();
            - read from helper->out until it sees an empty line;
            - break out of the loop;
        <-- return helper
        - file = xfdopen(helper->out) to get another FILE on the fd
        - read the rest of the output from helper->out via file

It seems to me that the fclose() in get_helper() will close the underlying
fd and would break the caller, no?

I think "struct helper_data" should get a new FILE* field and once
somebody creates a FILE* out of its helper->out, that FILE* can be passed
around without a new xfdopen().

Or something like that.

Who is responsible for closing the underlying helper->out fd in the
start_command() API, by the way?
