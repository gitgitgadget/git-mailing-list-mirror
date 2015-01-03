From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv9 1/9] receive-pack.c: shorten the execute_commands loop
 over all commands
Date: Fri, 2 Jan 2015 18:20:04 -0800
Message-ID: <20150103022004.GI29365@google.com>
References: <1419982898-23108-1-git-send-email-sbeller@google.com>
 <1419982898-23108-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 03:20:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7EKI-0000jS-Ve
	for gcvg-git-2@plane.gmane.org; Sat, 03 Jan 2015 03:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbbACCUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 21:20:09 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:60950 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbACCUI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 21:20:08 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so17355807iec.38
        for <git@vger.kernel.org>; Fri, 02 Jan 2015 18:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qvQ18OnJ1k7tgCTewLRedS/7oP9PdtLpLmtOq2K/ByI=;
        b=JbL+0tWxfkKx5iVhLuo2Q28ItQZI7u0n8yPI3Tjv5Gn4IOwHl8OV3P1dCFJ4IM3azR
         hp6pwth3BhStjxnBeaSO/kEGzFGQ/fkkVwWDv+ax1EMrKqutVasEMFN0YBzxj7GfV4jB
         5YKTYpQcKQ0f+S0tMAvTUdo5uHqWDjIr8VVoLcNE4dy4hP5IP8Q3AHlFuQdSsjEokHES
         Mpq9GBtJxZxsucdS6f82MXvi2qH+HO+LRjYSDAfgrWMZr1hQr+Ol7/k+0O5EDqW60TR2
         bKAPikGT+VfFSxU/AuY4dY2p3sAHHqp9qnVNR/S6IwNuBCqmmEpAyUR7hLHINGKxoOpq
         h83Q==
X-Received: by 10.50.107.36 with SMTP id gz4mr1476602igb.25.1420251607209;
        Fri, 02 Jan 2015 18:20:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:4dc:a2d1:6dcb:ef51])
        by mx.google.com with ESMTPSA id g5sm23612645iod.25.2015.01.02.18.20.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Jan 2015 18:20:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1419982898-23108-2-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261989>

(+cc: Duy, who understands shallow push well)
Hi,

Stefan Beller wrote:

> This commit shortens execute_commands loop over all commands by moving

The commit message can be simplified by leaving out "This commit" and
stating what the commit does in the imperative, focusing on what problem
the commit solves.

For example:

	Make the main "execute_commands" loop in receive-pack easier to read
	by splitting out some steps into helper functions.  The new helper
	'should_process_cmd' checks if a ref update is unnecessary, whether
	due to an error having occured or for another reason.  The helper
	'check_shallow_bugs' warns if we have forgotten to run a connectivity
	check on a ref which is shallow for the client.

	This will help us to duplicate less code in a later patch when we make
	a second copy of the "execute_commands" loop.

	No functional change intended.

By the way, is there some clearer name for check_shallow_bugs?  That
name makes it sound like there are some bugs we are checking up on,
whereas a name that makes it obvious what the function will do and saves
me from having to read the function body would be ideal.

[...]
> +++ b/builtin/receive-pack.c
[...]
> @@ -1077,27 +1099,15 @@ static void execute_commands(struct command *commands,
[...]
>  	for (cmd = commands; cmd; cmd = cmd->next) {
[...]
> -		if (shallow_update && !cmd->error_string &&
> -		    si->shallow_ref[cmd->index]) {
> -			error("BUG: connectivity check has not been run on ref %s",
> -			      cmd->ref_name);
> -			checked_connectivity = 0;
> -		}
>  	}
>
> -	if (shallow_update && !checked_connectivity)
> -		error("BUG: run 'git fsck' for safety.\n"
> -		      "If there are errors, try to remove "
> -		      "the reported refs above");
> +	if (shallow_update)
> +		check_shallow_bugs(commands, si);

In the same spirit of saving the reader from having to look at the
body of check_shallow_bugs, would it make sense for the part that reacts
to an error to be kept in the caller?  E.g.:

	if (shallow_update && warn_if_skipped_connectivity_check(commands, si))
		error("BUG: run 'git fsck for safety.\n"
		      "If there are errors, try removing the refs reported above");

Is this error possible, by the way?  update() does not return success
unless it has reached the bottom block in the function.  In the
!is_null_sha1(new_sha1) case that means it calls update_shallow_ref(),
which performs the connectivity check.  In the is_null_sha1(new_sha1)
case, update_shallow_info() does not set cmd->index and
si->shallow_ref[cmd->index] cannot be set.

Perhaps this error message could be written in a way that makes it
clearer that we really expect it not to happen, like

		die("BUG: connectivity check skipped in shallow push???");

(die() instead of error() to prevent refs from updating and pointing
to a disconnected history).

Thoughts?
Jonathan
