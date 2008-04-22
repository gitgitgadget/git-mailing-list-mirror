From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't force imap.host to be set when imap.tunnel is set
Date: Mon, 21 Apr 2008 23:47:44 -0700
Message-ID: <7vbq424c8f.fsf@gitster.siamese.dyndns.org>
References: <200804211459.07527.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:48:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoCIu-0006cN-JF
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 08:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbYDVGrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 02:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754781AbYDVGru
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 02:47:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbYDVGru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 02:47:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0AA951528;
	Tue, 22 Apr 2008 02:47:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4CF971526; Tue, 22 Apr 2008 02:47:46 -0400 (EDT)
In-Reply-To: <200804211459.07527.andyparkins@gmail.com> (Andy Parkins's
 message of "Mon, 21 Apr 2008 14:59:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80069>

Andy Parkins <andyparkins@gmail.com> writes:

> The documentation for git-imap-send suggests a tunnel setting such as
>
>   Tunnel = "ssh -q user@server.com /usr/bin/imapd ./Maildir 2> /dev/null"
>
> which works wonderfully and doesn't require a username, password or port
> setting.
>
> However, git-imap-send currently requires that the imap.host variable be
> set in the config even when it was unused.  This led me to have to put
> the following in my .gitconfig.
>
>  [imap]
>    host = dummy
>
> This patch changes imap-send to only require that the imap.host setting
> is set if imap.tunnel is _not_ set.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

I am not an imap-send user myself, but is it the case that the use of
imap.tunnel always makes imap.host useless/unnecessary and safe to be left
as NULL?

My quick scan of imap-send.c suggests that

 * imap_open_store() does not look at host/port when tunnel is defined
   while connecting at the socket level;

 * however, when not preauth, "host" is used to issue error message when
   user is not set, and in prompt when pass needs to be asked.  I suspect
   you do not want to leave "host" NULL in this case.

Driving imapd standalone like the "tunnel" example you quoted above would
trigger preauth behaviour, so that should be safe, but I suspect there are
other ways to use tunnel to just relay the connection over the firewall,
while still requiring the client to authenticate the same way as usual.
