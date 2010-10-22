From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Following history of a copied file from another indirect branch
Date: Fri, 22 Oct 2010 08:35:17 +0200
Message-ID: <4CC130A5.6050802@viscovery.net>
References: <4CC08AA5.8070502@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 08:35:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9BDr-000194-O0
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 08:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab0JVGfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 02:35:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53745 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752886Ab0JVGfV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 02:35:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P9BDi-0000lk-5K; Fri, 22 Oct 2010 08:35:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C7BA91660F;
	Fri, 22 Oct 2010 08:35:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4CC08AA5.8070502@workspacewhiz.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159649>

Am 10/21/2010 20:47, schrieb Joshua Jensen:
> It has become a necessity to copy a file from one long-lived branch to
> another.  It is not possible to merge the branches at this time.
> 
> I would like to have 'git gui blame' follow the copy back through its
> original history, but I don't believe Git has metadata for storing this. 
> Something along the lines of a 'followparent' in the commit object, for
> instance, would allow the revision walking code to wander the history down
> an alternate line.

You can branch off one commit form that long-lived branch that undoes
everything except the file F you are interested in since the last
merge-base. Then you merge that single commit into the other branch.

   ---o--o--B     <- long-lived
     /  /    \
    /  /      U   <- the-file
   /  /        \
 -o--A----------M <- master (the other branch)

i.e. 'git diff A..B' shows a lot of changes, but 'git diff A..U' shows
only changes to the file you are interested in. 'git diff -R B..U' differs
from 'git diff A..B' only in the changes to the file you are intersted in.

When you later find that you need new changes to F that were made on
long-lived, but you still cannot merge long-lived, then you can merge
long-lived into the-file (resolve conflicts by removing the conflicted
files and also remove newly added files), and then you merge the-file into
master again.

WARNING: When you later merge long-lived into master, the merge will lose
all changes made on long-lived. You work it around by temporarily grafting
away the merge parents that point to commits listed by
long-lived..the-file. After you complete the merge, you can remove the
grafts again.

-- Hannes
