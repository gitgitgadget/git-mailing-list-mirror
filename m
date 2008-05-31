From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: use Git.pm, and use its parse_rev method for
 git_get_head_hash
Date: Sat, 31 May 2008 14:39:58 +0200
Message-ID: <4841471E.2070302@gmail.com>
References: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com>	<484087A7.2030107@gmail.com> <m3lk1q24nb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 14:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2QOl-0001Fm-Lj
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 14:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbYEaMkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 08:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbYEaMkG
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 08:40:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:45194 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbYEaMkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 08:40:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so309785fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 05:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=9nVWeh5jxCSjVm5edhOnX9C43wR/CwoCiRJoPiF7JSE=;
        b=gtBe3mQhelk1e458yp4j+kvZYuBEKGWxnfZ0vH9PQqKUpkbuN6/1jslRuKS3kBR61KN7iK3qnFMH3vYFhbRJr6yCneAEmbarjjS8T2FAu0rnZlciQxBjLMX0uK0sNIGH2s8dFPd54aA5CWVBgnfhdKwJ/1PvEHCpu5P695C+f9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Mm7B8uXiwEmqOWyDntWxvOUUjEzrtSPeOBrajgH3TJE3WT0PsoAzXqz24ekuYIQv4q4zaPQ7aKpSR2J7wkuHizlUdD74NktYGU5VK/pSqikbz0C4rw+YcpNg5p5FLvvDHvnEC7AZU8DLYblxIM8aRJl4gy+e4JhxngbAlKDcrOE=
Received: by 10.86.90.2 with SMTP id n2mr8082074fgb.51.1212237599329;
        Sat, 31 May 2008 05:39:59 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.213.54])
        by mx.google.com with ESMTPS id 31sm4359833fkt.2.2008.05.31.05.39.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 05:39:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <m3lk1q24nb.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83380>

Jakub Narebski wrote:
> But I'm not sure for example [that] parsing subroutines [that parse the
> output of the git commands should be in Git.pm].
> 
> [...] IMVHO caching command output is bad idea.  I'd rather have gitweb
> cache _parsed_ data (i.e. Perl structures).

Yes, I agree with you that parsed data should be cached, but for that 
reason I think that the subroutine that parse git's output should be in 
Git.pm, not in Gitweb:

If you want to cache parsed data, you need the caching layer in between 
the application (= Gitweb) and the repository access layer (= command 
output parsing), or you would have to insert cache code at every call to 
the repository access layer.  So you end up with these layers:

(Layer 0: Front-end [HTML] caching.)
Layer 1: Application (Gitweb)
Layer 2: Back-end caching
Layer 3: Repository access (command parsing)
Layer 4: Calls to the git binary

Layer 3 and 4 are application-independent (i.e. not Gitweb specific), 
and since they form a usable API, they might as well be written as a 
separate API rather than lumped together with Gitweb.  Git.pm is a start 
of such an API (it does layer 4 and a little bit of layer 3), so it 
seems natural for me to extend it.

Layer 2 is application-independent as well, so it can become an extra 
class in Git.pm or a separate module.  (It should stay independent of 
layers 3 and 4).

We may need to have an explicitly implemented layer 0 (front-end 
caching) in Gitweb for at least a subset of pages (like project pages), 
but we'll see if that's necessary.

> Caching git command output (something like IPC::Cmd::Cached?)
> would only repeat bad I/O patterns of git commands.

I hope you're not assuming that the back-end cache will reside on disk 
-- the problem is IO throughput, so having a cache on disk can really 
only work for a front-end cache.  For the back-end cache, we *will* have 
to use a memory cache (or no cache at all).

> P.S. Here it is what could go [from Gitweb] to Git.pm: [snip]

Good points, I agree those should eventually be moved to Git.pm.  (They 
are not my priority at the moment, since I really want to implement 
caching.  So unless they move naturally as part of my refactoring, I'll 
leave them in Gitweb for now.)

-- Lea
