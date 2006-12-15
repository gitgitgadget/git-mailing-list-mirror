X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 16 Dec 2006 00:43:56 +0100
Message-ID: <e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <200612150007.44331.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com>
	 <200612152242.50472.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 23:44:09 +0000 (UTC)
Cc: "R. Steve McKown" <rsmckown@yahoo.com>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sut2J+U7cPg/muTeI3gbDBuJWXoDI76tVto9c8WMaLJ+tr6b1I5YGDV5kdvhP3ulaxuxO2BNBtDZT6YDhbE/xStNDYHbqZY3G8dP6MTyNNIDjg8FpiwC1loQSnt1xUtwQzsB7wYixHqGQhFm8pDta0oyxpbBIWXOKLR1zeplOKg=
In-Reply-To: <200612152242.50472.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34576>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvMig-00036N-5S for gcvg-git@gmane.org; Sat, 16 Dec
 2006 00:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965290AbWLOXn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 18:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbWLOXn7
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 18:43:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:55944 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S965290AbWLOXn6 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 18:43:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1264190nfa for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 15:43:57 -0800 (PST)
Received: by 10.48.162.15 with SMTP id k15mr611030nfe.1166226237126; Fri, 15
 Dec 2006 15:43:57 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Fri, 15 Dec 2006 15:43:56 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/15/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> That all sounds fine, but how do you create such symlinks in practice?

I'm very open to suggestions here, but the concept growing in my head
is based around Linus 'module'-file and keep things simple. A git
configuration file that specifies:
* link name for reference
* local path to link
* submodule source
* submodule path to tree/blob
* submodule commit / HEAD / branch
* options (depth-limit , ...)

I'm reconsidering having the path-name in the link, it should be
sufficient to have two SHA1's, one for the commit and one for the
tree/blob. Super-module should have the tree/blob in it's database so
that the link part only is there for version information and reference
(checking dirty state or history on the submodule). This way it easy
to clone the super-project and use it without having to map up all
sub-project sources. Sub-project sources is not important for version
information and could always be specified in the project in a
README-type of file.


> Especially, what is the SCM user supposed to do to change the link
> target, ie. from
>  <commit>/path/to/subtree
> to
>  <commit>/path2/to2/subtree2
> ?
> Should this do a re-checkout at the other point?

That would be a change in the modules file, maybe through a command
that also fixes the link. The link will have to be updated in the
index and commited as normal.


> By linking a file from a submodule, such a link seems to force that
> this file has to be at a fixed position in the submodule. Otherwise,
> some magic has to happen when the file is moved in the submodule,
> possibly leading to a dangling link, eg. if the whole subdirectory
> specified in the link is removed.

Since we have the SHA1 (this is what we're using) and tree/blob
information in the super-modules database the change itself is not a
problem. The problem is to track renames/moves and your remove case in
the submodule. The tool that tracks the submodule should probably
warn/exit here and we would fix up the modules file manually.


> IMHO this is getting way to complex.

One of complex situation here as I see it is the ability to handle to
track/checkout only a subset (tree/blob) of the submodule. This is
also quite an important feature - in my example it means the
difference of tracking one header file versus the whole source.


> If you only want to check out part of a submodule, this should be
> done with path-limiting checkouts, which should be a feature totally
> independent from submodules.

If we can do path-limiting checkouts on a repo (module) we also can do
it on a sub-module since they are exactly the same. This is a very
powerful feature and it'd be a huge waste if it wasn't allowed for a
super-module to do on submodules.


> And if you want to limit the number of objects transferred in cloning
> of a subproject, it is better to further split this subproject into
> multiple subprojects itself.

What if we have no control of the submodule?  This can be tracked from
upstream, sourceforge, another company, etc. The submodule will often
live their own life and could be X, kernel, gcc, cairo, whatever, ...


> The problem is not the representation in the git repository, but the
> checked out module/submodule, where you need to use normal UNIX file semantics.
> To move submodules around, the user should be able to just use
> the normal UNIX "mv" commands, and git should be able to detect move
> actions after the fact.

If we disregard the commit info, the link will act exactly as a normal
tree/blob. Git can know we're moving a subproject by watching the
module file. The main problem is to keep modules file up-to-date with
reality. We could enforce module file validity by disallowing such
operations and let the user do a "force" operation which also alters
the modules file.


> This now becomes a problem if you use symlinks to "unify" multiple checkouts
> of the same submodule at multiple places in the supermodule, and move
> the symlink around, as it easily can get dangling this way. Thus, you would
> not have a way to see what submodule this link was talking about.

The symlink only exists in the modules file. We only have the SHA1's
at the tree-level and there we have everything underneath the
tree/blob SHA1 in our database. We will only know if the modules
symlink file is dangling next time we fetch from the submodule - here
we would notify the user but our database is still consistent.


> If you have a source commit chain A => B => C => D, you want
> to make any build commits totally independent: you first only
> are interested in a build commit for source versions A and D,
> and later find out that a build commit for B and C would be nice,
> too. If you force build commits into some history order, this
> order now would be A => D => B => C, which makes no sense.

It makes no sense because the user seem to have act irrationally. The
commit-chain is completely valid as it has tracked the correct history
of the builds. I can't see any problems here, the build-project is
independent of the source-project with it's own history. We can hope
the user has given good explanations for his/her actions in the commit
messages though.


