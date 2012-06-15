From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/5] git log -L, all new and shiny
Date: Thu, 14 Jun 2012 21:40:53 -0700
Message-ID: <7vlijpchm2.fsf@alter.siamese.dyndns.org>
References: <cover.1339063659.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jun 15 06:41:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfOLG-0005rW-Aq
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 06:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139Ab2FOEk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 00:40:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36957 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab2FOEk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 00:40:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FA0D8CB7;
	Fri, 15 Jun 2012 00:40:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CXsX8uMMOmEvbzxc5su4wzY1Kn0=; b=CgzoF5
	INNNSLdkYQB1NoCS+4tGrrZOBzF1+gLth0ge43tnpkBCTPGGZVZqCP1C1KAnG4pj
	EnXhnzRU7KaAsWOBgCjYhOB2nCkajgUSvK4z4AlqYue/dsiOYhpVAGzCipi4sdLi
	GUNN5jUjYF5ZhbaslErW5KW0pIIoc3JNgKuD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QMFNB+BfOYfr3YGMTE0JrVIJcqG06J/V
	IbUqLxlWSGJjTcKZzVoCrmGG1H7IraHTNmzrfqT33KV50KpF27aM/GjCWNCBIt0J
	wghqkfA/kHhRNZvrUChMYEZUXXeFELKofZwc2d7XXIAuvOSk2f/J0IvKKXCsJC36
	ADuzM19KPtA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 263728CB6;
	Fri, 15 Jun 2012 00:40:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B9798CB4; Fri, 15 Jun 2012
 00:40:55 -0400 (EDT)
In-Reply-To: <cover.1339063659.git.trast@student.ethz.ch> (Thomas Rast's
 message of "Thu, 7 Jun 2012 12:23:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B908A9C-B6A4-11E1-9CA6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200039>

Thomas Rast <trast@student.ethz.ch> writes:

> I too thought it would never happen -- but then again this is still
> not ready, I'm just trying to give it some exposure.
> ...
> There's also a longer-term wishlist hinted at in the commit message of
> the main patch: the diff machinery currently makes no provisions for
> chaining its various bells and whistles.

I am not convinced that it is "diff machinery makes no provivsions"
that is the problem. Isn't it coming from the way the series limits
the output line range and reimplements its own output routine?

All the "bells and whistles" like diffstat, word coloring, etc. go
through the xdi_diff_outf() interface, so isn't it the matter of
limiting lines that this interface calls back the "bells and
whistles" callback functions with?

When you enter the diff machinery, you have the path and the line
range you are interested in of one side (lets say you are comparing
side A and B, and have line range for side A).

If you

 - add a mechanism to pass the "interesting" line range and path
   down to the callchain from xdi_diff_outf() to xdiff_outf();

 - make one of these functions filter out (i.e. not call the
   callback xdiff_emit_consume_fn) hunks that do not overlap with
   the line range you are interested in (I would presume that they
   would be a few new fields in xdemitconf_t structure); and

 - while recording the corresponding line ranges in the other side
   of the hunks that are output,

that would give you

 - output that is limited to the "interesting" input range of side A;

 - the corresponding "interesting" range in the other side of the
   comparison, so that you can update the "interesting" range to
   feed to the next diff that compares side B with something else; and

 - for whatever processing the various "bells and whistles" callers
   already implement, as all their callbacks see are the lines in
   your "interesting" range.

No?  Am I missing something?
