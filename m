From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-config: Parse config files leniently
Date: Thu, 03 Sep 2009 16:42:28 -0700
Message-ID: <7viqfz4mu3.fsf@alter.siamese.dyndns.org>
References: <7vvdkmte4p.fsf@alter.siamese.dyndns.org>
 <f29b5893b7022f53d380504fe201303acd9ee3da.1251922441.git.git@drmicha.warpmail.net> <7vab1cfr6s.fsf@alter.siamese.dyndns.org> <4A9F733D.5050205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 01:42:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjLwy-00073D-IU
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 01:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbZICXme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 19:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbZICXme
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 19:42:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbZICXmd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 19:42:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8122924AFE;
	Thu,  3 Sep 2009 19:42:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=SpaoMRTd+Z0AtwR1FBXC/MGrXEI=; b=pu2sGIv0cYTDBKi+6chzfZb
	gGG44w8ll0zk6YMMOfqBJaaGhPcn75DZoWo5xaeAjWchOaACiVQzQHlmey1wF+ip
	UrTg2tx2vbZy6a7MDcMvVdi3hi2ZT8tJyjOZOziWVrtVXYT3pEyB+B5iHBTspzkW
	8bHK7t7/W3hjOV8U59s8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yMh3dKCZcuaxwfibzitFq4lDe5ida/f5QvWK6XY2K2XYtnLkZ
	WCAUDr5A14cGb/My+xSvJ6OSbTlhhKBQXRP6bZvglZL0fLVKv8wYfRIcyhlCPhrK
	MhNZLKlDYbsvyVs3ikG5CGOYNlgSXwQGI33xVFZcUYALO7mhifOQQZrs6I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6242A24AFC;
	Thu,  3 Sep 2009 19:42:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9670624AF8; Thu,  3 Sep
 2009 19:42:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 73B05EB2-98E3-11DE-9383-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127671>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Why was I CC'ed, if the patch wasn't even self tested?
>
> Because
> - not CC'ing you would have meant culling you from the existing CC,
> - we've discussed v1 of this patch before,
> - I asked in this patch (v2) whether to go for an alternative.

Oh, so you did not mean this was for inclusion but as another round
of RFC.  I misread your intent.  Sorry about that.

The eralier analysis of the cause of the breakage indicated that the
implementation in this patch was flawed.  What it essentially did was to
re-define all die() to warn() in the codepaths around configuration
variable handling [*1*].

However, it does not mean that the idea of "ignoring syntax errors while
keeping other errors still noticed for all commands, not limited to config
nor not limited to 'config -e'" is necessarily flawed.

For example, the test I noticed the breakage with was stuffing an invalid
value to branch.autosetuprebase and wanted to see "git branch" fail.

Obviously we do want to fail a "git branch newbranch origin/master" when
the value given to branch.autosetuprebase is misspelled, to avoid creating
bogus settings the user did not intend to.  We do care about semantic
errors (i.e. this variable can take only one of these values, but the
value given in the file is bogus) in such a case.  But if you are running
"git branch" only to view, but not to create, there is no reason for us to
care about the branch.autosetuprebase variable [*2*].

This observation suggests that it may make sense to make the error
handling _even looser_ than what you intended to do in your patch (which I
assume was "we ignore syntax errors and try to recover, pretending that we
saw a comment until the end of line, but we still keep the validation of
values assigned to variables that the existing commands rely on").

Ideally, the rule would be "we care about the values of variables we are
going to use, but allow misspelled values in variables that are not used
by us---we have no business complaining about them."  Unfortunately that
is much harder to arrange with the current code structure, but under that
rule, "config -e" would care only about "core.editor" and nothing else, so
as long as that variable can be sanely read, it should be able to start.


[Footnotes]

*1* The additional test that came with the patch only checked for the
positive case (i.e. "does the system with this patch treats errors looser
than before?"), but failed to check the negative case (i.e. "does the
change too much and stop catching errors that should be caught?"), which
unfortunately is a common mistake that easily lets bugs go unnoticed.

*2* Worse yet, the parsing of branch.autosetuprebase is part of the
default_config and commands that do not have anything to do with new
branch creation will fail with the current setup.
