From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs
 in a repository
Date: Fri, 18 Sep 2009 17:16:40 +0200
Message-ID: <4AB3A458.5070100@viscovery.net>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com> <878wgcbb52.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Murphy, John" <john.murphy@bankofamerica.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Sep 18 17:16:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MofCc-0003aE-Do
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 17:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbZIRPQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 11:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbZIRPQk
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 11:16:40 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:49920 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbZIRPQk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 11:16:40 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MofCT-0006J5-1I; Fri, 18 Sep 2009 17:16:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 415734E9; Fri, 18 Sep 2009 17:16:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <878wgcbb52.fsf@users.sourceforge.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128800>

Pat Thoyts schrieb:
> "Murphy, John" <john.murphy@bankofamerica.com> writes:
>> There is a error when running  gitk --all when there are more than 797 refs in a repository.
>> We get an error message:
>>
>> Error reading commits: fatal ambiguous argument '3': unknown revision or path not in the working tree.
>> Use '--' to separate paths from revisions.
>>
>> I believe issue is with this line of the code in proc parseviewrevs:
>>
>>       if {[catch {set ids [eval exec git rev-parse "$revs"]} err]}
>>
>> When there are more than 797 refs the output of git rev-parse is too large to fit into the string, ids.
>>
>> 797 refs = 32,677 bytes.
>> 798 refs = 32,718 bytes my guess is a little too close for comfort to 32,768 bytes.
>>
>> As I was deleting refs locally the error message would change from '3' to any char [A-Z,0-9].

I cannot reproduce the error. I have a repository with 100 commits in a
linear history and 5000 refs (50 refs per commit). They are named
refs/heads/branch-XXXX. I don't see any problems with 'gitk --all'.

> +proc git-rev-parse {args} {
> +    set ids {}
> +    set pipe [open |[linsert $args 0 git rev-parse] r]
> +    while {[gets $pipe line] != -1} {
> +        lappend ids $line
> +    }
> +    close $pipe
> +    return $ids
> +}
> +    
>  proc parseviewrevs {view revs} {
>      global vposids vnegids
>  
>      if {$revs eq {}} {
>  	set revs HEAD
>      }
> -    if {[catch {set ids [eval exec git rev-parse $revs]} err]} {
> +    if {[catch {set ids [git-rev-parse $revs]} err]} {

Sorry, but you are changing the wrong end of git rev-parse. The limit is
on the command line, but if you run 'gitk --all', then $revs is simply
"--all" - no limit is exceeded. You changed the output of rev-parse, but
there is no limit on how much Tcl can eat of rev-parse's output.

The error must be in some other git invocation.

-- Hannes
