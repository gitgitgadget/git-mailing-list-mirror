From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] branch: allow creating a branch with same name and
 same starting point.
Date: Sun, 17 Jan 2010 11:38:33 -0800
Message-ID: <7vzl4cy11i.fsf@alter.siamese.dyndns.org>
References: <1263737212-8101-1-git-send-email-Matthieu.Moy@imag.fr>
 <1263737212-8101-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jan 17 20:38:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWaxT-0002Gs-Gg
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 20:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570Ab0AQTin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 14:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754545Ab0AQTin
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 14:38:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab0AQTim (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 14:38:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CB7C91C97;
	Sun, 17 Jan 2010 14:38:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=soGVTfaRzpzfe+kn1P7C6w/0hfk=; b=cht3tM
	p1tshfGl0nLLkRwu7LiDZZCJ0K41S2kwGQJnQb8aZdyjOBiBoU/8PCNgXx9GHIOc
	rSIngfT7UFjpAM6vpqtOJBgk6vCkoFZFkuL8dFWmS3GCvTkU2iuRLsk1JhGuNBXG
	E+VOvsCxEZngQ1vGty2iw7jUGREOGImku4/wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AbhmqeZZBy6LMkzHxV7UNTQ/WXE3KXyA
	XzBCCk9lHyaldRf2aIOzyZeeKyGw/+GQga9RqgLPGoiGOgHu/p83iXSnNuvnzKQV
	GDUbKDMKxGoHEpGrxrU7o2pW9XRVfll/CfO8UIgFFS1728y6+oLkF6eDzP9+/XSm
	6hNYzVSjagc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3619891C96;
	Sun, 17 Jan 2010 14:38:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78F7491C95; Sun, 17 Jan
 2010 14:38:35 -0500 (EST)
In-Reply-To: <1263737212-8101-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Sun\, 17 Jan 2010 15\:06\:51 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E8A066BE-039F-11DF-BC81-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137313>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Previously, "git branch --track newname old" was rejected if newname
> existed, even if it already had the same value. This patch allows it,
> even without --force. This has two advantages:
>
> * Not requiring --force for a safe operation, hence allowing the user to
>   benefit from the other safety checks.
>
> * Allow changing the configuration of the checked-out branch.

Two issues I have to ask because you didn't cover these cases in your
tests [*1*]:

 - What should "git branch new old" do when (0) local branch new already
   exists and points at old, (1) branch.new.{remote,rebase,merge} do not
   currently exist, and (2) branch.autosetup{merge,rebase} is set?

 - What should "git branch --no-track new old" do when (0) local branch
   new already exists and points at old, (1)
   branch.new.{remote,rebase,merge} do currently exist?

No matter what they do, should there be some extra message when the new
code does something that the old code didn't do?

> +test_expect_success 'setup tracking with branch --track on existing branch' '
> ...
> +	git branch from-master master --track &&

The parser may be too loosely implemented and might allow this today, but
please stick to "command names then dashed options and then arguments".

We have to fix the parser someday to be more strict and broken order in
tests like this will get in the way.

> +	git config branch.from-master.merge > actual &&
> +	grep -q "^refs/heads/master$" actual
> +'
>  test_done

[Footnote]

*1* it is an easy trap to fall into to test only what it newly does while
showing your shiny new toy and forget to test conditions that the shiny
new toy should not kick in.
