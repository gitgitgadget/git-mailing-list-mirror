From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
 submodules
Date: Sun, 18 Jan 2009 19:33:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>  <1232275999-14852-2-git-send-email-hjemli@gmail.com>  <1232275999-14852-3-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de>
 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 19:34:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOcTu-0005Eu-Hj
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 19:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934270AbZARSdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 13:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934208AbZARSdT
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 13:33:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:45466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934207AbZARSdS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 13:33:18 -0500
Received: (qmail invoked by alias); 18 Jan 2009 18:33:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 18 Jan 2009 19:33:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+A6ywRUV6A80G0Q0ZNh/zH5DZcxRiUlXan6BDFbb
	mI+GvLtwxXsn38
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106256>

Hi,

On Sun, 18 Jan 2009, Lars Hjemli wrote:

> On Sun, Jan 18, 2009 at 16:48, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Sun, 18 Jan 2009, Lars Hjemli wrote:
> >
> >> +                  struct tree **subtree)
> >> +{
> >> +     unsigned char sha1[20];
> >> +     int linked_odb = 0;
> >> +     struct commit *commit;
> >> +     void *buffer;
> >> +     enum object_type type;
> >> +     unsigned long size;
> >> +
> >> +     hashcpy(sha1, commit_sha1);
> >> +     if (!add_gitlink_odb(path)) {
> >> +             linked_odb = 1;
> >> +             if (resolve_gitlink_ref(path, "HEAD", sha1))
> >> +                     die("Unable to lookup HEAD in %s", path);
> >> +     }
> >
> > Why would you want to continue if add_gitlink_odb() did not find a checked
> > out submodule?
> >
> > Seems you want to fall back to look in the superproject's object database.
> > But I think that is wrong, as I have a superproject with many platform
> > dependent submodules, only one of which is checked out, and for
> > convenience, the submodules all live in the superproject's repository.
> 
> Actually, I want this to work for bare repositories by specifying the
> submodule odbs in the alternates file. So if the current submodule odb
> wasn't found my plan was to check if the commit object was accessible
> anyways but don't die() if it wasn't.

Please make that an explicit option (cannot think of a good name, though), 
otherwise I will not be able to use your feature.  Making it the default 
would be inconsistent with the rest of our submodules framework.

> >> +     commit = lookup_commit(sha1);
> >> +     if (!commit)
> >> +             die("traverse_gitlink(): internal error");
> >
> > s/internal error/could not access commit '%s' of submodule '%s'",
> >                        sha1_to_hex(sha1), path);/
> 
> Ok (I belive this codepath is virtually impossible to hit, hence the
> "internal error", but I could of course be mistaken).

You make it a function that is exported to other parts of Git in cache.h.  
So you might just as well expect it to be used by other parts at some 
stage.

Ciao,
Dscho
