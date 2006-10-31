X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] upload-pack: no longer call rev-list
Date: Mon, 30 Oct 2006 21:11:25 -0800
Message-ID: <7v1woprrwi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0610302008320.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 05:11:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0610302008320.26682@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 30 Oct 2006 20:08:43 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30568>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeluV-00012g-M5 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 06:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965524AbWJaFL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 00:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965523AbWJaFL1
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 00:11:27 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60087 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S965524AbWJaFL0
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 00:11:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031051126.QOET18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Tue, 31
 Oct 2006 00:11:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gtB61V00H1kojtg0000000 Tue, 31 Oct 2006
 00:11:06 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It is trivial to do now,...

May be, but can we do something about these duplicated code?

> @@ -57,6 +60,40 @@ static ssize_t send_client_data(int fd,
>  	return safe_write(fd, data, sz);
>  }
>  
> +FILE *pack_pipe = NULL;
> +static void show_commit(struct commit *commit)
> +{
> +	if (commit->object.flags & BOUNDARY)
> +		fputc('-', pack_pipe);
> +	if (fputs(sha1_to_hex(commit->object.sha1), pack_pipe) < 0)
> +		die("broken output pipe");
> +	fputc('\n', pack_pipe);
> +	fflush(pack_pipe);
> +	free(commit->buffer);
> +	commit->buffer = NULL;
> +}
> +
> +static void show_object(struct object_array_entry *p)
> +{
> +	/* An object with name "foo\n0000000..." can be used to
> +	 * confuse downstream git-pack-objects very badly.
> +	 */
> +	const char *ep = strchr(p->name, '\n');
> +	if (ep) {
> +		fprintf(pack_pipe, "%s %.*s\n", sha1_to_hex(p->item->sha1),
> +		       (int) (ep - p->name),
> +		       p->name);
> +	}
> +	else
> +		fprintf(pack_pipe, "%s %s\n",
> +				sha1_to_hex(p->item->sha1), p->name);
> +}
> +
> +static void show_edge(struct commit *commit)
> +{
> +	fprintf(pack_pipe, "-%s\n", sha1_to_hex(commit->object.sha1));
> +}
> +

