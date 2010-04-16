From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Make rev_compare_tree less confusing.
Date: Fri, 16 Apr 2010 11:31:06 +0200
Message-ID: <201004161131.06880.trast@student.ethz.ch>
References: <1271321171-12176-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 11:31:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2htU-0007RQ-S4
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 11:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427Ab0DPJbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 05:31:18 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:21750 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847Ab0DPJbR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 05:31:17 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Apr
 2010 11:31:15 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Apr
 2010 11:31:07 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <1271321171-12176-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145060>

Bo Yang wrote:
> -	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "",
> -			   &revs->pruning) < 0)
> -		return REV_TREE_DIFFERENT;
> +	diff_tree_sha1(t1->object.sha1, t2->object.sha1, "", &revs->pruning);

Ack on the patch contents (though we could also make the function
'void' to reduce further confusion), but I'd word the commit message
differently:

> Make rev_compare_tree less confusing.
> 
> diff_tree_sha1 always return 0, so comparing the return value
> of it make no sense. Just delete the comparison to make code
> reader clear.

Something like

  rev_compare_tree: do not check return value of diff_tree_sha1

  diff_tree_sha1() unconditionally inherits its return value from
  diff_tree(), which always returns 0.  Hence, pretending that its
  return value carries any information about the tree difference is
  extremely misleading.

  The point of the call is in the side effects on revs->pruning, so
  simply drop the dead 'return'.

Interestingly enough, this call survived with slight changes here and
there from all the way back in cf48454 (Teach git-rev-list to follow
just a specified set of files, 2005-10-20), where it was added in
rev-list.c.  Even back then diff_tree() would always return 0.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
