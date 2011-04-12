From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 00/11] gitweb: Change timezone
Date: Mon, 11 Apr 2011 18:19:32 -0700
Message-ID: <BANLkTik9D6++P1rg+VbvKj9oTFhRYNmrpQ@mail.gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 03:19:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9SGk-0007Gj-1p
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 03:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab1DLBTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 21:19:33 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34951 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab1DLBTc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 21:19:32 -0400
Received: by pxi2 with SMTP id 2so3274260pxi.10
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 18:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FnEx/zlixRetdOogjIBQS4KUFHvuBGEGpGew4BMsbIE=;
        b=me2Turfh6zMSi9/mafe76ZgFIY3hEIkHB2To/VcTHPguDeOWrZ371bbaCAvjJkrFCz
         uh2jOYXPth3oEGyEBxTTxotzNmVIl+jUobdCc1mbhZJAz7ptUOW2M5tM4c0uaaCPA/Yx
         2KAQx6fa5plSLhdlNUmaM/qGNqa2zUDVD5hII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XNEjaWwhNPTZjfv/83ymHaBLBOOgleXLoWHmQpSDIGehHmBo92Ph6WHAo7EWULJSYH
         o3nWGj3gVeuL+wykTT5PWwCwBfN2s0xgLgm6aB5H5z62ABVKD68NfoPXosU2OUWaBbLA
         g4tqC7UN6WN7fyKzVIYqw+KqayJQ32j/N5ofI=
Received: by 10.143.137.6 with SMTP id p6mr5868507wfn.305.1302571172104; Mon,
 11 Apr 2011 18:19:32 -0700 (PDT)
Received: by 10.68.62.38 with HTTP; Mon, 11 Apr 2011 18:19:32 -0700 (PDT)
In-Reply-To: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171367>

On Sat, Apr 9, 2011 at 3:49 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> This is split version (with assorted cleanups) of J.H. patch adding
> JavaScript-base ability to change timezone in which dates are
> displayed.

Jakub,

Thanks for the update.  This UI does seem to work better than the
original "[+]" dropdown interface.

The new code appears to degrade gracefully on IE6 (everything shown in UTC).

Tests on Firefox 3.6.15 looked OK.

Chromium 6.0.472.62 (59676) does not like this operation:

Uncaught Error: NOT_FOUND_ERR: DOM Exception 8
  removeChangeTZForm
  /gitweb-static/gitweb.js:785
onTZFormChange

line 785: var removed = container.removeChild(container.lastChild);

Opera 10.63 resets target.selectedIndex to 1 after calling
removeChangeTZForm() from onTZFormChange().  Net effect is that you're
always stuck in the "local" zone.  Here is a workaround that fixed it
for me:

       var target = event.target || event.srcElement;
       var selectedIndex = target.selectedIndex;

       removeChangeTZForm(documentFragment, target, tzClassName);

       var selected = target.options.item(selectedIndex);

Couple other random nitpicks:

> +	// server-side of gitweb produces datetime in UTC,
> +	// so if tz is 'utc' there is no need for changes
> +	var nochange = tz === 'utc';

If I delete my gitweb_tz cookie, then refresh the page:

 - All times show up in my browser's local time (good)

 - Clicking UTC/GMT on the dropdown has no immediate effect; I need to
   refresh the page again to see the times change (bad)

> +	my (undef, undef, $datetime_class) =
> +		gitweb_get_feature('javascript-timezone');
> +	if ($datetime_class) {
> +		$strtime = qq!<span class="datetime">$strtime</span>!;

Should this hard-code class "datetime", or use $datetime_class from
the gitweb server configuration?

> +/* JavaScript-base timezone manipulation */

Might want to reword as "JavaScript-based"

> +		// refresh cookie, so it expires 7 days from last use of gitweb
> +		setCookie(tzCookieName, tzCookie, { expires: 7, path: '/' });

Hmm, only 7 days?

> + * and instals appropriate onclick trigger (via event delegation).

"installs"
