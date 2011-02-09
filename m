From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl: Fix command_bidi_pipe() don't care about
 repository path
Date: Wed, 09 Feb 2011 12:59:29 -0800
Message-ID: <7v7hd8q5zi.fsf@alter.siamese.dyndns.org>
References: <1297091360-11409-1-git-send-email-unpush@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Masatake Osanai <unpush@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 21:59:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnH8d-0004ZW-A8
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 21:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab1BIU7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 15:59:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab1BIU7k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 15:59:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5EE354B59;
	Wed,  9 Feb 2011 16:00:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ptkUNiWbUHB59WMwvI4KY+o2zJo=; b=Q/vQJP
	EB7PelCAhWNdBD3LZ52VCM27SEVPuSQBsLvw4xnfvlRApQbUXHX9BSG00+qmnkQc
	wScOEAT4pwp6Is0Lu3gYzPRYvZFwRn1NrBQW1izeDEJBSTZTwK+HwEJPJe1SGn8X
	LfIDgo8mgwInwag0F6p8+3ZqhQE+DUgnhUsxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r+EESxo8jLQmJOSikQCaK6PDe8mSguL5
	7+tyrdHLZbbp3zT9uFV+oKscmOSfI+XzkM9E2ttFYO9rTBLcpgJ7NqTmHkg9nP0G
	nSwXEtGXE2oIUVmx4vqR4F61e2WHh/Gj5c7D6KmPixqEpn/Qxjn0tX4qpIoyMibM
	sMPmo4Z5gPE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 279514B58;
	Wed,  9 Feb 2011 16:00:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1BB754B57; Wed,  9 Feb 2011
 16:00:31 -0500 (EST)
In-Reply-To: <1297091360-11409-1-git-send-email-unpush@gmail.com> (Masatake
 Osanai's message of "Tue\,  8 Feb 2011 00\:09\:20 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A39FADFA-348F-11E0-8336-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166441>

Masatake Osanai <unpush@gmail.com> writes:

> Subject: Re: [PATCH] perl: Fix command_bidi_pipe() don't care about repository path

Sorry but -ECANTPARSE.  It is unclear if you are saying "the command does
not care, which is incorrect and it should", or "the command shouldn't
care, fix it as it does currently".  It only turns out to be the former
after reading the body, but the subject must be understandable without
reading the body to keep "git shortlog" readable.

> command_bidi_pipe must care about repo_path() in case of repository
> instance.

Because...?

> This also fixes error on cat_blob() and hash_and_insert_object()
> in case of using outside of working tree.

Missing in your description are X and Y in: "Earier these functions did X
but they should do Y instead; the patch makes them do so".

> @@ -396,7 +396,16 @@ See C<command_close_bidi_pipe()> for details.
>  
>  sub command_bidi_pipe {
>  	my ($pid, $in, $out);
> +	my($self) = _maybe_self(@_);

Nit; s/my/my /.

> +	local %ENV = %ENV;
> +	my $cwd_save = undef;
> +	if ($self) {
> +		shift;
> +		$cwd_save = cwd();
> +		_setup_git_cmd_env($self);
> +	}

The POD description for this function says that it runs the same way as
command_output_pipe, which in turn uses _command_common_pipe that is
shared with command_input_pipe.  The reason these two other functions are
Ok without this patch is because _cmd_exec() has the logic to do the repo
dependent set-up, as far as I can tell.  But command_bidi_pipe() does not
use _cmd_exec(), and does not have a corresponding logic, and that is what
you are trying to fix.

Am I following your logic Ok so far?

It would have saved reviewers' time if you explained your patch a bit
better, perhaps like...

	When command_input_pipe and command_output_pipe are used as a
	method of a Git::repository instance, they eventually call into
	_cmd_exec method that sets up the execution environment such as
	GIT_DIR, GIT_WORK_TREE environment variables and the current
	working directory in the child process that interacts with the
	repository.

        command_bidi_pipe however didn't expect to be called as such, and
	lacked all these set-up.  Because of this, a program that did this
	did not work as expected:

            my $repo = Git->repository(Directory => '/some/where/else');
            my ($pid, $in, $out, $ctx) = 
            $repo->command_bidi_pipe(qw(hash-object -w --stdin-paths));

	This patch refactors the _cmd_exec into _setup_git_cmd_env that
	sets up the execution environment, and makes _cmd_exec and
	command_bidi_pipe to use it.

	Note that unlike _cmd_exec that execv's a git command as an
	external process, command_bidi_pipe is called from the main line
	of control, and the execution environment needs to be restored
	after open2() does its magic.

Thanks.
