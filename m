From: Michael Lai <myllai@gmail.com>
Subject: git-svn does not support intermediate directories?
Date: Tue, 3 Mar 2009 17:43:47 -0800
Message-ID: <21fc26450903031743x4beda8a3i835ecbd428817070@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 02:45:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LegAh-0002hF-69
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 02:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbZCDBnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 20:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbZCDBnu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 20:43:50 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:42101 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbZCDBnt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 20:43:49 -0500
Received: by rv-out-0506.google.com with SMTP id g37so3053674rvb.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 17:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=RLs3fw5gJhwjAsGAo4dwL38mC7aT5s7liv2SuenjwcQ=;
        b=YHOzGaW1wLe2hmUvpaJL4QgU+vt+fMZq5kesL9L7bEjoAL5hnIxX91qs6qyFw/RXTH
         kxP1afp+/ifKJylgOUnAXRZHaUMzT0fUmX6qSh/uJSmudKaqeX22ZinB1YL6OYezlfAr
         6m3NDJ3Ud8q5Yv5235M12D6yUe8Uue/28T9Ek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=QmWteP0gChs6iKyplxGxEEjTy9xVeas0NXdF6T3b5GJPnvWOv2VjRdDo0tnSjT6B9S
         AleaY1kZwEIOCBvM/Tccbi7of8Cbvc2Oa2IHX+TpRODdVc1uKgH4gWCBYAEgkHU5/Hau
         OtvkizxH6dKCoB0LJPhN29fvbnhl+teNNtOJM=
Received: by 10.141.96.19 with SMTP id y19mr3861770rvl.116.1236131027881; Tue, 
	03 Mar 2009 17:43:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112177>

Hey all,

  After spending some hours struggling with git svn, it would appear
that it does not support svn projects stored in paths similar to
"http://foo.com/svn/repos/bar/myproject", where "myproject" uses the
standard SVN tags/trunk/branches layout.  I'm currently using git
1.6.1, though I tried this with 1.6.2-rc2 as well.  The resulting
.git/config looks something like this:

[svn-remote "svn"]
	url = http://foo.com/svn/repos/bar
	fetch = myproject/trunk:refs/remotes/trunk
	branches = bar/myproject/branches/*:refs/remotes/*
	tags = bar/myproject/tags/*:refs/remotes/tags/*

Yes, that's a redundant "bar" directory under "branches =" and "tags
=".  The issue seems to lie in git-svn doing something intelligent to
extract the appropriate trunk directory.  For the branches and tags,
however, it just takes the full URL and removes the repository root
(http://foo.com/svn/repos/bar) to produce "bar/myproject/{branches,
tags}/*".  The second effect is that "git svn fetch" will run but exit
quietly without actually pulling anything from the repository.  I
tracked down an existing thread on the mailing list from a while ago
(Feb 4th, title of "git-svn doesn't fetch anything"), but there was no
resolution.

There is a quick workaround, which was to make this change to match_paths:
< 	$self->{path_regex} ||= qr/^\/\Q$self->{path}\E\//;
---
> 	$self->{path_regex} ||= qr/\/\Q$self->{path}\E\//;

The additional "bar" directory gets pulled in when git-svn tries to
determine what paths to pull down, and tries to match
"/myproject/trunk" to "/bar/myproject/trunk".  I've merely put a
band-aid on the situation.  My perl is rudimentary at best, or I'd
have spent additional time to try to put in a "proper" patch, but was
wondering if anyone else had run into this problem and would be
willing to put in a fix (or point me in the right direction, that
works too).

Thanks,
Mike
