From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-imap-send.
Date: Thu, 09 Mar 2006 02:35:14 -0800
Message-ID: <7vacbz7vod.fsf@assigned-by-dhcp.cox.net>
References: <440C3499.9080000@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 11:35:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHIUV-0004et-KF
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 11:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWCIKfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 05:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWCIKfT
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 05:35:19 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29606 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751787AbWCIKfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 05:35:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309103521.IFZQ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 05:35:21 -0500
To: Mike McCormack <mike@codeweavers.com>
In-Reply-To: <440C3499.9080000@codeweavers.com> (Mike McCormack's message of
	"Mon, 06 Mar 2006 22:09:45 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17405>

Mike McCormack <mike@codeweavers.com> writes:

> This probably needs a bit more work, but I'll solicit comments and
> flames anyway...

OK, then please work a bit more ;-)

I kind of like this approach and even wish my e-mail workflow
involved an imap server with draft folders.  Currently I do
everything in Gnus and my drafts are on local disk.

> The target IMAP folder:
>
> [imap]
>         Folder = "INBOX.Drafts"
>
> A command to open an ssh tunnel to the imap mail server.

The .git/config file is a good choice for storing this
information, because you might even use different draft folders
for different projects, i.e. the configuration is
per-repository.

> [imap]
>         Tunnel = "ssh -q user@imap.server.com /usr/bin/imapd ./Maildir
> 2> /dev/null"
> [imap]
> 	Host = imap.server.com
> 	User = bob
> 	Password = pwd
> 	Port = 143

These I am not so sure.  It _might_ make sense to have something
like this under $HOME/.  Isn't there an established convention
for storing something like this for existing MUAs?

> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *...
> + * As a special exception, mbsync may be linked with the OpenSSL library,
> + * despite that library's more restrictive license.

Hmmm.  

> +#include <sys/types.h>
>...
> +#include <pwd.h>
> +
> +#include "cache.h"

If you are including "cache.h", you probably do not need to
include many of the standard include files.

> +#define as(ar) (sizeof(ar)/sizeof(ar[0]))

We have something like this in apply.c, exec_cmd.c and git.c;
probably we would want a macro in "cache.h".

	git.c:326:#define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))

> +static int
> +git_imap_config(const char *key, const char *val)
> +{
>...
> +	if (!strcasecmp( "Folder", key )) {

git_config calls you after downcasing the keys, so you do not
need to do strcasecmp.  Just spell things out in lowercase.

> +		if (!memcmp( "imaps:", val, 6 )) {
> +			if (!memcmp( "imap:", val, 5 ))

Is val always longer than 5 or 6 bytes here?
