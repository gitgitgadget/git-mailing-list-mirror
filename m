X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: "R. Steve McKown" <rsmckown@yahoo.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 9 Dec 2006 14:34:14 -0700
Message-ID: <200612091434.15001.rsmckown@yahoo.com>
References: <20061130170625.GH18810@admingilde.org> <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com> <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 21:35:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on server.titaniummirror.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33837>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt9rG-0005Lo-Cc for gcvg-git@gmane.org; Sat, 09 Dec
 2006 22:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757265AbWLIVfn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 16:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757289AbWLIVfn
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 16:35:43 -0500
Received: from titaniummirror.com ([71.39.22.123]:37717 "EHLO
 server.titaniummirror.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1757265AbWLIVfm (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 16:35:42 -0500
Received: from steve.titaniummirror.com (steve.titaniummirror.com
 [172.16.0.129]) by server.titaniummirror.com (8.12.9-20030917/8.12.9) with
 ESMTP id kB9LxpF2029284 (version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128
 verify=NO); Sat, 9 Dec 2006 14:59:51 -0700
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Saturday 02 December 2006 12:41 pm, Linus Torvalds wrote:
> In other words, I _suspect_ that that is really what module users are all
> about. They want the ability to specify an arbitrary collection of these
> atomic snapshots (for releases etc), and just want a way to copy and move
> those things around, and are less interested in making everything else
> very seamless (because most people are happy to do the actual
> _development_ entirely within the submodules, so the "development" part
> is actually not that important for the supermodule, the supermodule is
> mostly for aggregation and snapshots, and tying different versions of
> different submodules together).
>
> So that's where I come from. And maybe I'm totally wrong. I'd like to hear
> what people who actually _use_ submodules think.

Here's some thoughts on subprojects from my company's perspective.  I 
apologize for the long message.

Abstract: We use submodules heavily in CVS and SVN.  I like what I've read 
from Linus about the "thin veneer" approach of integrating subprojects.  It 
seems conceptually to provide the support we desire.  For us, it's important 
that the mandated linkage between a master project and a subproject is 
minimal to maximize our flexibility in building our processes.


We develop and maintain a lot of embedded applications.  Both for higher level 
systems (ex: 32MB RAM/32MB storage) running the Linux kernel and a customized 
set of libs/app support code and more deeply embedded environments (ex: 8KB 
of RAM and 32KB of storage).  Even though these two cases are very different 
in many repects, the version management issues are the same.

- We (mostly) track everything needed to build historical versions of code 
with 100% fidelity.  This includes all of the tools used to compile, build, 
test, deploy, debug, etc. the actual build results themselves.  I initially 
looked at Vesta several years ago.  I love their conceptual approach to this 
problem (integrated build system that caches mid-level build results within 
the repository itself), but it's too unwieldy, very hard to set up (lots of 
up-front effort), and lacks many useful features.

- Most of our "applications" are a relatively small amount of app-specific 
code with references to several/many shared modules.  Shared modules can 
contain support tools, like build/test/debug/deploy support for a given 
embedded platform, in-house developed shared app code, or shared code 
developed by third parties.

- We use CVS to manage our larger system development projects.  The repo is 
about 2GB and has several dozen application-code submodules.  We use the 
"third party sources" approach to tracking submodules as outlined in Ch.13 of 
the CVS manual.  Additionally, we manage our "buildox" (similar to buildroot 
in concept) in another CVS repo.  All prior interesting versions of the 
buildroot can be built from source (toolchains, everything), if necessary.  
Applications contain metadata (a file...) in the repo so the app-level build 
system can ensure it is being ran under the correct version of buildbox; 
clunky but serviceable.  CVS is a nightmare because of its poor 
branch/tagging facilities, and many of the things we *ought* to be doing with 
revision control we don't because of the complexity.

- We use SVN to manage our deeply embedded system projects.  The repo is about 
250MB in size.  Applications use the svn:externals property to reference 
needed modules.  We aren't using a buildbox in this environment yet (bad!).  
SVN's simple branching and svn:externals are a giant leap forward in 
comparison to CVS's capabilities.


Below are some common use case scenarios that are to varying degrees unweildy 
in CVS and/or SVN.  Many of these involving non-trivial branching and merging 
operations are nearly impractical in CVS, and the lack of merge tracking (to 
support repeated safe merging from one branch to another) makes some of these 
a bit tricky in SVN too.  Of course neither repo supports 
disconnected/distributed operation, which would make a number of activities 
that much simpler as well.

- Round trip module management.  A specific app requires a change to a shared 
module, so it makes a local branch to develop the change.  The "diff" is 
presented to the maintainer (who may be inhouse).  The next interesting 
maintainer version of the module gets imported into our repo (if in house, 
it's already there), where the app can reference it.  This merge process may 
leave changes not yet implemented (or never to be implemented) by the module 
maintainer in the local branch used by the apps.  Other apps are unaffected, 
as they are linking to a prior version in the local branch.

- Pragmatic development.  It's typical that in developing an application, a 
developer will need to simultaneously make changes to one or more submodules.  
If more than trivial, he/she should branch the submodules and continually 
tracking the HEAD of those branches in the relevant app.  This is so complex 
and fraught with problems in CVS that it doesn't get done, and developers 
house too much change over time in their working directories.  With SVN and 
svn:externals, the process is workable.  It is nice that an svn:external can 
point to (the HEAD of) a branch when making changes.

- An application implements a new feature internally (say support for a new 
digital chipset in the embedded world) which later needs to be "promoted" to 
a subproject for use by others.  Pretty easy in SVN.  A challenge in CVS; 
it's really not possible to "convert" app code into a "third party source" 
and retain an historical link.

- Updating build tools.  In concept no different than updating a shared code 
module.  In practice, due to the buildbox strategy, it's a bit convoluted.  I 
don't expect this to get much smoother.  Getting Vesta-like features, where 
integrated build suport can cache lower-level build results in a version-safe 
manner (like the binary code built when the cross toolchain was built) would 
be killer, but that's surely OT for the submodules discussion.

Thanks,
