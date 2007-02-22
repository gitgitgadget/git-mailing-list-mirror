From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Wed, 21 Feb 2007 23:08:08 -0800
Message-ID: <7v4ppellev.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xeqllxk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 08:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK83s-0007OW-Bk
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 08:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbXBVHIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 02:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbXBVHIK
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 02:08:10 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:64635 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbXBVHIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 02:08:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222070808.VIUB2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 02:08:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SX881W0041kojtg0000000; Thu, 22 Feb 2007 02:08:08 -0500
In-Reply-To: <7v8xeqllxk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 21 Feb 2007 22:56:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40337>

Junio C Hamano <junkio@cox.net> writes:

>> +static int verify_bundle(struct bundle_header *header)
>> +{
>> +	/*
>> +	 * Do fast check, then if any prereqs are missing then go line by line
>> +	 * to be verbose about the errors
>> +	 */
>> +	struct ref_list *p = &header->prerequisites;
>> +	const char *argv[5] = {"rev-list", "--stdin", "--not", "--all", NULL};
>> +	int pid, in, out, i, ret = 0;
>> +	char buffer[1024];
>> +
>> +	in = out = -1;
>> +	pid = fork_with_pipe(argv, &in, &out);
>> +	if (pid < 0)
>> +		return error("Could not fork rev-list");
>> +	if (!fork()) {
>> +		for (i = 0; i < p->nr; i++) {
>> +			write(in, sha1_to_hex(p->list[i].sha1), 40);
>> +			write(in, "\n", 1);
>> +		}
>> +		close(in);
>> +		exit(0);
>> +	}
>> +	close(in);
>
> What if write() fails?  That can happen when one of the objects
> you feed here, or its parent objects, is missing from your
> repository -- receiving rev-list would die() and the writing
> child would sigpipe.
>
> I also wonder who waits for this child...

In general, fork() to avoid bidirectional pipe deadlock is a
good discipline, but in this particular case I think it would be
easier to handle errors if you don't (and it would save another
process).  The other side "rev-list --stdin --not --all" is
running a limited traversal, and would not emit anything until
you stop feeding it from --stdin, or until it dies because you
fed it a commit that does not exist.  So as long as you check
the error condition from write() for EPIPE to notice the other
end died, I think you are Ok.
