From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] "diff --no-index" updates
Date: Wed, 25 Mar 2015 23:20:30 -0700
Message-ID: <1427350832-17005-1-git-send-email-gitster@pobox.com>
References: <xmqqiodtd3b4.fsf@gitster.dls.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 07:20:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb19t-00054c-27
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 07:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbbCZGUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 02:20:37 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750838AbbCZGUg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 02:20:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 677423C8C0;
	Thu, 26 Mar 2015 02:20:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/vQb
	nGx3CZU6Nr5LdtP/rCDMuZQ=; b=th2L0DaNbk4Fr3iWYy6g9rpmO3Wz3WTN/qw/
	ide+Iaof78tJO41tERDQXt7kwKd7Rl4qdNOqmPXedHrstpxA3NRxGsjS5WEsa1yN
	M1zlnPsKGcmkShR1ibrhfVzPjZwQ8pmN0wZTlpghihqABjGuITz27qanX/EHRCaB
	0pOErTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bLpHFw
	3jfMzBRemwseGjE/0OIBxK0aeG+DtjD6tCS+tdA1y4cdNLKsCQRAcIO+/UuHFY7w
	Yd1XnpiYiXEyl975sHCpF1coXthTF+S+ySy3Yu+UyRoVDnbyA/SJIc2tkxgWtrwO
	g9IpP63v4f19WclMGASmN0PT6u4eUa62Fdvys=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 616233C8BF;
	Thu, 26 Mar 2015 02:20:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E59A43C8BE;
	Thu, 26 Mar 2015 02:20:33 -0400 (EDT)
X-Mailer: git-send-email 2.3.4-477-g2c00653
In-Reply-To: <xmqqiodtd3b4.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: 35C7DD9A-D380-11E4-A80A-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266315>

Here are a few patches to scratch my itches in "diff --no-index" I
have had for quite some time, but didn't feel strong enough to fix
them myself so far.

The first one is to make "diff File Directory" (and "diff Directory
File") more useful by aligning its behaviour with more mainstream
"diff" implementations.  We used to complain that one is a file and
the other is a directory and died without doing anything useful.
Instead, we pretend as if the user asked to compare "diff File
Directory/File" (or vice versa), which is what GNU diff does.

The second one on the other hand is to make it behave more like the
normal "git diff" when comparing two directories, when one directory
has a path as a file while the other directory has the same path as
a directory.  GNU diff punts and says "File D1/path is a regular
file while file D2/path is a directory" in such a case, and that is
what "diff --no-index" does, too, but when the normal "git diff"
compares two such trees, we show a removal of the file and creations
of all the files in the directory (or vice versa).  With this patch,
we teach "diff --no-index" codepath to do the same, which would be
more in line with the spirit of "diff --no-index", which is to make
"git diff" goodies available to people who compare paths outside
control of any git repository.

Junio C Hamano (2):
  diff-no-index: DWIM "diff D F" into "diff D/F F"
  diff: align D/F handling of "diff --no-index" with that of normal Git

 diff-no-index.c          | 66 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t4053-diff-no-index.sh | 34 +++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 2 deletions(-)

-- 
2.3.4-475-g3180e2e
