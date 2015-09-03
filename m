From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-protocol: clarify LF-handling in PKT-LINE()
Date: Thu, 03 Sep 2015 15:19:53 -0700
Message-ID: <xmqqzj13gn7a.fsf@gitster.mtv.corp.google.com>
References: <20150903080205.GA20182@sigill.intra.peff.net>
	<20150903082409.GA20786@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Dave Borowitz <dborowitz@google.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 00:20:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcrP-0000Ex-Nf
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 00:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbbICWTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 18:19:55 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35498 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbbICWTy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 18:19:54 -0400
Received: by pacfv12 with SMTP id fv12so3198330pac.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=o+OCe274gZxx3MbjUzd8hdwY7HEVkfFC1sox8ME1qzw=;
        b=xQvwJo/Xd+hg4RYUCDOtFRzAbf+U6QdxAz3e/HLEXBxsQVb8MdNop6Npq0T6lKrm/t
         68kN8U1vyYtLjx5I7WYGbeaodVYkq2+lK/TnRtn6IYdhOSV1jaw9iyb0WnriavXgorA4
         8XZlE4oqc2ADROc1Pz9EtqTIKwFDO6GfuYegNRdfHoHS5ZyzS0Ivds8PGo5uZJkOaFA7
         zfEeuNJPUVCCPYGURPrYt7zetQQkJhqpcgzcymtwFyA+3NeGOBv0wco9wVgD3vzNfLJr
         9/+GB/oPN3ySZ2SGNy+xIQjScK4b99aIEWUc+qz0Rf4NTBuB9UGerPJo96AtvgkVCWLz
         K2og==
X-Received: by 10.68.197.65 with SMTP id is1mr451631pbc.109.1441318794314;
        Thu, 03 Sep 2015 15:19:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id au10sm138945pbd.81.2015.09.03.15.19.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 15:19:53 -0700 (PDT)
In-Reply-To: <20150903082409.GA20786@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 3 Sep 2015 04:24:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277275>

Jeff King <peff@peff.net> writes:

> Since the discussion seemed to end up in this "let's make PKT-LINE more
> clear" direction, here is an attempt to do that.

Ah, I was confused while reading the other one ;-)

Will queue this one instead.  Thanks.

