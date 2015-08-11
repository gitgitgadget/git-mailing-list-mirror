From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 02/13] ref-filter: print output to strbuf for formatting
Date: Tue, 11 Aug 2015 11:00:21 -0700
Message-ID: <xmqqh9o5so22.fsf@gitster.dls.corp.google.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 20:00:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPDqk-0003ak-H7
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 20:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbbHKSA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 14:00:28 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34207 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbbHKSAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 14:00:25 -0400
Received: by pawu10 with SMTP id u10so169088353paw.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VuGCCXTMJ36XgYqKg2FfMbBZC/3I3aoW43QJ/40k0IU=;
        b=Wa6smf4QJvPJwcHSP16p9wmNQaSkm5BSR4h84Cuf+yWUKwA2NXNI+8eT+AFwNy7XtZ
         8cyeqb55WKoRNpeEwePavAxyDQXP/YViASMw/8CSikOMwFyjbLn9XahW1akshVdlzmnY
         1GszcUO1OUY5VJ4B5bslXmex7ocwoCK5dBdQkaiGwq6t9NaAY519e3Obu+zvfuZUZz3Y
         /+Uhl8jAzBgWYWscdVXG4wn/y5ZewkO+fevd+0AvD3SwX7Xr4H6cXbxeOXqype2suaE7
         Ozhw+vgQJrDF0WoMtG5/GDuSRS+9kC8H5PFqStUYdmBa+ZMRoUiUvo/xe3aS8bJ2Goj2
         r+Ig==
X-Received: by 10.68.134.129 with SMTP id pk1mr59613618pbb.65.1439316024735;
        Tue, 11 Aug 2015 11:00:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id xv1sm3452751pbb.25.2015.08.11.11.00.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 11:00:23 -0700 (PDT)
In-Reply-To: <1439129506-9989-3-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 9 Aug 2015 19:41:35 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275702>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -1283,9 +1279,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>  		if (color_parse("reset", color) < 0)
>  			die("BUG: couldn't parse 'reset' as a color");
>  		resetv.s = color;
> -		print_value(&resetv, quote_style);
> +		format_quote_value(&resetv, quote_style, &output);

Mental note: I _think_ the logic to scan the string and set
need_color_reset_at_eol that happens at the beginning can be removed
once the code fully utilizes formatting-state information.  A
coloring atom would leave a bit in the formatting state to say that
the line color has been changed to something other than reset, and
then this "at the end of line" code can decide if that is the case
and add a "reset" thing here (i.e. the code inside the "if
(need_color_reset_at_eol)" block shown here does not need to change,
but the "if" condition would).
