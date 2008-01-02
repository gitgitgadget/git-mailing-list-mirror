From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] fix "git diff" to create wrong UTF-8 text
Date: Tue, 01 Jan 2008 21:26:54 -0800
Message-ID: <7v1w904x29.fsf@gitster.siamese.dyndns.org>
References: <20080102.082014.02281301.tshibata@ab.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tsugikazu Shibata <tshibata@ab.jp.nec.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 06:27:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9w8Z-0008RJ-QV
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 06:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbYABF1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 00:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYABF1D
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 00:27:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbYABF1C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 00:27:02 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E09DB955A;
	Wed,  2 Jan 2008 00:26:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FE609559;
	Wed,  2 Jan 2008 00:26:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69455>

Tsugikazu Shibata <tshibata@ab.jp.nec.com> writes:

> I believe this should be work for another language using UTF-8 and
> solve this issue.
> ...
> @@ -368,6 +394,7 @@ int xdl_emit_hunk_hdr(long s1, long c1,
>  		buf[nb++] = ' ';
>  		if (funclen > sizeof(buf) - nb - 1)
>  			funclen = sizeof(buf) - nb - 1;
> +		funclen = utf8width(func, funclen);
>  		memcpy(buf + nb, func, funclen);
>  		nb += funclen;
>  	}

I'd rather not do this in xdiff/ level for two reasons.

We consider the functions there strictly "borrowed code", and
ideally I'd rather even not to have that "chop down to funclen"
logic at that level.

The code at that level does not know what paths it is dealing
with and cannot consult git specific data (i.e. attributes); it
would make it harder to enhance it later by introducing per-path
encoding information.

How about...

 * (optional) lift the funclen limit from xdl_emit_hunk_hdr()
   and xdl_emit_diff() and have them preserve the full line;

 * Around ll.554 in diff.c::fn_out_consume(), look at
   line[i..eol] and apply the "chomp between character" logic
   there.  I think it is very sensible to use the UTF-8 logic by
   default as you did above (but I suspect you may be able to
   reuse helper functions in utf8.c such as git_wcwidth(),
   instead of rolling your own).  Chomp the funcname line given
   from xdiff layer in this function.

 * (future) make the length of the funcname line configurable
   either from the command line or configuration.

 * (future) add per-path blob encoding information (default to
   UTF-8) to struct emit_callback, and initialize it from the
   gitattributes(5) mechanism, just like we have added ws_rule
   recently there.  Use that to decide how inter-character chomp
   works to customize the logic in diff.c::fn_out_consume() you
   would introduce above.

I think the two future enhancements I listed above as examples
would be cleaner to implement if the line chomping is done in
fn_out_consume().
