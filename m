From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] fetch/push: readd rsync support
Date: Sat, 29 Sep 2007 23:09:52 -0700
Message-ID: <7vhclciszz.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
	<Pine.LNX.4.64.0709281629270.28395@racer.site>
	<7vtzpeo5ar.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709290134000.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 08:10:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibs0M-0002YM-1y
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 08:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbXI3GKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 02:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbXI3GKB
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 02:10:01 -0400
Received: from rune.pobox.com ([208.210.124.79]:47921 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbXI3GKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 02:10:00 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 5691113E9E0;
	Sun, 30 Sep 2007 02:10:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5DCFC13E9DD;
	Sun, 30 Sep 2007 02:10:16 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709290134000.28395@racer.site> (Johannes
	Schindelin's message of "Sat, 29 Sep 2007 01:35:06 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59523>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> We lost rsync support when transitioning from shell to C.  Support it
> again (even if the transport is technically deprecated, some people just
> do not have any chance to use anything else).

s/chance/choice/?

> +test "$TEST_RSYNC" && {

Somehow this feels dirty ... perhaps leave early like:

	if test -z "$TEST_RSYNC"
        then
        	test_expect_success 'skipping rsync transport tests' :
		test_done
                exit
	fi

> diff --git a/transport.c b/transport.c
> index 4f9cddc..a2ee8f3 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -6,6 +6,330 @@
> ...
> +{
> +	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
> +	struct ref dummy, *tail = &dummy;
> +	struct child_process rsync;
> +	const char *args[5];
> +	int temp_dir_len;
> +
> +	/* copy the refs to the temporary directory */
> +
> +	strbuf_addstr(&temp_dir, git_path("rsync-refs-XXXXXX"));
> +	if (!mkdtemp(temp_dir.buf))
> +		die ("Could not make temporary directory");

I wonder how portable mkdtemp() is (it does not seem to be POSIX);
would we need something in compat/ perhaps based on tempnam()?

> +static int fetch_objs_via_rsync(struct transport *transport,
> +				 int nr_objs, struct ref **to_fetch)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct child_process rsync;
> +	const char *args[8];
> +	int result;
> +
> +	strbuf_addstr(&buf, transport->url);
> +	strbuf_addstr(&buf, "/objects/");
> +
> +	memset(&rsync, 0, sizeof(rsync));
> +	rsync.argv = args;
> +	rsync.stdout_to_stderr = 1;
> +	args[0] = "rsync";
> +	args[1] = transport->verbose ? "-rv" : "-r";
> +	args[2] = "--ignore-existing";
> +	args[3] = "--exclude";
> +	args[4] = "info";
> +	args[5] = buf.buf;
> +	args[6] = get_object_directory();
> +	args[7] = NULL;

Hmm, we used to do "rsync $remote/objects/ $our/.git/objects/",
but this omits the trailing "/" from our side.  I suspect the
reason was to deal with the case where our .git/objects was a
symlink to elsewhere (which was how you did alternates before
alternates was invented), which may not matter anymore these
days.
