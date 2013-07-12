From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Make check-{attr,ignore} -z consistent
Date: Thu, 11 Jul 2013 23:18:43 -0700
Message-ID: <1373609927-3244-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:18:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWgx-0006km-1o
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab3GLGSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:18:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab3GLGSu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:18:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A53B2B4DB
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=aQ7iKBtwj3erKv1coO6+E5qU21E
	=; b=w3OhPBlDfAiI3wxiF0cy9FV3Np1NWkpn0qO39mzOwMSGqk8avpgn8RXVDbH
	9TMKOm0DiCn/BwmyGfdruRcGwyLb5DFVyFfYGXVzuYlW21Mp9aaOsQYBja2sKttQ
	Er2G2f6oN4ELXxSMIZfmcrDrJtLyjptLjEhjyZL42lunemec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=rVDIji4d7vdAlLMiRUkbf+FjWpa0E
	tI02QLkqdwON3Dj/uq/gOVxlQIP1e3g05AngPTPWCM9rFnx1qppLLe0sQLyl9Lbk
	Vd5CWNGLICpq1MQxFY3br+J2LBHVi2UbBo13vtgTfKNC8FXaO7jE4gUnBWpfF7Xv
	WJXxL4vlYnsy1s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FE5C2B4DA
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A2412B4D9
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:48 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-911-g2c4daa5
X-Pobox-Relay-ID: E9FDCD98-EABA-11E2-A20A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230166>

A command that has to deal with input/output that may contain LF
needs to offer the "-z" (--nul-terminated-records) option, and if it
does not support separate --nul-terminated-{input,output} options,
the "-z" option should govern both input and output.  A caller that
uses "-z" knows that the paths it feeds to these commands as input
may have LF that cannot be expressed in LF delimited input format,
and the output from these commands do contain the same paths, so
there is no way for their output to be expressed unambiguously for
an input that requires "-z".

Unfortunately, "git check-attr -z" was broken and ignored the option
on the output side.  This is a backward-incompatible fix, so we may
need to add a "checkAttr.brokenZ" configuration to allow people to
keep the existing breakage on top of these fixes, and then flip the
default at Git 2.0 boundary (sometime early next year).

Credit goes to Eric Sunshine for finding this discrepancy
($gmane/230158).

Junio C Hamano (4):
  check-ignore: the name of the character is NUL, not NULL
  check-attr: the name of the character is NUL, not NULL
  check-ignore -z: a single -z should apply to both input and output
  check-attr -z: a single -z should apply to both input and output

 Documentation/git-check-attr.txt |  9 +++++++--
 builtin/check-attr.c             | 20 ++++++++++++++------
 builtin/check-ignore.c           | 12 ++++++------
 3 files changed, 27 insertions(+), 14 deletions(-)

-- 
1.8.3.2-911-g2c4daa5
