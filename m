From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] test/send-email: to-cover, cc-cover tests
Date: Tue, 29 Apr 2014 12:01:10 -0700
Message-ID: <xmqqppk0j6yx.fsf@gitster.dls.corp.google.com>
References: <1398750059-11955-1-git-send-email-mst@redhat.com>
	<1398750059-11955-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 21:01:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfDHT-0004mC-4C
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 21:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbaD2TBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 15:01:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965000AbaD2TBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 15:01:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8284981A42;
	Tue, 29 Apr 2014 15:01:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YDIar202bQ28SSMQQdqfPYucqgM=; b=x3aeI8
	ZnABhLjRxs5mQ9mYyxqIlUusN1beqnqxeTH7Wro2OK57v9D+YrR9g5UAVhzbm/6I
	D2A+dP8rKKdCwCFy1am7uP2h9Wlvx3utDBbPKcpCS/tmZLqpvW/nYKMABgMhoWny
	Si/T221gVmgYW8TX7kDBWuJZO507ImbDfjz44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A51i9+nRniM8+5gv4bbrH15DJEMDdQdJ
	OVEYWFYsrx4d5VnZnIxl1LUpXWs4L2svnfGv2lxIsnZU9iNAXRJWIRV38pnBuYIP
	0UrjMvC+jLd589qqgoDwL0QB4naX6BebuUxwBc3nLOeNMUMq4JEmG3mLAdFJlwdy
	T6NokccjubY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A7E481A41;
	Tue, 29 Apr 2014 15:01:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B06881A3D;
	Tue, 29 Apr 2014 15:01:12 -0400 (EDT)
In-Reply-To: <1398750059-11955-2-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Tue, 29 Apr 2014 08:41:18 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A1C26196-CFD0-11E3-955E-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247603>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Add tests for the new feature.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  t/t9001-send-email.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 1ecdacb..97cc094 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1334,6 +1334,51 @@ test_expect_success $PREREQ '--force sends cover letter template anyway' '
>  	test -n "$(ls msgtxt*)"
>  '
>  
> +test_cover_addresses () {
> +	header="$1"
> +	shift
> +	clean_fake_sendmail &&
> +	rm -fr outdir &&
> +	git format-patch --cover-letter -2 -o outdir &&
> +	cover=`echo outdir/0000-*.patch` &&
> +	mv $cover cover-to-edit.patch &&
> +	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.patch > $cover &&

Please do the redirection like this:

	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.patch >"$cover" &&

in your later patches (I'll tweak this patch myself, so no need to
resend).  We know >$cover should be the same as >"$cover", but it
was reported that some version of bash does not know it and
complains instead (see Documentation/CodingGuidelines).
