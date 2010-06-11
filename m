From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Leaving large binaries out of the packfile
Date: Fri, 11 Jun 2010 09:17:44 -0700
Message-ID: <20100611161744.GS14847@spearce.org>
References: <4C108556.8040102@workspacewhiz.com> <20100610180457.GO14847@spearce.org> <4C12566E.6020607@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jun 11 18:17:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON6vb-0001on-DR
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 18:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab0FKQRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 12:17:51 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59174 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab0FKQRu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 12:17:50 -0400
Received: by pvg16 with SMTP id 16so663226pvg.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 09:17:50 -0700 (PDT)
Received: by 10.114.49.4 with SMTP id w4mr1630996waw.88.1276273067485;
        Fri, 11 Jun 2010 09:17:47 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id r20sm15243532wam.5.2010.06.11.09.17.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 09:17:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C12566E.6020607@gnu.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148959>

Paolo Bonzini <bonzini@gnu.org> wrote:
> On 06/10/2010 08:04 PM, Shawn O. Pearce wrote:
>> Joshua Jensen<jjensen@workspacewhiz.com>  wrote:
>>> Sometimes, 'git gc' runs out of memory.  I have to discover which file
>>> is causing the problem, so I can add it to .gitattributes with a
>>> '-delta' flag.  Mostly, though, the repacking takes forever, and I dread
>>> running the operation.
>>
>> If you have the list of big objects, you can put them into their
>> own pack file manually.  Feed their SHA-1 names on stdin to git
>> pack-objects, and save the resulting pack under .git/objects/pack.
>
> Do you know any simpler way than
>
> git log --pretty=format:%H | while read x; do
>   git ls-tree $x -- ChangeLog | awk '{print $3}'
> done | sort -u
>
> to do this?  I thought it would be nice to add --sha1-only to  
> git-ls-tree, but maybe I'm missing some other trick.

Maybe

  git rev-list --objects HEAD | grep ' ChangeLog'

pack-objects wants the output of rev-list --objects as input, file
name and all.  So its just a matter of selecting the right lines
from its output.

>> Assuming the pack was called pack-DEADC0FFEE.pack, create a file
>> called pack-DEADC0FFEE.keep in the same directory.  This will stop
>> Git from trying to repack the contents of that pack file.
>>
>> Now run `git gc` to remove those huge objects from the pack file
>> that contains all of the other stuff.
>
> That obviously wouldn't help if these large binaries are updated often,  
> however.

No, it doesn't.  But you still could do this on a periodic basis.
That way you only drag around a handful of recently created large
binaries during a typical `git gc`, and not the entire project's
history of them.

-- 
Shawn.
