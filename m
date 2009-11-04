From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Tue, 03 Nov 2009 17:07:52 -0800
Message-ID: <7vljinnllj.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
 <7v4opbp1fa.fsf@alter.siamese.dyndns.org>
 <20091104005614.GD10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 02:08:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5UM4-0004Ny-TA
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 02:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbZKDBH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 20:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbZKDBH5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 20:07:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbZKDBH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 20:07:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 309D39167A;
	Tue,  3 Nov 2009 20:08:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hxw32g9Xe9UPPg6795iZpD5hSis=; b=IatABA
	zwl272HytYpm2cjF49UImPF2i5NXQ9bfs8kjhj4hFHNt9VLR5jqPdTj77xokzJDE
	tVpdlAaiUOHfBp/58bXN0PzBS0zQ9PD4qmV54EYTJIrxLiefoLpKRyddyd6/+zWN
	kXrqPjKvU55VUuVqlH9qR190R3oUjnrkr7tss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GHUQS2uwUXbVXQpUqVDBidFuvRsUl/fx
	YEjBo0hmrjwZxYsOHQtsokjfPBzgNDi4F/XGnPpyd/d78IvjxIVNDsfrroy0iDfa
	84FOvaV4PNi6M2OJpncYiP/4Xh7WlZ3jbbfy0qWa3gp66lUfrNNPWAreaSrQFIr+
	G+x4iFu2Zz0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 691FB91679;
	Tue,  3 Nov 2009 20:07:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1837991678; Tue,  3 Nov 2009
 20:07:53 -0500 (EST)
In-Reply-To: <20091104005614.GD10505@spearce.org> (Shawn O. Pearce's message
 of "Tue\, 3 Nov 2009 16\:56\:14 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7DA3F700-C8DE-11DE-92DE-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132016>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> > +A pkt-line with a length field of 0 ("0000"), called a flush-pkt,
>> > +is a special case and MUST be handled differently than an empty
>> > +pkt-line ("0004").
>> 
>> ...especially that this sentence makes it sound as if it is perfectly
>> normal to send "0004" for "an empty line" (and I've always thought that is
>> Ok), I am quite puzzled by that "SHOULD NOT".
>
> I don't think we ever send an empty packet.  If we have no data to
> send, why the hell did we create the packet header?

Oh, I do not disagree that it is pointless, but the example that followed
the part we are discussing also had "0004".  I think it is Ok to allow it.

The original intent of packet_flush() was that everything else could be
kept buffered in-core without going to write() until packet_flush() is
called.  The protocol was defined in a way that we won't wait for
listening a response from the other end to an earlier message we "sent"
with packet_write() but haven't called packet_flush() yet hence could
still be in our buffer.  We still have this comment:

    /*
     * If we buffered things up above (we don't, but we should),
     * we'd flush it here
     */
    void packet_flush(int fd)

And once we start buffering, allowing "0004" packet_write() wouldn't even
be a problem; it can be optimized out in the buffering layer.
