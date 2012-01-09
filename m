From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitignore: warn about pointless syntax
Date: Mon, 09 Jan 2012 11:43:21 -0800
Message-ID: <7vhb04ek6e.fsf@alter.siamese.dyndns.org>
References: <1326123647-18352-1-git-send-email-jengelh@medozas.de>
 <1326123647-18352-2-git-send-email-jengelh@medozas.de>
 <20120109162802.GA2374@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 09 20:43:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkL7y-0007QZ-4t
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 20:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230Ab2AITnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 14:43:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933046Ab2AITnX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 14:43:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E3D05205;
	Mon,  9 Jan 2012 14:43:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RGSnRGe3qDod7zT5d2k/CR4BxWc=; b=ya864Z
	BrQOWnwajzrwxVqfMajwX0TDfeGZ1ph3tlE/XGwCjrgsbFAhqGLQafWoiUpzFqHk
	McbozlxgRai+AZxuAoyuRJAzWAc03+mit3XX3vbuXAYwYhfPlwJgg9jae4+6XNUd
	QjCdC/G+Z93jmzosA3+X5cKAYktU9zgZYH1JA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cj4pieYQXA0lc4hIRiCq4r2Q+K+50kHd
	ALk0V1IcM0eJaRbCSEtPtnO5YBkY1u7TEkk+DR7BUkAfWbQEgOAoKhk93fAQ2nMz
	KuKy5X0+XtynowSaGhGRdkBNpaHm0FSANO5JAlMBTzgPdoteNuPSjz/3B3xzgKLT
	hOTV8s+TnNQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35AB05204;
	Mon,  9 Jan 2012 14:43:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC0205201; Mon,  9 Jan 2012
 14:43:22 -0500 (EST)
In-Reply-To: <20120109162802.GA2374@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 9 Jan 2012 11:28:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3076FB40-3AFA-11E1-B076-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188185>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 09, 2012 at 04:40:47PM +0100, Jan Engelhardt wrote:
>
>> +static inline void check_bogus_wildcard(const char *file, const char *p)
>> +{
>> +	if (strstr(p, "**") == NULL)
>> +		return;
>> +	warning(_("Pattern \"%s\" from file \"%s\": Double asterisk does not "
>> +		"have a special meaning and is interpreted just like a single "
>> +		"asterisk.\n"), file, p);
>
> Wouldn't this also match the meaningful "foo\**"?

Yes.

But trying to catch that false positive by checking one before "**"
against a backslash is not a way to do so as it will then turn "foo\\**"
into a false negative, and you would end up reimplementing fnmatch if you
really want to avoid false positives nor negatives. At that point, you may
be better off implementing git_fnmatch() instead that understands the
double-asterisk that works as some people may expect it to work ;-).
