From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] exec_cmd: system_path memory leak fix
Date: Sun, 23 Nov 2014 13:58:48 -0800
Message-ID: <xmqq7fyly3xj.fsf@gitster.dls.corp.google.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com>
	<1416750981-24446-2-git-send-email-kuleshovmail@gmail.com>
	<xmqqioi5ycme.fsf@gitster.dls.corp.google.com>
	<87sih9en65.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Alex Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 22:59:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsfBN-000715-53
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 22:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbaKWV6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 16:58:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752089AbaKWV6v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 16:58:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 183C91DE57;
	Sun, 23 Nov 2014 16:58:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=msVUiLFtin3CfrUNvLr5DXQCc+4=; b=IeN4UD
	7WUkDK2EV3NYDX6x8U5tDPTqaIpH06gZSBSS5wawtArUL/nWNDXoKvRjOa8aUIWc
	SB5U3Uby6/5YkVdH8sZjvhdu+zB94Ew+O2sx0UoCGPLNT35JGXFqFgW4anlYqX7p
	bvNFynzNB7fIC4Da9mBscYclAjYAeY00cxHoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G/VLvj55xAwVdboW1cPV+ERukpqx6IpO
	GcsBrwsiKL1TLKznoXsvXEePiC8IiEn9lXSH7AwIrwc/yOJLp5dRwpkcQihbQAFi
	K4MDliIoPMWY22PhK8Tbqco2eo1KOxkPa8lehx5SYhVH2d1TwjYr5k+yki/5y7V3
	ltTSU1NpJLQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E4ED1DE56;
	Sun, 23 Nov 2014 16:58:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94AF41DE53;
	Sun, 23 Nov 2014 16:58:49 -0500 (EST)
In-Reply-To: <87sih9en65.fsf@gmail.com> (Alex Kuleshov's message of "Mon, 24
	Nov 2014 01:19:29 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E7CDE564-735B-11E4-BF88-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260105>

Alex Kuleshov <kuleshovmail@gmail.com> writes:

> Signed-off-by: Alex Kuleshov <kuleshovmail@gmail.com>

So this one does not change the contract between the caller and the
callee.  It does not change the fact that you need to explain your
change, though.  The story should read something like this:

    system_path(): always return a volatile result

    The function sometimes returns a newly allocated string and
    sometimes returns a borrowed string, the latter of which the
    callers must not free().

    The existing callers all assume that the return value belongs to
    the callee and most of them copy it with strdup() when they want
    to keep it around.  They end up leaking the returned copy when
    the callee returned a new string.

    Make sure all callers receive a volatile result, so that they do
    not have to be worried about freeing the returned string.

    There however are existing callers that are already broken, for
    example, ...

    Fixing these callers are done as separate patches, that can be
    applied either before or after this patch.

Personally, as I already said, I think the approach the previous
version took (but not the implementation) to change the contract
between the callers and this function is probably a good idea in
the longer term.  Leaking a bit by forgetting to convert a few
callers to free the returned values will not affect the correctness,
but making the returned value consistently more volatile will
expose existing breakage more often and will break codepaths that
happened to be working by accident.

Thanks.
