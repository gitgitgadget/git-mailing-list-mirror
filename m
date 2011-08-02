From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Tue, 2 Aug 2011 04:36:41 +0200
Message-ID: <201108020436.42148.chriscool@tuxfamily.org>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com> <1312222025-28453-18-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 04:36:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo4qo-0006pn-M8
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 04:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873Ab1HBCgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 22:36:53 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55544 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753821Ab1HBCgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 22:36:52 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DE7A5A6108;
	Tue,  2 Aug 2011 04:36:43 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1312222025-28453-18-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178432>

On Monday 01 August 2011 20:07:04 Ramkumar Ramachandra wrote:
>
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
> +	if (fd < 0)
> +		die_errno(_("Could not open %s."), todo_file);
> +	if (strbuf_read(&buf, fd, 0) < 0) {
> +		close(fd);
> +		strbuf_release(&buf);
> +		die(_("Could not read %s."), todo_file);
> +	}
> +	close(fd);
> +
> +	next = todo_list;
> +	for (p = buf.buf; *p; p = strchr(p, '\n') + 1) {
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

I'd suggest using 2 functions like this:

static int parse_insn_buffer(char *buffer,
			     struct commit_list **todo_list,
			     struct replay_opts *opts)
{
	struct commit_list **next = todo_list;
	char *p = buffer;
	int i;

	for (i = 1; p && *p; i++) {
		struct commit *commit = parse_insn_line(p, opts);
		if (!commit)
			return error(_("Could not parse line %d."), i);
		next = commit_list_append(commit, next);
		p = strchr(p, '\n');
		if (p)
			p++;
	}
	if (!*todo_list)
		return error(_("Could not parse one commit."));
	return 0;
}

static void read_populate_todo(struct commit_list **todo_list,
			       struct replay_opts *opts)
{
	const char *todo_file = git_path(SEQ_TODO_FILE);
	struct strbuf buf = STRBUF_INIT;
	int fd, res;

	fd = open(todo_file, O_RDONLY);
	if (fd < 0)
		die_errno(_("Could not open %s."), todo_file);
	if (strbuf_read(&buf, fd, 0) < 0) {
		close(fd);
		strbuf_release(&buf);
		die(_("Could not read %s."), todo_file);
	}
	close(fd);

	res = parse_insn_buffer(buf.buf, todo_list, opts);
	strbuf_release(&buf);
	if (res)
		die(_("Unusable instruction sheet: %s"), todo_file);
}

Thanks,
Christian.
