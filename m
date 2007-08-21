From: Junio C Hamano <gitster@pobox.com>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 19:06:27 -0700
Message-ID: <7vejhxproc.fsf@gitster.siamese.dyndns.org>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
	<20070820174142.GA7943@glandium.org>
	<867inqhyuk.fsf@lola.quinscape.zz>
	<20070820181357.GA8264@glandium.org>
	<86zm0mgicy.fsf@lola.quinscape.zz>
	<20070820184829.GA8617@glandium.org> <853ayeos82.fsf@lola.goethe.zz>
	<20070820205042.GB10173@glandium.org>
	<20070821013541.GC27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 04:06:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INJ8h-0003x9-3w
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 04:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbXHUCGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 22:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbXHUCGe
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 22:06:34 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbXHUCGd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 22:06:33 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FF0F124F5B;
	Mon, 20 Aug 2007 22:06:50 -0400 (EDT)
In-Reply-To: <20070821013541.GC27913@spearce.org> (Shawn O. Pearce's message
	of "Mon, 20 Aug 2007 21:35:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56272>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Mike Hommey <mh@glandium.org> wrote:
>> > >> > sprintf "%06o %s\0%s", $mode, $file, pack("H[40]", $sha1)
>> 
>> The question here was why the permissions are encoded with "%06o" while
>> the hash is packed. Anyways, it's just a boring detail.
>
> Because text format is simple and pretty much everyone understands
> it, especially when you are talking about UNIX mode/permission
> bits in octal, the name is "text", and then oh, wait, those 40
> bytes of hex is a lot of data - we'll just make that 20 bytes of
> binary instead.  :-)

That is almost true, but there is one factual error I need to
correct.

In-tree representation of the mode is not actually "%06o" but
just "%o".  In very early days of git, we used to have extra
leading "0" in trees (e.g. "040000"), but that is something
modern fsck even warns about.  IOW, it is not the norm.

It is represented as text because we _can_ add any number of
bits to the data later if we wanted to.  Basic tree objects that
contain only the kind of data we traditionally used will
continue to work, while trees that contain (yet to be invented)
new types that are represented with longer mode bits may of
course not be read by older tools.

On the other hand, by definition, SHA-1 is 20-bytes.  If we
wanted to be able to replace hash function, we _could_ have done
hashtype + length + data format (and length is represented with
either text or "7-bit-per-byte plus stop bit" format as in the
pack format), but there was no reason to.

The same logic applies to the loose object header -- length is
not "network byte order 4-byte integer" (or 8-byte), but just a
textual representation of an unsigned integer of unspecified
length.  The current code happen to use "%lu" with ulong only
because that is the largest integral type that can be used
portably and is not cumbersome to use.  On future architectures
with larger word size, we do not have to update the data
structure definition nor even the code to read and write loose
objects.  Using a blob that is longer than 2^64 bytes may or may
not be possible depending on how long your ulong is, of course.
