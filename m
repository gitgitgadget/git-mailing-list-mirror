From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-daemon memory usage, disconnection.
Date: Wed, 19 Apr 2006 07:59:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604190749160.3701@g5.osdl.org>
References: <1145452967.13200.92.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 17:04:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWEDs-0002x5-VR
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 17:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWDSPEB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 11:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWDSPEA
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 11:04:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750838AbWDSPEA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 11:04:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3JExitH024159
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Apr 2006 07:59:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3JExhQd022929;
	Wed, 19 Apr 2006 07:59:44 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1145452967.13200.92.camel@pmac.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18928>



On Wed, 19 Apr 2006, David Woodhouse wrote:
>
> I'm running git-daemon from xinetd and it seems a little greedy...
> 
> Cpu(s):  2.7% us,  6.4% sy,  0.0% ni,  1.7% id, 87.7% wa,  1.4% hi,  0.0% si
> Mem:    253680k total,   250076k used,     3604k free,      568k buffers
> Swap:   500960k total,   500864k used,       96k free,    24696k cached
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> 31232 nobody    18   0  155m  29m 7224 D  1.3 11.9   0:25.56 git-rev-list
> 30743 nobody    18   0  179m  29m 9480 D  0.7 11.9   0:42.60 git-rev-list
> 31277 nobody    18   0  147m  28m 7476 D  2.6 11.4   0:20.90 git-rev-list
> 30314 nobody    18   0  233m  26m 7696 D  0.0 10.6   1:20.24 git-rev-list
> 30612 nobody    18   0  204m  23m 7432 D  1.3  9.4   0:59.19 git-rev-list
> 30574 nobody    18   0  190m  20m 7608 D  0.3  8.3   0:50.77 git-rev-list
> 30208 nobody    18   0  140m  14m 7632 D  0.3  5.9   0:15.23 git-pack-object

Well, you've probably got two issues: 

 - it looks like you aren't packing your archives (which explains why the 
   disk accesses are horrid, which in turn explains the "D" part).

   For a git server, you _really_ want all trees to be mostly packed, or 
   you want absolutely tons of memory (and 256kB is definitely not "tons"
   as far as git is concerned).

 - git-rev-list won't notice that there is nobody listening until it gets 
   a EPIPE, and it won't get an EPIPE until it actually outputs something, 
   and it won't output anything until it is largely done traversing the 
   tree..

> Now, this wouldn't be _so_ bad if there were only two of them running.
> The clients for the other four have actually given up and disconnected
> long ago, but git-daemon doesn't seem to have reacted to that.

Well, the way things work under UNIX, you normally don't notice that the 
other end isn't interested until you try to write, and you get a "nobody 
is listening". And sadly, the packing stuff does most (not all) of the 
heavy lifting before it can even start to write things out.

That said, I should probably take a look at git-rev-list --objects memory 
usage once again. It's neve rbeen exactly "lean" (and it can't really be: 
it does end up needing the total object list in memory for a full clone, 
and with something like the kernel, that's about 250 _thousand_ objects).

We should probably also make send-pack.c use the nice revision library, 
because right now it's doing that pipe to git-rev-list for no good reason.

		Linus
