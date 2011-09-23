From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Fri, 23 Sep 2011 12:06:51 +0200
Message-ID: <4E7C5A3B.10703@alum.mit.edu>
References: <4E7A3BDE.3040301@alum.mit.edu> <7vy5xh1whq.fsf@alter.siamese.dyndns.org> <4E7AF1AE.5030005@alum.mit.edu> <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com> <20110922171340.GA2934@sigill.intra.peff.net> <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com> <20110922205856.GA8563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 23 12:07:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R72ez-0004Ka-Rz
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 12:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996Ab1IWKHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 06:07:03 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58531 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab1IWKHB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 06:07:01 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8NA6pgV025164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 23 Sep 2011 12:06:51 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <20110922205856.GA8563@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181955>

On 09/22/2011 10:58 PM, Jeff King wrote:
> However, I think this is skirting around a somewhat larger issue, which
> is that gitattributes are sometimes about "this is what the file is like
> at the current state of history", and sometimes about "this is what this
> file is like throughout history".

This is a very dangerous line of thought.  When content is read out of a
historical commit, the content must be identical to what was checked
into that commit.  For example, the EOL characters that I see in an old
file revision must not depend on my current HEAD or index.  This rule
should apply regardless of whether the content is being read to be
checked out, put into an archive, or diffed against some other revision.
 So for these purposes, I think there is no choice but to honor the
gitattributes files in the tree/index/directory from which the content
was read.

If the user really wants to say "this is what this file is like
throughout history" (thereby altering history), then this should be a
local decision that should be stored locally in $GIT_DIR/info/attributes.

There are other attributes that affect "two-argument" operations like
diff.  Here the policy has to depend on the situation.  In the case of
diff, I suggest that the relevant attributes be read from *both*
versions of the file.  If they are the same, then obviously use them.
If they differ, then fall back to a "safe" default (for example, the
diff that would be used if *no* attributes had been specified).
However, as a special case, if an attribute is specified in one version
and unspecified in another, it would *usually* be OK to use the
specified version of the attributes and that might be considered a
reasonable alternative.

By the way, it is possible that the two ends of a diff operation have
different filenames (e.g., with -M or -C).  In this case the attributes
should be looked up using the filename corresponding to the commit.

> So I think doing it "right" would be a lot more complicated than just
> reading the commits from a particular tree. I think it would mean adding
> more context to all attribute lookups, and having each caller decide how
> the results should be used.

I agree.

> So if the status quo with working trees (i.e., retroactively applying
> the current gitattributes to past commits) is good enough, perhaps the
> bare-repository solution should be modeled the same way? In other words,
> should "git log -p" in a bare repo be looking for attributes not in the
> commits being diffed, but rather in HEAD[2]?

This would be a very poor policy, modeled on a status quo that is *not*
good enough.  For example, HEAD might not even be a descendant of the
commit whose content is being interrogated; the commit might have new
files and new gitattributes that would be ignored.  I suppose your
suggestion is better than the status quo, so it would be fine as a
starting point, *provided* it is clear that people should not rely on
this behavior not being improved later.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
