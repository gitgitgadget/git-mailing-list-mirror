From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 13:28:44 +0200
Message-ID: <vpq8xbnlmdv.fsf@bauges.imag.fr>
References: <20070515201006.GD3653@efreet.light.src>
	<46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
	<Pine.LNX.4.64.0705161232120.6410@racer.site>
	<46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
	<Pine.LNX.4.64.0705170152470.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 13:29:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoeAK-0007cb-Ct
	for gcvg-git@gmane.org; Thu, 17 May 2007 13:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbXEQL27 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 07:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbXEQL27
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 07:28:59 -0400
Received: from imag.imag.fr ([129.88.30.1]:61817 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754498AbXEQL26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 07:28:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4HBSiMt025535
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 17 May 2007 13:28:44 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HoeA0-0007v3-Em; Thu, 17 May 2007 13:28:44 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HoeA0-00079G-Bh; Thu, 17 May 2007 13:28:44 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0705170152470.6410@racer.site> (Johannes Schindelin's message of "Thu\, 17 May 2007 01\:52\:55 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 17 May 2007 13:28:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47512>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 17 May 2007, Martin Langhoff wrote:
>
>> On 5/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> > On Wed, 16 May 2007, Martin Langhoff wrote:
>> > > Do the indexes have enough info to use them with http ranges? It'd be
>> > > chunkier than a smart protocol, but it'd still work with dumb servers.
>> > It would not be really performant, would it? Besides, not all Web servers
>> > speak HTTP/1.1...
>> 
>> Performant compared to downloading a huge packfile to get 10% of it?
>> Sure! It'd probably take a few trips, and you'd end up fetching 20% of
>> the file, still better than 100%.
>
> Don't forget that those 10% probably do not do you the favour to be in 
> large chunks. Chances are that _every_ _single_ wanted object is separate 
> from the others.

FYI, bzr uses HTTP range requests, and the introduction of this
feature lead to significant performance improvement for them (bzr is
more dumb-protocol oriented than git is, so that's really important
there). They have this "index file+data file" system too, so you
download the full index file, and then send an HTTP range request to
get only the relevant parts of the data file.

The thing is, AAUI, they don't send N range requests to get N chunks,
but one HTTP request, requesting the N ranges at a time, and get the N
chunks a a whole (IIRC, a kind of MIME-encoded response from the
server). So, you pay the price of a longer HTTP request, but not the
price of N networks round-trips.

That's surely not as efficient as anything smart on the server, but
might really help for the cases where the server is /not/ smart.

-- 
Matthieu
