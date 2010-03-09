From: Junio C Hamano <gitster@pobox.com>
Subject: Re: using gvim as editor on Windows
Date: Tue, 09 Mar 2010 12:07:13 -0800
Message-ID: <7vzl2hw972.fsf@alter.siamese.dyndns.org>
References: <20100306070628.GM2480@ece.pdx.edu>
 <201003061317.38422.markus.heidelberg@web.de>
 <20100308185439.GO2480@ece.pdx.edu>
 <201003090032.10037.markus.heidelberg@web.de>
 <20100309024523.GU2480@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>, git@vger.kernel.org
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 21:08:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np5iJ-0000A0-CX
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 21:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074Ab0CIUH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 15:07:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab0CIUH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 15:07:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C5F9A0D51;
	Tue,  9 Mar 2010 15:07:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=GBo3E+Dr/YIJHpQAfp4Goxfuy8U=; b=MqVCD/HaG20k5u6JZQj6rzu
	/ogcB25rQWJzOJvix0GU58PNzrXikLnK2qd4K8DLWVXHauu6zWG1Wvuv0ARJbdN9
	kwLpYotSfZVqj1SR1tvQ6fLl1zolQEAtbCsjPAG040d3dHS7iAmpIBoKjcYMWudD
	cG8QbwheHI6SgIIUuu8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=GZ+PbC0Ew0EnV+radXddgfSe3BcWX7so3eGp5dfkMRrCudHkk
	d8gDfu4gUYiALYiw3Yy9RWwVUQtLrMSYdjJlgaenGqfxlZ2t4S8y6zt3rfD2pzpt
	ksUoaHp9QwQi7vTuMqdQQdKAh9+eCm2RerJlmna2y56tSDXHE5L2p0f7wc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 27F7EA0D50;
	Tue,  9 Mar 2010 15:07:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6649DA0D4D; Tue,  9 Mar
 2010 15:07:14 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5CDB97EE-2BB7-11DF-B0C3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141846>

Tait <git.git@t41t.com> writes:

> It comes from line 33 of editor.c, in launch_editor().
> if (strcmp(editor, ":")) {

This says "if 'editor' is not exactly the string ':'", then come into this
block.  If you set editor to ":abc", or "c:\path to\my editor.exe", they
are not "exactly the string ':'" and the codepath inside will be executed.

> ... I'm not familiar with the EDITOR=:
> convention. What is that supposed to indicate?

Literally, it means "run ':' command as the editor".  ':' command takes
and ignores arbitrary arguments and returns success without doing
anything.  As such, the codepath pretends that it ran ':' command without
actually running it, and returns as if it ran ':' command that left the
input file given as its argument unmodified.

> Can we narrow the
> detection to that specific case, or does a : anywhere in EDITOR need
> to be handled this way?

No, and the if statement is already narrow enough.  I think the problem is
that you have a broken shell ("sh").

    /* ... */
    if (strcspn(editor, "$ \t'") != len) {
        /* there are specials */
        strbuf_addf(&arg0, "%s \"$@\"", editor);
        args[i++] = "sh";
        args[i++] = "-c";
        args[i++] = arg0.buf;
    }
    args[i++] = editor;
    args[i++] = path;
    args[i] = NULL;
    /* ... */


If you have editor='"c:\some path\editor" -f', strcspn() notices that you have a
funny character in the path, and creates this string in arg0:

    "c:\some path\editor" -f "$@"

and feeds '-c', the above arg0, editor, and finally the name of the file,
to your shell; it is the same as running this from the command line:

    sh -c '"c:\some path\editor" -f "$@"' '"c:\some path\editor" -f' path-to-file

Now shell is supposed to expand "$@" into positional parameters, i.e. $1
(in this case, path-to-file) and run the named editor with it, IOW, your
editor program should see "-f" as its first parameter, and path-to-file as
its second parameter (and argv[] is terminated with NULL after that).

If you end up with a file whose name literally is '$@', that probably
means your "sh" did not expand it correctly.
