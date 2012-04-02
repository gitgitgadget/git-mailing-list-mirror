From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Tue, 03 Apr 2012 00:20:48 +0100
Message-ID: <4F7A3450.7000302@pileofstuff.org>
References: <11292500.AVmZFUUvNi@flobuntu> <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com> <2148933.pnpYo0xMAP@flomedio> <2487557.B8qfnaixh3@flomedio> <4F7A258C.5000200@pileofstuff.org> <20120402222958.GD13969@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Florian Achleitner <florian.achleitner@student.tugraz.at>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 01:20:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEqYU-0001y4-Dd
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 01:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab2DBXUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 19:20:54 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:5398 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751548Ab2DBXUx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 19:20:53 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120402232051.WJZ18388.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Tue, 3 Apr 2012 00:20:51 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120402232050.KXWW23925.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>;
          Tue, 3 Apr 2012 00:20:50 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <20120402222958.GD13969@burratino>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=Hd5Tmzg1rDkA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=dRiOB2z9pnJ3xSgKBWoA:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194579>

On 02/04/12 23:29, Jonathan Nieder wrote:
> Hi Andrew,
> 
> Andrew Sayers wrote:
>> On 02/04/12 09:30, Florian Achleitner wrote:
> 
>>> The remote helper has to convert the foreign protocol and data (svn) to the 
>>> git-fast-import format.
>>
>> As discussed on IRC, I'd like to see some discussion of solutions that
>> use plumbing directly (e.g. git-commit-tree) if you choose to focus on
>> branch import.
> 
> Do you mean that fast-import is not a plumbing command?

Sorry, that wasn't clear.  I meant commands that just expose a single
primitive bit of functionality (like git-commit-tree) instead of those
that present an abstract interface to the whole git machinery (like
git-fast-import).  I'm not sure what the right word for that would be?

I agree it's possible to use fast-import for this problem, but it seems
like it's redundant after svn-fe has already loaded everything into git.
 For example, if svn-fe loaded three revisions into the master branch,
you could create a trunk branch by doing something like:

COMMIT=$( git show -s --pretty=%b master^^ | \
          git commit-tree master^^:trunk )
COMMIT=$( git show -s --pretty=%b master^ | \
          git commit-tree master^:trunk -p $COMMIT )
COMMIT=$( git show -s --pretty=%b master | \
          git commit-tree master:trunk -p $COMMIT )
echo $COMMIT > .git/refs/heads/foo

The point I was making in IRC was that (so far as I understand)
fast-import doesn't let you pass trees around in this way, but instead
requires you to transmit the contents of all the changed files.

The code above could of course be achieved more easily with
git-filter-branch, or achieved more efficiently with a custom bit of C.
 I suggested discussing the problem in terms of single-purpose commands
because it strikes me as about the right level to expose the
architectural questions without getting bogged down in detail.

	- Andrew
