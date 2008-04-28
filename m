From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 09:29:02 -0700
Message-ID: <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:30:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWEp-0002g9-Oc
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934694AbYD1Q3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 12:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934675AbYD1Q3K
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:29:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934369AbYD1Q3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:29:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C0BB5F34;
	Mon, 28 Apr 2008 12:29:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E3C745F32; Mon, 28 Apr 2008 12:29:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80553>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With rotating logs, there is a problem when the syslog is opened only once 
> (in the beginning).  So open the log everytime we write something, and 
> close it directly after writing.

Gaah, this is ugly.

Is this something all the daemons need to deal with?

> diff --git a/daemon.c b/daemon.c
> index 2b4a6f1..a887c72 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -90,7 +90,9 @@ static void logreport(int priority, const char *err, va_list params)
>  	msglen = vsnprintf(buf + buflen, maxlen, err, params);
>  
>  	if (log_syslog) {
> +		openlog("git-daemon", 0, LOG_DAEMON);
>  		syslog(priority, "%s", buf);
> +		closelog();
>  		return;
>  	}
