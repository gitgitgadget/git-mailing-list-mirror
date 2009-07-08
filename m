From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] quickfetch(): Prevent overflow of the rev-list command
 line
Date: Wed, 08 Jul 2009 10:22:34 -0700
Message-ID: <7vws6j6qed.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
 <200907081558.51767.johan@herland.net> <4A54B755.4090100@viscovery.net>
 <200907081801.36901.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 19:22:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOar6-0003JN-W7
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 19:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbZGHRWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 13:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbZGHRWp
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 13:22:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbZGHRWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 13:22:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2FE1526B6C;
	Wed,  8 Jul 2009 13:22:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 866E426B63; Wed, 
 8 Jul 2009 13:22:36 -0400 (EDT)
In-Reply-To: <200907081801.36901.johan@herland.net> (Johan Herland's message
 of "Wed\, 8 Jul 2009 18\:01\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F222E31E-6BE3-11DE-B823-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122906>

Johan Herland <johan@herland.net> writes:

> Maybe I need to do something to the close() call as well? What happens
> on close() after EPIPE?

You should be OK (you could try this).

-- >8 --
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>

int main(int ac, char **av)
{
	int pipefd[2];
	int child;

	if (pipe(pipefd) < 0) {
		fprintf(stderr, "pipe failed: %s\n", strerror(errno));
		exit(1);
	}
	child = fork();
	if (child < 0) {
		fprintf(stderr, "fork failed: %s\n", strerror(errno));
		exit(1);
	} else if (child == 0) {
		char buf[1024];
		ssize_t sz;

		/* the child reads from the parent but does not talk back */
		close(pipefd[1]);

		/* emulate reading a bit, then dying without cleaning up */
		sz = read(pipefd[0], buf, sizeof(buf));
		fprintf(stderr, "read %lu bytes, and will die\n",
			(unsigned long) sz);
		exit(1);
	} else {
		const char data[] = "abcdefg";
		size_t len = sizeof(data);
		size_t written = 0;

		/* the parent writes to the child but does not listen */
		close(pipefd[0]);

		/* we will rite to the pipe even after the child is gone */
		signal(SIGPIPE, SIG_IGN);

		/* write, write, write, ... */
		while (1) {
			ssize_t sz = write(pipefd[1], data, len);
			if (sz < 0) {
				/* error */
				fprintf(stderr,
					"write failed (%s) after writing"
					" %lu bytes\n",
					strerror(errno),
					(unsigned long) written);
				break;
			}
			written += sz;
		}
		errno = 0;
		if (close(pipefd[1]))
			fprintf(stderr, "close failed: %s\n", strerror(errno));
		else
			fprintf(stderr, "close ok\n");
	}
	exit(0);
}
