From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] describe --contains / name-rev --weight
Date: Wed, 29 Aug 2012 20:50:23 -0700
Message-ID: <1346298629-13730-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 05:51:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6vmu-0007XS-AY
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 05:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab2H3Dud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 23:50:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab2H3Duc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 23:50:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E0C488A2
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=p2V0rYIfuaK22gyPOJ4eRcSvqLY
	=; b=HJYLdk3M7Fc8s+CV9bIvyKqGSfNc5KQ5PbOmgZmb3jb/v0xoL73e7Rvz/49
	UL4V17fgtGLeUX3bO3AbOwpf4LDd68QKj6O9wSsCjV9wl93XjRS6hJc7LcQDkBsR
	gdCRUZWXD8pWQQVkQR7qTsnKVcZQULvQQ2cI5Ja+SmkgA5JI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=nInmhGnLtzE5cj4Oy0arh//+Q9N9d
	cmMieBLZotcgCf4q5CIaX3Sr8YIaVyq2c8xrqM/u48Jt3GsuFdEmDFRNAKxQUSYl
	W2e5FX9xU1ROJaItD7wXSATVqLSYy1N0X8eDBkLMX5zb+R1OJop14kqiOCTg2CQz
	IpxIE5NzMKwSMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DB5F88A1
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA24B889E for
 <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.286.g9df01f7
X-Pobox-Relay-ID: D8119EA6-F255-11E1-9525-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204509>

Greg KH noticed that the commit 0136db586c that was merged to the
mainline back in v3.5-rc1 days was merged again as part of a
different branch to the mainline before v3.6-rc1.

"git describe --contains" gives the commit a name based on the newer
v3.6-rc1 tag, which was surprising.

This is because "describe --contains" calls "name-rev", which tries
to use the tag that minimizes the steps between the tag and the
commit being named.  The branch merged recently to the mainline did
not have as much work done on top of the commit as the old branch
that was merged earlier, and "name-rev" chose to use the newer tag
to base the name on.

The new "--weight" option introduced by this series tells it to use
the oldest tag that contains the commit being named instead.  This
matches what people expect from "describe --contains" better.

Junio C Hamano (6):
  name-rev: lose unnecessary typedef
  name_rev: clarify the logic to assign a new tip-name to a commit
  name-rev: --weight option
  name-rev --weight: cache the computed weight in notes
  name-rev --weight: tests and documentation
  describe --contains: use "name-rev --weight"

 Documentation/git-name-rev.txt |  14 ++-
 builtin/describe.c             |   3 +-
 builtin/name-rev.c             | 195 ++++++++++++++++++++++++++++++++++++-----
 t/t6039-name-rev.sh            |  62 +++++++++++++
 4 files changed, 248 insertions(+), 26 deletions(-)
 create mode 100755 t/t6039-name-rev.sh

-- 
1.7.12.286.g9df01f7
