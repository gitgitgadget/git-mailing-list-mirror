From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 07/11] commit: avoid race when creating orphan commits
Date: Mon, 9 Feb 2015 10:35:17 -0800
Message-ID: <CAGZ79kYF2WWqSq71d5FZvP7PCKra-cmYHPAB0RVFed8Ag14ZWA@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:35:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtB5-0002fq-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933593AbbBISfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:35:19 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33956 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbbBISfS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:35:18 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so18387778igq.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IJIOejATR9n05wzG8x9FqPj5bbvsV6QcD8bXF1B3/EU=;
        b=jokZDbL1lNlm4l257vvtXVERtbXJLBExPBQnzdULar9yrqopFjW5nMv7k5BhhbA4xT
         pXOwl3mMm+nLDcgyH+kpdnWIvyCAFH2RAfRHx25r/KQ3l26dBH4qnPpNyF+SZrIMjfFl
         c9IkE/nkdiPs/pg30srwpWs0BeQ+Lqj/BoA4meL76WBoyGB/6x7Z0dq39ToxPfrDLcCy
         AxJyTNdI/JwdUijTs1SN9NHXaOQPWbIFsS/KCEj1kqjwnjWC/1r+UJ9NSr6AOJolg77z
         SWA/N9nakf6F0Uydh/siuLEnNVLKnBZgxT70epriuD3vcoQofRW3TjurinBB+iOyj/E9
         IZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IJIOejATR9n05wzG8x9FqPj5bbvsV6QcD8bXF1B3/EU=;
        b=OH7EVRjxFQyyw7kY5eZFonpSOZNFVIACgRe9iK0kWIHHtN/hJyPK4d1aF4SCOb6d3h
         artyr2mP3kM5r88BDTOGWhY6NFUuYoh5d7SaI9D65t9+NXxa7Qh/kyrIDzjc4XHVGbLd
         +BCMBK58RSU5taope3V67605S5A8YOFXPxW0NwYM8X2Cx1mXpTShakPppHOFUjLXBwop
         uWlQk4RWOKyrAkOCOZj1PeWSSA6N3iHt/cMuWNI3TKtKlFRbZLKUuC2nbrXJlgC52gm2
         yPBxl0uDkCzeS9+6TenFZ11/hwhIg59zjSGckpTpzRMi1/vIyWhXYva6258SkLwknoE9
         dzog==
X-Gm-Message-State: ALoCoQkyQIBfoe2/ZALT0HhzblFBa1RTH6Zez6XAZxexQZeRh+0kpOmA08Nvr01ODlhmqK9mLeVO
X-Received: by 10.42.71.194 with SMTP id l2mr26213008icj.71.1423506917509;
 Mon, 09 Feb 2015 10:35:17 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 10:35:17 -0800 (PST)
In-Reply-To: <1423412045-15616-8-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263575>

On Sun, Feb 8, 2015 at 8:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> If, during the initial check, HEAD doesn't point at anything, then we

Maybe
"If HEAD doesn't point at anything during the initial check, then..." ?
(Being a non native speaker is hard. These commas look so confusing,
so the version without commas makes it way easier to read for me.)

Otherwise
Reviewed-by: Stefan Beller <sbeller@google.com>
