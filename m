From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git
 ls-files
Date: Mon, 4 Oct 2010 12:03:42 -0500
Message-ID: <20101004170342.GA5450@burratino>
References: <4CA847D5.4000903@workspacewhiz.com>
 <1286099806-25774-7-git-send-email-avarab@gmail.com>
 <AANLkTimH8Lj69qcOCmR3+5HYfgKnr5nyMvQU=9h0=FaB@mail.gmail.com>
 <201010032019.09244.j6t@kdbg.org>
 <20101004074916.GK24884@burratino>
 <AANLkTikgLzczp1Gkmcg2v35oE2bKxBtxY389Z76FJDRz@mail.gmail.com>
 <4CA9EBA2.9020401@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	Thomas Adam <thomas@xteddy.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 19:07:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2oVO-0000mb-Oh
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 19:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab0JDRHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 13:07:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64325 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab0JDRHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 13:07:05 -0400
Received: by fxm4 with SMTP id 4so93810fxm.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gl67x4Ti+fXAkvaS9RSTrrSALY2A/C/hm6bA5DgB070=;
        b=rPFx3zgXNQCK9TSFdO0ELfQK6C3eHKBMQSq5UQreCnn4It8WRxegYdwwBK3EotpPRg
         6iH56RoqRY7OXFT/W/NDhHKoSLISkqgU1nLuOhkYyqJZtSys4/8V+KATyaYPP+B2boNE
         uQPlu7hIfYcwu/mgsVajU1y234wV55ir2DCRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qmp+sb3CaCr22jnVpjSPImk0KMRHPoGzrekqBeYPZlnekTQe02Wm4jNC9uZWLEJKTL
         0nYijM4iNZddaFFWTZ0HBAjvhhWGzzpnqXdqk/Gdw8Mo2GBiPnDyp5NS6Z1NF7VmwyG1
         XDu5shcMDdsIv+FGQ7IwiRxlkRuBNs07FX95E=
Received: by 10.223.125.148 with SMTP id y20mr9455781far.94.1286212023590;
        Mon, 04 Oct 2010 10:07:03 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r5sm340302fai.1.2010.10.04.10.06.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 10:07:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CA9EBA2.9020401@workspacewhiz.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158067>

Joshua Jensen wrote:

> I'm running on a really, really fast machine, a Xeon X5560.  The
> difference in time for the above code versus what is in the patch
> seems to average about 0.07 seconds.

The useful information would be a percentage...

> Remember, this is an
> incredibly fast machine, and I imagine it will be worse on machines
> with slower processors and less cache.

... but the subarch and cache size may indeed also be relevant.

Here's a revised version of the ugly speed hack.  Using a separate
function like this is probably a bad idea unless it speeds things up.

/* Returns match length, or -1 for mismatch. */
static inline int match_until_glob_special(const char *match, const char *name,
						int namelen, int ignore_case)
{
	int remaining = namelen;
	for (;;) {
		unsigned char c1 = (ignore_case) ? tolower(*match) : *match;
		unsigned char c2 = (ignore_case) ? tolower(*name) : *name;
		if (c1 == '\0' || is_glob_special(c1))
			return namelen - remaining;
		if (c1 != c2)
			return -1;
		match++;
		name++;
		remaining--;
	}
}

[...]
	int matched;

	/* If the match was just the prefix, we matched */
	if (!*match)
		return MATCHED_RECURSIVELY;

	/*
	 * Note: this funny "if" is to ensure each case gets inlined separately.
	 * Please don't optimize it away unless you've checked the assembler
	 * to ensure it wasn't helping.
	 */
	if (ignore_case)
		matched = match_until_glob_special(match, name, namelen, 1);
	else
		matched = match_until_glob_special(match, name, namelen, 0);

	if (matched == -1)	/* mismatch! */
		return 0;

	match += matched;
	name += matched;
	remaining -= matched;
