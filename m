From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git mergetool: Don't repeat merge tool candidates
Date: Fri, 23 Jan 2009 14:10:48 -0800
Message-ID: <7vpridr7vb.fsf@gitster.siamese.dyndns.org>
References: <7v7i4m1lq4.fsf@gitster.siamese.dyndns.org>
 <1232702093-24313-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tytso@mit.edu
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:12:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQUGD-0006vF-Bj
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 23:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668AbZAWWK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 17:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756444AbZAWWK5
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 17:10:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500AbZAWWK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 17:10:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 496D41D04C;
	Fri, 23 Jan 2009 17:10:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1BE2F1CFA2; Fri,
 23 Jan 2009 17:10:49 -0500 (EST)
In-Reply-To: <1232702093-24313-1-git-send-email-heipei@hackvalue.de>
 (Johannes Gilger's message of "Fri, 23 Jan 2009 10:14:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B476711E-E99A-11DD-B820-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106922>

Johannes Gilger <heipei@hackvalue.de> writes:

> git mergetool listed some candidates for mergetools twice, depending on
> the environment.
>
> Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
> ---
> The first patch had the fatal flaw that it listed nothing when DISPLAY 
> and EDITOR/VISUAL were unset, we fixed that.
> The order in which merge-candidates appear is still exactly the same, 
> only duplicates have been stripped. The check for KDE_FULL_SESSION was 
> removed since kdiff3 was added as long as DISPLAY was set and we weren't 
> running gnome.

The old code produced this:

   DISPLAY set
   | GNOME_DESKTOP_SESSION_ID set
   | | KDE_FULL_SESSION true
   | | |
   - - - (editor)
   - - + (editor)
   - + - (editor)
   - + + (editor)
   + - - kdiff3 tkdiff xxdiff meld gvimdiff (editor)
   + - + kdiff3 kdiff3 tkdiff xxdiff meld gvimdiff (editor)
   + + - meld kdiff3 tkdiff xxdiff meld gvimdiff (editor)
   + + + kdiff3 meld kdiff3 tkdiff xxdiff meld gvimdiff (editor)

where (editor) lists emerge or vimdiff if the preferred editor was emacs
or vim, and then opendiff, and then emerge and vimdiff as fallback
duplicates.

Looking at what the new code does for the (editor) fallback part first:

   if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
       merge_tool_candidates="$merge_tool_candidates emerge opendiff vimdiff"
   fi
   if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
       merge_tool_candidates="$merge_tool_candidates vimdiff opendiff emerge"
   fi
   if test -z "$merge_tool_candidates" ; then
       merge_tool_candidates="opendiff emerge vimdiff"
   fi

I think it is better to rewrite this part for clarity:

    if EDITOR is emacs?
    then
    	append emerge opendiff vimdiff in this order
    elif EDITOR is vim?
    then
    	append vimdiff opendiff emerge in this order
    else
    	append opendiff emerge vimdiff in this order
    fi

because emacs and vim cannot be set to EDITOR at the same time
(note that I think this also fixes a bug; see below).

>      if test -n "$DISPLAY"; then
>          if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
> +            merge_tool_candidates="meld kdiff3 tkdiff xxdiff gvimdiff"
> +        else
> +            merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
>          fi
>      fi

This one produces:

   DISPLAY set
   | GNOME_DESKTOP_SESSION_ID set
   | | KDE_FULL_SESSION true
   | | |
   - - - (editor)
   - - + (editor)
   - + - (editor)
   - + + (editor)
   + - - kdiff3 tkdiff xxdiff meld gvimdiff (editor')
   + - + kdiff3 tkdiff xxdiff meld gvimdiff (editor')
   + + - meld kdiff3 tkdiff xxdiff gvimdiff (editor')
   + + + meld kdiff3 tkdiff xxdiff gvimdiff (editor')

where "(editor')" is empty if your EDITOR is not emacs nor vim.

The original list with the duplicates removed is:

   DISPLAY set
   | GNOME_DESKTOP_SESSION_ID set
   | | KDE_FULL_SESSION true
   | | |
   - - - (editor)
   - - + (editor)
   - + - (editor)
   - + + (editor)
   + - - kdiff3 tkdiff xxdiff meld gvimdiff (editor)
   + - + kdiff3 tkdiff xxdiff meld gvimdiff (editor)
   + + - meld kdiff3 tkdiff xxdiff gvimdiff (editor)
   + + + kdiff3 meld tkdiff xxdiff gvimdiff (editor)

Aside from the "(editor') is empty when DISPLAY is set" difference, the
result is also different iff GNOME_DESKTOP_SESSION_ID and KDE_FULL_SESSION
are both set.  I am guessing that that does not happen in a sane
environment, though.
