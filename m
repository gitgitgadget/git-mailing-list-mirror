From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/15] http: release the memory of a http pack request as well
Date: Tue, 24 Mar 2015 10:48:15 -0700
Message-ID: <xmqqh9ta70dc.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-10-git-send-email-sbeller@google.com>
	<xmqq1tkgddto.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZbe9d7wG+CJ0o93hDs3sFjkSp68pBHXpjOysbzgvjo3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:48:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSwc-00061u-IO
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbbCXRs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:48:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932671AbbCXRsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:48:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20466419DA;
	Tue, 24 Mar 2015 13:48:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NVe3rW91gSlqP3SipJm5HUhDzA4=; b=bIvP7p
	xBxWJ/RFSgL4H0qb2C+zQtt3I43Dp6rbISFohTarCDeAQ2FmGZ2d8aON2Ul+9zGV
	D5aiED3TyUgiosx2YkSwNPQmM3ZstSOzLeBKX+AuqiUBxWiyIh3/DAqbQ/IvwO4v
	Ye3W//0kiigq82mxRT+vJlW2TgK9y0PGwFJH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JS9bAkg7A1iBI/uygpG9HR/lETFWMEoq
	yvtxfbuk+5yzsrB0/yYhWJWTgY9nMv6Gk8fZTuen6tW3+U9LtA2FkSjWlg7lcyNE
	QrQTCVqc2mH1b5r0yfu4KPNltiZm9dKuFRMZRXArEK3W1KasB8BBdAPSWyhYhdGV
	9n+NOwgdOoA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17835419D9;
	Tue, 24 Mar 2015 13:48:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E2B2419D2;
	Tue, 24 Mar 2015 13:48:17 -0400 (EDT)
In-Reply-To: <CAGZ79kZbe9d7wG+CJ0o93hDs3sFjkSp68pBHXpjOysbzgvjo3w@mail.gmail.com>
	(Stefan Beller's message of "Tue, 24 Mar 2015 09:54:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3E24920-D24D-11E4-A7E7-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266211>

Stefan Beller <sbeller@google.com> writes:

> Well there is hope, as `release_request` only touches
>     free(request->url);
>     free(request);
>
> and not the userData pointer.

OK.

> I am a bit puzzled what you're trying to hint at.

The caller does this:

        static void start_fetch_packed(struct transfer_request *request)
        {
                ...
                preq = new_http_pack_request(target, repo->url);
                ...
                preq->slot->callback_func = process_response;
                preq->slot->callback_data = request;
                request->slot = preq->slot;
                request->userData = preq;

                /* Try to get the request started, abort the request on error */
                request->state = RUN_FETCH_PACKED;
                if (!start_active_slot(preq->slot)) {
                        fprintf(stderr, "Unable to start GET request\n");
                        release_http_pack_request(preq);
                        repo->can_update_info_refs = 0;
                        release_request(request);
                }
        }

and start_active_slot() actually not just "starts" but calls
curl_multi_perform() to do things, like calling process_response(),
which has calls to release_{,http_pack_}request().  I didn't see
those releases and the releases we see in the above (i.e. when !start)
will not run at the same time (but I see it now ;-))

In short, not hinting at anything.  I was genuinely having a hard time
following the codeflow.
