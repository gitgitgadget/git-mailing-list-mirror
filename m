From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in 'git am' when applying a broken patch
Date: Mon, 01 Jun 2015 11:31:10 -0700
Message-ID: <xmqqwpzn5lht.fsf@gitster.dls.corp.google.com>
References: <20150601001759.GA3934@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Gaston Gonzalez <gascoar@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 01 20:31:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzUUY-0002Ag-Ea
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 20:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbbFASbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 14:31:14 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33092 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbFASbM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 14:31:12 -0400
Received: by iebgx4 with SMTP id gx4so115444643ieb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 11:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=w7y24YzQofS0SqgvHsCEOFaOOg1G47Wf9jyN33Uhjvg=;
        b=eXUi0KJiEAurT2ylMK4D9DELyJ4859jGAIHF0/VVUItszKP29uTVXWFvlxjkLVpWga
         7k7a5/EWMR3tCk44caIScm67g4lEJELEshYtrElM/jGsWlMu48ekYl/3MU5nRM3Dvviu
         g8s0QdhYusW7IOiUvF26khL2m8FLNdoFtmCc89m8c+n1Fpwi2YAonB1EpaDQE3fyU5aO
         KCpOTU8e5Udel4ld4FDBoExQ+giKDVjdjEwkK4xmH/LNDq8hKHcnjIEPw7xYnzsxjMss
         E/62xNtKBLqAuxoNyVS1unaGZsiFzHy0nkfnIr/H4/+u9OJOQWum7DHyYE7LKJAtK666
         eXbA==
X-Received: by 10.50.78.225 with SMTP id e1mr6704714igx.19.1433183472011;
        Mon, 01 Jun 2015 11:31:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id d4sm10927393iod.17.2015.06.01.11.31.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 11:31:11 -0700 (PDT)
In-Reply-To: <20150601001759.GA3934@kroah.com> (Greg KH's message of "Mon, 1
	Jun 2015 09:17:59 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270453>

Greg KH <gregkh@linuxfoundation.org> writes:

> But, there's nothing in the patch at all except the commit message:
>
> $ git show HEAD
> ...
> Any ideas what is going on here?  Shouldn't 'git am' have failed?

Yes.  The patch reads like this:

    ---
     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 5 +++--
     1 file changed, 3 insertions(+), 2 deletions(-)

    diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/...
    index d2e8b12..0477ba1 100644
    --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
    +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
    @@ -660,2 +660,2 @@ inline struct sk_buff *ieee80211_authentic...
            auth = (struct ieee80211_authentication *)
                    skb_put(skb, sizeof(struct ieee80211_authentication));

    -	auth->header.frame_ctl = IEEE80211_STYPE_AUTH;
    -	if (challengelen) auth->header.frame_ctl |= IEEE80211_FCTL_WEP;
    +	auth->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_AUTH);
    +	if (challengelen)
    +		auth->header.frame_ctl |= cpu_to_le16(IEEE80211_FCTL_WEP);

            auth->header.duration_id = 0x013a; //FIXME

    --
    2.1.4

    _______________________________________________
    devel mailing list
    devel@linuxdriverproject.org
    http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel


It claims that it has only 2 lines in the hunk, so "git apply"
parses the hunk that begins at line 660 as such:

    @@ -660,2 +660,2 @@ inline struct sk_buff *ieee80211_authentic...
            auth = (struct ieee80211_authentication *)
                    skb_put(skb, sizeof(struct ieee80211_authentication));

And then seeing that the next line (which is a blank line, not even
a lone SP on it) does not begin with "@@ -", it says "OK, the
remainder is a cruft after the patch" and discards the rest (which
it must be capable of, to ignore "-- ", "2.1.4", "devel mailing
list", etc.)

There is some safety against not finding a correct patch header
(i.e. "diff --git" line) by detecting a lone "@@ -" while parsing
the patch stream, but there is no logic implemented to detect this
kind of breakage in the code.
