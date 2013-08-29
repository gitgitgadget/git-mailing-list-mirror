From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: http.postBuffer set at the server side?
Date: Thu, 29 Aug 2013 00:40:16 -0400
Organization: PD Inc
Message-ID: <D7C6383E8CCC40338EABF61A1CDADFC8@porsche>
References: <871B6C10EBEFE342A772D1159D132085416127CF@umechphj.easf.csd.disa.mil> <20130829035209.GC22788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 29 06:40:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEu1v-0005lC-Rb
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 06:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab3H2EkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 00:40:20 -0400
Received: from projects.pdinc.us ([67.90.184.26]:48602 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753041Ab3H2EkT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 00:40:19 -0400
Received: from porsche (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id r7T4dv0n009544;
	Thu, 29 Aug 2013 00:39:58 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac6kaydp4NQNpyugSDenfwmkwNFBuQABY3Dw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
In-Reply-To: <20130829035209.GC22788@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233234>

> -----Original Message-----
> From: Jeff King
> Sent: Wednesday, August 28, 2013 23:52
> To: Pyeron, Jason J CTR (US)
> Cc: git@vger.kernel.org
> Subject: Re: http.postBuffer set at the server side?
> 
> On Wed, Aug 28, 2013 at 11:08:02PM +0000, Pyeron, Jason J CTR 
> (US) wrote:
> 
> > We have systems hosting git which are behind proxies, and 
> unless the 
> > client sets the http.postBuffer to a large size they connections 
> > fails.
> > 
> > Is there a way to set this on the server side? If not would 
> a patch be 
> > possible to fix this?
> 
> What would it mean to set it on the server?  It is the size 
> at which the client decides to use a "chunked" 

To tell the client...

> transfer-encoding rather than buffering the whole output to 
> send at once. So you'd want to figure out why the server is 
> upset about the chunked encoding.
> 

Unchangable settings in a specific case here.

> > jason.pyeron@hostname /home/jason.pyeron/desktop/projectname
> > $ git push remote --all
> > Username for 'https://server.fqdn':
> > Password for 'https://jpyeron@server.fqdn':
> > Counting objects: 1820, done.
> > Delta compression using up to 4 threads.
> > Compressing objects: 100% (1276/1276), done.
> > error: RPC failed; result=22, HTTP code = 411
> > fatal: The remote end hung up unexpectedly Writing objects: 100% 
> > (1820/1820), 17.72 MiB | 5.50 MiB/s, done.
> > Total 1820 (delta 527), reused 26 (delta 6)
> > fatal: The remote end hung up unexpectedly
> 
> The server (or the proxy) returns 411, complaining that it 
> didn't get a Content-Length header. That's because the git 
> http client doesn't know how big the content is ahead of time 
> (and that's kind of the point of chunked encoding; the 
> content is streamed).
> 
> > jason.pyeron@hostname /home/jason.pyeron/desktop/projectname
> > $ git config http.postBuffer 524288000
> > 
> > jason.pyeron@hostname /home/jason.pyeron/desktop/projectname
> > $ git push remote --all
> > Username for 'https://server.fqdn':
> > Password for 'https://jpyeron@server.fqdn':
> > Counting objects: 1820, done.
> > Delta compression using up to 4 threads.
> > Compressing objects: 100% (1276/1276), done.
> > Writing objects: 100% (1820/1820), 17.72 MiB | 11.31 MiB/s, done.
> > Total 1820 (delta 519), reused 26 (delta 6) To 
> > https://server.fqdn/git/netasset-portal/
> >  * [new branch]      master -> master
> 
> And here you've bumped the buffer to 500MB, so git will 
> potentially buffer that much in memory before sending 
> anything. Which works for your 17MB packfile, as we buffer 
> the whole thing and then send the exact size ahead of time, 
> appeasing the proxy.
> 
> But there are two problems I see with just bumping the 
> postBuffer value:
> 
>   1. You've just postponed the problem. The first 501MB push will fail
>      again. You can bump it higher, but you may eventually hit a point
>      where your buffer is too big to fit in RAM.
> 

Agreed. By then I hope to get our infrastructure team to address the proxies.
Liking the spool idea below. The other idea would be restrict the size of any
one transfer. (would that work if a given commit is large than the threshold???)

>   2. You've lost the pipelining. With a small postBuffer, we are
>      streaming content up to the server as pack-objects generates it.
>      But with a large buffer, we generate all of the content, 
> then start
>      sending the first byte (notice how the progress meter, which is
>      generated by pack-objects, shows twice as fast in the 
> second case.
>      It is not measuring the network at all, but is streaming into
>      git-remote-https's buffer).
> 
> If the server really insists on a content-length header, then 
> we can't ever fix (2). But we could fix (1) by spooling the 
> packfile to disk and then sending from there (under the 
> assumption that you have way more temporary disk space than RAM).
> 

Hmmm. So if the server says, hey I have a borked infrastructure, please send me
a content length git could spool then.

> However, if you have control of the proxies, the best thing 
> would be to tweak its config to stop complaining about a lack 
> of content-length header (at least in cases where you're 
> getting a "chunked"
> content-transfer-encoding). That would solve both issues (and 
> without clients having to change anything).
> 

One of the many is under my control, I will get that one addressed but the
others there is no hope.

-Jason


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 
