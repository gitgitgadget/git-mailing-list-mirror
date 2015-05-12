From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/18] is_refname_available(): avoid shadowing "dir" variable
Date: Tue, 12 May 2015 14:06:33 -0700
Message-ID: <xmqq4mnhfque.fsf@gitster.dls.corp.google.com>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
	<1431357920-25090-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 12 23:06:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHNy-0008AW-VP
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933225AbbELVGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:06:38 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:32797 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933128AbbELVGf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:06:35 -0400
Received: by iebgx4 with SMTP id gx4so13855976ieb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=B0WFhsjjswI18PXxEQa8MCPzpT4qcYFG+EL8EdIdkYU=;
        b=q+XlPWNqnraRmQNRXFpGxvYE5Cs1oizSTBL/40TGpzHt/yPze7tF+WBgT5QJ5hwfuI
         XpmG2EbCeJHm0WVTlG/wv16oYi+FPXU43jKou6CaXSTnMQgtGLQMQ8A4hWSADjff65nB
         AHHmpCG26+hQfZ5yfhoLjyFmqi6PVk8jZffDA1XK6RrYL7v3yu1Ir/5CdmxLGIWoi0/9
         U9KkuNb9GEDxbpX1AAKknZbilqn9jTis41Hng84/IwhfXEqIbQ8J6lsCsM2GmHc4NUoI
         bcOjGeS9OFNarlc7nhlZrASqawun8huLAdExHm356vvld3J89KPqQFj+gyPc87XKRcKF
         4rOw==
X-Received: by 10.43.71.75 with SMTP id yj11mr5336640icb.69.1431464794869;
        Tue, 12 May 2015 14:06:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id p196sm12700046iop.15.2015.05.12.14.06.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 14:06:34 -0700 (PDT)
In-Reply-To: <1431357920-25090-4-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 11 May 2015 17:25:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268884>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The function had a "dir" parameter that was shadowed by a local "dir"
> variable within a code block. Use the former in place of the latter.
> (This is consistent with "dir"'s use elsewhere in the function.)
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 776bbce..9d87e84 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -967,10 +967,10 @@ static int is_refname_available(const char *refname,
>  		 * "refs/foo/bar/"). It is a problem iff it contains
>  		 * any ref that is not in "skip".
>  		 */
> -		struct ref_entry *entry = dir->entries[pos];
> -		struct ref_dir *dir = get_ref_dir(entry);
>  		struct nonmatching_ref_data data;

Wow, the original is a tricky code, but that helps us be confident
that this change is not breaking anything by "unmasking" the value
of incoming "dir" ;-)

> +		struct ref_entry *entry = dir->entries[pos];
>  
> +		dir = get_ref_dir(entry);
>  		data.skip = skip;
>  		sort_ref_dir(dir);
>  		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
