From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: git status options feature suggestion
Date: Sun, 12 Oct 2008 01:10:01 -0700
Message-ID: <7v1vymgrom.fsf@gitster.siamese.dyndns.org>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
 <20081009061136.GA24288@coredump.intra.peff.net>
 <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
 <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
 <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <48EE1F58.2060707@drmicha.warpmail.net>
 <20081012044900.GA27845@coredump.intra.peff.net>
 <7vwsgegvsh.fsf@gitster.siamese.dyndns.org>
 <20081012064512.GA32597@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 12 10:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kow38-0002hA-Ay
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 10:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbYJLIKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 04:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbYJLIKP
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 04:10:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbYJLIKN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 04:10:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D0826D20F;
	Sun, 12 Oct 2008 04:10:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5E5D06D20E; Sun, 12 Oct 2008 04:10:02 -0400 (EDT)
In-Reply-To: <20081012064512.GA32597@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 12 Oct 2008 02:45:13 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 310B9FD6-9835-11DD-ADB9-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98006>

Jeff King <peff@peff.net> writes:

> I remember a long time ago you started on a parallel diff walker that
> could diff the working tree, the index, and a tree at once. Do you
> remember the issues with it?

Sorry, I don't.

> I think that would be the right tool here to show each file only once,
> but with multiple status flags. Something like:
>
>   A M foo
>
> to show that "foo" has been added since the last commit, but there are
> modifications in the working tree that have not yet been staged.

One thing to keep in mind is what to do when you would want to detect
renames.  The parallel walk would be Ok but between HEAD and index there
could be renames involved, and at that point it would get quite tricky.
Once the index is in-core, I think it hurts us much to walk HEAD vs index
and index vs working tree in separate passes.

I think it is perfectly fine to run the diff-index first, and keep the
result from it in a string_list, and then run "diff-files" and annotate
the string_list with the output from it.

Something like...

	struct git_st_data {
        	const char *head_path;
                char head_to_index_status;
                char index_to_worktree_status;
	};

	static int cmp_head_path(const void *a_, const void *b_)
        {
		struct git_st_data *a = (struct git_st_data *)a_;
		struct git_st_data *b = (struct git_st_data *)b_;
		return strcmp(a->head_path, b->head_path);
        }

	static void git_st_inspect_index_cb(struct diff_queue_struct *q,
        			struct diff_options *opts, void *data)
	{
		struct string_list *git_st_list = data;
		int i;
		for (i = 0; i < q->nr; i++) {
                	struct git_st_data *d;
                        struct string_list_item *e;
			struct diff_filepair *fp = &q->queue[i];
			d = xcalloc(1, sizeof(*d));
                        d->head_path = xstrdup(fp->one->path);
                        e = string_list_insert(fp->two->path, git_st_list);
			e->util = d;
                        d->head_to_index_status = fp->status;
                }
	}

	static void git_st_inspect_file_cb(struct diff_queue_struct *q,
        			struct diff_options *opts, void *data)
	{
		struct string_list *git_st_list = data;
		int i;
		for (i = 0; i < q->nr; i++) {
                	struct git_st_data *d;
                        struct string_list_item *e;
			struct diff_filepair *fp = &q->queue[i];
			e = string_list_lookup(fp->one->path, git_st_list);
			if (!e)
                        	die("Oops -- shouldn't happen");
			d = e->util;
                        d->index_to_worktree_status = fp->status;
                }
	}

	void git_st_inspect(struct string_list *git_st_list)
        {
        	struct rev_info rev;

		git_st_list->items = NULL;
                git_st_list->nr = git_st_list->alloc = 0;
                git_st_list->strdup_strings = 1;

		/*
                 * run "diff-index -B -M HEAD" and keep the result in a
                 * string list, keyed by the path in the index.
                 */
                init_revisions(&rev, NULL);
                setup_revisions(0, NULL, &rev, "HEAD");
                rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
                rev.diffopt.format_callback = git_st_inspect_index_cb;
                rev.diffopt.format_callback_data = git_st_list;
                rev.diffopt.detect_rename = 1;
                rev.diffopt.rename_limit = 200;
                rev.diffopt.break_opt = 0;
                run_diff_index(&rev, 1);

		/*
                 * run "diff-files" and update the previous with the result.
		 */
		init_revisions(&rev, NULL);
                setup_revisions(0, NULL, &rev, NULL);
                rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
                rev.diffopt.format_callback = git_st_inspect_file_cb;                
                rev.diffopt.format_callback_data = git_st_list;
                run_diff_files(&rev, 0);

		/*
                 * sort the string-list entries in HEAD path order
                 */
		qsort(git_st_list->items, git_st_list->nr,
                      sizeof(struct string_list_item),
                      cmp_head_path);
	}

Then git_st_inspect() can also be called by wt_status_print(), making it
unnecessary to do the equivalent of the above in wt_status_print_updated()
and wt_status_print_changed().
