From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/3] Fix how for-each-ref handles broken loose references
Date: Mon,  1 Jun 2015 17:53:48 +0200
Message-ID: <1433174031-5471-1-git-send-email-mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 17:54:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzS2X-0002ne-7e
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 17:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbbFAPyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 11:54:10 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48709 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753473AbbFAPx7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 11:53:59 -0400
X-AuditID: 1207440d-f79026d000000bad-3f-556c80147625
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 74.1F.02989.4108C655; Mon,  1 Jun 2015 11:53:56 -0400 (EDT)
Received: from michael.fritz.box (p4FC96750.dip0.t-ipconnect.de [79.201.103.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t51FrsEn010505
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 1 Jun 2015 11:53:55 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqCvSkBNq8OaKocWZvnCLrivdTBYN
	vVeYLW6vmM9s8aOlh9li8+Z2Fgc2j7/vPzB5LNhU6tF05iizx7PePYweFy8pe3zeJBfAFsVt
	k5RYUhacmZ6nb5fAnfFyUhNjwVKuiidTe1gbGJdzdDFyckgImEg8mTKTBcIWk7hwbz0biC0k
	cJlR4vy6ui5GLiD7OJPEqbvHWEESbAK6Eot6mplAbBEBNYmJbYfAmpkFNjNKdD4MArGFBTwl
	zjW9BxvEIqAqceTsT0YQm1fAWWLNoylQy+Qkzh//yTyBkXsBI8MqRrnEnNJc3dzEzJzi1GTd
	4uTEvLzUIl0jvdzMEr3UlNJNjJCQ4d3B+H+dzCFGAQ5GJR7ejO7sUCHWxLLiytxDjJIcTEqi
	vM6VOaFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHitKoByvCmJlVWpRfkwKWkOFiVxXrUl6n5C
	AumJJanZqakFqUUwWRkODiUJ3tl1QI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnx
	oECPLwaGOkiKB2hvNEg7b3FBYi5QFKL1FKOilDjvPpCEAEgiozQPbiwsEbxiFAf6Upj3P0gV
	DzCJwHW/AhrMBDS4XQBscEkiQkqqgdEzN2/LsqgXomm3AnPFvxv6KVRn3vkj/7BlTnL19Jfx
	bXNFFNQtFMWEn6wvFf9/TfaJoC2DTVr7IanvK59b6D3pWtd2OUn5PE9h5arg983nVsp0nIhV
	WJVxK89IWHnn+dacNcU7jjkei8i9YLki9odw/ss5jI/+LefJ3LpO6OrbzNviB9re 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270429>

Currently, "git for-each-ref" fails to handle REF_ISBROKEN references
correctly, treating them instead as valid references that point at
NULL_SHA1. Sometimes this makes for-each-ref emit the wrong error
message; sometimes it even appears to complete successfully.

Instead, emit warnings for broken references but otherwise ignore
them. Also, add special-case code to defend against an actual
NULL_SHA1 in a loose reference file being treated as valid. (We've
seen that problem on our servers before, probably caused by the Ruby
Git client that we used to use.)

This patch series was prepared against "maint" as it might be suitable
for that branch, but it also applies cleanly against "master".

This patch series is also available from my GitHub account [1], as
branch for-each-ref-errors.

[1] https://github.com/mhagger/git

Michael Haggerty (3):
  t6301: new tests of for-each-ref error handling
  for-each-ref: report broken references correctly
  read_loose_refs(): treat NULL_SHA1 loose references as broken

 builtin/for-each-ref.c         |  5 +++++
 refs.c                         |  7 +++++++
 t/t6301-for-each-ref-errors.sh | 45 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100755 t/t6301-for-each-ref-errors.sh

-- 
2.1.4
