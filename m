Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF85F20189
	for <e@80x24.org>; Mon, 20 Jun 2016 10:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbcFTKHn (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:07:43 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:56190 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357AbcFTKHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:07:42 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4) with SMTP id u2ACtM3f015404;
	Thu, 10 Mar 2016 15:55:23 +0300
Date:	Thu, 10 Mar 2016 15:55:22 +0300
From:	Konstantin Khomoutov <kostix+git@007spb.ru>
To:	Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Problem with git-http-backend.exe as iis cgi
Message-Id: <20160310155522.1dee53cf95fead8cfd4e178a@domain007.com>
In-Reply-To: <F0F5A56A22F20D4CB4A03BB8D6658797E260E0E3@SERVER2011.CS-SOFTWARE.local>
References: <F0F5A56A22F20D4CB4A03BB8D6658797E260E0E3@SERVER2011.CS-SOFTWARE.local>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, 10 Mar 2016 07:28:50 +0000
Florian Manschwetus <manschwetus@cs-software-gmbh.de> wrote:

> I tried to setup git-http-backend with iis, as iis provides proper
> impersonation for cgi under windows, which leads to have the
> filesystem access performed with the logon user, therefore the
> webserver doesn't need generic access to the files. I stumbled across
> a problem, ending up with post requests hanging forever. After some
> investigation I managed to get it work by wrapping the http-backend
> into a bash script, giving a lot of control about the environmental
> things, I was unable to solve within IIS configuration. The
> workaround, I use currently, is to use "/bin/head -c
> ${CONTENT_LENGTH} | ./git-http-backend.exe", which directly shows the
> issue. Git http-backend should check if CONTENT_LENGTH is set to
> something reasonable (e.g. >0) and should in this case read only
> CONTENT_LENGTH bytes from stdin, instead of reading till EOF what I
> suspect it is doing currently.

The rfc [1] states in its section 4.2:

| A request-body is supplied with the request if the CONTENT_LENGTH is
| not NULL.  The server MUST make at least that many bytes available
| for the script to read.  The server MAY signal an end-of-file
| condition after CONTENT_LENGTH bytes have been read or it MAY supply
| extension data.  Therefore, the script MUST NOT attempt to read more
| than CONTENT_LENGTH bytes, even if more data is available.  However,
| it is not obliged to read any of the data.

So yes, if Git currently reads until EOF, it's an error.
The correct way would be:

1) Check to see if the CONTENT_LENGTH variable is available in the
   environment.  If no, read nothing.

2) Otherwise read as many bytes it specifies, and no more.

1. https://www.ietf.org/rfc/rfc3875
