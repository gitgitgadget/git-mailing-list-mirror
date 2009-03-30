From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test-suite: adding a test for fast-export with tag 
 variants
Date: Sun, 29 Mar 2009 19:50:37 -0700
Message-ID: <7vab73pvuq.fsf@gitster.siamese.dyndns.org>
References: <1237812789-1360-1-git-send-email-kusmabite@gmail.com>
 <40aa078e0903291305p28ec2ae8xf0cb465e593af0b0@mail.gmail.com>
 <7vwsa8ow10.fsf@gitster.siamese.dyndns.org>
 <40aa078e0903291444m3a29662j3162ed511eee0ac8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 04:52:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo7bl-0007LO-Ob
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 04:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757533AbZC3Cut convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 22:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756740AbZC3Cut
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 22:50:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922AbZC3Cus convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 22:50:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A102AD20;
	Sun, 29 Mar 2009 22:50:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 54DFEAD1E; Sun,
 29 Mar 2009 22:50:41 -0400 (EDT)
In-Reply-To: <40aa078e0903291444m3a29662j3162ed511eee0ac8@mail.gmail.com>
 (Erik Faye-Lund's message of "Sun, 29 Mar 2009 23:44:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 90E5C768-1CD5-11DE-856B-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115054>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

>> But running the tests with the first patch applied to the same base =
as
>> where v1 was applied gives this, which is a more serious issue:
>>
>> =C2=A0 =C2=A0$ sh t9301-fast-export.sh 2>&1 | tail -n 2
>> =C2=A0 =C2=A0* still have 4 known breakage(s)
>> =C2=A0 =C2=A0* failed 6 among remaining 15 test(s)
>>
>> In other words, the changes to the set-up part seem to break unrelat=
ed
>> tests. =C2=A0Why can such an update supersede the previous one?
>
> That's weird. I did test it properly before I applied it, and I don't
> recall having any failures on Linux.

I think it is just the matter of doing something like this instead of y=
our
patch [PATCH v2 1/4].  Either that, or I think you need to adjust the
existing tests that try to export --all and get hit by the fast that yo=
u
added the tags you already knew the old code had trouble with in the te=
st
setup for them.

-- >8 --
=46rom: Erik Faye-Lund <kusmabite@gmail.com>
Date: Mon, 23 Mar 2009 12:53:06 +0000
Subject: [PATCH] test-suite: adding a test for fast-export with tag var=
iants

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9301-fast-export.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 86c3760..2e31f67 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -259,4 +259,20 @@ test_expect_success 'cope with tagger-less tags' '
=20
 '
=20
+test_expect_success 'set-up a few more tags for tag export tests' '
+	git checkout -f master &&
+	HEAD_TREE=3D`git show -s --pretty=3Draw HEAD | grep tree | sed "s/tre=
e //"` &&
+	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
+	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
+	git tag    tag-obj_tag     -m "tagging a tag" tree_tag-obj &&
+	git tag -a tag-obj_tag-obj -m "tagging a tag" tree_tag-obj
+'
+
+# NEEDSWORK: not just check return status, but validate the output
+# two tests commented out due to crash and thus unreliable return code
+test_expect_failure 'tree_tag'        'git fast-export tree_tag'
+test_expect_failure 'tree_tag-obj'    'git fast-export tree_tag-obj'
+test_expect_failure 'tag-obj_tag'     'git fast-export tag-obj_tag'
+test_expect_failure 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj=
'
+
 test_done
--=20
1.6.2.1
