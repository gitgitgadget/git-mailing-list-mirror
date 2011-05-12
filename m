From: Michael J Gruber <drmicha@warpmail.net>
Subject: RFC proposal: set git defaults options from config
Date: Thu, 12 May 2011 16:35:11 +0200
Message-ID: <4DCBF01F.9040009@warpmail.net>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com> <4DCB88C1.20105@drmicha.warpmail.net> <20110512080425.GA11870@sigill.intra.peff.net> <4DCB96F9.2020700@drmicha.warpmail.net> <20110512082210.GA16813@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	David Pisoni <dpisoni@gmail.com>,
	GIt Mailing List <git@vger.kernel.org>,
	Git Maintainer <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 12 16:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKWz3-0004Pm-QK
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 16:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757774Ab1ELOfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 10:35:15 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46351 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757527Ab1ELOfO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 10:35:14 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6BFE5209D0;
	Thu, 12 May 2011 10:35:13 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 12 May 2011 10:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=X4Dfcj+FIREPzO8RFt4iGZGY/NA=; b=jRZjL3xSaNXa7CrwkyONsoiwzr+58fLyFPAb5zV8fUg4+lu1ASng+x71q5p+GyitGz6P75rAbWS9R5Vwszwzp+Iib0tKcYR0uO5Owkx+rj7NC5zHnJmNJoSybEF18Nyrhkjd35jXJMvUWs68IF4JSaMnzucmmLeZhGEtDoEmT18=
X-Sasl-enc: DSUm8D42C01NSB9eJ7H2AyMGOHhf7WfNoAoT/rX1017R 1305210913
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 93666447D35;
	Thu, 12 May 2011 10:35:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110512082210.GA16813@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173471>

Mechanism
=========

I propose the following mechanism for setting default command line
options from the config:

options.<cmd> = <value>

is a "multivar" in git-config speak, i.e. it can appear multiple times.
When running "git <cmd> <opts>", our wrapper executes

git <cmd> <values> <opt>

where <values> is determined by the following rule in pseudocode:

if $GIT_OPTIONS_<cmd> is unset:
  <values> := empty
else:
  for <value> in $(git config --get-all options.cmd):
    if <value> matches the regexp in $GIT_OPTIONS_<CMD>:
      append <value> to <values>

Examples
========

* By default, no options can be overriden from config (other than those
which have config vars already, of course).

* A script which wants to protect options "foo" and "bar" of "cmd" from
being set by config sets GIT_OPTIONS_CMD="!(foo|bar)".

* A script which wants to allow overriding options "foo" and "bar" of
"cmd" by config (but nothing else) sets GIT_OPTIONS_CMD="foo|bar"

NOTES
=====

* This can be done by commit_pager_choice() or by a call right after
that in those places.
* regexp notation/version to be decided
* We should probably do this for long options only (and insert
"--<value>" rather than "<value>" to spare the "--" in config).
* We should probably do a prefix match.
* We could use GIT_OPTIONS_<CMD>_ALLOW and GIT_OPTIONS_<CMD>_DENY rather
than rely on negated regexps (if DENY matches deny, otherwise if ALLOW
matches allow, otherwise deny).
* We can get rid of a few config vars then...and may need to clean up
our option names.

Taking cover...

Michael
