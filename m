From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 properly indented] fix start_command() bug when stdin
 is closed
Date: Mon, 25 Aug 2008 23:09:09 -0700
Message-ID: <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
 <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org>
 <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net>
 <E1KXcH3-0000zJ-0m@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 08:10:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXrl2-0003Zj-Vc
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 08:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbYHZGJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 02:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYHZGJU
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 02:09:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbYHZGJT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 02:09:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 393D168C39;
	Tue, 26 Aug 2008 02:09:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 56C8A68C36; Tue, 26 Aug 2008 02:09:12 -0400 (EDT)
In-Reply-To: <E1KXcH3-0000zJ-0m@fencepost.gnu.org> (Paolo Bonzini's message
 of "Mon, 25 Aug 2008 15:37:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8454ACFC-7335-11DD-8050-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93713>

Paolo Bonzini <bonzini@gnu.org> writes:

>  int start_command(struct child_process *cmd)
>  {
>  	int need_in, need_out, need_err;
>  	int fdin[2], fdout[2], fderr[2];
>  
>  	/*
> +	 * Make sure that all file descriptors <= 2 are open, otherwise we
> +	 * mess them up when dup'ing pipes onto stdin/stdout/stderr.  Since
> +	 * we are at it, save a file descriptor on /dev/null to use it later.
> +	 */
> +	if (devnull_fd == -1) {
> +		devnull_fd = open("/dev/null", O_RDWR);
> +		while (devnull_fd >= 0 && devnull_fd <= 2)
> +			devnull_fd = dup(devnull_fd);
> +		if (devnull_fd == -1)
> +			die("opening /dev/null failed (%s)", strerror(errno));
> +	}
> +

I may be misreading the patch but, this logic always opens /dev/null, if
nobody asked for *any* cmd->no_stdXXX and low 3 fds are occupied, and
worse, it keeps fd=3 open.

Making sure low fds 0, 1 and 2 are open is a good thing.  I do not think
clobbering fd=3 is good.

Also shouldn't this be done only on the side that dup()s fds around,
i.e. in the child process after fork()?  Why is this done for the parent?
