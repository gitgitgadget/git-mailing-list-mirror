From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/5] git-cherry-pick: Add ignore-if-made-empty option
 [v2]
Date: Fri, 06 Apr 2012 20:30:19 +0200
Message-ID: <4F7F363B.3090007@kdbg.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com> <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com> <1333654745-7898-4-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 20:30:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGDvf-0001rI-DK
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 20:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab2DFSaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 14:30:30 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:6163 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695Ab2DFSaa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 14:30:30 -0400
Received: from [10.35.35.108] (77.118.253.84.wireless.dyn.drei.com [77.118.253.84])
	by bsmtp.bon.at (Postfix) with ESMTP id 63B312C400A;
	Fri,  6 Apr 2012 20:30:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <1333654745-7898-4-git-send-email-nhorman@tuxdriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194892>

Am 05.04.2012 21:39, schrieb Neil Horman:
> +	if (pipe2(pipefd, 0) < 0)
> +		return 0;
> +	output = xfdopen(pipefd[0], "r");
> +	memset(&cp, 0, sizeof(struct child_process));
> +	... setup cp ...
> +	if (start_command(&cp) < 0)
> +		goto out;
> +	if (fscanf(output, "%s\n", ptree)<  1)
> +		goto out;
> +	finish_command(&cp);
> +	fclose(output);
> +	close(pipefd[0]);

Instead of this sequence (I quoted only the relevant pieces), use the 
following:

	memset(&cp, 0, sizeof(struct child_process));
	cp.out = -1;
	... set other pieces in cp ...
	if (start_command(&cp) < 0)
		goto out;
	read_in_full(cp.out, ptree, sizeof(ptree));
	/* add suitable error reporting above */
	close(cp.out);
	if (!finish_command(&cp))
		goto out;

i.e.,

1. let start_command create the pipe for you by setting cp.out = -1,
2. avoid fscanf() if read_in_full() is equally simple to use,
3. close the pipe before finish_command(),
4. check the return code of finish_command().

-- Hannes
