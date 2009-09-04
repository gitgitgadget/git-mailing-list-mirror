From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-config: Parse config files leniently
Date: Fri, 04 Sep 2009 01:40:34 -0700
Message-ID: <7v8wgvyuf1.fsf@alter.siamese.dyndns.org>
References: <7vvdkmte4p.fsf@alter.siamese.dyndns.org>
 <f29b5893b7022f53d380504fe201303acd9ee3da.1251922441.git.git@drmicha.warpmail.net> <7vab1cfr6s.fsf@alter.siamese.dyndns.org> <4A9F733D.5050205@drmicha.warpmail.net> <7viqfz4mu3.fsf@alter.siamese.dyndns.org> <4AA0BE30.1030408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 10:41:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjULr-0001FH-Gp
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 10:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933164AbZIDIkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 04:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933163AbZIDIkq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 04:40:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933082AbZIDIkj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 04:40:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F3C2D256B3;
	Fri,  4 Sep 2009 04:40:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6wXyL+w4fcu9wB8cLPsmHYQPuy4=; b=A4Yb42BiQu60yG5BFB7vEQi
	GTlHvH7Sq37MAU77ckh+s5QuRm9qppvIc3Axv14p0NLBgguhWtp6syRMkzGZEM7b
	aqPN4mDylcWlcUI/x/0C8dw55lrZkt8XzYDgHzRgdbMqgaIkcv3zAuqyQYtp2qt3
	uLP828Lm9QNd0eU4rKB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Ut3lVYol4upvCL+szHJi1voqdO57xZJP5X1JKElIosOH3yV32
	Kc0IAXCbc2+ZsdCO/7uf1c/rYH0u1lY6vOEobOXffrYO9zJZCdlOhn2OUcJvzuDq
	eybgBIVH/7bQB5TUN/uJ0QXp9FMJLoBaFpRniYBpqLoqxQRvwMR39md1S0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B25256B2;
	Fri,  4 Sep 2009 04:40:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BFCC256B1; Fri,  4 Sep
 2009 04:40:36 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9F57B830-992E-11DE-9CCD-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127697>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> *2* Worse yet, the parsing of branch.autosetuprebase is part of the
>> default_config and commands that do not have anything to do with new
>> branch creation will fail with the current setup.
>
> Thanks for the thorough explanations. Especially *2* makes me think that
> quite some restructuring would be necessary in order to "do it right".

We need to distinguish at least the "syntax" and "semantics" errors, i.e.
not necessarily "do it right", but "how your patch should have looked
like".

I think a slightly hacky but practical workaround then becomes possible.
We can have a config callback function to parse only core.editor (and
perhaps some other very minimum set of variables needed to launch the
editor on the right config file) extremely loosely, i.e. not even calling
git_config_string() to complain about error-nonbool.  You can use the
callback _only_ from the ACTION_EDIT codepath in builtin-config.c (which
currently uses git_default_config and errors out when some uninteresting
configuration variables have semantic errors).

That would get rid of the issue that the configuration mechanism triggers
semantic errors for unrelated variables, and would give us a usable
recovery editor, no?
