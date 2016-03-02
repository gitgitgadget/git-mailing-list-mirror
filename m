From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resumable git clone?
Date: Wed, 02 Mar 2016 00:31:16 -0800
Message-ID: <xmqq4mcp5lij.fsf@gitster.mtv.corp.google.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
	<CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
	<20160302023024.GG17997@ZenIV.linux.org.uk>
	<xmqq8u215r25.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DcNrOmrKKPibV6GuSqspovBmHzUv_mRB6fZyLjw5wWzQ@mail.gmail.com>
	<20160302075437.GA8024@x>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:31:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab2Bp-0006Di-Hn
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 09:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbcCBIbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 03:31:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750977AbcCBIbV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 03:31:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2AA24408C6;
	Wed,  2 Mar 2016 03:31:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/kjgndrCof+Bj7weAQ87L5+wXxU=; b=fV8FS1
	tJV9jNaW5d2Zjtq3wYPD/zqyULA5StV++LPT9hEA+4UdLb3t/Tzpn5AtFYyimZHl
	QEdGnWyEH1W9BWDdcbz69mls8GPlJGW5F3dJKhQO9pcQvk5TUKDt1i4duTXHRcOq
	ZKTNz5kOsfHxom8bJ6U4gd7AxHOT8rqtdfvdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EEzEKZ4+Es0bHYgjoMAcB+z/UAmzMK6/
	Xuilyfj7DtzYNGUecj5xQOdymvCdrQi3XGsqiFSuvZezam9x6q25J9t0BVvSR8it
	wr+wlXLXU/nST8dYs6U2SuTpjrSanlDpTBFG67pQaBW47Ou8999DbOdV++Ul/REF
	9b1PVyXGS2c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 202B1408C5;
	Wed,  2 Mar 2016 03:31:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 18842408C4;
	Wed,  2 Mar 2016 03:31:18 -0500 (EST)
In-Reply-To: <20160302075437.GA8024@x> (Josh Triplett's message of "Tue, 1 Mar
	2016 23:54:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2298CB60-E051-11E5-944B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288106>

Josh Triplett <josh@joshtriplett.org> writes:

> I don't think it's worth the trouble and ambiguity to send abbreviated
> object names over the wire.  

Yup.  My unscientific experiment was to show that the list would be
far smaller than the actual transfer and between full binary and
full textual object name representations there would not be much
meaningful difference--you seem to have a better design sense to
grasp that point ;-)

> I think several simpler optimizations seem
> preferable, such as binary object names, and abbreviating complete
> object sets ("I have these commits/trees and everything they need
> recursively; I also have this stack of random objects.").

Given the way pack stream is organized (i.e. commits first and then
trees and blobs that belong to the same delta chain together), and
our assumed goal being to salvage objects from an interrupted
transfer of a packfile, you are unlikely to ever see "I have these
commits/trees and everything they need" that are salvaged from such
a failed transfer.  So I doubt such an optimization is worth doing.

Besides it is very expensive to compute (the computation is done on
the client side, so the cycles burned and the time the user has to
wait is of much less concern, though); you'd essentially be doing
"git fsck" to find the "dangling" objects.

The list of what would be transferred needs to come in full from the
server end, as the list names objects that the receiving end may not
have seen, but the response by the client could be encoded much
tightly.  For the full list of N objects from the server, we can
think of your response to be a bitstream of N bits, each on-bit in
which signals an unwanted object in the list.  You can optimize this
transfer by RLE compressing the bitstream, for example.

As git-over-HTTP is stateless, however, you cannot assume that the
server side remembers what it sent to the client (instead, the
client side needs to re-post what it heard from the server in the
previous exchange to allow the server side to use it after
validating).  So "objects at these indices in your list" kind of
optimization may not work very well in that environment.  I'd
imagine that an exchange of "Here are the list of objects", "Give me
these objects" done naively in full 40-hex object names would work
OK there, though.
