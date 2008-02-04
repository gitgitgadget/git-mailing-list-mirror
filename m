From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] fix misuse of prefix_path()
Date: Mon,  4 Feb 2008 12:13:26 +0100
Message-ID: <1202123606.47a6f3567ebb9@webmail.eunet.at>
References: <7v3as9mce7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 12:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLzH7-0003lS-UE
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 12:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbYBDLNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 06:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYBDLNh
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 06:13:37 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:52383 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbYBDLN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 06:13:28 -0500
Received: from localhost (webmail01.srv.eunet.at [193.154.180.195])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 8A97710A6F9;
	Mon,  4 Feb 2008 12:13:26 +0100 (CET)
Received: from cm56-163-160.liwest.at (cm56-163-160.liwest.at [86.56.163.160]) 
	by webmail.eunet.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Mon,  4 Feb 2008 12:13:26 +0100
In-Reply-To: <7v3as9mce7.fsf@gitster.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 86.56.163.160
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72490>

Junio C Hamano <gitster@pobox.com> wrote:
> When DEFAULT_GIT_TEMPLATE_DIR is specified as a relative path,
> init-db made it relative to exec_path using prefix_path(), which
> is wrong.  prefix_path() is about a file inside the work tree.
> There was a similar misuse in config.c that takes relative
> ETC_GITCONFIG path.
>
> A convenience function prefix_filename() can concatenate two paths
> to form a path that points at somewhere outside the work tree.
> Use it in these codepaths instead.

Thanks for catching that. But, no, your patch does not work. The reason is
that prefix_filename() assumes that the prefix ends with a directory
separator ('/'), but git_exec_path() doesn't have one.

prefix_path() has the same assumption, but at the same time it does the
"../" sanitization. In the MinGW configuration both relative paths begin
with "../" and prefix_path() removed one path component from the prefix,
but left a trailing '/' behind. IOW, so far the code worked by accident,
not by design ;)

I'll work on a fix (later today).

-- Hannes
