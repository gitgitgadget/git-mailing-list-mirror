From: <com.git-scm@io7m.com>
Subject: What's "wrong" with this fast-import?
Date: Sat, 12 Dec 2015 19:25:40 +0000
Organization: io7m.com
Message-ID: <20151212192540.4ba49fea@viper.int.arc7.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 12 20:33:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7pvA-0002yV-Lt
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 20:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbbLLTd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 14:33:26 -0500
Received: from nov-007-i611.relay.mailchannels.net ([46.232.183.165]:43123
	"EHLO nov-007-i611.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751901AbbLLTdZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Dec 2015 14:33:25 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Dec 2015 14:33:23 EST
X-Sender-Id: wwwh|x-authuser|com.git-scm+io7m.com@bs3-dallas.accountservergroup.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 043AA120600
	for <git@vger.kernel.org>; Sat, 12 Dec 2015 19:25:51 +0000 (UTC)
Received: from bs3-dallas.accountservergroup.com (ip-10-229-11-165.us-west-2.compute.internal [10.229.11.165])
	by relay.mailchannels.net (Postfix) with ESMTPA id 817D91205CB
	for <git@vger.kernel.org>; Sat, 12 Dec 2015 19:25:50 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|com.git-scm+io7m.com@bs3-dallas.accountservergroup.com
Received: from bs3-dallas.accountservergroup.com (bs3-dallas.accountservergroup.com [10.95.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA)
	by 0.0.0.0:2500 (trex/5.6.1);
	Sat, 12 Dec 2015 19:25:50 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|com.git-scm+io7m.com@bs3-dallas.accountservergroup.com
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1449948350637:530141006
X-MC-Ingress-Time: 1449948350636
Received: from dsl78-143-196-24.in-addr.fast.co.uk ([78.143.196.24]:50754 helo=viper.int.arc7.info)
	by bs3-dallas.accountservergroup.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.85)
	(envelope-from <com.git-scm@io7m.com>)
	id 1a7pnh-000Cbj-8n
	for git@vger.kernel.org; Sat, 12 Dec 2015 13:25:49 -0600
X-AuthUser: com.git-scm+io7m.com@bs3-dallas.accountservergroup.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282304>

Hello!

I'm trying to track down an issue with the Fossil SCM, specifically the
export feature that can produce the fast-import files consumed by Git.

The symptom of the bug seems to be that if a branch B is created from
branch A, files committed to B, and then B merged with A, the committed
files are not present in the head of A.

As an example:

  http://waste.io7m.com/2015/12/12/fossilexport/

The given test.fossil repository was populated with the following steps:

  1. Create fossil repository.
  2. Add README.txt and commit in trunk.
  3. Create branch 'b0' and switch to it.
  4. Add README-b0.txt and commit in b0.
  5. Switch to trunk.
  6. Merge and commit 'b0'.

The HEAD of the fossil repository now contains README.txt and
README-b0.txt.

Exporting the repository (see test.export) produces:

--
blob
mark :4
data 7
Hello.

blob
mark :10
data 10
Hello b0.

commit refs/heads/trunk
mark :3
committer someone <someone> 1449930286 +0000
data 22
initial empty check-in
deleteall

commit refs/heads/trunk
mark :7
committer someone <someone> 1449930317 +0000
data 7
Initial
from :3
M 100644 :4 README.txt

commit refs/heads/b0
mark :9
committer someone <someone> 1449930338 +0000
data 28
Create new branch named "b0"
from :7

commit refs/heads/b0
mark :13
committer someone <someone> 1449930374 +0000
data 13
Add README-b0
from :9
M 100644 :10 README-b0.txt

commit refs/heads/trunk
mark :15
committer someone <someone> 1449930396 +0000
data 8
Merge b0
from :7
merge :13
--

Importing that into git produces a trunk branch that only
contains the file README.txt. Something is evidently being lost in the
merge, but it's not clear how.

Does anyone have any idea what Fossil is doing wrong?

M
