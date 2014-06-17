From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 1/1] refs.c: SSE2 optimizations for check_refname_component
Date: Tue, 17 Jun 2014 11:03:46 -0700
Message-ID: <xmqq8uovmn0d.fsf@gitster.dls.corp.google.com>
References: <1403025199-21360-1-git-send-email-dturner@twitter.com>
	<1403025199-21360-2-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 20:04:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwxjn-00034M-66
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 20:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932809AbaFQSD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2014 14:03:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52828 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932135AbaFQSD6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2014 14:03:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D8AB1FD8F;
	Tue, 17 Jun 2014 14:03:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FXBOztiq2wPN
	rHeLrR4TRjHFnBM=; b=utVLcBlmLp72Uv34bfPqTrCnaCmGVcUay5zfWx6rqKI1
	Nj4yk1FQd2t2UUvmA8hhPfBD2cqNpzlEKWihN/LQ3qMMKH4K4BKGSEJHxJ7PgzXR
	R7tpOZ+wwGcGFFyIPIAuAoJnlpS2dNwcyNYeScyEEFSuRLUIuoejALxE/w4SzIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=csKxJL
	VyndFBtFKH7FkqKW0tid9BZFcOa760tUXIsQJKnkv9NaJqoAIIP0A5JRFY0rvQhU
	YcFWXFDteae/gNE6tcEwWobOvDIKO/hxboH8K8hpWs8p9CjajMdTs7BrpkEzGw2r
	Ac5AgiX738HRtvaOljHOQ1Uf3tESj/BZDE3e8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42B381FD8E;
	Tue, 17 Jun 2014 14:03:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E0ED71FD86;
	Tue, 17 Jun 2014 14:03:45 -0400 (EDT)
In-Reply-To: <1403025199-21360-2-git-send-email-dturner@twitter.com> (David
	Turner's message of "Tue, 17 Jun 2014 13:13:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B9AB5E3A-F649-11E3-98E2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251931>

David Turner <dturner@twopensource.com> writes:

> Optimize check_refname_component using SSE2 on x86_64.
>
> git rev-parse HEAD is a good test-case for this, since it does almost
> nothing except parse refs.  For one particular repo with about 60k
> refs, almost all packed, the timings are:
>
> Look up table: 29 ms
> SSE2:          23 ms
>
> This cuts about 20% off of the runtime.
>
> Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> suggested an SSE2 approach =
to the
> substring searches, which netted a speed boost over the SSE4.2 code I
> had initially written.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---

When applied on top of your dde8a902 (refs.c: optimize
check_refname_component(), 2014-06-03), this seems to fail t1402 for
me.

Test Summary Report
-------------------
t1402-check-ref-format.sh (Wstat: 256 Tests: 93 Failed: 9)
  Failed tests:  28, 36, 38, 40, 63, 75, 77, 85-86
  Non-zero exit status: 1

#28 is the one that runs "check-ref-format heads/v@{ation".
