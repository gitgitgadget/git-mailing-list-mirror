From: Tim Harper <timcharper@gmail.com>
Subject: Making submodules easier to work with (auto-update on checkout or merge, stash & restore submodules)
Date: Tue, 29 Apr 2008 22:08:00 -0600
Message-ID: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 06:08:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr3cn-0008U8-9I
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 06:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbYD3EII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 00:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbYD3EIH
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 00:08:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:18756 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbYD3EIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 00:08:06 -0400
Received: by wf-out-1314.google.com with SMTP id 28so232909wfc.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 21:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=9tGKiJsE1YfSya28lshw96hNsmd8R2k93lDxrysWzZk=;
        b=ghfEXMc0R/Gk0vKegd/zWvHyrjZjzSmFoRgxEsHOdVeJLrkfu1TTnDdlJiSBjBzCJTHyOBziHkvpkavaxIEsVyN6yI5zx9g1oLJvON4NgMOp8j+bP+3M2oW/OBgnGCvg2QM/HtAHpy43hp5Fw8hZ4HyGsWAHlTGAEYkmr7rphxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=GJLcv33rkScGlQxnSxK+8DJQLeYYmCibBPVRZaHKolq7V0yU1y2/pZKBlT92gqMqo2CU9uXtA2Lt8yE3gnPfqE0dOb5ALo1yhtXZEAjZviEkL12xbrU32gUFBUUXlfHDeQNYRevANPdWWtFWdsarWSGVYhFGVNicc0p/PefwBzA=
Received: by 10.142.58.7 with SMTP id g7mr96467wfa.317.1209528484339;
        Tue, 29 Apr 2008 21:08:04 -0700 (PDT)
Received: from ?10.0.0.103? ( [208.186.134.104])
        by mx.google.com with ESMTPS id 22sm1016792wfg.13.2008.04.29.21.08.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Apr 2008 21:08:03 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80784>

OVERVIEW:
On the Git TextMate Bundle, I've automated a lot of the submodule  
commands to make them not a terrible pain to work with. (don't get me  
wrong - I really like the git submodule implementation, I just don't  
like how hard it is to work with).

"WARTS" WITH EXISTING IMPLEMENTATION
1) The submodule stays in the working copy when changing to a branch  
that does not have a submodule.  This can break a build and cause  
problems.  To work around, I have to delete the folder completely (git- 
clean).  Then, when I switch back to the branch again, I have to re- 
download the submodule.
2) I have to type "git checkout branch && git submodule init && git  
submodule update" to be sure that I really have the whole contents of  
the branch.  That's 3 commands, and a lot of typing.
3) If I don't run "git submodule update", and carelessly run "git  
commit -a" or "git add .", I risk propagating a submodule version from  
another branch or undoing an important change.

SUGGESTED ALGORITHM (AS HAS BEEN IMPLEMENTED IN THE GIT TEXTMATE BUNDLE)
When pulling / merging / changing branches:
1) cache all submodules to ~/.git/submodules_cache
    a) move from the working directory to a folder that is a MD5 hex- 
hash of both the submodule path and the submodule url
2) execute the pull / merge / branch change
3) restore all defined submodules to ~/.git/submodules_cache (only the  
submodules that are still defined after the merge / change / pull)
4) execute git submodule init && git submodule update


PITFALLS:
pitfall)
If you commit a change on a submodule that's not on a branch, auto- 
updating submodules will make it difficult to revive that change.

workaround)
Don't allow the user to commit unless they are on a branch.

... couldn't think of anymore.  Anyone?

CONCLUSION
So far, this algorithm holds up well in my use cases, and has made  
submodule management seamless for me (I don't have to know that I'm  
working with submodules).  It's resolved every one of the above  
outlined interface warts.

Would it be a good idea to build this algorithm into git?  What would  
be the best approach?  Am I completely overlooking something by  
designing the Git TextMate bundle to handle submodules this way?

Thanks,
Tim
