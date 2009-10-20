From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git hang with corrupted .pack
Date: Tue, 20 Oct 2009 09:52:46 -0700
Message-ID: <7viqeaovmp.fsf@alter.siamese.dyndns.org>
References: <20091014042249.GA5250@hexapodia.org>
 <20091014142351.GI9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:53:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0HxM-0002RJ-2V
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 18:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbZJTQw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 12:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbZJTQw5
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 12:52:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZJTQw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 12:52:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D6BD47E2E8;
	Tue, 20 Oct 2009 12:53:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yZged9nad52rI7qC254dd8yDpAQ=; b=NtFlBB
	RfkfOn1QjVNlVrFSE9kaCDWLUv3SJc3Dnthok4PZdBPJK8OU+0g1umF8zYafB+Zt
	/xYDf+uBfmmh4vR833iwikRIrV8KOZIbKj6jAb9NUep08l3zBc8q4k1C+GW0sc41
	3ioNh3k/4rGaVyL4IacjRw74NqwM58c6sa8pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nbCAA0FCiQ3MDFeHOnJu5r0Ewc4wERy5
	4kh4gh8cDYtgeH4hnFkPv94UdeOFTg3aF7+WR1L0aHog5sqzPhQSyypLSYuFxLnd
	W3jw50NDld9hGVZg7sPyadBB8CSg7rsRMbalmsSiNI+WnDrtFXTypw2h/dde6m9f
	QPqLQ0eUb7w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 958887E2E7;
	Tue, 20 Oct 2009 12:52:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6674B7E2E6; Tue, 20 Oct 2009
 12:52:48 -0400 (EDT)
In-Reply-To: <20091014142351.GI9261@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 14 Oct 2009 07\:23\:51 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 039727A2-BD99-11DE-A858-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130812>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Z_BUF_ERROR is returned from inflate() if either the input buffer
> needs more input bytes, or the output buffer has run out of space.
> Previously we only considered the former case, as it meant we needed
> to move the stream's input buffer to the next window in the pack.
>
> We now abort the loop if inflate() returns Z_BUF_ERROR without
> consuming the entire input buffer it was given, or has filled
> the entire output buffer but has not yet returned Z_STREAM_END.
> Either state is a clear indicator that this loop is not working
> as expected, and should not continue.

When the inflated contents is of size 0, avail_out would be 0 and avail_in
would still have something because the input stream needs to have the end
of stream marker that is more than zero byte long.

If that is more than one-byte long, and your avail_in originally fed only
the first byte from that sequence, what happens?  Wouldn't inflate eat all
what was given (now avail_in is zero), updated its internal state but it
still hasn't produced anything (avail_out is zero)?

I am not saying the end-of-stream is more than one-byte long (I didn't
check), but we had a similar bug arising from confusing "no more output
data" and "fully consumed input stream" (e.g. 456cdf6 (Fix loose object
uncompression check., 2007-03-19).

Something like that may be what is happening to cause problem Alex is
seeing.

I think the corrupt packdata detection needs an output buffer at least
one-byte larger than what is needed to store the correct result.  Then
when we get BUF_ERROR:

 - We never look at avail to see if it is zero; !avail_out is not the same
   as "it stopped because it ran out of output space".  It might mean
   "there is nothing more to come but the input stream ended before
   signalling that fact to the inflate engine fully".

 - We do look at avail_out to find how much data we ended up getting.  If
   inflate has consumed more buffer than we planned to give it, the stream
   is corrupt (at least it is not what we expected to see);

>  		st = git_inflate(&stream, Z_FINISH);
> +		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
> +			break;
>  		curpos += stream.next_in - in;
>  	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
>  		 stream.total_out < sizeof(delta_head));
> @@ -1594,6 +1596,8 @@ static void *unpack_compressed_entry(struct packed_git *p,
>  		in = use_pack(p, w_curs, curpos, &stream.avail_in);
>  		stream.next_in = in;
>  		st = git_inflate(&stream, Z_FINISH);
> +		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
> +			break;
>  		curpos += stream.next_in - in;
>  	} while (st == Z_OK || st == Z_BUF_ERROR);
>  	git_inflate_end(&stream);
> -- 
> 1.6.5.52.g0ff2e
>
> -- 
> Shawn.
