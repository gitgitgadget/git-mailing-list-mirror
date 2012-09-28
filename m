From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: refresh the index before running diff-files
Date: Fri, 28 Sep 2012 14:40:46 -0700
Message-ID: <7vmx09keqp.fsf@alter.siamese.dyndns.org>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
 <20120928202330.GA5770@sigill.intra.peff.net>
 <20120928205054.GA5985@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Batchelor <scott.batchelor@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 23:41:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THiJ1-0001Wp-Mt
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 23:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032031Ab2I1Vky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 17:40:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032019Ab2I1Vkv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 17:40:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EF8182E7;
	Fri, 28 Sep 2012 17:40:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vgO7GhDRjMCeueJXvdU7HFG7zoE=; b=hAWABa
	X6QZDMw556fbpZjNOKjvPUG7Bm6XVnuEhbV/FuawNrNbfkNDcpb6sqxjQ26DqA+Y
	CRiU5rpaPMoaB5Yqn8gq7zrMjoBhJfjxF89o56IBb2QeN8n9B5Lq5zCl6kTu8pG6
	boycqQoTnuTIbb/Un8X3KUTI+i+KeiifPJmi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G5123Sl5XC0RheyoXQDOsQY97+BlFQdu
	KhVA3H7AIUo2gjnTzh2N2+FVXa58tzTw51PqSreoMri9gH+KrwO6MsnYiZ6wzYfb
	YybUGxXP4dU4uCHEz0jYT9qx8p8eLMKvxzq2ne41z/GZ5SVbjzJss7+qNBhzWDE/
	i/1z35aMsUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88A7F82DF;
	Fri, 28 Sep 2012 17:40:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFC5682DB; Fri, 28 Sep 2012
 17:40:47 -0400 (EDT)
In-Reply-To: <20120928205054.GA5985@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 28 Sep 2012 16:50:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A60CD96-09B5-11E2-933D-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206611>

Jeff King <peff@peff.net> writes:

> Potentially the "reload" command should reset the need_index_refresh
> flag, too.

Yeah, I think that is a sane enhancement to think about.

>  gitk | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/gitk b/gitk
> index 379582a..561be23 100755
> --- a/gitk
> +++ b/gitk
> @@ -5112,6 +5112,14 @@ proc dodiffindex {} {
>      filerun $fd [list readdiffindex $fd $lserial $i]
>  }
>  
> +proc refresh_index {} {
> +    global need_index_refresh
> +    if { $need_index_refresh } {
> +	exec sh -c "git update-index --refresh >/dev/null 2>&1 || true"
> +	set need_index_refresh false
> +    }
> +}
> +
>  proc readdiffindex {fd serial inst} {
>      global viewmainheadid nullid nullid2 curview commitinfo commitdata lserial
>      global vfilelimit
> @@ -5131,6 +5139,7 @@ proc readdiffindex {fd serial inst} {
>      }
>  
>      # now see if there are any local changes not checked in to the index
> +    refresh_index
>      set cmd "|git diff-files"
>      if {$vfilelimit($curview) ne {}} {
>  	set cmd [concat $cmd -- $vfilelimit($curview)]
> @@ -11670,6 +11679,7 @@ set want_ttk 1
>  set autosellen 40
>  set perfile_attrs 0
>  set want_ttk 1
> +set need_index_refresh true
>  
>  if {[tk windowingsystem] eq "aqua"} {
>      set extdifftool "opendiff"
