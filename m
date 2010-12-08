From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP/RFH] format-patch: Allow diffs for first-parent history
Date: Wed, 8 Dec 2010 04:52:09 -0600
Message-ID: <20101208105209.GA4947@burratino>
References: <f60b93ae61c0e3088112cd6e1185d9c66f623813.1291803440.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 08 11:52:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQHdP-0008Pw-0R
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 11:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580Ab0LHKwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 05:52:25 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55949 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab0LHKwY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 05:52:24 -0500
Received: by gyb11 with SMTP id 11so563215gyb.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZeyDkyVjjKoW3bXFMmrLByg96mDyTZQxh9kQRzrzga8=;
        b=oq2mOpa+yLC4Ag0BlcyKvYiMtM/xMUek6tDLBNMp4ulJVDnE2kRY6NHGq2WNZNQJTn
         3RCRqU6MingTx7/Jf7LRTheZuF85Q1QdQhRRDsmBZ6RwTuq4xV0g9/NVwHNzP/BVNjXd
         t4KJOXwmqjGZ9dfxVCUCWxlIMSxNuk6W+YOLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=is4wYOAoUA7wgksB//wPPk43a0aaZWGyOnvES+sXqSLqWOmavIR75JG5iwkGrWOL4b
         2H+DkUR8JbRSskwSCrm/ZXls2Iu2q7o8nh9Z4Y3AP0k2IEy2vi8oYP4LtbqAK2kYeYNC
         GX7q3jMEMsnfiPhE/C89hkEU5+/zehsxRvV34=
Received: by 10.150.138.18 with SMTP id l18mr3889038ybd.106.1291805541410;
        Wed, 08 Dec 2010 02:52:21 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id d4sm342309ybi.12.2010.12.08.02.52.19
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 02:52:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f60b93ae61c0e3088112cd6e1185d9c66f623813.1291803440.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163187>

Michael J Gruber wrote:

> The attached patch teaches format-patch not to ignore merges (on
> "--first-parent"), but I failed to track how "diff-tree" sets options
> based on "-m"

With hindsight, here's a search result:

 $ git grep -e argv -- builtin/diff-tree.c
 int cmd_diff_tree(int argc, const char **argv, const char *prefix)
         argc = setup_revisions(argc, argv, opt, &s_r_opt);
                 const char *arg = *++argv;

So it's setup_revisions, in revision.c, which clears revs->ignore_merges
when -m is detected.

Maybe it should clear revs->no_merges while at it?  I can't see any
other meaningful meaning for

	git alias.lg "log --no-merges"
	git lg -m HEAD~2..HEAD

or

	git format-patch -m --first-parent HEAD~2..HEAD

Meanwhile I would also be happy to see --first-parent imply -m, though
that might be more controversial since -p -c --first-parent and
-p --cc --first-parent are also meaningful.
