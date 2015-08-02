From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Sun, 02 Aug 2015 11:10:53 -0700
Message-ID: <xmqq614xa7de.fsf@gitster.dls.corp.google.com>
References: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cT842GAFFM-wfjSU1ZiOevDCOPNDWxux6-vqtdr=3F4qw@mail.gmail.com>
	<20150801201950.5d8c1951@jvn>
	<CAPig+cQwgYYYYsszaRdJDwFLLB0PmiDQ_WTa+Nzzoq0U1zuMiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Viktorin <viktorin@rehivetech.com>,
	Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 20:11:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLxj3-0007bh-Pl
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 20:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbbHBSK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 14:10:56 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32832 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbHBSKz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 14:10:55 -0400
Received: by padck2 with SMTP id ck2so71924859pad.0
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1cnazX8/DGn1pvv4o/T+vifcLW+21VdGMEmtwe9UNmM=;
        b=tfCOiI1L2qxaN7fuMJtqXFIKuJ2xnsdQgE9xNcea3gKhfDp5qtbqroHXbpFEN0spbY
         ia8ty+ZDIRfdlIVfP4fM4ZUIOnMjVHPPU37nX4NnULwwNxQe9cNmTdZk8SoVPPgGOji/
         9iyUC3pRqrlAVoDQbuJAyABlOoZ/CSchhRwAg03CXqd0mCXu434wHczxxze3EHMkKt1O
         DLbnxrs48YIymwBmXhq51EzJ94YGAz76+gX1v58RTyoKxQvuaGe7CD4gVz12knpRznip
         of62Ni0fJYXvrJArFm6nuVJ8bh1P2eHT397b7iEVeSMD1PJlNR1OfkOp1ZuIfKgD4xYy
         /ANA==
X-Received: by 10.66.136.172 with SMTP id qb12mr29068361pab.84.1438539054860;
        Sun, 02 Aug 2015 11:10:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9922:d65f:3652:1a73])
        by smtp.gmail.com with ESMTPSA id ml10sm14964952pab.47.2015.08.02.11.10.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 02 Aug 2015 11:10:54 -0700 (PDT)
In-Reply-To: <CAPig+cQwgYYYYsszaRdJDwFLLB0PmiDQ_WTa+Nzzoq0U1zuMiA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 2 Aug 2015 05:41:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275147>

Eric Sunshine <sunshine@sunshineco.com> writes:

> What I was really asking was whether this sort of checking really
> belongs in git-send-email or if it is better left to Net::SMTP (and
> Authen::SASL) to do so since they are in better positions to know what
> is valid and what is not. If the Perl module(s) generate suitable
> diagnostics for bad input, then it makes sense to leave the checking
> to them. If not, then I can understand your motivation for
> git-send-email doing the checking instead in order to emit
> user-friendly diagnostics.
>
> So, that's what I meant when I asked 'What are the consequences of not
> limiting the input to this "approved" list?'.
>
> The other reason I asked was that it increases maintenance costs for
> us to maintain a list of "approved" mechanisms, since the list needs
> to be updated when new ones are implemented (and, as brian pointed
> out, some may already exist which are not in your list).

Both are very good points.  I do not think we should be limiting the
user input; instead, we (1) either let the Perl module emit proper
diagnosis (e.g. it may say "There is no valid auth method in the
list you gave me, which was 'PLIAN LOGIN CROM-MD5'") and do nothing,
or (2) catch the error from the Perl module and then guess what
happened after the fact (e.g. the module may say in its die() message
something that is understandable by the program but not by the user,
and "eval { ... module call ... }; if ($@) { ... HERE ... }" would
massage what it can learn in HERE from $@ into what the end user
would understand.  It may be that it is sufficient to have something
as simple as this:

	my $msg = "$@"
	if ($smtp_auth is used to customize) {
		$msg .= "\nYour customized <$smtp_auth> might be misspelt?"
	}
	die $msg;

in "HERE" above.

> ...
> Maybe. This leads back to my original question of whether it's really
> git-send-email's responsibility to do validation or if that can be
> left to Net::SMTP/Authen::SASL. If the Perl module(s) emit suitable
> diagnostics for bad input, then validation can be omitted from
> git-send-email.

Yes, exactly.  What happens if we go the route of doing nothing
here?  What are the horrible diagnostic message the end user would
not understand?
