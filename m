X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Light-weight checkouts via ".gitlink"
Date: Fri, 8 Dec 2006 23:54:34 +0100
Message-ID: <200612082354.34488.Josef.Weidendorfer@gmx.de>
References: <200612082252.31245.Josef.Weidendorfer@gmx.de> <elco6p$uku$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 22:54:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <elco6p$uku$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33763>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsocA-0001mA-JF for gcvg-git@gmane.org; Fri, 08 Dec
 2006 23:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947468AbWLHWyn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 17:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947469AbWLHWyn
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 17:54:43 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:35937 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1947468AbWLHWyl (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 17:54:41 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 03E31282A; Fri,  8
 Dec 2006 23:54:38 +0100 (MET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Friday 08 December 2006 23:18, Jakub Narebski wrote:
> A few (very few) comments:
> 
> Josef Weidendorfer wrote:
> 
> > This can be implemented by enhancing git to ignore any subdirectory which
> > has a file .gitlink in it.
> 
> If I remember correctly, while git ignores .git, it does not ignore
> by default (i.e. without entry in either GIT_DIR/info/excludes, or
> .gitignore) the directory which has .git directory in it.

I know. But this is essential. We _have_ to ignore all the files and
subdirectories in the directory which contains the .gitlink file,
as these files/subdirectories belong to the submodule.

There is no other way. You could try to use a special name for the
whole directory with the light-weight checkout, e.g. ".checkout".

But then, this is useless for submodules, as for submodules, we want to
be able to specify the root directory name of the submodule, as that
is the name which will end up in the tree object of the supermodule.

> And that should not change for .gitlink. You can always add
> .gitignore file with * .* patterns in it (ignore all).

That is not possible:
.gitignore file has its own meaning inside of the light-weight
checkout aka submodule, as this directory is the root directory of
a git checkout.

AFAIK, Martin's submodule support does it the same, only for directories
with .git, as he stores the GITDIR directly in the submodule
checkout.


> > * Gitdir = "<Path to base git repository>"
> [...]
> > * Name: <explicit name for this checkout>
> 
> Why use once "key = value", once "key: value" form? Better to stick
> with one. I Would prefer "key = value" one.

Sorry. Typo ;-)


> GIT_DIR = path to base git repository
> it is equivalent to setting the following:
> 
> GIT_INDEX_FILE = path to index file
> GIT_OBJECT_DIRECTORY = path to object directory
> GIT_HEAD_FILE = path to HEAD file
> GIT_REFS_DIRECTORY = path to refs directory

AFAIK the latter two do not exist yet, or do they?

I would also be fine with .gitlink looking like some shell script,
defining these variables. However, we need the smart directory
lookup.
And IMHO the keys can be case insensitive as in .git/config.

I am not sure we want to allow the freedom of being able to put any of
GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY, GIT_HEAD_FILE, GIT_REFS_DIRECTORY
in the .gitlink file.

It is enough if GITDIR and NAME is given. With GITDIR_REAL after the
smart lookup, e.g. GIT_INDEX_FILE would default to $GITDIR_REAL/external/$NAME
and so on.

However, for submodules we really _want_ to have fully independent GITDIRs
for each submodule somewhere, and we would have to warn:

 # Warning: if you change one GIT_INDEX, ... in this file, you
 # will screw up the possibility to clone from the GITDIR directory


> NAME = name
> should match "name subdirectory" entry in modules file in superproject.

Yes.
This would be in my next proposal about how to build the submodule support
on light-checkouts ;-)

 
> Perhaps instead of adding arbitrary number of .. in front of relative
> path, we better use some magic, like ... for finding somewhere up?

I thought about it. But why whould you need it?
If the value of GITDIR in .gitlink begins with "/", it is an absolute path.
If not, I think you always want the smart lookup the go upwards, i.e.
looking for

  ../<relpath>.git
  ../../<relpath>.git
  ../../../<relpath>.git

So there is no need to add "..." in front of the relative path.
Or do you see a usecase for
 rel/path/start/.../rel/path/end

Ah, yes, I see. Perhaps this makes sense with absolute paths:

	/home/user/repos/.../linux

Josef
