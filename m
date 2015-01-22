From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: do not request symbolic refs to remote helpers
Date: Thu, 22 Jan 2015 09:52:55 -0800
Message-ID: <xmqqoapqu2h4.fsf@gitster.dls.corp.google.com>
References: <1421631307-20669-1-git-send-email-mh@glandium.org>
	<xmqqwq4fuxbb.fsf@gitster.dls.corp.google.com>
	<20150122070301.GA18195@glandium.org>
	<xmqqbnlruurk.fsf@gitster.dls.corp.google.com>
	<20150122080638.GA9546@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:53:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YELwF-000058-HP
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 18:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbbAVRw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 12:52:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752691AbbAVRw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 12:52:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4303300E8;
	Thu, 22 Jan 2015 12:52:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tHZNID8P1zf9KJbULwtsF4G33CY=; b=mw6YrR
	LyMQytM6VzITEGIMPS1+yg6Pggap2YOfgJH1UZD8jKtmajvKZA/XhUXcdiGH9203
	cHUDj6ag/s7Vx7fwm6rifmrA9igT741vvMX65K38cwAw9wEkTLLMjQoTViNhCC3M
	oQOQ0/lqPB1N8j/iQx5S1QwZwqCe8IzBywAbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U1Ybvmrm0ikXKD+Fi2tBS4mxt0H2MsEL
	ILYujTkyO+uPiYs/35BMF4IiQwMo1MqlToPKvCY3/MYF/P1L+1FO8nWAOgK2Z/+y
	pQ8BeRDFnw4I/oVjetAjfmhONzWwMlSBOMwfkypsrqxCgEH8kIzjgpc2rOOLwTXs
	wWbQ3GfWdvw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB684300E7;
	Thu, 22 Jan 2015 12:52:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35E94300E6;
	Thu, 22 Jan 2015 12:52:56 -0500 (EST)
In-Reply-To: <20150122080638.GA9546@glandium.org> (Mike Hommey's message of
	"Thu, 22 Jan 2015 17:06:38 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7EE240D0-A25F-11E4-A39B-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262851>

Mike Hommey <mh@glandium.org> writes:

> The patch changes the behavior in all cases, because it didn't feel
> necessary to have a different behavior between the "normal" case and the
> '?' case: it makes sense to request the ref being pointed at than the
> symbolic ref in every case.
>
> Moreover, this makes existing non-git remote-helpers work without
> having to modify them to provide a refspec for HEAD (none of the 5
> mercurial remote-helpers I checked do).

I do not question the latter.  It is not surprising if all of them
share the same limitation that shares the same root in the same
impedance mismatch.

The trouble I had in supporting "makes sense ... in every case" was
that you said that the code as patched would not work for a symref
pointing at another symref.  The original code did not have that
problem with remote helpers that support the 'list' command.

Does the new code avoid regressions for them and if so how?  That is
what was needed in the justification.

For remote helpers that support the 'list' command, asking for a
symref and asking for a ref that the symref points at both work OK
and behave the same, and hopefully that would be true even when the
latter is a symref that points yet another ref, so dereferencing
only one level on our end when making a request, instead of letting
the remote side dereference, is not likely to cause regression.
