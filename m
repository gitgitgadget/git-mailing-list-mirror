From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: encrypted repositories?
Date: Mon, 20 Jul 2009 14:09:28 +0200
Message-ID: <op.uxc712eh1e62zd@balu.cs.uni-paderborn.de>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
 <alpine.LFD.2.01.0907171226460.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 14:10:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSrgy-0007dE-JH
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 14:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbZGTMJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 08:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbZGTMJc
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 08:09:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:56730 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753189AbZGTMJb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 08:09:31 -0400
Received: (qmail invoked by alias); 20 Jul 2009 12:09:30 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp071) with SMTP; 20 Jul 2009 14:09:30 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/uQhReIYzuFhuCHQoNf0CJkB6zWYzkiSwCSGqu4+
	CeW8xpvVQQ0c93
Received: from localhost ([127.0.0.1] helo=balu.cs.uni-paderborn.de)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KN2XRT-000418-FJ; Mon, 20 Jul 2009 14:09:29 +0200
In-Reply-To: <alpine.LFD.2.01.0907171226460.13838@localhost.localdomain>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123595>

Am 17.07.2009, 21:38 Uhr, schrieb Linus Torvalds  
<torvalds@linux-foundation.org>:

>
>
> On Fri, 17 Jul 2009, Matthias Andree wrote:
>>
>> Assume you have a repository where you want to work on embargoed  
>> information,
>> so that not even system administrators of the server you're pushing to  
>> can get
>> a hold of the cleartext data.
>
> If the server can't ever read it, you're basically limited to just one
> story:
>
>  - use rsync-like "stupid" transports to upload and download things.
>
>  - a "smart" git server (eg the native git:// style protocol is not going
>    to be possible)

I don't know all its features, apparently it's online recompression - this  
is no longer going to be available.

> and you strictly speaking need no real git changes, because you might as
> well just do it by uploading an encrypted tar-file of the .git directory.
> And there is literally no upside in doing anything else - any native git
> support is almost entirely pointless.
>
> You could make it a _bit_ more useful perhaps by adding some helper
> wrappers, probably by just implementing a new transport name (ie instead
> of using "rsync://", you'd just use "crypt-tgz://" or something).
>
> Now, that said, there are probably situations where maybe you'd allow the
> server to decrypt things _temporarily_, but you don't want to be  
> encrypted
> on disk, and no persistent keys on the server, then that would open up a
> lot more possibilities.

> Of course, that still does require that you trust the server admin to
> _some_ degree - anybody who has root would be able to get the keys by
> running a debugger on the git upload/download sequence when you do a
> upload or download.
>
> Maybe that kind of security is still acceptable to you, though?

No, the server can't be allowed access to the keys or decrypted data.

I'm not sure about the graph, and if I should be concerned. Exposing the  
DAG might be in order.

It would be ok if the disk storage and the over-the-wire format cannot use  
delta compression then. It would suffice to just send a set of objects  
efficiently - and perhaps smaller revisions can be delta-compressed by the  
clients when pushing.

I admit haven't checked how the current git:// over-the-wire protocol[s]  
work[s]. I think client-side delta compression may require limiting the  
graph depths or delta size (when exceeded, the client must send the  
standalone self-contained object rather than a delta), so that the server  
can refuse patches when the delta nesting or size gets too deep/big.

I think this would generate the git server to something like a storage  
device for objects, perhaps with the DAG if exposed.


On a more general note, is someone looking into improving the http://  
efficiency?  Perhaps there are synergies between my plan of (a) encryption  
and (b) more efficient "dumb" (http/rsync/...) protocol use.

-- 
Matthias Andree
