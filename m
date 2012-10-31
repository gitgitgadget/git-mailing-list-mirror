From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 17:57:48 -0700
Message-ID: <20121031005748.GW15167@elie.Belkin>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
 <20121030185914.GI15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 01:58:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTMdD-0006jW-5q
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 01:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053Ab2JaA5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 20:57:54 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50475 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab2JaA5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 20:57:53 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so562035pad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 17:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q7rUGoAeWPR6jkUmRyEHNJyNq68rLKvBG8vdoKduJas=;
        b=PiktM1wYM5z/LMgrgRc2nGlurCv07ForiwiqLHoNxdiZs2w0lU9uCp2zXRYTD7qiTC
         fOhkQ5odAkRs7L7EH+/ba2CutygVliIrg+ZElb59IMHHI0RwngrhQ7VYJNIexVRPFWXG
         TcFILhH9l42WK+pVUxu/maQ5LFZqwKCxgBmN4cjGTbLFhFbNdYfgX9hJ08l84W/iOEtb
         Mz7KklH6xUGPi2JQ1/2tIAZMC0aNXt7/iwFoWXRxEdKVHSbKszrxBnSMeneMiiLzAxok
         +EBpb3XOjRpbnWjqk6WEfn0MY1/jQo8NQuDUA0+adf7liVw45Wj1/fU4oGbg4mKR8UEF
         /ZPA==
Received: by 10.68.217.104 with SMTP id ox8mr107177865pbc.35.1351645073325;
        Tue, 30 Oct 2012 17:57:53 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id o11sm1353434pby.8.2012.10.30.17.57.51
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 17:57:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121030185914.GI15167@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208774>

Hi again,

Felipe Contreras wrote:

> They have been marked as UNINTERESTING for a reason, lets respect that.

So, the above description conveyed zero information, as you mentioned.

A clearer explanation would be the following:

	fast-export: don't emit "reset" command for negative refs

	When "git fast-export" encounters two refs on the commandline
	referring to the same commit, it exports the first during the usual
	commit walk and the second using a "reset" command in a final pass
	over extra_refs:

		$ git fast-export master next
		reset refs/heads/master
		commit refs/heads/master
		mark :1
		author Jonathan Nieder <jrnieder@gmail.com> 1351644412 -0700
		committer Jonathan Nieder <jrnieder@gmail.com> 1351644412 -0700
		data 17
		My first commit!

		reset refs/heads/next
		from :1

	Unfortunately the code to do this doesn't distinguish between positive
	and negative refs, producing confusing results:

		$ git fast-export ^master next
		reset refs/heads/next
		from :0

		$ git fast-export master ^next
		reset refs/heads/next
		from :0

	Use revs->cmdline instead of revs->pending to iterate over the rev-list
	arguments, checking the UNINTERESTING flag bit to distinguish between
	positive (master, --all, etc) and negative (next.., --not --all, etc)
	revs and avoid enqueueing negative revs in extra_revs.

	This does not affect revs that were excluded from the revision walk
	because pointed to by a mark, since those use the SHOWN bit on the
	commit object itself and not UNINTERESTING on the rev_cmdline_entry.

A patch meeting the above description would make perfect sense to me.
Except for the somewhat strange testcase, the patch I am replying to
would also be fine in the short term, as long as it had an analagous
description (i.e., with an appropriate replacement for the
second-to-last paragraph).

Thanks for your patience, and hoping that helps,
Jonathan
