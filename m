X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding a new file as if it had existed
Date: Wed, 13 Dec 2006 16:46:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612131611050.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7ac1e90c0612120205k38b2fc14jbfd8ea682406efb2@mail.gmail.com>
 <7vhcw1whfx.fsf@assigned-by-dhcp.cox.net> <7ac1e90c0612120332o20d6778bsa16a788fdc04a3a1@mail.gmail.com>
 <7vzm9tuft7.fsf@assigned-by-dhcp.cox.net> <457FCA8C.6000300@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 15:46:54 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Bahadir Balban <bahadir.balban@gmail.com>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <457FCA8C.6000300@op5.se>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34223>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuWJg-0001i1-NG for gcvg-git@gmane.org; Wed, 13 Dec
 2006 16:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964999AbWLMPqg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 10:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWLMPqg
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 10:46:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:35125 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S964999AbWLMPqf
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 10:46:35 -0500
Received: (qmail invoked by alias); 13 Dec 2006 15:46:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp010) with SMTP; 13 Dec 2006 16:46:33 +0100
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Andreas Ericsson wrote:

> Junio C Hamano wrote:
> > "Bahadir Balban" <bahadir.balban@gmail.com> writes:
> > 
> > There is one thing we could further optimize, though.
> > 
> > Switching branches with 100k blobs in a commit even when there
> > are a handful paths different between the branches would still
> > need to populate the index by reading two trees and collapsing
> > them into a single stage.  In theory, we should be able to do a
> > lot better if two-tree case of read-tree took advanrage of
> > cache-tree information.  If ce_match_stat() says Ok for all
> > paths in a subdirectory and the cached tree object name for that
> > subdirectory in the index match what we are reading from the new
> > tree, we should be able to skip reading that subdirectory (and
> > its subdirectories) from the new tree object at all.
> > 
> > Anybody interested to give it a try?
> > 
> 
> I'm not vell-versed enough in git internals to have my hopes high of 
> making something useful of it, but if you give me a pointer of where to 
> start I'd be happy to try, and perhaps learn something in the process.

Okay, I'll have a stab at explaining it.

For huge working directories, you usually have a huge number of trees. The 
idea of cache_tree is to remember not only the stat information of the 
blobs in the index, but to cache the hashes of the trees also (until they 
are invalidated, e.g. by an update-index). This avoids recalculation of 
the hashes when committing.

This cache is accessible by the global variable active_cache_tree. It is 
best accessed by the function cache_tree_find(), which you call like that:

	struct cache_tree *ct = cache_tree_find(active_cache_tree, path);

where the variable "path" may contain slashes. The SHA1 of the 
corresponding tree is in ct->sha1, and you can check if the hash is still 
valid by asking

	if (cache_tree_fully_valid(ct))
		/* still valid */

AFAIU Junio would like to take the shortcut of doing nothing at all when 
(twoway) reading a tree whose hash is identical to the hash stored in the 
corresponding cache_tree _and_ when the cache is still fully valid.

Ciao,
Dscho
