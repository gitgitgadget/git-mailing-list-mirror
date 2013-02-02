From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Sat, 02 Feb 2013 09:49:01 -0800
Message-ID: <7vfw1ebo8i.fsf@alter.siamese.dyndns.org>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <7vy5fbq48t.fsf@alter.siamese.dyndns.org>
 <7vtxpzq2uv.fsf@alter.siamese.dyndns.org>
 <20130130071209.GD11147@sigill.intra.peff.net>
 <7vboc6mzpf.fsf@alter.siamese.dyndns.org>
 <CAJo=hJv0aqLpitnRJ6WKdPCETT6YgX5Njpv44DAYUg_KALhf=g@mail.gmail.com>
 <20130201094237.GE30644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 18:49:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1hDd-000170-Nc
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 18:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757766Ab3BBRtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 12:49:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60741 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757137Ab3BBRtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 12:49:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9954CBB99;
	Sat,  2 Feb 2013 12:49:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=DCCDdiSn/tqBQinmEd01TouBrug=; b=rFcFT/DgzRZMyzXXhMWy
	rg6USItKgXATqfeyVoUlLJMKw+zjYelfSga04t1L9490G+2HoNk7tg5xX+jm233v
	qUTe3WeI150aNGpATKaKtYbsVxtB2pzSkcwp8uYMPb3pq51WzbWGv4XBpIG1iiUg
	Hw52+PgKU23UZzC2+Z3r3mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=rI7IkYkdPmG9fdwBU8UwaqHIksu9jADJb+6fAmQ/ZgUJgI
	FTNq42QqdgQrmPdpoFAtrcDM2IKT85zrSj42otcXdrQKnInMSMV0Jrdbjv8iwZZc
	kZJhzwhBLUu15KPN2mOuBfP2Wr+OqEuAJqN8tpI0kKSsX2uQLryEVGAkgr6Is=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EE0BBB98;
	Sat,  2 Feb 2013 12:49:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3E6BBB97; Sat,  2 Feb 2013
 12:49:02 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4DCF1AA-6D60-11E2-8F21-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215290>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 31, 2013 at 09:03:26AM -0800, Shawn O. Pearce wrote:
> ...
>> If we are going to change the index to support extension sections and
>> I have to modify JGit to grok this new format, it needs to be index v3
>> not index v2. If we are making index v3 we should just put index v3 on
>> the end of the pack file.
>
> I'm not sure what you mean by your last sentence here.

I am not Shawn, but here is a summary of what I think I discussed
with him in person, lest I forget.

You could imagine that a new pack system (from pack-objects,
index-pack down to read_packed_sha1() call) that works with a
packfile that

 * is a single file, whose name is pack-$SHA1.$sfx (where $sfx
   is something other than 'pack', perhaps);

 * has the pack data stream, including the concluding checksum of
   the stream contents at the end, at the beginning of the file; and

 * has the index v3 data blob appended to the pack data stream.

The pack data is streamed over the wire exactly the same way,
interoperating with existing software.  When receiving, the new
index-pack can read such a pack stream and add index at the end.
When re-indexing an existing pack (think: upgrading existing
packfiles from the current system), the index-pack can read from the
packfile and do what it does currently (notably, it knows where the
pack stream ends and can stop reading at that point, so even if you
feed the new pack to it, it will stop at the end of the pack data,
ignoring the index v3 already at the end of the input).

One potential advantage of using a single file, instead of the
primary .pack file with 3 (or 47) auxiliary files, is that it lets
you repack without having to deal with this sequence, which happens
currently when you repack:

 * create a new .pack file and the corresponding auxiliary files
   under temporary filename;

 * move existing pack files that describe the same set of objects
   away;

 * rename these new files, one at a time, to their final name,
   making sure that you rename .idx the last, because that happens
   to be the key to the pack aware programs.

Instead you can rename only one thing (the new one) to the final
name (possibly atomically replacing the existing one).  With the
current system, when you need to replace a pack with a new pack with
the same packname (e.g. you repack everything with a better pack
parameter in a repository that has everything packed into one),
there is a very small window other concurrent users will not find
the object data between the time when you rename the old ones away
and the time when you move the new ones in.  The hairly logic
between "Ok we have prepared all new packfiles" and "End of pack
replacement" can be done with a single rename(2) of the new packfile
(which contains everything) to the final name, which atomically
replaces the old one.

This will become even safer if we picked $SHA1 (the name of the
packfile) to represent the hash of the whole thing, not the hash of
the sorted object names in the pack, as that will let us know there
is no need to even "replace" the files.
