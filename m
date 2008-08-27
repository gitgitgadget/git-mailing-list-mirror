From: Johan Herland <johan@herland.net>
Subject: Relative submodule URLs vs. clone URL DWIMming
Date: Wed, 27 Aug 2008 14:00:54 +0200
Message-ID: <200808271400.54302.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 14:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYJj2-0006yb-2l
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 14:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbYH0MBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 08:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754601AbYH0MBE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 08:01:04 -0400
Received: from sam.opera.com ([213.236.208.81]:33344 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459AbYH0MBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 08:01:03 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m7RC0s32014145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 27 Aug 2008 12:01:00 GMT
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93886>

Hi,

I'm observing a couple of bugs/issues when using relative submodule 
URLs:

Say, I have a repo "foo" with a couple of submodules "bar", "baz", and 
the following .gitmodules:

	[submodule "bar"]
	    path = bar
	    url = ./bar
	[submodule "baz"]
	    path = baz
	    url = ./baz

Now, what I want to do is to clone this repo and initialize the 
submodules using the following commands:

	git clone <URL> <DIR>
	cd <DIR>
	git submodule update --init

I will demonstrate that whether or not the "git submodule update --init" 
succeeds depends on the value of <URL>:


Scenarios:

#1: <URL> is a non-bare local repo: "/home/user/foo"

builtin-clone.c:get_repo_path() will DWIM this to "/home/user/foo/.git", 
and store this as the origin URL. Relative submodule URLs will be 
resolved against this, and end up looking 
like "/home/user/foo/.git/bar".

Result: FAIL


#2: <URL> is a non-bare remote repo: "file:///home/user/foo"

(For the purposes of this discussion, a file:// URL is equivalent to a 
real remote URL) builtin-clone.c:get_repo_path() fails to DWIM it, and 
we fall back to using it verbatim as the origin URL. Relative submodule 
URLs will be resolved against this, and end up 
like "file:///home/user/foo/bar".

Result: Success


Note: When using bare repos below, I assume that the repos are laid out 
in the following manner:

	/home/user/foo.git
	/home/user/foo.git/bar.git
	/home/user/foo.git/baz.git


#3: <URL> is a bare local repo (indirectly): "/home/user/foo"

builtin-clone.c:get_repo_path() will DWIM it to "/home/user/foo.git", 
and store this as the origin URL. Relative submodule URLs will be 
resolved against this, and end up looking 
like "/home/user/foo.git/bar", which will work (because the same 
DWIMming is applied when cloning submodules).

Result: Success


#4: <URL> is a bare local repo (directly): "/home/user/foo.git"

This ends up looking exactly like scenario #3.

Result: Success


#5: <URL> is a bare remote repo (indirectly): "file:///home/user/foo"

As in scenario #2, builtin-clone.c:get_repo_path() fails to DWIM it, and 
the origin URL ends up as a verbatim copy, but the initial clone still 
works because of similar DWIMing at the remote/transport level. 
Relative submodule URLs will be resolved against the origin URL, 
however, and end up looking like "file:///home/user/foo/bar", which 
will not work, since - on the submodule clone - remote/transport level 
will only try to DWIM the last path component 
(i.e. "file:///home/user/foo/bar.git", and 
not "file:///home/user/foo.git/bar.git").

Result: FAIL


#6: <URL> is a bare remote repo (directly): "file:///home/user/foo.git"

The initial clone goes off without a hitch, and the submodule URLs end 
up looking like "file:///home/user/foo.git/bar", which is subsequently 
DWIMmed "correctly" to "file:///home/user/foo.git/bar".

Result: Success


I'd like to fix this, but I'm not sure whether the fix belongs in 
builtin-clone.c (i.e. making sure the origin URL is always "correct" 
wrt. resolving relative submodule URLs), or in git-submodule.sh (i.e. 
adding smarts when resolving relative submodule URLs against the 
super-repo's origin URL).


...Johan
