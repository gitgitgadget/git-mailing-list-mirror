From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Q] merge squash unexpected conflicts
Date: Thu, 14 May 2009 14:17:35 +0200
Message-ID: <4A0C0BDF.9020803@drmicha.warpmail.net>
References: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com>	 <bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com>	 <7v4ovo1iap.fsf@alter.siamese.dyndns.org> <bb9d69200905132057u60adc2f8vb9ba9a35791f72ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Cory Sharp <cory.sharp@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 14:17:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Zsl-0003fF-U5
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 14:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbZENMRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 08:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbZENMRo
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 08:17:44 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41780 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752893AbZENMRn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 08:17:43 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id AA5A23450E0;
	Thu, 14 May 2009 08:17:44 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 14 May 2009 08:17:44 -0400
X-Sasl-enc: GRO+f7sshmmqvhZ+0eJFHgFVH93nSN39siBVWRCpsVJv 1242303464
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1D32813F07;
	Thu, 14 May 2009 08:17:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <bb9d69200905132057u60adc2f8vb9ba9a35791f72ac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119185>

Cory Sharp venit, vidit, dixit 14.05.2009 05:57:
> On Wed, May 13, 2009 at 8:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Cory Sharp <cory.sharp@gmail.com> writes:
>>
>>> Am I doing something a little wrong or unexpected?  Is there a way
>>> around this squash conflict behavior?  This doesn't seem to happen
>>> with plain merge without squash.
>>
>> Of course.  That's the whole point of recording a merge as a merge.
>>
> 
> $ git help merge
> 
>   --squash
>            Produce the working tree and index state as if a real merge
> happened. ... This allows you to create a
>            single commit on top of the current branch whose effect is
> the same as merging another branch.

The problem is simply in the "...". You cut out the vital part:


        but do not actually make a commit or
        move the `HEAD`, nor record `$GIT_DIR/MERGE_HEAD` to
        cause the next `git commit` command to create a merge
        commit.

See? Tree: yes, index: yes, merge info: no.

Git does perform a (tree) merge with --squash, but records the resulting
tree as an ordinary non-merge commit (with a single parent).

I'm not sure whether the statement about the index is completely
correct, though. During a merge the index records info about the merge
(stages :1: etc.) but that as missing with --squash. Only the resulting
tree is added to the index. How about the below?

Michael

diff --git a/Documentation/merge-options.txt
b/Documentation/merge-options.txt
index 637b53f..adadf8e 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -39,7 +39,8 @@

 --squash::
        Produce the working tree and index state as if a real
-       merge happened, but do not actually make a commit or
+       merge happened (except for the merge information),
+       but do not actually make a commit or
        move the `HEAD`, nor record `$GIT_DIR/MERGE_HEAD` to
        cause the next `git commit` command to create a merge
        commit.  This allows you to create a single commit on
