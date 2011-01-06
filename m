From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: log -p hides changes in merge commit
Date: Thu, 6 Jan 2011 15:04:38 -0600
Message-ID: <20110106210438.GB15090@burratino>
References: <4D25F6BE.7010300@cfl.rr.com>
 <7vwrmhakdz.fsf@alter.siamese.dyndns.org>
 <4D262B05.2060306@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 22:04:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pax0y-00069G-Cw
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 22:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872Ab1AFVEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 16:04:50 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49637 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab1AFVEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 16:04:49 -0500
Received: by vws16 with SMTP id 16so6951383vws.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 13:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OS6R4BrNECfX/UcHsUQluXQAAU5qDkOhckYOrtD3Ttk=;
        b=YRhyt5X8/inIjVbuR4TGgi3C4IXwjmHRzHUJPYO05+1qTZn6N/oCpUt4Uey+3Ku4t1
         EnqmLBcLtH/DMq11AVCfo5uZkgel81SCSKeggyjcBL36DU6QwNsrfKRKQK0Vb1jJH3rF
         kocLem94+NAsOXp2WF/hCptiuuQgEKbJ7J1p8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=htQANKgShQfQgPs4onmmAee3vWwMXkrSnENtI3uRnPl1L3FBcQvmxK3clDHOIvp9hn
         GUmWR+zpCk0ktAwX7VKD7nllFWcfA7DcQyQXUTlccSdPHjulS1uIOLgjOS+6Jp+3v+g6
         /RmJse8c8E8ESCXtf0SqSUf3zB2jo17YzeFzo=
Received: by 10.220.186.66 with SMTP id cr2mr7374832vcb.65.1294347888769;
        Thu, 06 Jan 2011 13:04:48 -0800 (PST)
Received: from burratino ([69.209.72.219])
        by mx.google.com with ESMTPS id c8sm5454547vcc.33.2011.01.06.13.04.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 13:04:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D262B05.2060306@cfl.rr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164673>

Phillip Susi wrote:

> What I would like to do is be able to review a merge to sign off on it.
>  While the full diff against the left parent would be a large and
> unhelpful amalgamation of the changes in the merged branch, any
> additional changes made during the commit should not be hidden.  This
> allows someone performing the merge to effectively sneak in unintended
> changes.  I would expect any such changes to be shown by log -p, but
> this only seems to happen if you add -c.

To be more precise, here is what -c and --cc do.  Consider the
following history (time flowing left to right):

    -- [topic]
   /
 B --- [master]

>From the master branch, I merge topic.  (1) If I am lucky, the changes
from B to topic and B to master touch entirely different sections of
code (though perhaps within the same files), so one could just apply
the two diffs in succession to make a merge automatically.  (2) Almost
as good is the case when they touch code a couple of lines apart ---
"git merge" still figures it out automatically.  (3) Less nice is the
case when they touch the same line, say --- but even here the correct
merge can be obvious.  (4) Worst of all is when the changes
semantically conflict but syntactically do not:

	$ git merge topic
	$ make test;	# fails!
	$ ... hack hack hack ...
	$ git commit --amend

   -- o [topic] ------
  /                   \
 B -- o --------------- [master]

In case (1), -c will show a "combined diff" for files where master
does not match either the old master or topic.  --cc, on the other
hand, will correctly suppress these uninteresting diffs.

In case (2), -c will show a noisy "combined diff" as before.
--cc will show a combined diff when the changes from both parents
touch nearby code, even if it merged trivially.

In case (3), -c and --cc will show the semantically boring but
syntactically interesting merge.

Case (4) is underspecified.  So let's give a more precise example:
the old master and topic tried to fix the same bug in two incompatible
ways.  When merging, I decide I like the topic's way better, so I
resolve conflicts in favor of the topic.  Hopefully all unrelated
changes on master were preserved!

In this case, -c and --cc will very likely show nothing at all.
Each file matches one of the two parents (old master or topic) so
there is no easy way to distinguish the case from (0) or (1).

By now it should be clear how to get the diff you are looking for.
One makes a test merge, perhaps using the iffy "resolve in favor
of one side or the other" feature to save time on conflicts:

	git checkout oldmaster^0
	git merge topic
	git reset --merge ORIG_HEAD; # meh, too many conflicts
	git merge -Xours topic

and then makes a diff.

	git diff master

Hope that helps,
Jonathan
