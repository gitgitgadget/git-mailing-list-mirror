From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] fix "v"iew subcommand in "git am -i"
Date: Wed, 17 Feb 2016 11:15:13 -0800
Message-ID: <1455736516-13466-1-git-send-email-gitster@pobox.com>
References: <1455664017-27588-1-git-send-email-gitster@pobox.com>
Cc: Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 20:18:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW7c0-0003jH-Ot
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 20:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161266AbcBQTP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 14:15:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423707AbcBQTPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 14:15:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 10603423D8;
	Wed, 17 Feb 2016 14:15:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3zo+
	3kuTjfShoKjaB+ZotvOK0l8=; b=QtwbLcQq3z2AQZFUAKD+Ocp6OgvBz0KogmTs
	sQtBApErWjMemWq8EoFGuVwoa1oEdIjythYDg4s1FkPpJ18SV5PZGEi9j9o5iwNL
	r1qstZlO+HaE8Avf2KnBnkaI9g9PH1sr+EE03xoj3MwtijyW22q6KGh5r3ziABvd
	rho0gQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	aJDnnEH4y+JAOUrIq3wl+ye18Z7Ufv3LLjfSi7QglRoXdXBIw675HuXQiXVlav7f
	GOx02snxi2uEhrvARFChJeudA7QddUQB2guORYSwOtikq7P+OgZ/PYq7q+po0FBa
	/3fNYAMvmSZt1DOxthSFYa/p/6P0Bwlbm2YVvFA2bz0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0742D423D5;
	Wed, 17 Feb 2016 14:15:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 78B55423D2;
	Wed, 17 Feb 2016 14:15:17 -0500 (EST)
X-Mailer: git-send-email 2.7.1-489-g20b2cbe
In-Reply-To: <1455664017-27588-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C7A1922E-D5AA-11E5-8BF4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286537>

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
patch to fix the breakage in "am" trivial.  Compared to v1, the
helper was much simplified with help by Peff: it always and only
takes child-process and the pager command string.  The caller can
append extra command line arguments after the helper returns if it
wants to.

Junio C Hamano (3):
  pager: lose a separate argv[]
  pager: factor out a helper to prepare a child process to run the pager
  am -i: fix "v"iew

 builtin/am.c |  2 +-
 cache.h      |  3 +++
 pager.c      | 19 +++++++++++--------
 3 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.7.1-489-g20b2cbe
