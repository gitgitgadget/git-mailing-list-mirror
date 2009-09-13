From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] transport-helper.c: don't leak fdopen'd stream buffers
Date: Sun, 13 Sep 2009 09:45:10 +0200
Message-ID: <878wgjz3sp.fsf@meyering.net>
References: <87hbv833kd.fsf@meyering.net>
	<7vtyz760lm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 09:45:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmjmL-0003Ba-R4
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 09:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbZIMHpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 03:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbZIMHpP
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 03:45:15 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:51845 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbZIMHpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 03:45:14 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 42E26818085
	for <git@vger.kernel.org>; Sun, 13 Sep 2009 09:45:12 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 64827818036
	for <git@vger.kernel.org>; Sun, 13 Sep 2009 09:45:10 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 3F01D38B5A; Sun, 13 Sep 2009 09:45:10 +0200 (CEST)
In-Reply-To: <7vtyz760lm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 12 Sep 2009 19:27:01 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128344>

Junio C Hamano wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>> diff --git a/transport-helper.c b/transport-helper.c
>> index f57e84c..0bbd014 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -49,6 +49,7 @@ static struct child_process *get_helper(struct transport *transport)
>>  		if (!strcmp(buf.buf, "fetch"))
>>  			data->fetch = 1;
>>  	}
>> +	fclose (file);
>>  	return data->helper;
>>  }
>>
>> @@ -88,6 +89,7 @@ static int fetch_with_fetch(struct transport *transport,
>>  		if (strbuf_getline(&buf, file, '\n') == EOF)
>>  			exit(128); /* child died, message supplied already */
>>  	}
>> +	fclose (file);
>>  	return 0;
>>  }
>
> The callchain of fetch_with_fetch() looks like:
>
>     fetch_with_fetch()
>         helper = get_helper();
>         --> get_helper()
>             - start helper with start_command();
>             - read from helper->out until it sees an empty line;
>             - break out of the loop;
>         <-- return helper
>         - file = xfdopen(helper->out) to get another FILE on the fd
>         - read the rest of the output from helper->out via file
>
> It seems to me that the fclose() in get_helper() will close the underlying
> fd and would break the caller, no?

I confess that my sole test was to run "make test", which passed.
If the fd must live on, a slightly less invasive change would be to
xdup each descriptor just before each of the three xfdopen calls, e.g.,

-       file = xfdopen(helper->out, "r");
+       file = xfdopen(xdup(helper->out), "r");

> I think "struct helper_data" should get a new FILE* field and once
> somebody creates a FILE* out of its helper->out, that FILE* can be passed
> around without a new xfdopen().
>
> Or something like that.

That's probably best.

> Who is responsible for closing the underlying helper->out fd in the
> start_command() API, by the way?
