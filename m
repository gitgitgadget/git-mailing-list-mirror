From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 39/83] builtin/apply: move 'ws_error_action' into 'struct apply_state'
Date: Tue, 26 Apr 2016 13:40:59 -0700
Message-ID: <xmqqpotcdrxg.fsf@gitster.mtv.corp.google.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-40-git-send-email-chriscool@tuxfamily.org>
	<xmqqtwiods5n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:41:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9nI-0002UY-JW
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbcDZUlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:41:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753496AbcDZUlD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:41:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F6161622F;
	Tue, 26 Apr 2016 16:41:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DK4Nx7cPDDL1+AIi+YKmlx5JZv0=; b=UFb04C
	dsQdhmpwh2ToD5hpAL2SZeKQwqGlcgnUaeJhc6z00QmTHD86UR9B3jS0vP1mzFfH
	JBXo0vv2Z3be89dVTFoRsCAdK6yxvUbEzshgjcVPOtpk/hd33KolAtFsaejlJGFZ
	+Ro5dSfUD4I8WHHa4Qxt9PkP1eKyIbh35GdlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OBuZB2/aWj7gRxxRLGJ6A8LisJ1OANTR
	ENYY+uSSTRa09tZ7mKueAD23Q1LuZffDBKC98EUxg/PBPXy84GWpcMWuEZJqx+DW
	dABGUVCfbHlK7Ubcujra5pxMIPL8WkG73IkIUlhdr54zq1TOYRfRx0hrrnsarQl5
	9L1etWhRmL0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 859F71621F;
	Tue, 26 Apr 2016 16:41:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C54DA1621E;
	Tue, 26 Apr 2016 16:41:00 -0400 (EDT)
In-Reply-To: <xmqqtwiods5n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 26 Apr 2016 13:36:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2FD452F8-0BEF-11E6-8C84-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292664>

Junio C Hamano <gitster@pobox.com> writes:

> As I do not expect that cmd_apply() which is a moral equivalent of
> main() will stay to be the only one who wants to see a reasonably
> initialized apply_state(), I think the patch that introduced the
> very first version of "struct apply_state" should also introduce a
> helper function to initialize it, i.e.
>
> 	static void init_apply_state(struct apply_state *s,
>         			     const char *prefix)
>         {
> 		memset(s, '\0', sizeof(*s));
>                 s->prefix = prefix;
>                 s->prefix_length = s->prefix ? strlen(s->prefix) : 0;
> 	}
>
> in [PATCH 7/xx].

Just to avoid misunderstanding, I do not mean to say that the
init-apply-state helper that should have been introduced in 07/xx
would gain a new caller-supplied parameter ws_error_action.  This
step would have a patch to the function that does something like:

 static void init_apply_state(struct apply_state *s,
                                 const char *prefix)
 {
         memset(s, '\0', sizeof(*s));
         s->prefix = prefix;
         s->prefix_length = s->prefix ? strlen(s->prefix) : 0;
         ...
+        s->ws_error_action = warn_on_ws_error;
 }

without having the caller supply what error_action should the state
be initialized with.
