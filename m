From: Sam Vilain <sam@vilain.net>
Subject: Re: weaning distributions off tarballs: extended verification of
 git tags
Date: Mon, 02 Mar 2015 12:52:09 -0800
Message-ID: <54F4CD79.4080209@vilain.net>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com> <CANv4PNmF9sTh8od9xT5tYTOF1Cv0Mev2Muf-qxQDS_6kE7EnOw@mail.gmail.com> <1425316197.895196.234425829.536E6C06@webmail.messagingengine.com> <20150302181230.GA31798@kitenet.net> <54F4BC18.5060702@vilain.net> <xmqqwq2z9n7c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joey Hess <id@joeyh.name>, GIT Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 21:52:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSXK7-0000UI-GC
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 21:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbbCBUwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 15:52:15 -0500
Received: from tx.vilain.net ([74.50.57.245]:42455 "EHLO tx.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754977AbbCBUwM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 15:52:12 -0500
Received: from [10.133.246.91] (unknown [38.104.194.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by tx.vilain.net (Postfix) with ESMTPSA id 07C33843C;
	Mon,  2 Mar 2015 20:52:10 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <xmqqwq2z9n7c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264625>

On 03/02/2015 12:08 PM, Junio C Hamano wrote:
>> I have a
>> hazy recollection of what it would take to replace SHA-1 in git with
>> something else; it should be possible (though tricky) to do it lazily,
>> where a tree entry has bits (eg, some of the currently unused file
>> mode bits) to denotes which hash algorithm is in use for the entry.
>> However I don't think that got past idea stage...
> I think one reason why it didn't was because it would not work well.
> That "bit that tells this is a new object or old" would mean that a
> single tree can have many different object names, depending on which
> of its component entries are using that bit and which aren't.  There
> goes the "we know two trees with the same object name are identical
> without recursing into them" optimization out the window.
>
> Also it would make it impossible to do what you suggest to Joey to
> do, i.e. "exactly the same way that git does", once you start saying
> that a tree object can be encoded in more than one different ways,
> wouldn't it?

I was reasoning that people would rather not have to rewrite their whole 
history in order to switch checksum algorithms, and that by allowing 
trees to be lazily converted that this would make things more 
efficient.  However, I think I see your point here that this doesn't work.

However, as a per-commit header, then only first commit which changes 
the hashing algorithm would have to re-checksum each of the files: but 
just in the current tree, not all the way back to the beginning of 
history.  The delta logic should not have to care, and these objects 
with the same content but different object ID should pack perfectly, so 
long as git-pack-objects knows to re-checksum objects with the available 
hash algorithms and spot matches.

Other operations like diff which span commit hashing algorithms might be 
able to get away with their existing object ranking algorithms and cache 
alternate object IDs for content as they operate to facilitate exact 
matching across hash algorithm changes.

But actually, for the original problem - just producing a signature with 
a different hashing algorithm - probably it would be sufficient to just 
re-hash the current commit and the current tree recursively, and the 
mixed hash-algorithm case does not need to exist.  But I'm just thinking 
it might not be too hard to make git nicely generic, to be well prepared 
for when a second pre-image attack on SHA-1 becomes practical.

Sam
