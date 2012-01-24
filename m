From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 06/10] clone: delay cloning until after remote HEAD
 checking
Date: Mon, 23 Jan 2012 16:39:38 -0800
Message-ID: <7vvco253xx.fsf@alter.siamese.dyndns.org>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326189427-20800-7-git-send-email-pclouds@gmail.com>
 <7v62g26jm3.fsf@alter.siamese.dyndns.org>
 <7vzkde546x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 01:39:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpUQN-00052M-Iv
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 01:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab2AXAjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 19:39:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731Ab2AXAjl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 19:39:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5637267F9;
	Mon, 23 Jan 2012 19:39:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tna1ITycO6Nz43JcOgA9NqoXamk=; b=c/77iw
	xi2YLNXRcHgJr3NAQcUTYi1CPiKqsWKNSXteKvPy2B1Q/TbMutYTB+pIeNP7gh9v
	CLq+k1RmYVjF66Rgg3pkYEC+DPcoQjPKFpv/9h4L5Ii10jZLQ14BfFl165P+/pAU
	vijiXILx0IuQnQoNDBOs4tGg9Saw4k84FVoIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tpLQAvyzkhIRuZsNFGvsS6w+8Nw8U8Am
	oUnzPfTeFS6bQLFtd16V0Z1SY4zaGY+tWS6PWn2CprLKgM1gQNKJ1xQ/PHLcxg9n
	o8CIaN0x++WZ8qysKMN2Oh9a1ymYIbFRKmg0JXLQYT7eGlL5OO/smtFg/Jgk47KK
	UCrqa2o2Hio=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D76467F8;
	Mon, 23 Jan 2012 19:39:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93D0067EE; Mon, 23 Jan 2012
 19:39:39 -0500 (EST)
In-Reply-To: <7vzkde546x.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 23 Jan 2012 16:34:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E62640C0-4623-11E1-B65A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189028>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> It breaks pushing to multiple URLs like this:
>>
>>     $ cat .git/config
>>     [remote "origin"]
>>             url = https://code.google.com/p/git-htmldocs/
>>             url = github.com:gitster/git-htmldocs.git
>>             push = refs/heads/master:refs/heads/master
>>     $ git push
>>
>> The second url that is supposed to use the git-over-ssh transport
>> mistakenly use https:// and fails with:
>>
>>     error: Couldn't resolve host 'github.com:gitster' while accessing
>>     github.com:gitster/git-htmldocs.git/info/refs
>>     fatal: HTTP request failed
>
> And here is an obvious band-aid to work it around.

-- >8 --
Subject: [PATCH] push: do not let configured foreign-vcs permanently clobbered

Recently, 6f48d39 (clone: delay cloning until after remote HEAD checking,
2012-01-16) tried to record if a remote helper needs to be called after
parsing the remote when transport_get() is called, by overwriting the
field meant to store the configured remote helper name in the remote
structure.

This is OK when a remote represents a single remote repository, but fails
miserably when pushing to locations with multiple URLs, like this:

    $ cat .git/config
    [remote "origin"]
        url = https://code.google.com/p/git-htmldocs/
        url = github.com:gitster/git-htmldocs.git
        push = refs/heads/master:refs/heads/master
    $ git push

The second url that is supposed to use the git-over-ssh transport
mistakenly use https:// and fails with:

    error: Couldn't resolve host 'github.com:gitster' while accessing
    github.com:gitster/git-htmldocs.git/info/refs
    fatal: HTTP request failed

The right solution would probably be to dedicate a separate field to store
the detected external helper to be used, which is valid only during a
single use of transport until it is disconnected, instead of overwriting
foreign_vcs field, but in the meantime, this band-aid should suffice.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 35cce53..5fb98a0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -204,11 +204,13 @@ static int do_push(const char *repo, int flags)
 		url_nr = remote->url_nr;
 	}
 	if (url_nr) {
+		const char *configured_foreign_vcs = remote->foreign_vcs;
 		for (i = 0; i < url_nr; i++) {
 			struct transport *transport =
 				transport_get(remote, url[i]);
 			if (push_with_options(transport, flags))
 				errs++;
+			remote->foreign_vcs = configured_foreign_vcs;
 		}
 	} else {
 		struct transport *transport =
-- 
1.7.9.rc2.100.gfd863d
