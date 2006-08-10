From: Jeff King <peff@peff.net>
Subject: diff machinery cleanup
Date: Thu, 10 Aug 2006 04:24:55 -0400
Message-ID: <20060810082455.GA30739@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 10 10:25:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5qf-00040g-Gf
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 10:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWHJIY6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 04:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWHJIY6
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 04:24:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:61882 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751449AbWHJIY5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 04:24:57 -0400
Received: (qmail 8465 invoked from network); 10 Aug 2006 04:24:23 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Aug 2006 04:24:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2006 04:24:55 -0400
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25170>

I'm trying to run two different 'diffs' in the same C program, and the
results of the second diff depend on whether or not the first diff has
run. A minimal case is below. When show_updated() is run, show_changed()
results in all files listed as "unmerged". If show_updated() is
commented out, the output for show_changed() is as expected.

-- >8 --
#include "cache.h"
#include "object.h"
#include "commit.h"
#include "diff.h"
#include "revision.h"

void show_updated() {
	struct rev_info rev;
	const char *argv[] = { NULL, "HEAD", NULL };
	init_revisions(&rev, NULL);
	setup_revisions(2, argv, &rev, NULL);
	rev.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
	run_diff_index(&rev, 1);
}

void show_changed() {
	struct rev_info rev;
	const char *argv[] = { NULL, NULL };
	init_revisions(&rev, NULL);
	setup_revisions(1, argv, &rev, NULL);
	rev.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
	run_diff_files(&rev, 0);
}

int main(int argc, char **argv) {
	printf("updated:\n");
	show_updated();
	printf("changed:\n");
	show_changed();
	return 0;
}
-- >8 --

It seems clear that there's some global magic touched by the first diff
that impacts the second. I have to give up on finding it for tonight,
but I'm hoping somebody who knows more about the code will find it
obvious (or can tell me that I'm doing something else horribly wrong in
the above, or that these functions were never intended to be called
within the same program).

-Peff
