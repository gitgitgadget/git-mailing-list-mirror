From: Jeff King <peff@peff.net>
Subject: Re: git log --follow
Date: Wed, 3 Nov 2010 23:18:27 -0400
Message-ID: <20101104031827.GA20772@sigill.intra.peff.net>
References: <AANLkTinEEtfxu=NbaGn=A88MrU7JCFztMzB-x3--FCdB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 04:17:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDqKk-0005Cz-Ua
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 04:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab0KDDRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 23:17:46 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39298 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab0KDDRp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 23:17:45 -0400
Received: (qmail 22564 invoked by uid 111); 4 Nov 2010 03:17:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Nov 2010 03:17:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Nov 2010 23:18:27 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinEEtfxu=NbaGn=A88MrU7JCFztMzB-x3--FCdB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160688>

On Wed, Nov 03, 2010 at 08:00:23PM -0700, Scott Chacon wrote:

> Is there any way to get 'git log --follow' to respect the -M[num]
> option?  If I want to lower the boundary for rename detection when
> printing file history, is there any way to do that?  It doesn't seem
> to work if I just list them both.

No. But this patch would do it.

diff --git a/tree-diff.c b/tree-diff.c
index 12c9a88..378f049 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -351,6 +351,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->paths[0];
 	diff_opts.break_opt = opt->break_opt;
+	diff_opts.rename_score = opt->rename_score;
 	paths[0] = NULL;
 	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)

You can see the difference with:

  $ git log --oneline --follow --name-status \
    Documentation/technical/api-string-list.txt
  1d2f80f string_list: Fix argument order for string_list_append
  M       Documentation/technical/api-string-list.txt
  e242148 string-list: add unsorted_string_list_lookup()
  M       Documentation/technical/api-string-list.txt
  0dda1d1 Fix two leftovers from path_list->string_list
  M       Documentation/technical/api-string-list.txt
  c455c87 Rename path_list to string_list
  A       Documentation/technical/api-string-list.txt

  $ git log -M40 --oneline --follow --name-status \
    Documentation/technical/api-string-list.txt
  1d2f80f string_list: Fix argument order for string_list_append
  M       Documentation/technical/api-string-list.txt
  e242148 string-list: add unsorted_string_list_lookup()
  M       Documentation/technical/api-string-list.txt
  0dda1d1 Fix two leftovers from path_list->string_list
  M       Documentation/technical/api-string-list.txt
  c455c87 Rename path_list to string_list
  R047    Documentation/technical/api-path-list.txt
  Documentation/technical/api-string-list.txt
  328a475 path-list documentation: document all functions and data structures
  M       Documentation/technical/api-path-list.txt
  530e741 Start preparing the API documents.
  A       Documentation/technical/api-path-list.txt

I think it's probably something we should be doing (as you can see, we
already copy the break_opt).

-Peff
