From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC/RFD] clone: quell the progress report from init
Date: Mon, 29 Mar 2010 22:18:32 -0700
Message-ID: <7v7houxu8n.fsf@alter.siamese.dyndns.org>
References: <4BAB2234.4070202@drmicha.warpmail.net>
 <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net> <7veij6lvze.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1003261611130.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Mar 30 07:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwTr3-0002yr-QA
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 07:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582Ab0C3FSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 01:18:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab0C3FSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 01:18:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 310A9A6FA8;
	Tue, 30 Mar 2010 01:18:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=atvAEKWX+zOLbA45YdRTa2c4Yu8=; b=dyMbc9W+kwDLHVyRdcFGP1F
	brdH1/kKBRAU/8P3opPpWJrRUQk955ZGvs7RUZPd+apfbaI9nnj1Csl2cdVUqCmQ
	/8JYvf/O/W1t0UZP3PIhYdo1i+uwLYm1rBtMaq+MzyGFxSBn3DabRyc1EY53Cl8J
	lzFSjDCjUdJtyjp0JbLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Yi62f571qJCMBywCwZUgfE9YTSsF3Av0x5rzM9+OPKWuSZCj2
	YLnqRCYdUNoGMxeH6tExFd70lomvnUAAhLf32A7JMV4RsoWz1VvM/mAvsfp+lNVY
	hEFnj6PRZj8+T4t686LfMoTSA5dV30zGL6wKnxEpDvaBkYujda+SgQJwOM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C69E6A6FA2;
	Tue, 30 Mar 2010 01:18:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF588A6FA0; Tue, 30 Mar
 2010 01:18:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B48398DE-3BBB-11DF-B7EB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143546>

Nicolas Pitre <nico@fluxnic.net> writes:

> Personally I like your suggestion above.  A clone is not something you 
> perform repeatedly, and it is the first thing that random people told to 
> use Git to grab a piece of code will do.  Better give them some comfort 
> by telling them what is happening.

Here is what such a change may look like.  I'll leave adjusting
documentation (namely, tutorials) and perhaps tests as an exercise to the
readers ;-)


 builtin/clone.c  |    6 +++++-
 t/t5601-clone.sh |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 05f8fb4..0bedde4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -302,6 +302,8 @@ static const struct ref *clone_local(const char *src_repo,
 	transport = transport_get(remote, src_repo);
 	ret = transport_get_remote_refs(transport);
 	transport_disconnect(transport);
+	if (0 <= option_verbosity)
+		printf("done.\n");
 	return ret;
 }
 
@@ -461,7 +463,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die("could not create leading directories of '%s'", git_dir);
 	set_git_dir(make_absolute_path(git_dir));
 
-	init_db(option_template, (option_verbosity < 0) ? INIT_DB_QUIET : 0);
+	if (0 <= option_verbosity)
+		printf("Cloning into %s...\n", get_git_dir());
+	init_db(option_template, INIT_DB_QUIET);
 
 	/*
 	 * At this point, the config exists, so we do not need the
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 2147567..678cee5 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -34,7 +34,7 @@ test_expect_success 'clone with excess parameters (2)' '
 test_expect_success 'output from clone' '
 	rm -fr dst &&
 	git clone -n "file://$(pwd)/src" dst >output &&
-	test $(grep Initialized output | wc -l) = 1
+	test $(grep Clon output | wc -l) = 1
 '
 
 test_expect_success 'clone does not keep pack' '
