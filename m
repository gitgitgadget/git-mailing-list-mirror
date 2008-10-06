From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] check-attr: Add --stdin-paths option
Date: Mon, 06 Oct 2008 09:09:11 +0200
Message-ID: <48E9B997.1010006@viscovery.net>
References: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com> <1223173855-6173-1-git-send-email-dpotapov@gmail.com> <1223173855-6173-2-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 09:11:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmkFR-00007k-Hm
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 09:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbYJFHJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 03:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbYJFHJV
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 03:09:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43759 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbYJFHJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 03:09:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KmkDT-0004KV-Ox; Mon, 06 Oct 2008 09:09:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4D40B4FB; Mon,  6 Oct 2008 09:09:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1223173855-6173-2-git-send-email-dpotapov@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97568>

Dmitry Potapov schrieb:
> +static void check_attr_stdin_paths(int cnt, struct git_attr_check *check,
> +	const char** name)
> +{
> +	struct strbuf buf, nbuf;
> +
> +	strbuf_init(&buf, 0);
> +	strbuf_init(&nbuf, 0);
> +	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
> +		if (buf.buf[0] == '"') {
> +			strbuf_reset(&nbuf);
> +			if (unquote_c_style(&nbuf, buf.buf, NULL))
> +				die("line is badly quoted");
> +			strbuf_swap(&buf, &nbuf);
> +		}
> +		check_attr(cnt, check, name, buf.buf);
> +	}
> +	strbuf_release(&buf);
> +	strbuf_release(&nbuf);
> +}
> +

We know that you will want to use this feature in gitk to reduce the
number of fork()s. But you've a problem: gitk will first write a path to
git-check-addr's stdin, and then wait for the result on its stdout. But
this is a classic pitfall: You are not guaranteed that something will be
returned from stdout right away due to buffering. The least that is needed
is fflush(stdout) in this loop (after each iteration!) so that gitk sees
some result and does not hang forever.

-- Hannes
