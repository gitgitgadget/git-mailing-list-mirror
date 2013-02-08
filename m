From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph: output padding for merge subsequent parents
Date: Fri, 08 Feb 2013 11:40:11 -0800
Message-ID: <7vd2wa1tno.fsf@alter.siamese.dyndns.org>
References: <201302051700.r15H0GXx031004@freeze.ariadne.com>
 <7vtxpqslpm.fsf@alter.siamese.dyndns.org> <vpqmwvia2n7.fsf@grenoble-inp.fr>
 <201302061503.r16F30UA016375@freeze.ariadne.com>
 <20130206151447.GZ1342@serenity.lan> <vpqbobxwavv.fsf@grenoble-inp.fr>
 <20130206195702.GA1342@serenity.lan> <vpqtxpmae1p.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	"Dale R. Worley" <worley@alum.mit.edu>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 08 20:40:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3toP-000669-JF
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 20:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946941Ab3BHTkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 14:40:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946899Ab3BHTkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 14:40:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C544BB70F;
	Fri,  8 Feb 2013 14:40:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zEOHFBTVnYnW+9UeI2BYLaG1heA=; b=TdjU8I
	jWg7Sxoe7YThMfmYZGwRL0GJ7/yTJYw0Piif/6KjNYQ2QkXvG/qXGyLmHXbgwUhV
	oy44AOd3IA4cp1+zulWeKWTyI8jd31PZo6BarBqyyaKLSJNzP2u4Z6PruZr+dEMX
	dgo3CXTpshk/+TdH8Vwmg+mHTjTsX4yeEIZiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ABAfu+wPBr+iF6tDUv7qnbtYfiiDi3SP
	dEGNL93hTAuzBWJ2RDKjYSe00BWon1OS6SJIfBtsBAcsgE2uFPbpKKO+tcPdX+aN
	mrvWUzvcMTMDmbH65+fDLuNS/PJO2Glq/6W7q3USkk5ZsdJ5pWWxf4IpB1wQTxa6
	JTz0UL6mz+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8F7BB70E;
	Fri,  8 Feb 2013 14:40:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D4F7B70A; Fri,  8 Feb 2013
 14:40:13 -0500 (EST)
In-Reply-To: <vpqtxpmae1p.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Fri, 08 Feb 2013 18:52:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B0B4C48-7227-11E2-854B-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215806>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> John Keeping <john@keeping.me.uk> writes:
>
>> diff --git a/graph.c b/graph.c
>> index 391a712..2a3fc5c 100644
>> --- a/graph.c
>> +++ b/graph.c
>> @@ -1227,6 +1227,16 @@ void graph_show_commit(struct git_graph *graph)
>>  	if (!graph)
>>  		return;
>>  
>> +	/*
>> +	 * When showing a diff of a merge against each of its parents, we
>> +	 * are called once for each parent without graph_update having been
>> +	 * called.  In this case, simply output a single padding line.
>> +	 */
>> +	if (graph_is_commit_finished(graph)) {
>> +		graph_show_padding(graph);
>> +		shown_commit_line = 1;
>> +	}
>> +
>>  	while (!shown_commit_line && !graph_is_commit_finished(graph)) {
>
> This works, but if we know we're not going to enter the while loop, it
> seams even easier to do this:
>
> --- a/graph.c
> +++ b/graph.c
> @@ -1227,7 +1227,17 @@ void graph_show_commit(struct git_graph *graph)
>         if (!graph)
>                 return;
>  
> -       while (!shown_commit_line && !graph_is_commit_finished(graph)) {
> +       /*
> +        * When showing a diff of a merge against each of its parents, we
> +        * are called once for each parent without graph_update having been
> +        * called.  In this case, simply output a single padding line.
> +        */
> +       if (graph_is_commit_finished(graph)) {
> +               graph_show_padding(graph);
> +               return;
> +       }
> +
> +       while (!shown_commit_line) {
>                 shown_commit_line = graph_next_line(graph, &msgbuf);
>                 fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
>                 if (!shown_commit_line)

In this particular case, with the current state of this function, it
is probably OK, but an early return like this tend to be a source of
future bugs in the longer term, to make the codeflow skip whatever
necessary clean-up that needs to be done after the loop exits.
