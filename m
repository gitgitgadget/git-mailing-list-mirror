From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] builtin-branch - allow deleting a fully specified branch-name
Date: Sat, 11 Apr 2009 13:01:30 -0400
Message-ID: <200904111301.31250.mlevedahl@gmail.com>
References: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com> <200904092119.10520.mlevedahl@gmail.com> <7vbpr519jq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 19:03:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsgbm-0003s6-0A
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 19:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038AbZDKRBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 13:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755781AbZDKRBh
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 13:01:37 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:60609 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592AbZDKRBg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 13:01:36 -0400
Received: by qyk16 with SMTP id 16so2899791qyk.33
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=U6SNKb1AmCMsg84F9N78eSMn5Fksx2y650qUZ3Kvsco=;
        b=MQLR4AAHUHN+6TdgMyd4M+oXU60KVrMOYRIiNvyHQ+Yl8hit1Y/326xtXbnv03A3vh
         3QgRqz9pNvD20YFmL1ixI7c5z/ngHpo/VPp+fXvLiVWjz4O2xMhtjAo+vw5LxDo9kNy1
         pGC6bC22PLKIyiRvir0ijncb8XaFDAGr8H4sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:cc
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Y8GIlKcWrWFudgXzhZz8igSetv4TWoumjyjQ0dnGE/f/2D6lP8Nmxfu0nIexg4On9C
         S42ARgtJO3GC91tO4wQ4VII86L9doPqzrNgwAo+E3vcd2tBiI6yD8PWADLRxmJeYqo1q
         Gcm7IGhM3CZjj0rtURqxa6m2fUi5w7FV320+U=
Received: by 10.224.67.130 with SMTP id r2mr4888676qai.284.1239469295495;
        Sat, 11 Apr 2009 10:01:35 -0700 (PDT)
Received: from hplap.localnet (pool-173-79-135-88.washdc.fios.verizon.net [173.79.135.88])
        by mx.google.com with ESMTPS id 6sm4684299qwk.27.2009.04.11.10.01.34
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 10:01:35 -0700 (PDT)
User-Agent: KMail/1.11.1 (Linux/2.6.27.21-170.2.56.fc10.i686; KDE/4.2.1; i686; ; )
In-Reply-To: <7vbpr519jq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116301>

On Thursday 09 April 2009 23:18:01 you wrote:
>
> All other commands happen to take a branch name because that is just one
> case of extended SHA-1 expression to name an object.  In that context, a
> refname (which a branch name is a special case of) refers to the commit
> pointed by it.  E.g.
>
>         "git checkout HEAD~20 -- Makefile"
>         "git show refs/heads/foo"
>         "git show heads/foo"
>         "git show foo"

I think my underlying problem here is the porcelain's ability to use either a 
branch name or a ref name, in different contexts, leading to a sometimes 
inconsistent interface. Consider the following
   $ git checkout master
             checks out branch master
   $ git checkout refs/heads/master
             checks out commit pointed to by refs/heads/master on a detached 
HEAD

   $ git checkout -b refs/heads/master refs/heads/master
             creates a new branch, refname = refs/heads/refs/heads/master

The last command is the one that I find most curious. The exact same string 
has two entirely different meanings to the same command. I can explain why 
this happens, but I cannot explain why this is a good thing. 

A model I could explain without mental gymnastics would be "branch names are 
simply refnames without the leading refs/heads or refs/remotes, and a refname 
may be used wherever a branch name is requested. While branch names are 
potentially ambiguous, refnames never are."  Of course, this would mean that 
the refs/heads/refs/... namespace is illegal. I don't know of any other 
downside (except of course to someone using that namespace), and frankly I 
don't think the existence of the refs/heads/refs namespace is a good thing, 
given the potential for confusion.

Just a thought.

Mark
