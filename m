From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t1301-*.sh: Fix the 'forced modes' test on cygwin
Date: Fri, 17 Jun 2011 14:27:22 -0700
Message-ID: <7vsjr8f8sl.fsf@alter.siamese.dyndns.org>
References: <4DFA6632.40607@ramsay1.demon.co.uk> <4DFB0C66.5080904@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 17 23:27:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXgZf-0004Tc-KH
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 23:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab1FQV10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 17:27:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab1FQV10 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 17:27:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB3435264;
	Fri, 17 Jun 2011 17:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jF/FX/EVBsqte+NoHgfasXsx47c=; b=Vdw0yX
	hqKrQKnHqm7M1cSDE9vu4f1PP0CW8VeoQIGHf3XxHYSrqVw2pefroy78QgqP0Gne
	Sz9OWOZFGSqm6YP091nJE7jvA8hlGQmtGrpB86JdX0zrWC8ixOt9aIbJh/VGSXo5
	R3du/7lCAVGL5LnLdpIfm6FyL+zaEFhNjXNx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TXMLR/54nZz3uDCnusf10bK+tw5prjh5
	Izx9tn+PKekESyw1/WhyjvtoDdHuxWd4FsajnvNQ5jOAz2gax8Z5sfLGTbVuf38O
	zSomODIXSfSesf/hZ7cOxSr/qzdFYGfS759WBJhI0K6x7hss2IM7/TlbOf1GAp94
	aphvTLkCCG8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 805E55262;
	Fri, 17 Jun 2011 17:29:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B1FEC5261; Fri, 17 Jun 2011
 17:29:35 -0400 (EDT)
In-Reply-To: <4DFB0C66.5080904@kdbg.org> (Johannes Sixt's message of "Fri, 17
 Jun 2011 10:12:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5FCAB14-9928-11E0-B9B5-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175959>

Johannes Sixt <j6t@kdbg.org> writes:

>>  static int init_stat(void)
>>  {
>> -	if (have_git_dir()) {
>> -		git_config(git_cygwin_config, NULL);
>> +	if (have_git_dir() && git_config(git_cygwin_config,NULL)) {
>>  		if (!core_filemode && native_stat) {
>>  			cygwin_stat_fn = cygwin_stat;
>>  			cygwin_lstat_fn = cygwin_lstat;
>
> So, this means that if neither core.filemode nor
> core.ignorecygwinfstricks is assigned a value, then regular (Cygwin's)
> l/stat is used. Ok, that's what we need: the default value of
> core.filemode is true, which means we need Cygwin's l/stat; it trumps
> the default value of core.ignorecygwinfstricks, which is also
> true. Good!
>
> BTW, it seems the patch fixes a bug when the two config parameters are
> not assigned a value: the initialization looks like this[*]:
>
> static int native_stat = 1;
> static int core_filemode;
>
> i.e., the default value of core.filemode seen by compat/cygwin.c is
> actually false, and the fast native l/stat would be used, contrary to
> the documentation. Am I missing something?

Probably you are not missing anything.  It is a regression introduced by
7974843 (compat/cygwin.c: make runtime detection of lstat/stat lessor
impact, 2008-10-23).

What the added "&& git_config()" is doing is that until we actually open
and read .git/config and the like, we do not take that if (), meaning we
leave the cygwin_stat_fn pointing at the cygwin_stat_stub (same for
lstat), using the "unoptimized" cygwin version.  Once we do read from
config we are likely to have core.filemode defined (prepared by git init),
so the "default" value here would probably not matter in practice.
