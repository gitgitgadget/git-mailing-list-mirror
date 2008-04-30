From: Tim Harper <timcharper@gmail.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout or merge, stash & restore submodules)
Date: Tue, 29 Apr 2008 22:47:25 -0600
Message-ID: <EC4DE72E-665B-44C9-A85C-C12C26B00C3A@gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 06:48:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr4Eu-0000DQ-75
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 06:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbYD3Erb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 00:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbYD3Erb
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 00:47:31 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:13377 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbYD3Era (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 00:47:30 -0400
Received: by py-out-1112.google.com with SMTP id u52so544599pyb.10
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 21:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=t04BXAiBq32SbzOb9FbKmL3xZe8k8kwjSmedXFpp020=;
        b=dpjqaO5lSm0ShkzbF0B8Z+fy583wioxuRzuCCv03uJjQ1HEO7kV0iMNYOMQSI68U71snxANmQIl4F92kI92F/ZFA2G8IOWMqPQLZGet7i4OT8/giH23eCpKDs5TYmXfx7GzFYWxXhs2cVZN9ec0XoVkX2ZfIVVmb7ooL9eENSeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=M7aOfVKlw97T7S4EMqqQT8a3tGYFwrTEvhnp+DDG6CWnqjk9rvY0O4PP59ZKxYQl1v0bx7TQ2vcFR4Zz5VnQjLZDtzGVrirLTjOAPDw5i52GIDb2TX2dP9sb18jRWLkOv8AfSLJGUKv5nQNDArvkjNZoJY8p6SulFVBXXFGFeiQ=
Received: by 10.142.144.16 with SMTP id r16mr116286wfd.195.1209530849555;
        Tue, 29 Apr 2008 21:47:29 -0700 (PDT)
Received: from ?10.0.0.103? ( [208.186.134.104])
        by mx.google.com with ESMTPS id 29sm1161742wfg.0.2008.04.29.21.47.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Apr 2008 21:47:28 -0700 (PDT)
In-Reply-To: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80788>

clarification:

SUGGESTED ALGORITHM (AS HAS BEEN IMPLEMENTED IN THE GIT TEXTMATE BUNDLE)
When pulling / merging / changing branches:
1) cache all submodules to .git/submodules_cache
-  a) move the submodule to .git/submodules_cache/`echo  
"$submodule_path\n$submodule_url" | md5`
2) execute the pull / merge / branch change
3) restore all defined submodules from .git/submodules_cache to their  
respective working directory locations (only the submodules that are  
still defined after the merge / change / pull)
4) execute git "submodule init && git submodule update"


On Apr 29, 2008, at 10:08 PM, Tim Harper wrote:

> OVERVIEW:
> On the Git TextMate Bundle, I've automated a lot of the submodule  
> commands to make them not a terrible pain to work with. (don't get  
> me wrong - I really like the git submodule implementation, I just  
> don't like how hard it is to work with).
>
> "WARTS" WITH EXISTING IMPLEMENTATION
> 1) The submodule stays in the working copy when changing to a branch  
> that does not have a submodule.  This can break a build and cause  
> problems.  To work around, I have to delete the folder completely  
> (git-clean).  Then, when I switch back to the branch again, I have  
> to re-download the submodule.
> 2) I have to type "git checkout branch && git submodule init && git  
> submodule update" to be sure that I really have the whole contents  
> of the branch.  That's 3 commands, and a lot of typing.
> 3) If I don't run "git submodule update", and carelessly run "git  
> commit -a" or "git add .", I risk propagating a submodule version  
> from another branch or undoing an important change.
>
> SUGGESTED ALGORITHM (AS HAS BEEN IMPLEMENTED IN THE GIT TEXTMATE  
> BUNDLE)
> When pulling / merging / changing branches:
> 1) cache all submodules to ~/.git/submodules_cache
>   a) move from the working directory to a folder that is a MD5 hex- 
> hash of both the submodule path and the submodule url
> 2) execute the pull / merge / branch change
> 3) restore all defined submodules to ~/.git/submodules_cache (only  
> the submodules that are still defined after the merge / change / pull)
> 4) execute git submodule init && git submodule update
>
>
> PITFALLS:
> pitfall)
> If you commit a change on a submodule that's not on a branch, auto- 
> updating submodules will make it difficult to revive that change.
>
> workaround)
> Don't allow the user to commit unless they are on a branch.
>
> ... couldn't think of anymore.  Anyone?
>
> CONCLUSION
> So far, this algorithm holds up well in my use cases, and has made  
> submodule management seamless for me (I don't have to know that I'm  
> working with submodules).  It's resolved every one of the above  
> outlined interface warts.
>
> Would it be a good idea to build this algorithm into git?  What  
> would be the best approach?  Am I completely overlooking something  
> by designing the Git TextMate bundle to handle submodules this way?
>
> Thanks,
> Tim
