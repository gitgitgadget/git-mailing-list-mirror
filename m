From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bundle: keep a copy of bundle file name in the in-core bundle header
Date: Wed, 02 Mar 2016 10:15:12 -0800
Message-ID: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
References: <xmqqvb556abd.fsf@gitster.mtv.corp.google.com>
	<xmqqr3ft6a9x.fsf@gitster.mtv.corp.google.com>
	<20160302090129.GC30295@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 19:15:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abBIy-0006GX-UU
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 19:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbcCBSPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 13:15:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752980AbcCBSPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 13:15:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 420E0479C5;
	Wed,  2 Mar 2016 13:15:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+xUeqL81cDR3RaS1yQI2iSchlWo=; b=Tg/INn
	cNgMRa0Fiynlu4Bs66ZAaT7QpPVsrWG4u6suNK80ori9lqLboki8nzeVWPULIVac
	JxH2IrGAzjUiBPmoHwgmtqVul7pu8cZ8p0JSDpnMfNK9xoTall0DTbS0eoc7f8aI
	/46SdWgQGxWkDAKNCLnWXc9tbZW7OXOwmRViU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pxMgoASntS6B8zhzp1stOodzRtIo+qHn
	ZtWGJXzLvMYhZY1CoSNUfzZYzqeIr4j0EJHQPLR+AtpKHd9NlmW8txUbqo2ik11d
	lj5DLJUnl212uZsWX1pttKekkfvOgrKT1YbBS0xBOiNFbfCToXTdCbAISchuXxjb
	E6u/Ujvt0cM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B01E479C4;
	Wed,  2 Mar 2016 13:15:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF757479C3;
	Wed,  2 Mar 2016 13:15:13 -0500 (EST)
In-Reply-To: <20160302090129.GC30295@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Mar 2016 04:01:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B5656A42-E0A2-11E5-8DCD-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288140>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 01, 2016 at 03:36:26PM -0800, Junio C Hamano wrote:
>
>> This will be necessary when we start reading from a split bundle
>> where the header and the thin-pack data live in different files.
>> 
>> The in-core bundle header will read from a file that has the header,
>> and will record the path to that file.  We would find the name of
>> the file that hosts the thin-pack data from the header, and we would
>> take that name as relative to the file we read the header from.
>
> Neat. I'm hoping this means you're working on split bundles. :)

Let's just say that during the -rc freeze period, because I can stop
looking at or queuing completely new topics to encourage people who
are responsible for topics in the upcoming release to focus more on
responding to regressions and follow-up fixes necessary, I have a
better chance of having some leftover time to look into things
myself, at least enough to figure out what needs to be done, ;-)

>> -	if (strcmp(cmd, "create") && (bundle_fd =
>> -				read_bundle_header(bundle_file, &header)) < 0)
>> +	header.bundle_file = bundle_file;
>
> What are the memory ownership rules for header.bundle_file?
>
> Here you assign from either an argv parameter or a stack buffer, and
> here...
>
>> @@ -112,6 +111,8 @@ void release_bundle_header(struct bundle_header *header)
>>  	for (i = 0; i < header->references.nr; i++)
>>  		free(header->references.list[i].name);
>>  	free(header->references.list);
>> +
>> +	free((void *)header->bundle_file);
>>  }
>
> You free it.
>
> The call in get_refs_from_bundle does do an xstrdup().

Good eyes.

>
> Should we have:
>
>   void init_bundle_header(struct bundle_header *header, const char *file)
>   {
> 	memset(header, 0, sizeof(*header));
> 	header.bundle_file = xstrdup(file);
>   }
>
> to abstract the whole procedure?

Maybe, maybe not.  I'll decide after adding the bundle_version field
to the structure (which will be read from an existing bundle, but
which will have to be set for a bundle being created).

Thanks.
