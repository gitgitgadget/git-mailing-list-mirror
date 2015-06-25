From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git error in tag ...: unterminated header
Date: Thu, 25 Jun 2015 13:48:52 -0700
Message-ID: <xmqqa8vny0nf.fsf@gitster.dls.corp.google.com>
References: <20150625155128.C3E9738005C@gemini.denx.de>
	<xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
	<20150625201309.5026A384E81@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Wolfgang Denk <wd@denx.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 22:49:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8E4x-0000X7-ID
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 22:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbbFYUs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 16:48:56 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:32997 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbFYUsy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 16:48:54 -0400
Received: by ieqy10 with SMTP id y10so63013337ieq.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9hfXsecwgyuKoYtcDAVuX2zKtmQBtSCGDlEjj/g+Yfc=;
        b=D7bSpnnAR+ynBkHpOVhgKCdU6p+FAOY70tgolis4/vwIeIuHZJENwCC8dytbXAIk7i
         MudTHQueDqXLj7Vzc5eq1ynPh9wAV8MoyGXA3yeSEVPYG26XMywZ77PCFUO6994BIoy5
         3z0nGMWvHvTUCrjPyE9b16ApAIAJGj1CV1rYfW9rHlBni7o5T72LjTFUeYdNRB0scfeR
         CQoVcpF6rCuGUNHKCBJwu4icZWyOqbKMnxhQcYUMDk65ngnNaEm4dAcnkdTdvWp3iwrm
         k4FSdrAd94qO53RYPBgtihQUpp3eppliVT7aqIU1ltD+SJDsmPDtCmHKUfA8JPwRAFzL
         mIdA==
X-Received: by 10.43.163.129 with SMTP id mo1mr44440225icc.61.1435265334229;
        Thu, 25 Jun 2015 13:48:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id z6sm4056751ign.13.2015.06.25.13.48.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 13:48:53 -0700 (PDT)
In-Reply-To: <20150625201309.5026A384E81@gemini.denx.de> (Wolfgang Denk's
	message of "Thu, 25 Jun 2015 22:13:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272731>

Wolfgang Denk <wd@denx.de> writes:

> Hm... it seems I cannot even easily delte these tags:
>
> -> git tag -d LABEL_2006_03_12_0025
> Deleted tag 'LABEL_2006_03_12_0025' (was eb394f5)
> -> git fsck --full
> Checking object directories: 100% (256/256), done.
> Checking object directories: 100% (256/256), done.

This is expected.  "git tag -d" only severed the linkage between
tagname LABEL_2006_03_12_0025 and the tag object eb394f5; without
repacking and pruning, the object eb394f5 is not removed from your
object store.

> dangling tag eb394f56db3e05d00891d6dc36a00df0025cf255
>
> Now I also have this "dangling tag" thingy...

That also is expected.  It now is "dangling" because it is not
reachable from any of your refs.

"git repack -a -d -f" after "git tag -d && git tag -a" would make
your repository fsck-clean, but I highly doubt that you would want
to recreate your tags right now.

If I were you, I'd learn to ignore these 'unterminated header'
errors for now and wait to see if Git folks decide that 4d0d8975
(Make sure fsck_commit_buffer() does not run out of the buffer,
2014-09-11) is overzealous and giving an error message where there
is no error, in which case future versions of Git will not complain
on these objects.  It is not too late to do the re-tagging after
they decide to keep the current behaviour.
