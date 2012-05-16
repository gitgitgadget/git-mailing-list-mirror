From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] git-sh-setup: work around Cygwin path handling gotchas
Date: Wed, 16 May 2012 11:00:08 -0700
Message-ID: <1337191208-21110-3-git-send-email-gitster@pobox.com>
References: <4FB09FF2.70309@viscovery.net>
 <1337191208-21110-1-git-send-email-gitster@pobox.com>
Cc: Steven Penny <svnpenn@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 20:02:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUiYA-0001FY-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 20:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760043Ab2EPSCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 14:02:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760039Ab2EPSCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 14:02:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26977827B;
	Wed, 16 May 2012 14:02:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=w1Ow
	nGTw9fazkIV9ePmpWEVu+aI=; b=Qv4gQikAwyVU8wTZ84QPJJXzXmW7n+YDseXp
	tQPde2BNGOhKIRHVNZHRc0b/IO7QV5VCwSyxbPZ4/wWDkZTA8LQQ0RZAEXezoAIL
	utsGMWPilWVkZvJXVRRMfsRlYFIILmz5c6TSHuD7zea77VK8s1AIP9KAlWx7V7jk
	tboChd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	W6wr68oOsbEKyPOzWzgzXushBKU3AMO/fHWemcZdglm/RlpIg7r/GVSEP2NvCutZ
	ixZ8RGVm2MV7wqepWmIywVlHimXnnIHrf/xETFGQFcFbEfQI2TbsS4OUJ/WzFd4z
	r6aUujF9V7BincVBCOdBB/IZijb3gqtpy/yLKU4Q+jo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D4048279;
	Wed, 16 May 2012 14:02:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DB588278; Wed, 16 May 2012
 14:01:59 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.2.537.g0ac6509
In-Reply-To: <1337191208-21110-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3B83B492-9F81-11E1-B8AD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197889>

From: Steven Penny <svnpenn@gmail.com>

From: Steven Penny <svnpenn@gmail.com>

On Cygwin, tools built for Cygwin can take both Windows-style paths
(e.g. C:/dir/file.txt or C:\dir\file.txt) and Cygwin-style paths
(e.g. /cygdrive/c/dir/file.txt), but Windows-native tools can only take
Windows-style paths.  Because the paths that are relative to $GIT_DIR,
e.g. the name of the insn sheet file of the "rebase -i" command, are given
to the programs with $GIT_DIR prefixed, and $GIT_DIR in turn is computed
by calling "pwd", wrap "pwd" to call "cygpath -m" to give a Windows-style
path, in a way similar to how mingw does this.
---
 git-sh-setup.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 770a86e..f0f941d 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -241,6 +241,11 @@ case $(uname -s) in
 		return 1
 	}
 	;;
+*CYGWIN*)
+	pwd () {
+		builtin cygpath -m
+	}
+	;;
 *)
 	is_absolute_path () {
 		case "$1" in
-- 
1.7.10.2.537.g0ac6509
