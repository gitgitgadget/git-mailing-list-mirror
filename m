From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] run-command: Add checks after execvp fails with
 EACCES
Date: Tue, 13 Dec 2011 11:01:21 -0800
Message-ID: <7vliqguwhq.fsf@alter.siamese.dyndns.org>
References: <op.v5e8mgbc0aolir@keputer>
 <1323788917-4141-1-git-send-email-fransklaver@gmail.com>
 <1323788917-4141-2-git-send-email-fransklaver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 20:01:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaXbU-00012N-Rr
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 20:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab1LMTBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 14:01:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37549 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750Ab1LMTBX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 14:01:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34D6A518F;
	Tue, 13 Dec 2011 14:01:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bO8wlrIOe07BI7OSKvFkMVef2Gw=; b=SnrEuN
	HOLQfDPSj9tWqw1zSwPUaqfeI9/4eOonX0kM2L6ct4QjgwjwGvnD1bR5IcfkTImY
	prFyIZAvej46zFgCPvJEeDvSZgWBnovKGNecJFwGVojQoFTAD1Z9wVmTxVr1QQI1
	TVLQuoSS/2eRxIWxrS5GnHnW/MGE9PsD2/PxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kSQsxDXNaudBULYFpO3fFawI8FIWURvO
	3Lq9FoclwI3Ko8qwo1dTKIkVo1k/DMBQDBY2mq7E2HVaVPDY0gnd/CAhumo3KKD2
	FvyvRSOHaTsB4bO4MCthlTuECbKcOfx22hlZWZ70uwKHSjlxzhPiGHbWczkmwwmZ
	cM/InSJRFl8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CE98518E;
	Tue, 13 Dec 2011 14:01:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DD7F518C; Tue, 13 Dec 2011
 14:01:22 -0500 (EST)
In-Reply-To: <1323788917-4141-2-git-send-email-fransklaver@gmail.com> (Frans
 Klaver's message of "Tue, 13 Dec 2011 16:08:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D93D29D2-25BC-11E1-AE2A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187045>

Frans Klaver <fransklaver@gmail.com> writes:

> +static void diagnose_execvp_eacces(const char *cmd, const char **argv)
> +{
> +	/*
> +	 * man 2 execve states that EACCES is returned for:
> +	 * - Search permission is denied on a component of the path prefix
> +	 *   of cmd or the name of a script interpreter
> +	 * - The file or script interpreter is not a regular file
> +	 * - Execute permission is denied for the file, script or ELF
> +	 *   interpreter
> +	 * - The file system is mounted noexec
> +	 */
> +	struct strbuf sb = STRBUF_INIT;
> +	char *path;
> +	char *next;
> +
> +	if (strchr(cmd, '/')) {
> +		if (!have_read_execute_permissions(cmd))
> +			error("no read/execute permissions on '%s'\n", cmd);
> +		return;
> +	}
> +

Three points.

 - error() gives you a LF at the end, so you do not have to have your own.

 - That "have_..._ions()" is too long and ugly.

 - The only thing you care about this callsite is if you have enough
   permission to execute the "cmd".

In fact, you should not unconditionally require read permissions here.

    $ chmod a-r $(type --path git) && /bin/ls -l $(type --path git)
    --wx--x--x 109 junio junio 5126580 Dec 13 09:47 /home/junio/git-active/bin/git
    $ /home/junio/git-active/bin/git --version
    git version 1.7.8.249.gb1b73

You may need read permission when the file is a script (i.e. not binary
executable).

> +	path = getenv("PATH");
> +	while (path) {
> +		next = strchrnul(path, ':');
> +		if (path < next)
> +			strbuf_add(&sb, path, next - path);
> +		else
> +			strbuf_addch(&sb, '.');
> +
> +		if (!*next)
> +			path = NULL;
> +		else
> +			path = next + 1;
> +
> +		if (!have_read_execute_permissions(sb.buf)) {

When checking if you can run "foo/bar/baz", directories "foo/" and "foo/bar/"
do not have to be readable.  They only have to have executable bit to allow
descending into them, and typically this is called "searchable" (see man chmod).

    $ mkdir -p /var/tmp/a/b && cp $(type --path git) /var/tmp/a/b/git
    $ chmod 111 /var/tmp/a /var/tmp/a/b
    $ /var/tmp/a/b/git --version
    git version 1.7.8.249.gb1b73

I'd suggest having two helper functions, instead of the single one with
overlong "have...ions" name.

 - can_search_directory() checks with access(X_OK);

 - can_execute_file() checks with access(X_OK|R_OK), even though R_OK is
   not always needed.

Use the former here where you check the directory that contains the
command, and use the latter up above where you check the command that is
supposed to be executable, and also down below after you checked sb.buf is
a path to a file that may be the command that is supposed to be
executable.

Then patch 2/2 can extend can_execute() to enhance its support for scripts
by reading the hash-bang line and validating it, etc.
