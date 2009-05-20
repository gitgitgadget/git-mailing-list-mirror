From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix for a merge where a branch has an F->D transition
Date: Wed, 20 May 2009 12:34:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905201228040.16461@intel-tinevez-2-302>
References: <81b0412b0905110242u3624f0eeyc0dc9b2b987bfa2b@mail.gmail.com> <20090511192536.GA1485@blimp.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 12:35:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6j8Z-0006HX-55
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 12:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbZETKez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 06:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbZETKey
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 06:34:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:41519 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751113AbZETKex (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 06:34:53 -0400
Received: (qmail invoked by alias); 20 May 2009 10:34:54 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 20 May 2009 12:34:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MxfxQhY3MbSdhZlAUyG3SiJm3ugVytqR7adkW2g
	KZ1ZFAeN1CI1mI
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090511192536.GA1485@blimp.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119598>

Hi,

On Mon, 11 May 2009, Alex Riesen wrote:

> Some path names which transitioned from file to a directory were not
> updated in the final part of the merge (loop around unmerged entries in
> merge_trees), because the branch in process_renames which filtered out
> updates for the files with the same content ("merged same as existing")
> has left the rename entry in processed state. In this case, the
> processing cannot be finished at the process_renames phase (because
> the old file still blocks creation of directory where new files should
> appear), and must be postponed until the update_entry phase.

I know that as a German, I am supposed to like long sentences and crowded 
paragraphs.  Maybe I am not that German after all.

> Frankly, I'm not really sure. The solution came largely ... empirical 
> way. IOW, I tried more or less random things which looked like they 
> should fix the problem.

This does not give me the cozy feeling I need to review a patch.  After 
all, I do not want to do all the work that should be done by the patch 
author, but I just want to put in my knowledge to verify that the patch 
is correct.

But as you asked me explicitely...

> diff --git a/merge-recursive.c b/merge-recursive.c
> index a3721ef..3c5420b 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -980,14 +980,15 @@ static int process_renames(struct merge_options *o,
>  
>  				if (mfi.clean &&
>  				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
> -				    mfi.mode == ren1->pair->two->mode)
> +				    mfi.mode == ren1->pair->two->mode) {
>  					/*
>  					 * This messaged is part of
>  					 * t6022 test. If you change
>  					 * it update the test too.
>  					 */
>  					output(o, 3, "Skipped %s (merged same as existing)", ren1_dst);
> -				else {
> +					ren1->dst_entry->processed = 0;
> +				} else {

So basically, you say that a dst_entry has not been processed, when it 
_has_ been?  That cannot be correct...

Ciao,
Dscho
