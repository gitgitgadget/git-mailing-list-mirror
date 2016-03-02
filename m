From: Bhavik Bavishi <bhavikdbavishi@gmail.com>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 16:17:12 +0530
Message-ID: <56D6C4B0.5080003@gmail.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
 <20160302023024.GG17997@ZenIV.linux.org.uk> <20160302081344.GB8024@x>
 <CACsJy8CBBk4bgz6Gn0QvCwWtOsqcQZBYgOBQTd=4Y+2YKs44Qg@mail.gmail.com>
 <20160302083227.GA30065@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Josh Triplett <josh@joshtriplett.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 12:05:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab4af-0004VK-Um
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 12:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbcCBLFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 06:05:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:33586 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbcCBLFF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 06:05:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ab4aU-0004L1-Vz
	for git@vger.kernel.org; Wed, 02 Mar 2016 12:05:03 +0100
Received: from 1.22.172.90 ([1.22.172.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 12:05:02 +0100
Received: from bhavikdbavishi by 1.22.172.90 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 12:05:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 1.22.172.90
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <20160302083227.GA30065@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288121>

On 3/2/16 2:02 PM, Jeff King wrote:
> On Wed, Mar 02, 2016 at 03:22:17PM +0700, Duy Nguyen wrote:
>
>>> As a simple proposal, the server could send the list of hashes (in
>>> approximately the same order it would send the pack), the client could
>>> send back a bitmap where '0' means "send it" and '1' means "got that one
>>> already", and the client could compress that bitmap.  That gives you the
>>> RLE and similar without having to write it yourself.  That might not be
>>> optimal, but it would likely set a high bar with minimal effort.
>>
>> We have an implementation of EWAH bitmap compression, so compressing
>> is not a problem.
>>
>> But I still don't see why it's more efficient to have the server send
>> the hash list to the client. Assume you need to transfer N objects.
>> That direction makes you always send N hashes. But if the client sends
>> the list of already fetched objects, M, then M <= N. And we won't need
>> to send the bitmap. What did I miss?
>
> Right, I don't see what the point is in compressing the bitmap. The sha1
> list for a clone of linux.git is 87 megabytes. The return bitmap, even
> naively, is 500K. Unless you are trying to optimize for wildly
> asymmetric links.
>
> If the client just naively sends "here's what I have", then we know it
> can never be _more_ than 87 megabytes. And as a bonus, the longer the
> list is, the more we are saving (so at the moment you are sending 82MB,
> it's really worth it, because you do have 95% of the pack, which is
> worth amortizing).
>
> I'm still a little dubious that anything involving "send all the hashes"
> is going to be useful in practice, especially for something like the
> kernel (where you have tons of huge small objects that delta well). It
> would work better when you have gigantic objects that don't delta (so
> the cost of a sha1 versus the object size is way better), but then I
> think we'd do better to transfer all of the normal-sized bits up front,
> and then allow fetching the large stuff separately.
>
> -Peff
>


In case if we can have object-lookup-db like provisioning with stored 
information like SHA-1, type of object, parent if any, size of that 
object, as in entire hierarchy tree without data like commit message, 
tag name. This implementation may be look as bit duplication of existing 
information.

At initial clone time server sends object-lookup-db to client and then, 
by reading object-lookup-db client sends SHA1 to server to get/fecth 
objects, it can be got in parallel, as well. This process may not be 
transfer efficient but it can be resumable, as client knows what got 
sync and what's remain and which SHA1 refers to what object type.
