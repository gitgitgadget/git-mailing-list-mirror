From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] fix "v"iew subcommand in "git am -i"
Date: Tue, 16 Feb 2016 15:06:54 -0800
Message-ID: <1455664017-27588-1-git-send-email-gitster@pobox.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:07:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVoi4-00050g-8x
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756299AbcBPXHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 18:07:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756270AbcBPXHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:07:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B4A90453AD;
	Tue, 16 Feb 2016 18:06:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=EoL9KcBru/raQQc20XrfaF5I6PI
	=; b=jjQXQJberZhMoM3VBnom5LG+sRgTGOyefXso/NEeb9K4PROuB+n2RGaoxNE
	vMu8wcGoIvz5OSKz0nb/Da4zAIDa9VaE+Ej4nrqWupKfNsbJPhQpvQIadyuqNsJq
	dQd5J1TuzaUtouguWunn76qR3qrq/tQwcJytWiTb+m1C+8Is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=yhD+0lZxvlK1xIaJM+FXL
	8aZ+chw6M400bcn1oze3kpZ8QpQWEwetGbQlXDjPF3CR2T3ET7A5l/ATaQ0Z4PT7
	oz0hLdghy8NzMrNEo2i9fsfYNueNgLT5V0Z8YCCPnJ97Ut6nlEsVQeLbaw6X4ydc
	lTojnhdDv1CZqysHW1ycnM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD169453AC;
	Tue, 16 Feb 2016 18:06:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 32699453A8;
	Tue, 16 Feb 2016 18:06:59 -0500 (EST)
X-Mailer: git-send-email 2.7.1-460-gd45d0a4
X-Pobox-Relay-ID: FB488F1E-D501-11E5-A8A7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286448>

The 'v'iew subcommand of the interactive mode of "git am -i" was
broken by the rewrite to C we did at around 2.6.0 timeframe at
7ff26832 (builtin-am: implement -i/--interactive, 2015-08-04); we
used to spawn the pager via the shell, accepting things like

	PAGER='less -S'

in the environment, but the rewrite forgot and tried to directly
spawn a command whose name is the entire string.

The bug is understandable, because there are things we need to do
other than just run_command() to run the pager, such as running it
with default LESS/LV settings and running it via the shell, but
these pieces of necessary knowledge about what is the right thing to
do are hoarded by the setup_pager() entry point, which is only good
if we are feeding our own standard output to the pager.  A codepath
that wants to run the pager but not on our output needs to do the
right thing on its own.

So the first patch in this series factors out a helper function to
let the caller run the pager the right way.  They make the third
patch to fix the breakage in "am" trivial.

I debated myself where the call of git_pager() should go (it could
be argued that it conceptually belongs to the new prepare_pager_args()
helper), but I opted for a simpler change.

Junio C Hamano (3):
  pager: lose a separate argv[]
  pager: factor out a helper to prepare a child process to run the pager
  am -i: fix "v"iew

 builtin/am.c |  5 +++--
 cache.h      |  4 ++++
 pager.c      | 26 ++++++++++++++++++--------
 3 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.7.1-460-gd45d0a4
