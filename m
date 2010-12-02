From: Adam Kellas <Adam.Kellas@gmail.com>
Subject: using git as a distributed content management tool
Date: Wed, 01 Dec 2010 20:47:34 -0500
Message-ID: <id6tpm$sb4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 04:20:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNzia-0003WT-I7
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 04:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792Ab0LBDUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 22:20:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:33903 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756546Ab0LBDUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 22:20:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PNziG-0003Jv-8s
	for git@vger.kernel.org; Thu, 02 Dec 2010 04:20:04 +0100
Received: from 198-135-0-233.cisco.com ([198.135.0.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 04:20:04 +0100
Received: from Adam.Kellas by 198-135-0-233.cisco.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 04:20:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 198-135-0-233.cisco.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162665>

I'm thinking of using git in a slightly unusual way and am looking for 
advice or pointers. I'm developing a (GPL) tool which can be thought of 
as a generic content management system. The only thing that matters here 
is that it generates a related set of potentially binary files. My 
current "persistence solution" is a typical Java server backed by a 
relational database but while reading about git in another context, and 
in particular about how it's really a general content-addressable 
filesystem which just happens to be tuned for SCM, I started thinking 
replacing that back end with something based on git. Essentially this is 
the same old DVCS-vs-centralized question except the tool is not exactly 
a VCS. The results would be shared via the usual push/pull git semantics.

 From what I see of git plumbing this looks eminently doable, and I 
think it will almost certainly work if each user is given their own repo 
as in normal git usage. What I'm trying to figure out is whether an 
optimization is possible: I'd like to support a model where a repo is 
shared between a number of instances of my tool running on the same 
machine or even on the same network as long as the repo is available via 
NFS, which raises issues like race conditions and locking that don't 
come up for a developer using his/her own repo.

Specifically here's what I'm thinking: each instance would set GIT_DIR 
to point to the common repo, and GIT_INDEX_FILE to a per-instance temp 
file. Then, as artifacts are generated they can be stored as blobs using 
hash-object and entered into a tree using create-tree. Note here that 
blobs would go directly into the shared repo while trees would be in the 
private index file. Then at the approriate time the tree can be 
"published" via commit-tree. It would be available immediately to other 
users of the shared repo and could be pushed or pulled asynchronously 
from there.

So, assuming permissions are set to allow it, is there a problem with 
this? I see a possible race in creating blobs iff they happen to be 
identical and another at commit-tree time. Does git do any locking of 
its own or would I have to implement my own around these?

Thanks,
AK
