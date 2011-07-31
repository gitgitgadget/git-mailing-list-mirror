From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Sun, 31 Jul 2011 17:51:52 +0200
Message-ID: <201107311751.52965.chriscool@tuxfamily.org>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com> <1311871951-3497-18-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 17:56:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnYNd-00026A-SU
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 17:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab1GaPwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 11:52:07 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:45333 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839Ab1GaPwE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 11:52:04 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 70C6DA6225;
	Sun, 31 Jul 2011 17:51:55 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1311871951-3497-18-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178261>

On Thursday 28 July 2011 18:52:30 Ramkumar Ramachandra wrote:
> +static void read_populate_todo(struct commit_list **todo_list,
> +			struct replay_opts *opts)
> +{
> +	const char *todo_file = git_path(SEQ_TODO_FILE);
> +	struct strbuf buf = STRBUF_INIT;
> +	struct commit_list **next;
> +	struct commit *commit;
> +	char *p;
> +	int fd;
> +
> +	fd = open(todo_file, O_RDONLY);
> +	if (fd < 0) {
> +		strbuf_release(&buf);

We don't need to release buf here.

> +		die_errno(_("Could not open %s."), todo_file);
> +	}
> +	if (strbuf_read(&buf, fd, 0) < buf.len) {

The other places in the code are using "strbuf_read(...) < 0" to detect an 
error.

> +		close(fd);
> +		strbuf_release(&buf);
> +		die(_("Could not read %s."), todo_file);
> +	}
> +	close(fd);
> +
> +	next = todo_list;
> +	for (p = buf.buf; *p; p = strchr(p, '\n') + 1) {

This relies on a "\n" at the end of the last line...

> +		commit = parse_insn_line(p, opts);
> +		if (!commit)
> +			goto error;
> +		next = commit_list_append(commit, next);
> +	}
> +	if (!*todo_list)
> +		goto error;
> +	strbuf_release(&buf);
> +	return;
> +error:
> +	strbuf_release(&buf);
> +	die(_("Unusable instruction sheet: %s"), todo_file);
> +}

Thanks,
Christian.