> -- >8 --
> Subject: pack-protocol: clarify LF-handling in PKT-LINE()
>
> The spec is very inconsistent about which PKT-LINE() parts
> of the grammar include a LF. On top of that, the code is not
> consistent, either (e.g., send-pack does not put newlines
> into the ref-update commands it sends).
>
> Let's make explicit the long-standing expectation that we
> generally expect pkt-lines to end in a newline, but that
> receivers should be lenient. This makes the spec consistent,
> and matches what git already does (though it does not always
> fulfill the SHOULD).
>
> We do make an exception for the push-cert, where the
> receiving code is currently a bit pickier. This is a
> reasonable way to be, as the data needs to be byte-for-byte
> compatible with what was signed. We _could_ make up some
> rules about signing a canonicalized version including
> newlines, but that would require a code change, and is out
> of scope for this patch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/technical/pack-protocol.txt   | 46 ++++++++++++++++-------------
>  Documentation/technical/protocol-common.txt |  5 +++-
>  2 files changed, 30 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index 4064fc7..c6977bb 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -14,6 +14,14 @@ data.  The protocol functions to have a server tell a client what is
>  currently on the server, then for the two to negotiate the smallest amount
>  of data to send in order to fully update one or the other.
>  
> +pkt-line Format
> +---------------
> +
> +The descriptions below build on the pkt-line format described in
> +protocol-common.txt. When the grammar indicate `PKT-LINE(...)`, unless
> +otherwise noted the usual pkt-line LF rules apply: the sender SHOULD
> +include a LF, but the receiver MUST NOT complain if it is not present.
> +
>  Transports
>  ----------
>  There are three transports over which the packfile protocol is
> @@ -143,9 +151,6 @@ with the object name that each reference currently points to.
>     003fe92df48743b7bc7d26bcaabfddde0a1e20cae47c refs/tags/v1.0^{}
>     0000
>  
> -Server SHOULD terminate each non-flush line using LF ("\n") terminator;
> -client MUST NOT complain if there is no terminator.
> -
>  The returned response is a pkt-line stream describing each ref and
>  its current value.  The stream MUST be sorted by name according to
>  the C locale ordering.
> @@ -165,15 +170,15 @@ MUST peel the ref if it's an annotated tag.
>  		      flush-pkt
>  
>    no-refs          =  PKT-LINE(zero-id SP "capabilities^{}"
> -		      NUL capability-list LF)
> +		      NUL capability-list)
>  
>    list-of-refs     =  first-ref *other-ref
>    first-ref        =  PKT-LINE(obj-id SP refname
> -		      NUL capability-list LF)
> +		      NUL capability-list)
>  
>    other-ref        =  PKT-LINE(other-tip / other-peeled)
> -  other-tip        =  obj-id SP refname LF
> -  other-peeled     =  obj-id SP refname "^{}" LF
> +  other-tip        =  obj-id SP refname
> +  other-peeled     =  obj-id SP refname "^{}"
>  
>    shallow          =  PKT-LINE("shallow" SP obj-id)
>  
> @@ -216,8 +221,8 @@ out of what the server said it could do with the first 'want' line.
>  
>    depth-request     =  PKT-LINE("deepen" SP depth)
>  
> -  first-want        =  PKT-LINE("want" SP obj-id SP capability-list LF)
> -  additional-want   =  PKT-LINE("want" SP obj-id LF)
> +  first-want        =  PKT-LINE("want" SP obj-id SP capability-list)
> +  additional-want   =  PKT-LINE("want" SP obj-id)
>  
>    depth             =  1*DIGIT
>  ----
> @@ -284,7 +289,7 @@ so that there is always a block of 32 "in-flight on the wire" at a time.
>  		       compute-end
>  
>    have-list         =  *have-line
> -  have-line         =  PKT-LINE("have" SP obj-id LF)
> +  have-line         =  PKT-LINE("have" SP obj-id)
>    compute-end       =  flush-pkt / PKT-LINE("done")
>  ----
>  
> @@ -348,10 +353,10 @@ Then the server will start sending its packfile data.
>  
>  ----
>    server-response = *ack_multi ack / nak
> -  ack_multi       = PKT-LINE("ACK" SP obj-id ack_status LF)
> +  ack_multi       = PKT-LINE("ACK" SP obj-id ack_status)
>    ack_status      = "continue" / "common" / "ready"
> -  ack             = PKT-LINE("ACK SP obj-id LF)
> -  nak             = PKT-LINE("NAK" LF)
> +  ack             = PKT-LINE("ACK" SP obj-id)
> +  nak             = PKT-LINE("NAK")
>  ----
>  
>  A simple clone may look like this (with no 'have' lines):
> @@ -467,10 +472,10 @@ references.
>  ----
>    update-request    =  *shallow ( command-list | push-cert ) [packfile]
>  
> -  shallow           =  PKT-LINE("shallow" SP obj-id LF)
> +  shallow           =  PKT-LINE("shallow" SP obj-id)
>  
> -  command-list      =  PKT-LINE(command NUL capability-list LF)
> -		       *PKT-LINE(command LF)
> +  command-list      =  PKT-LINE(command NUL capability-list)
> +		       *PKT-LINE(command)
>  		       flush-pkt
>  
>    command           =  create / delete / update
> @@ -521,7 +526,8 @@ Push Certificate
>  
>  A push certificate begins with a set of header lines.  After the
>  header and an empty line, the protocol commands follow, one per
> -line.
> +line. Note that the the trailing LF in push-cert PKT-LINEs is _not_
> +optional; it must be present.
>  
>  Currently, the following header fields are defined:
>  
> @@ -560,12 +566,12 @@ update was successful, or 'ng [refname] [error]' if the update was not.
>  		      1*(command-status)
>  		      flush-pkt
>  
> -  unpack-status     = PKT-LINE("unpack" SP unpack-result LF)
> +  unpack-status     = PKT-LINE("unpack" SP unpack-result)
>    unpack-result     = "ok" / error-msg
>  
>    command-status    = command-ok / command-fail
> -  command-ok        = PKT-LINE("ok" SP refname LF)
> -  command-fail      = PKT-LINE("ng" SP refname SP error-msg LF)
> +  command-ok        = PKT-LINE("ok" SP refname)
> +  command-fail      = PKT-LINE("ng" SP refname SP error-msg)
>  
>    error-msg         = 1*(OCTECT) ; where not "ok"
>  ----
> diff --git a/Documentation/technical/protocol-common.txt b/Documentation/technical/protocol-common.txt
> index 889985f..bf30167 100644
> --- a/Documentation/technical/protocol-common.txt
> +++ b/Documentation/technical/protocol-common.txt
> @@ -62,7 +62,10 @@ A pkt-line MAY contain binary data, so implementors MUST ensure
>  pkt-line parsing/formatting routines are 8-bit clean.
>  
>  A non-binary line SHOULD BE terminated by an LF, which if present
> -MUST be included in the total length.
> +MUST be included in the total length. Receivers MUST treat pkt-lines
> +with non-binary data the same whether or not they contain the trailing
> +LF (stripping the LF if present, and not complaining when it is
> +missing).
>  
>  The maximum length of a pkt-line's data component is 65520 bytes.
>  Implementations MUST NOT send pkt-line whose length exceeds 65524
