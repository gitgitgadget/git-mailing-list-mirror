From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-fetch fetches blobs that are already in the local repository
 if no history is shared?
Date: Tue, 24 Apr 2012 07:23:47 -0700
Message-ID: <CAJo=hJsgk-5ByMoOJ-RSce+TUFLm43_SYHf1eHWsqE+xs6QNEA@mail.gmail.com>
References: <D7CFF7BD2A9545148AC2553870AA3A15@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <tor.arne.vestbo@nokia.com>
To: Adam Roben <adam@roben.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 16:24:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMgf9-0001D2-T6
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 16:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480Ab2DXOYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 10:24:10 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:48096 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab2DXOYI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 10:24:08 -0400
Received: by dadz8 with SMTP id z8so986610dad.10
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=haEsXJuey7RhFeZmxVM1pdzIypCbh6B3SuTu8qSySh4=;
        b=aLnXWBiUjg4U6J8wAFQ2gA0LtELkEczz3h3bQuJ/2RfqRm3bJ+4NLK14DghyePL7gq
         5xt3MmCtCpPYKtIQa4YCNulFYLoK42zFAe0n122m3/mKu0+tdqoyIJXZStTFFYdQ1QfL
         9i+u63MqEBqAgiUGHPuj3bEbpnDzBK+FXdigM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=haEsXJuey7RhFeZmxVM1pdzIypCbh6B3SuTu8qSySh4=;
        b=c/d/e7j79i0c3+F6jJsSOytXmiFu5Z3g0/N9RLGntKkyqDmyb7sqvHU7/RreQzQAJZ
         5iBWckpEwgEuan1jfE6tpgRgL0YgStR81bgS77NI+e+5GbVsC0O/pxmmNynkDt2Piuiq
         yaMOI2savyt2rjAuCy9M+uv9R/vJhYMKAYFcC/chffvBGrIBkK1Q3rI3OJGxRIMhtW80
         972As+GWq2BAA/luNpEBxduxlbZV1FJBLQwdkknPyWGR1HXkKux84xZYSUjm+e1TXyGP
         wD7BjuoD6M+txMfzyd2vjrD0tpZ7Yr1QpzbB7iwMEaKuzN7xmY0VM2w3+v9qNr3MR5B9
         bLBQ==
Received: by 10.68.226.170 with SMTP id rt10mr4152379pbc.2.1335277447948; Tue,
 24 Apr 2012 07:24:07 -0700 (PDT)
Received: by 10.68.211.74 with HTTP; Tue, 24 Apr 2012 07:23:47 -0700 (PDT)
In-Reply-To: <D7CFF7BD2A9545148AC2553870AA3A15@gmail.com>
X-Gm-Message-State: ALoCoQnCEKA18OAhqUHaeO2RfVYlNgRnxewr61keWfZIDb1r5EDag+sItpa9G/hfHc+4i7AAxXhD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196223>

On Tue, Apr 24, 2012 at 07:19, Adam Roben <adam@roben.org> wrote:
> There are two main git mirrors of the WebKit Subversion repository: <git://git.webkit.org/WebKit.git> and <https://github.com/WebKit/webkit>. These repositories have the exact same trees/blobs, but have entirely different commits due to the GitHub mirror using a custom --authors-prog with git-svn.
>
> Tor Arne (CCed) noticed something interesting today:
>
> If you clone one of these repositories, then add the other as a remote and fetch it, all the trees/blobs seem to get pulled down again, even though they're already in the local repository. It seems like only the commit objects should be fetched, since they're the only difference between the two remotes.
>
> Is this a bug in git?

No. Its the way the Git protocol was designed to function. Git only
negotiates over the commit history, as trying to include the blob and
tree information into the negotiation protocol would make the payloads
unreasonable in size. Granted in this case sending the 100M or
whatever it takes to enumerate all SHA-1s is smaller than the 4G or
whatever that WebKit actually is, but the protocol assumes nobody
would be this crazy to establish a huge project with two different
competing commit histories and then think they could fetch them
together into one repository with a small network delta.

Basically... Don't do this, and don't expect Git to save you.

There should be only one version of the WebKit history imported into
Git that everyone agrees on as being the canonical version of that
import. And everyone else who mirrors or works with WebKit in Git
should base off that version.

WebKit is a big enough project with enough users that you would think
you could trust the git.webkit.org conversion. Which suggests the
github.com one should be done over.
