From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] v2: proxy-command support for git://
Date: Fri, 4 Nov 2005 14:15:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511041409180.28804@g5.osdl.org>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org>
 <7v8xw5h898.fsf@assigned-by-dhcp.cox.net> <871x1wbgvn.fsf_-_@briny.internal.ondioline.org>
 <7v1x1wz7ae.fsf@assigned-by-dhcp.cox.net> <7v7jbow8ae.fsf@assigned-by-dhcp.cox.net>
 <87ll049l8a.fsf@briny.internal.ondioline.org> <7v3bmct7i3.fsf@assigned-by-dhcp.cox.net>
 <87hdas9ijp.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 23:18:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY9rF-0001Uz-Ae
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 23:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVKDWQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 17:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVKDWQI
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 17:16:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751046AbVKDWQG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 17:16:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA4MFxnO012869
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 4 Nov 2005 14:16:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA4MFwtf024473;
	Fri, 4 Nov 2005 14:15:59 -0800
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <87hdas9ijp.fsf@briny.internal.ondioline.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11166>



On Fri, 4 Nov 2005, Paul Collins wrote:
> 
>  * If the git config syntax is extended to allow dots in section or
>    key names:
> 
>      [proxy]
>      git.kernel.org = "ssh-to-bastion-proxy-command"
>      git.blargco.com = "blargco-proxy-command"

I would suggest

	[proxy]
		command = "ssh-to-bastion-proxy-command" for git.kernel.org

and then it's easy enough to just parse the value "proxy.command" with 
code like

	host = value;
	cmd = strstr(value, " for ");
	if (!cmd)
		return -1;
	*cmd = 0;
	cmd += 5;

which would do the right thing..

The thing is, it's not just ".". I could well imagine that you'd have

	[proxy]
		command="ssh" for "ssh://kernel.org/"
		command="proxy-command" for kernel.org
		command="myprotocol-command" for "my://"

which would actually allow you to literally add your own protocol names 
(it would see that the target starts with "my://", and decide that it 
shoul drun the "myprotocol-command" for the proxy).

I'd rather allow free-form strings for the values than for the key names. 
If we allow free-form key-names, then random text files suddenly often 
become valid (but strange) config files.

Right now the non-free-form key names are the strongest syntax checker of 
the whole protocol.

		Linus
