From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 10:35:50 -0700
Message-ID: <7vaa105dah.fsf@alter.siamese.dyndns.org>
References: <4FB9F92D.8000305@alum.mit.edu>
 <20120521174525.GA22643@sigill.intra.peff.net>
 <CACsJy8Dw+mbP+ttTP6gAfX9o4q4NyZgPYpbhS=tket=5fvBXwg@mail.gmail.com>
 <20120522170101.GA11600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 19:36:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWt04-0000ZE-9w
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 19:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759980Ab2EVRfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 13:35:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671Ab2EVRfy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 13:35:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C13B58C70;
	Tue, 22 May 2012 13:35:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TLc7CyRUBk7f9ImaY2k0jsoj4+U=; b=sgvL+N
	HAtc/2G2GITTApJh3fVVGZX+D4uidOIg9+JTXlk4DZKeTTvXVu8/UNkQBzV/LJcV
	B7MQfxccIHzCOW1TWqZD2hoDApkjwR1IEcWqFgkWrliWcCqY22co5am43DzRhuLm
	EuAJnSDLS2glEnYPkE9S3tTuMT9FI6Tnq8gHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S02XAOKmNHSjo6/qbYZjValYJmoDFCNQ
	grpq3nfhUXYLgDSmjH4TSEUx+mx37EBcGVvRH0iBiZXZQ5tEGTftkzWXTUSLxEle
	HTwj+Brj8iMcqe4Kb4LsoOOAZq1w6QwlnOx5bEV9/fkJyIhcLYnK5OkOM1DAJnNS
	KPv3BtTgCa0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B85F78C6F;
	Tue, 22 May 2012 13:35:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37D938C6C; Tue, 22 May 2012
 13:35:52 -0400 (EDT)
In-Reply-To: <20120522170101.GA11600@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 22 May 2012 13:01:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93C75F48-A434-11E1-817A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198212>

Jeff King <peff@peff.net> writes:

> On Tue, May 22, 2012 at 07:18:00PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Tue, May 22, 2012 at 12:45 AM, Jeff King <peff@peff.net> wrote:
>> > The rails/rails network repository at GitHub (i.e., a master repo with
>> > all of the objects and refs for all of the forks) has about 400K refs,
>> > and has been the usual impetus for me finding and fixing these sorts of
>> > quadratic problems.
>> 
>> Off topic and pure speculation. With 400k refs, each one 20 byte in
>> length, the pathname part only can take 7MB. Perhaps packed-refs
>> should learn prefix compressing too, like index v4, to reduce size
>> (and hopefully improve startup speed). Compressing refs/heads/ and
>> refs/tags/ only could gain quite a bit already.
>
> In this case, the packed-refs file is 30MB. Even just gzipping it takes
> it down to 2MB. As far as I know, we don't ever do random access on the
> file, but instead just stream it into memory.

True.

The current code reads the whole thing in upon first use of _any_ element
in the file, just like the index codepath does for the index file.

But the calling pattern to the refs machinery is fairly well isolated and
all happens in refs.c file.  Especially thanks to the recent work by
Michael Haggerty, for "I am about to create a new branch 'frotz'; do I
have 'refs/heads/frotz' or anything that begins with 'refs/heads/frotz/'?"
kind of callers, it is reasonably easy to design a better structured
packed-refs file format to allow us to read only a subtree portion of
refs/ hierarchy, and plug that logic into the lazy ref population code.
Such a "design a better packed-refs format for scalability to 400k refs"
is a very well isolated project that has high chance of succeeding without
breaking things.  No code outside refs.c assumes that there is a flat
array of refs that records what was read from the packed-refs file and can
walk linearly over it, unlike the in-core index.

If you do "for_each_ref()" for everything (e.g. sending 'have' during the
object transfer, or repacking the whole repository), you would end up
needing to read the whole thing for obvious reasons.
