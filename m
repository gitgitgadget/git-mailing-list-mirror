From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for
 .gitattributes
Date: Mon, 15 Oct 2012 09:54:34 -0700
Message-ID: <7vfw5fy8tx.fsf@alter.siamese.dyndns.org>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-3-git-send-email-pclouds@gmail.com>
 <50758477.3030304@viscovery.net> <7vtxu2ayov.fsf@alter.siamese.dyndns.org>
 <50765CDC.8020509@viscovery.net> <7vpq4p80sn.fsf@alter.siamese.dyndns.org>
 <5077C7AC.9010301@viscovery.net> <7v4nlx3cc8.fsf@alter.siamese.dyndns.org>
 <507BA6F0.4090500@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 18:54:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNnwH-00016M-Sg
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 18:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab2JOQyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 12:54:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061Ab2JOQyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 12:54:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C10869372;
	Mon, 15 Oct 2012 12:54:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lHaRlkQiIYbWLhTmehDMPQLM3QA=; b=pmQfPI
	hblPUe8G5E9uS3mm2uGFo4FdWXZvAeMhCf5715BxbeovGMyXFjRpGY3K8IeLCfmX
	fDvC1uSC59JXZmZuTB2q6hcoe010SeK6bnVqKvj/g0KvJa2NJrHL4Vpr36DJI6NG
	/FDkzOgbXpu+XP61ZdbptnnmmbSarBpgHK6gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZaaTfWOQbOedP5ENJhsHlYu5nEkSel1q
	N2Y1tsgkjHPBtaqgZgAeKpHOLx0d4uvJLhvNLTo99LU/ZJzaAnFxARV8EXhjudTQ
	GzBv5c2VWWTgfy7NH7gpyVgGDLeio9OqftiTlXNXMqX1IYnr293Gigt2HAAfNCa+
	+HVz5uA9Zxw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACE9F9371;
	Mon, 15 Oct 2012 12:54:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B7A2936F; Mon, 15 Oct 2012
 12:54:36 -0400 (EDT)
In-Reply-To: <507BA6F0.4090500@viscovery.net> (Johannes Sixt's message of
 "Mon, 15 Oct 2012 08:02:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00352A4E-16E9-11E2-9E71-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207761>

Johannes Sixt <j.sixt@viscovery.net> writes:

> For fflush() (as in write_or_die.c), EINVAL is not even listed
> as possible error code. Therefore, catching EINVAL wholesale should not be
> a problem, IMO, at least not "on other systems".

I see a disturbing gap between "EINVAL is not supposed to be even
possible" and "therefore it is safe to ignore".  Our usual attitude
towards catching errors is to ignore only specific things that are
expected to happen and known to be safe, e.g. the original code
before that patch which special cased to ignore EPIPE with

	if (fflush(f)) {
		if (errno == EPIPE)
                	exit(0);
		die_errno("write failure on '%s'", desc);
	}

where we know we are often downstream of something else and
diagnosing EPIPE as an error is actively wrong.

Unless you assume that *no* other platform has the same glitch as
Windows has with respect to fflush(f) returning EINVAL, or any other
platform that may return EINVAL from fflush(f) has the exactly same
glitch as Windows, ignoring EINVAL unconditionally everywhere is
wrong.  Perhaps the next broken platform may return EINVAL when it
should return EIO or something.  Ideally, that earlier workaround
should have done a logica equivalent of:


	if (fflush(f)) {
#ifdef WINDOWS		
		/*
		 * On Windows, EPIPE is returned only by the first write()
		 * after the reading end has closed its handle; subsequent
		 * write()s return EINVAL.
		 */
                if (errno == EINVAL && this is after a second write)
			errno = EPIPE;
#endif
		if (errno == EPIPE)
                	exit(0);
		die_errno("write failure on '%s'", desc);
	}

and did so not in-line at the calling site but in a compat/ wrapper
for fflush() to eliminate the need for the ifdef.

> But reverting the EINVAL check from write_or_die.c is out of question,
> because that handles a real case.

I am not saying we should not deal with EINVAL on Windows at all.  I
am just saying ignoring EINVAL on other platforms is wrong, and
these two shouldn't have been mutually incompatible goals.
