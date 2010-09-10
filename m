From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Alt. PATCH] format-patch: do not use diff UI config
Date: Fri, 10 Sep 2010 09:21:19 -0700
Message-ID: <7vzkvph8n4.fsf@alter.siamese.dyndns.org>
References: <1284019625-14096-1-git-send-email-ods15@ods15.dyndns.org>
 <2a6b8c51903fd6a22606b8f592b1a2e11ea68741.1284020917.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Oded Shimon <ods15@ods15.dyndns.org>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Sep 10 18:21:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou6M6-0006DY-O5
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab0IJQVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 12:21:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab0IJQVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 12:21:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1F59D5DB0;
	Fri, 10 Sep 2010 12:21:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZxfNKbflnruV5LmB4POvnRNvlQw=; b=cC3djSiYeYjaeS2bWHJHYFu
	QwcEGh9tDlYohxbNtEzpyIJCndSLL3zrQ+fXGZL9N5C4voXNaxzMmPutG6sXSQu9
	XsYR2sp+YB0WsWSDZS1wzpG+2B2a8WE0q65/ulhpCbwTB4fMDyD5SIG4YyeYQDjG
	deQjcj8sD8WQdrzD6TWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=qNm+L6rUrqY7d/LC/2y27v5cu605SgXSM7l5d5jEzRyvJzFnT
	AqwawVDZWoEg/aq/IrAyi4fwASoMtbVNPkGrhoz85QZ3HZzgrnTTgZXica8wOQzo
	rg3rUX6mRTvaZyJCJuSakxMisogrjy9LGb1lbBKnc3ui035CS4WALSFdDs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58BB0D5DAA;
	Fri, 10 Sep 2010 12:21:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59A36D5D9C; Fri, 10 Sep
 2010 12:21:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75C76D9C-BCF7-11DF-B653-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155943>

Thomas Rast <trast@student.ethz.ch> writes:

> ...
> arguably only diff.renames (and perhaps diff.ignoresubmodules, I don't
> use them) should affect format-patch.  Everything else undermines the
> guarantee (by having a consistent format) that format-patch|am works.

We need to be a bit careful here.

Each user must be able to find a combination of ($opts1, $opts2) to make
"format-patch $opts1 | am $opts2" run correctly with his funny settings
(e.g. diff.noprefix).  We must guarantee that [*1*].

I however don't think we need to guarantee that the pipeline always works
for empty opts1/2, and certainly we shouldn't insist what flows in that
pipe must be the bog-standard -p1 with a/ b/ prefix patch.  For example,
in circles under svn influence, people may prefer opts1=--no-prefix, and
as long as the recipient understands that is the community norm around
there, he can run his "am" with -p0 and everything should work.  It is not
unreasonable for the sender to have diff.noprefix in the repository config
in such a setup, don't you think?

There is no way to easily affect what options the "format-patch | am"
pipeline uses inside rebase.  It may make sense to introduce --rebasing
option to format-patch to cause it to ignore any funny setting the user
might have, so that we don't have to keep adding options to the command
invocation.  "am" has --rebasing already, and it may be beneficial to
teach the codepath to defeat some configuration variables in a similar
way.


[Footnote]

*1* ... within reason.  For example, I don't think there is no opts2 if
you had opts1="--src-prefix=a/ --dst-prefix=b/c/" that makes the pipeline
work reasonably.
