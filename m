From: Luke Lu <git@vicaya.com>
Subject: RFC: rebase without pain
Date: Fri, 13 Jun 2008 18:38:44 -0700
Message-ID: <5B4BD573-8C89-4E27-8ADB-F870EA503D00@vicaya.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 03:40:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7KkY-0005I3-P1
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 03:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbYFNBiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 21:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbYFNBiu
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 21:38:50 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:37709 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYFNBit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 21:38:49 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2640137ywe.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 18:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer:sender;
        bh=ceBmjJhl9SKqCmvJ9ug4Lc77PkcDR3xLKL9yV3YjU+0=;
        b=BwQgRTSF977kVc6cTCTIPjWSVSW+AX/E6LAsu4T1MKYpq6opQ8g+/Kuo9iWsI3Yxnl
         Jy/5NxwWWe1ohSq37BWkWVfVlYXjxDB+NQgfWRsEo+XErn2H1E4v1uzIMB6EcRXHy1aD
         vJH3jpzBRpLZfna7lfvOFRILF1GEzL0o+fWfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer:sender;
        b=FCfEYOHzBFvAqXqkO59GzgrlzJnooOy2jX9EweKAWh6aD832s3Nx7dW3BMJ7BnySxi
         m8ZVLUwSpA9anKhfCSKJbq6SSQCr1AL6HaFe0Kx37ABvcCRMq8YP+KQiMwra47VTiO9t
         FXW3otgdAgvr4QTLAjPSNUXWGWcMUrWNe2+ZA=
Received: by 10.151.111.15 with SMTP id o15mr5518535ybm.166.1213407527844;
        Fri, 13 Jun 2008 18:38:47 -0700 (PDT)
Received: from ?192.168.7.9? ( [71.198.200.243])
        by mx.google.com with ESMTPS id f60sm14175880pyh.37.2008.06.13.18.38.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 18:38:46 -0700 (PDT)
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84959>

This may have been discussed before, but I could not find it. If so, I  
apologize for the noise and hope somebody is working on the issue.

Based on my observation, rebase is the single most interesting and  
misunderstood feature in git compared with other VCS. Once I  
discovered rebase -i, I can't stop using it, because I'd like to keep  
my history clean for readability and maintenance purpose. The downside  
is that once you publish your branch, further rebasing could cause a  
lot of pain for people who have already rebased and merged this  
branch, as rebasing/merging against the branch by them would cause a  
lot conflicts that have to be resolved manually due to some loss of  
common history (one or more SHA1s were rewritten).

Of these lost SHA1s, the last SHA1 of the last rebase is most  
interesting, as it's usually the parent of other people's rebase or  
merge. The same applies to a series of patches that are being modified  
over time. If we preserve a  
<last_sha1_of_the_last_rebase_or_original_head> record, say in reflog,  
for every rebase, we can have more intelligent merges of rebased  
histories with much less conflicts (specifically, squashing,  
reordering and comment editing will result zero conflicts for  
downstream users). We probably need to extend git protocol to send  
along these rebase records. We can even modify format-patch to  
generate these rebase records for each rebase of a branch. We also  
need to modify gc code to reserve these records in reflog (along with  
stashes as discussed in another thread). I think this approach can be  
made backward compatible.

One obvious problem of this approach is that people can branch in the  
middle of a patch series after they rebased/merged it, which means  
they'll have to resolve conflicts manually even with this approach. I  
argue that this is a rare case and that the above approach works for  
most common cases.

In summary, the proposal tries to solve the rebase problems by  
preserving and propagating rebase history and let the merge algorithm  
take advantage of the information.

What do you guys think?

Disclaimer: I don't know much about git internal yet. My understanding  
of git is only at conceptual level (commit DAG and reflog)

__Luke
