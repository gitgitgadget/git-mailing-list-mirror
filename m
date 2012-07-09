From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Restore umasks influence on the permissions of work tree
 created by clone
Date: Sun, 08 Jul 2012 18:41:39 -0700
Message-ID: <7vobnpn224.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1207061700060.2056@iabervon.org>
 <20120707215029.GA26819@blimp.dmz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 03:41:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1So2yz-0002La-Ao
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 03:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462Ab2GIBln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 21:41:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab2GIBlm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 21:41:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8462097D9;
	Sun,  8 Jul 2012 21:41:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jzMAp8AMaiqaBskRLtS57U33fLo=; b=h3Nt+d
	tEKCxpdQlOMUhlzeQuBCxuuEa+F28pY6WRqpbKhvUqD8VIlAnZ9s64irzznqVeJ3
	a/SbU8JnoZXG+nDsW+/3ANrEAh86nH2I8RyhvyEJCCvqELRjRdIowqTZYRSFHNlp
	3qatrglLJizF98qmiCpc2GflTDZ0ey+OIXoRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a7n1NqUYsIEXWlylapgN7QjTQs0c1zQs
	AquYYWvXD89t9K2JYschZf4ymx7TsEYXx16tJZe6VfCEEBEnrKzhiLO2cyBaH9JA
	jo/Vj9nu0i8ITz77gD7FU3lVGvY5D8JLeWi4tgEYXiZMX1/Ues7rkHU9MALqBfva
	0VJtnJumtkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79B2797D7;
	Sun,  8 Jul 2012 21:41:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0125B97D6; Sun,  8 Jul 2012
 21:41:40 -0400 (EDT)
In-Reply-To: <20120707215029.GA26819@blimp.dmz> (Alex Riesen's message of
 "Sat, 7 Jul 2012 23:50:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B37E34A-C967-11E1-AB0F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201187>

Alex Riesen <raa.lkml@gmail.com> writes:

> The original (shell coded) version of the git-clone just used mkdir(1)
> to create the working directories. The builtin changed the mode argument
> to mkdir(2) to 0755, which was a bit unfortunate, as there are use

A much more important reason why this is a good change (I think you
could even say this is a bugfix) is because directories and files in
the working tree are created with entry.c::create_directories() and
entry.c::create_file(), and they do honour umask settings, and the
top-level of the working tree should be handled the same way, no?

> cases where umask-controlled creation is preferred and in any case
> it is a well-known behaviour for new directory/file creation.

> ---

Sign-off?

>
> On Fri, 6 Jul 2012, Daniel Barkalow wrote:
>> On Fri, 6 Jul 2012, Alex Riesen wrote:
>>> when git-clone was built in, its treatment of umask has changed: the shell
>>> version respected umask for newly created directories by using plain mkdir(1),
>>> and the builtin version just uses mkdir(work_tree, 0755).
>>>
>>> Is it intentional?
>> 
>> I have the vague feeling that it was intentional, but it's entirely 
>> plausible that I just overlooked that mkdir(2) applies umask and went for 
>> the mode that you normally want. I don't think there's any particular need 
>> for this operation to be more restrictive than umask.
>
> I didn't look hard enough, but still, I found not much of complaining either
> way (frankly - none, but as I said, I didn'l look hard): none before - for
> being too permissive, the only one in original post after building the thing
> in - for being too restrictive.
>
> Maybe we should reconsider and go back to the old permission handling?
>
>  builtin/clone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index d3b7fdc..e314b0b 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -708,7 +708,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		if (safe_create_leading_directories_const(work_tree) < 0)
>  			die_errno(_("could not create leading directories of '%s'"),
>  				  work_tree);
> -		if (!dest_exists && mkdir(work_tree, 0755))
> +		if (!dest_exists && mkdir(work_tree, 0777))
>  			die_errno(_("could not create work tree dir '%s'."),
>  				  work_tree);
>  		set_git_work_tree(work_tree);
