From: Andy Parkins <andyparkins@gmail.com>
Subject: Rebase will throw away log messages
Date: Fri, 23 Mar 2007 15:11:22 +0000
Message-ID: <200703231511.24397.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 16:11:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUlQV-0000TD-K8
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 16:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422938AbXCWPLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 11:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422936AbXCWPLb
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 11:11:31 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:19370 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422906AbXCWPLa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 11:11:30 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1059627nze
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 08:11:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dN8HLHyNqohpdsq1htSyWiNxrovsu0Ui92NMoLGFhg+zu4k7W6Sdoijc1rRCLmVn1Yf/pjTgiphrUXVciq1bSgxRu6HrlNFpDVupEjgUmvkqUqAZsQFPeInsyXBmaX3QY2M9cYpKMcEYzp3xKtCmWt8qV1azHVNNTtrEkz/+zQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jqZFT1WI+okVeYV1/I0N6MNio7RR+7vuTatfDAZkQ045wTr/Ec3G35zkovyW+YRw2hnaO8FDlNgavBbZQssjf/6Bd9hl8TMQ9hCvlmTcdC72VkXKtqdj2nAFuGdTmrnE/S8KbrtmKoJJD0x2ATGnc5uFmlehviY9gkIlqpn+rKU=
Received: by 10.64.185.7 with SMTP id i7mr6978093qbf.1174662689314;
        Fri, 23 Mar 2007 08:11:29 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id o53sm11851500nfa.2007.03.23.08.11.28;
        Fri, 23 Mar 2007 08:11:28 -0700 (PDT)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42938>

Hello,

The thread "[PATCH] have merge put FETCH_HEAD data in commit message" reminded 
me of a test I wanted to do after Junio told me off ;-) for putting "--- 
>8 ---" in a log message.  In particular, the objection was that the "---" 
made git-am think the message was at an end.  This combined with the talk of 
git-am in the above thread made me remember that I had more to say about 
git-am being so picky about what it would allow in the log message.

I just made a repository that looked like this:

 * -- * (somebranch)
  \
   X (master)

Then I did a rebase, while on master

 $ git rebase somebranch

Great; rebase worked as expected in terms of reorganising the repository:

 * -- * (somebranch)
       \
        X' (master)

The only thing is this change in the log.  Here is X before the rebase:

commit 3030bf9e3f8434dc3634e768f5e0bd54659bed48
Author: Andy Parkins <andyparkins@gmail.com>
Date:   Fri Mar 23 14:49:24 2007 +0000

    Short log
    
    Long log; line following this has dashes in it
    
    ---
    
    This is after the dashes.

Here is X after the rebase:

commit 575e0c226117d687ae9ba1c3c6b4c8e35cbe5ab7
Author: Andy Parkins <andyparkins@gmail.com>
Date:   Fri Mar 23 14:49:24 2007 +0000

    Short log
    
    Long log; line following this has dashes in it

Oh dear.  Half the log message has gone missing.

Of course the reason will be obvious to you clever chaps: git-rebase uses 
git-am to do the work and the "---" line in the original message causes it to 
drop into "diff starts here mode", and then everything until the "diff --git" 
line is ignored.

Surely git-am needs a better way of detecting the end of the log that that? 

Something more unique than "---" would be a start; "--- [end of log message]" 
sort of thing.

Although they aren't liked on the git list - emails with the different parts 
as different attachments would be a much more reliable input for git-am for 
use in git-rebase.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
