From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: check when helpers fail
Date: Sun, 21 Oct 2012 13:33:40 -0700
Message-ID: <7v7gqjftuj.fsf@alter.siamese.dyndns.org>
References: <1350847158-14154-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 22:33:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ2Dc-0001RT-Tw
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 22:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab2JUUdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 16:33:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35890 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468Ab2JUUdp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 16:33:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B9138C43;
	Sun, 21 Oct 2012 16:33:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lPjBsB6dY8lI0zZT+QRv4irXclg=; b=RLH6OX
	sfUsPbu+nUsDSIKo3ZqX4aLS/DZv+dC5H/g7x80DOj+NpS5jji2Juq9L11mNq0pj
	5Ffs4JM3QQW7TyiRACkAY1wSonRu+L/IsD5rXBDYOUKR67H6DWtaIZmhTQ98WLEu
	0le2G8W47U4/HFYPT0BFHQc+s1lbaITAd9ZTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c1nJkw1OVNZaGs7ixfjF7xPGAziJnbkD
	qqTonMXnxYks4ie0JGQ3TmIEAmCWsOHOLthJlDlaBzcTfM8HKV8QxZy6S/FfYkLE
	tQijwFYfEAECjn0HMosUU6746nKhah/jzClcbpP22AzP+qUuIOUyNMZg3QRx+BBt
	fvt6diGTAY0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 568F28C41;
	Sun, 21 Oct 2012 16:33:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EE678C3D; Sun, 21 Oct 2012
 16:33:42 -0400 (EDT)
In-Reply-To: <1350847158-14154-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 21 Oct 2012 21:19:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A982562-1BBE-11E2-9376-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208147>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Otherwise transport-helper will continue checking for refs and other
> things what will confuse the user more.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-remote-testgit.py     |  3 +++
>  run-command.c             | 17 +++++++++++++++++
>  run-command.h             |  1 +
>  t/t5800-remote-helpers.sh |  6 ++++++
>  transport-helper.c        |  8 ++++++++
>  5 files changed, 35 insertions(+)
>
> diff --git a/git-remote-testgit.py b/git-remote-testgit.py
> index 5f3ebd2..355e3f5 100644
> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -159,6 +159,9 @@ def do_import(repo, args):
>          ref = line[7:].strip()
>          refs.append(ref)
>  
> +    if os.environ.get("GIT_REMOTE_TESTGIT_FAILURE"):
> +        die('Told to fail')
> +

Fun.

> diff --git a/run-command.c b/run-command.c
> index 1101ef7..2852e9d 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -559,6 +559,23 @@ int run_command(struct child_process *cmd)
>  	return finish_command(cmd);
>  }
>  
> +int check_command(struct child_process *cmd)
> +{
> +	int status;
> +	pid_t pid;
> +
> +	pid = waitpid(cmd->pid, &status, WNOHANG);
> +
> +	if (pid < 0)
> +		return -1;
> +	if (WIFSIGNALED(status))
> +		return WTERMSIG(status);
> +	if (WIFEXITED(status))
> +		return WEXITSTATUS(status);
> +
> +	return 0;
> +}

It is nice to have a separate helper that would theoretically be
useful by anybody who runs a child process, but I have to wonder:

 - How other codepaths that run child process check their results?
   Do they ignore the result altogether?  Do they check the results
   in an ad-hoc way without a good reason?  Do they check the
   results differently because their error handling need to be
   different?

   With this, I am not requesting to port these other codepaths to
   use this helper in this patch series.  But designing the helper
   with potential others' use in mind is within the scope of this
   patch.

 - How does the caller use the return value from this helper?  I can
   see that "zero is success, non-zero is failure", unless there is
   a platform what defines a signum 0 for some signal that can kill
   the child process.  But I am not sure if the caller can tell more
   than that from the return value ("did it die with a signal, or
   did it exit with non-zero status"?)

   It looks to me that this helper loses information; does it belong
   to the public part of API in run-command.c?

> diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
> index e7dc668..d4b17ae 100755
> --- a/t/t5800-remote-helpers.sh
> +++ b/t/t5800-remote-helpers.sh
> @@ -145,4 +145,10 @@ test_expect_failure 'push new branch with old:new refspec' '
>  	compare_refs clone HEAD server refs/heads/new-refspec
>  '
>  
> +test_expect_success 'proper failure checks' '
> +	export GIT_REMOTE_TESTGIT_FAILURE=1 &&
> +	! git clone "testgit::$PWD/server" failure 2> errors &&
> +	grep -q "Error while running helper" errors
> +'
> +
>  test_done

Please be nicer to people who come *after* you are done with this
change.  Forcing failure will propagate to any new test added after
this piece with this patch.

Perhaps like this:

        test_expect_success 'proper failure checks' '
		(
	                GIT_REMOTE_TESTGIT_FAILURE=1 &&
	                export GIT_REMOTE_TESTGIT_FAILURE &&
	                test_must_fail git clone "testgit::$PWD/server" failure
		) 2>errors &&
                grep "Error while running helper" errors
        '

Points to note:

 - The environment does not propagate outside this test this way.

 - Avoid "export VAR=VAL" to help other people's shell; cf. 69ae92b
   (shell portability: no "export VAR=VAL", 2010-10-13).

 - Detect uncontrolled exit of "git clone" by using test_must_fail.

 - Avoid "grep -q"; cf. the latter half of aadbe44 (grep portability
   fix: don't use "-e" or "-q", 2008-03-12).

Thanks.
