From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/3] revert: introduce --abort to cancel a failed
 cherry-pick
Date: Wed, 30 Nov 2011 14:52:23 -0800
Message-ID: <7vty5lp6jc.fsf@alter.siamese.dyndns.org>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 23:52:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVt14-0006nm-JJ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 23:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab1K3Ww1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 17:52:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab1K3Ww0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 17:52:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EB2B648D;
	Wed, 30 Nov 2011 17:52:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=AGDxnwbd++aiK2zXDiabx9o8eAU=; b=GkQZanZqj2dmQo0urXZR
	MnvtIthHdVFmKEW9v5+cUDuGq2Ef2rs9q0MgjnD8boCDXaGNLMJNi40axbDGYrDv
	XW/jqSimZlMj/FCejBfPLbqSoasTqOCXehUnUx95LlvvLhBbXcJW9WNHfuLb1bYD
	TqaDNqRM6fvF2nhd+T4NsUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=CTqTPhjujOdT1mL7oo97TYcjJxmD1cURm4B1JYfcowpSrh
	sLSiLsVGuWXeP1/UDsrav6aY1eTfCKn3K/udFoVk/u7Y/W0bTw5upjO1gi7W6my1
	uoQWdaOm1shSZdrBlM4rJjTf/McFEwD44ApEERwaWjP4RmEbpu+TXOqGYHapA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51ED3648C;
	Wed, 30 Nov 2011 17:52:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E8B56488; Wed, 30 Nov 2011
 17:52:24 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F848A0D4-1BA5-11E1-AE55-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186142>

Jonathan Nieder <jrnieder@gmail.com> writes:

> After running some ill-advised command like "git cherry-pick
> HEAD..linux-next", the bewildered novice may want to return to more
> familiar territory.  Introduce a "git cherry-pick --abort" command
> that rolls back the entire cherry-pick sequence and places the
> repository back on solid ground.

This is confusing; if you have many commits in the range, and a handful of
them replayed without conflicts and then you hit a conflict, where should
(I am not asking "where does ... with your patch") abort take us? The
state after the random commit that happened to have replayed successfully?
The state before the entire cherry-pick sequence started?  "back on solid
ground" does not tell us which one you meant.

I am assuming that it is the latter.

> diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
> index 75f8e869..5747f442 100644
> --- a/Documentation/sequencer.txt
> +++ b/Documentation/sequencer.txt
> @@ -7,3 +7,6 @@
>  	Forget about the current operation in progress.  Can be used
>  	to clear the sequencer state after a failed cherry-pick or
>  	revert.
> +
> +--abort::
> +	Cancel the operation and return to the pre-sequence state.

Ok, it is the latter.

> +static int reset_for_rollback(const unsigned char *sha1)
> +{
> +	const char *argv[4];	/* reset --merge <arg> + NULL */
> +	argv[0] = "reset";
> +	argv[1] = "--merge";
> +	argv[2] = sha1_to_hex(sha1);
> +	argv[3] = NULL;
> +	return run_command_v_opt(argv, RUN_GIT_CMD);
> +}

So you give the value of the HEAD before the sequence started to this
function and all should go well. Where do you read that value from?

> +static int rollback_single_pick(void)
> +{
> +	unsigned char head_sha1[20];
> +
> +	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
> +	    !file_exists(git_path("REVERT_HEAD")))
> +		return error(_("no cherry-pick or revert in progress"));
> +	if (!resolve_ref("HEAD", head_sha1, 0, NULL))
> +		return error(_("cannot resolve HEAD"));
> +	if (is_null_sha1(head_sha1))
> +		return error(_("cannot abort from a branch yet to be born"));

Ok, this is for single-pick so HEAD is where we came from. Good.

> +	return reset_for_rollback(head_sha1);
> +}
> +
> +static int sequencer_rollback(struct replay_opts *opts)
> +{
> +	const char *filename;
> +	FILE *f;
> +	unsigned char sha1[20];
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	filename = git_path(SEQ_HEAD_FILE);
> +	f = fopen(filename, "r");
> +	if (!f && errno == ENOENT) {
> +		/*
> +		 * There is no multiple-cherry-pick in progress.
> +		 * If CHERRY_PICK_HEAD or REVERT_HEAD indicates
> +		 * a single-cherry-pick in progress, abort that.
> +		 */
> +		return rollback_single_pick();
> +	}
> +	if (!f)
> +		return error(_("cannot open %s: %s"), filename,
> +						strerror(errno));
> +	if (strbuf_getline(&buf, f, '\n')) {
> +		error(_("cannot read %s: %s"), filename, ferror(f) ?
> +			strerror(errno) : _("unexpected end of file"));
> +		goto fail;
> +	}

And when we are in multi-pick, SEQ_HEAD_FILE has it.

Looks good from a cursory review. Thanks.
