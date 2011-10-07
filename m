From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach merge the '[-e|--edit]' option
Date: Fri, 07 Oct 2011 10:30:34 -0700
Message-ID: <7vk48gwvyd.fsf@alter.siamese.dyndns.org>
References: <1318001347-11347-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 19:30:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCEFv-0001om-KX
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 19:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690Ab1JGRai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 13:30:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab1JGRah (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 13:30:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDACB62AD;
	Fri,  7 Oct 2011 13:30:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qrrqjNlGRwizc6CJg43epRKbqXE=; b=X4CtuE
	XDncp2a/dwr7/lMDoyJ11l785HMBBsPplmpDAh3cP6K8f9zDYmF8HGEgXH3xv9G9
	y+6p2YqSUdE60F56g3hkcirCMQCUkfXYOUjuxbJ9NYj2YSdNReLuPgJv1qIl8fxZ
	6z7bUTzM2KIwlQs/OOvZ5AfbQ45xqnd+TujFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JI3ySB9+H6HTtF9NinPwCyNylXsV6B+w
	XX/yFcAV8okPAT/9O2GzmbcahxfR7WCPkOvojwx5dLLCrgYFNmqq5RWzvXeePjXI
	xONC1SI8REaY8Mr2zcYOv7DSka/21dnAXVlc6K/k4xqZ/8XSAo7YWX22PZnOv0xF
	9RUQ4TLmzrE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C514962AC;
	Fri,  7 Oct 2011 13:30:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 587F062AB; Fri,  7 Oct 2011
 13:30:36 -0400 (EDT)
In-Reply-To: <1318001347-11347-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Fri, 7 Oct 2011 11:29:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1152F08C-F10A-11E0-82D6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183089>

Jay Soffian <jaysoffian@gmail.com> writes:

> Implement "git merge [-e|--edit]" as "git merge --no-commit && git commit"
> as a convenience for the user.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> ...
> @@ -1447,6 +1457,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (merge_was_ok) {
> +		if (option_edit) {
> +			const char *args[] = {"commit", "-e", NULL};
> +			return run_command_v_opt(args, RUN_GIT_CMD);
> +		}
>  		fprintf(stderr, _("Automatic merge went well; "
>  			"stopped before committing as requested\n"));
>  		return 0;


I wanted to like this approach, thinking this approach might be safer and
with the least chance of breaking other codepaths, but this feels like an
ugly hack.

Are we still honoring all the hooks "git merge" honors?  More importantly,
isn't this make it impossible for future maintainers of this command to
enhance the command by adding other hooks after the commit is made?

If we wanted to do this properly, we should update builtin/merge.c to call
launch_editor() before it runs commit_tree(), in a way similar to how
prepare_to_commit() in builtin/commit.c does so when e.g. "commit -m foo -e"
is run. An editmsg is prepared (you already have it in MERGE_MSG), the
editor is allowed to update it, and then the original code before such a
patch will run using the updated contents of MERGE_MSG. That way, the _only_
change in behaviour when "-e" is used is to let the user update the message
used in the commit log, and everything else would run exactly the same way
as if no "-e" was given, including the invocation of hooks.
