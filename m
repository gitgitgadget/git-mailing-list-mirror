From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v9 3/5] Implement line-history search (git log -L)
Date: Sat, 23 Mar 2013 07:00:45 +0100
Message-ID: <87fvzmzmcy.fsf@pctrast.inf.ethz.ch>
References: <cover.1363865444.git.trast@student.ethz.ch>
	<b8cabd5ca63a17577fca524891046e5a3d3dfc60.1363865444.git.trast@student.ethz.ch>
	<7vr4j8a7zy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 07:01:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJHW1-0004OD-2W
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 07:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab3CWGAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 02:00:50 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:56763 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab3CWGAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 02:00:49 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 23 Mar
 2013 07:00:42 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.211.48) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 23 Mar
 2013 07:00:46 +0100
In-Reply-To: <7vr4j8a7zy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 21 Mar 2013 12:05:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.211.48]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218888>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> +void line_log_init(struct rev_info *rev, const char *prefix, struct
>> string_list *args)
>> +{
>> +	struct commit *commit = NULL;
>> +	struct line_log_data *range;
>> +
>> +	commit = check_single_commit(rev);
>> +	range = parse_lines(commit, prefix, args);
>> +	add_line_range(rev, commit, range);
>> +
>> +	if (!rev->diffopt.detect_rename) {
>> +		int i, count = 0;
>> +		struct line_log_data *r = range;
>> +		const char **paths;
>> +		while (r) {
>> +			count++;
>> +			r = r->next;
>> +		}
>> +		paths = xmalloc((count+1)*sizeof(char *));
>> +		r = range;
>> +		for (i = 0; i < count; i++) {
>> +			paths[i] = xstrdup(r->spec->path);
>> +			r = r->next;
>> +		}
>> +		paths[count] = NULL;
>> +		init_pathspec(&rev->diffopt.pathspec, paths);
>> +		free(paths);
>> +	}
>> +}
>
> Why not do the pathspec limitation under "-M"?
>
> It is not like you are picking up origins of blocks of lines copied
> or moved from other files like "blame -C" does, so I suspect it
> would be simpler to mimic what --follow does, which is to (1) use
> the pathspec to follow the paths you care about, and then (2) when
> you find one or more of the paths you were following disappear in a
> commit, only at that point you re-check to see if there are other
> paths that existed in the parent that the disappeared paths were
> renamed from, and match with that one.

It's acting too soon though.  The way log -L is currently wired, we do
one revision walk with the pathspec filter already enabled to do the
topo sorting.  Wiring it in *at that point* would be equivalent to
fixing --follow.

Which I plan to do Real Soon Now(tm).  But let's not open too many cans
of worms at the same time.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
