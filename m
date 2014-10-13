From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: plug minor memory leak in unpack()
Date: Mon, 13 Oct 2014 12:08:09 -0700
Message-ID: <xmqq1tqb4wkm.fsf@gitster.dls.corp.google.com>
References: <54390DC0.8060302@web.de> <20141012015321.GA15272@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 21:08:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdkye-0006Um-90
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 21:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbaJMTIM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Oct 2014 15:08:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754326AbaJMTIM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Oct 2014 15:08:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31556158A0;
	Mon, 13 Oct 2014 15:08:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T84vXDqWtVbd
	AgTtibVqbSkyYEU=; b=YNOOAtEcadMQXbxgdvwv8GRkHTXMo51AuqCZkSf9imko
	Cy6L5PeIV4tdUDujT7lkpLnkfpiA/6WmBCmXWnXAArQ4iioPXsngy7l8VSxxLyeZ
	rbw5vl81G/lr5E6RwYP6JCmK9O5rMNjNpOvx/CgkhsMJygFEp1mYTruiI9tnJdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N79dc5
	q9u83VGaUGfHLPmrV9oJGRwYkVXnBnzrpNvQrKHTin4f8EWaXP3DHMqs2581RNFv
	8f43/UWO/tGAADn1ktmMxjf2/dBgm4fqcLp1K1y7WbRHT/LeTwecNTybX4Fu/atY
	Uu5oPQdRB5Cn9dI3UIv8ucGGS9kkIMRcqKUL8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 285181589F;
	Mon, 13 Oct 2014 15:08:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CA9D1589E;
	Mon, 13 Oct 2014 15:08:10 -0400 (EDT)
In-Reply-To: <20141012015321.GA15272@peff.net> (Jeff King's message of "Sat,
	11 Oct 2014 21:53:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45F7BA7C-530C-11E4-911F-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Oct 11, 2014 at 01:00:16PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> The argv_array used in unpack() is never freed.  Instead of adding
>> explicit calls to argv_array_clear() use the args member of struct
>> child_process and let run_command() and friends clean up for us.
>
> Looks good. I notice that the recently added prepare_push_cert_sha1 u=
ses
> an argv_array to create the child_process.env, and we leak the result=
=2E

You're right.  finish_command() runs argv_array_clear() on
cmd->args, but does not care about cmd->env so anybody that use the
(optional) "use these environment variable settings while running
the command" would leak unless the caller takes care of it.

> I wonder if run-command should provide a managed env array similar
> to the "args" array.

I took a look at a few of them:

 - setup_pager() uses a static set of environment variables that are
   not built with argv_array(); should be easy to convert, though.

 - wt_status_print_submodule_summary() does use two argv_arrays, for
   env and argv.  It can use the managed "args" today, and with such
   a change it can also use the managed "envs".

 - receive-pack.c::prepare_push_cert_sha1() would benefit from
   managed "envs".

 - http-backend.c::run_service() would benefit from managed "envs".

 - daemon.c::handle() uses a static set of environment variables
   that are not built with argv_array().  Same for argv.

It shouldn't be too hard to catch and convert all of them.
