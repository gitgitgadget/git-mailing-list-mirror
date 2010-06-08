From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 08 Jun 2010 08:12:35 +0200
Message-ID: <4C0DDF53.5090805@viscovery.net>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com> <20100608052929.GA15156@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Dario Rodriguez <soft.d4rio@gmail.com>, jrnieder@uchicago.edu,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 08:12:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLs3H-0003Za-17
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 08:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab0FHGMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 02:12:38 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55439 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab0FHGMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 02:12:37 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OLs3A-0000dq-2A; Tue, 08 Jun 2010 08:12:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7BF331660F;
	Tue,  8 Jun 2010 08:12:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100608052929.GA15156@coredump.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148645>

Am 6/8/2010 7:29, schrieb Jeff King:
> On Mon, Jun 07, 2010 at 08:58:08PM -0300, Dario Rodriguez wrote:
>> +#ifdef WIN32
>> +{	/* cannot trust the executable bit, peek into the file instead */
>> +	char buf[3] = { 0 };
>> +	int n;
>> +	int fd = open(name, O_RDONLY);
>> +	st.st_mode &= ~S_IXUSR;
>> +	if (fd >= 0) {
>> +		n = read(fd, buf, 2);
>> +		if (n == 2)
>> +			/* DOS executables start with "MZ" */
>> +			if (!strcmp(buf, "#!") || !strcmp(buf, "MZ"))
>> +				st.st_mode |= S_IXUSR;
>> +		close(fd);
>> +	}
>> +}
>> +#endif
>> +	return st.st_mode & S_IXUSR;
>> +}
>> +
>> +const char *git_pager(int stdout_is_tty) 
>>  {
>> +	static const char *pager_bins[] =
>> +		{ "less", "more", NULL };
>> +	static const char *common_binary_paths[] =
>> +		{ "/bin/","/usr/bin/","/usr/local/bin/",NULL };
> 
> ...must we really add code with such ugliness as magic PATHs and DOS
> magic numbers?

Yes and no.

Coding DOS magic numbers is bad because you could wrapped a real pager in
a shell script (even on Windows).

These days, start_command() is able to report ENOENT if it cannot run a
program because it does not exist. However, right in the case of
git_pager() this capability is disabled because it sets this magic
preexec_cb that waits for data in the child process before it execs the
real pager.

If we could get rid of preexec_cb, we could make this work much more
pleasantly. pager_preexec waits for data on stdin; Linus added it to work
around a faulty 'less'. Do we still need it?

-- Hannes
