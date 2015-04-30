From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 12:25:24 -0700
Organization: Twitter
Message-ID: <1430421924.22711.57.camel@ubuntu>
References: <1430341032.14907.9.camel@ubuntu>
	 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	 <1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
	 <1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
	 <20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>
	 <20150430011612.GA7530@peff.net> <1430358345.14907.62.camel@ubuntu>
	 <20150430033725.GB12361@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:25:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynu5T-0007Zp-VO
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 21:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbbD3TZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 15:25:27 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36723 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbbD3TZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 15:25:27 -0400
Received: by pdea3 with SMTP id a3so69823612pde.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 12:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=57o6i4yOG077iZbCDUsp8YvasYDQNkCbZUIV1LkkMUg=;
        b=Nu3D7BZeribTalslVOQIGNATDsqG/B8ZiiPhAOXRqBThOqPCbPHK6rZoLUl1JHMRqo
         jfD7t7UasaWG26XYDEF5mLVrq2cvmiOC//MdAgEBtSTQel+FqlxF5EiKU2CGut5zF4B1
         pvWWKoEehDGVpLNODw85CTcaEtOVBftyCO/1gCj5GLfI4GiK64TPWXMVuWc6GOBBCTRT
         BpY/8wQDPSxS48umF8QPQ0cqeg1StPkiPvThZYaMKGelS8uumUaBdvD02MP1jDhT+IGk
         cMzkgkvNuVtfm5/iEYCRd0VQWsOCcVa7Xg3u+2MZ1gCO/so14WwWS+0oXoFTmOyK/cJB
         UxYQ==
X-Gm-Message-State: ALoCoQkG3YiICvaDzpzwU6GJEkYPune4kr5ybfSf4OaiqrkhzNO0ToLfcEC3Bn4+U/60jLvScWhF
X-Received: by 10.68.57.143 with SMTP id i15mr11263999pbq.9.1430421926486;
        Thu, 30 Apr 2015 12:25:26 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id e6sm1489513pat.38.2015.04.30.12.25.24
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 12:25:25 -0700 (PDT)
In-Reply-To: <20150430033725.GB12361@peff.net>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268096>

On Wed, 2015-04-29 at 23:37 -0400, Jeff King wrote:
>   3. Return an object with the symlink relative to the original
>      filename (so "../external" in this case). This is kind of weird,
>      though, because we're not just returning a string from the name
>      resolution. It's an actual object.  So we'd be generating a fake
>      object that doesn't actually exist in the object db and
>      returning that. Feeding that sha1 to another program would fail.

> I can't say that I'm excited about any of them. Perhaps you or somebody
> else can think of a more clever solution.
> 
> Note that the complication with (3) does come from my trying to push
> this down into the name-resolution code.

All else being equal, I would prefer the more general solution.  But
here, the generality comes with a price that seems somewhat high. 

When I think about the commands that might use this, cat-file and
ls-tree are at the top of the list (although as noted, I am only likely
to use cat-file, and it's not clear what ls-tree should do in the event
of an out-of-repo link). 

I could imagine someone caring about grep and diff.  Someone who cares
about grep would likely want it to be willing to go out-of-worktree (as
opposed to silently missing things).  I think we all agree that having
git go out-of-worktree is a mistake, so I'm not sure this use-case is
one that is supportable.

The weirdest case is log.  If I say git log HEAD^{resolve} --
foo/bar/baz, does it mean "commits that have touched what is now pointed
to by foo/bar/baz"?  Or does it mean "commits that have touched a thing
that was at that time pointed to by foo/bar/baz"? [1]  The second one is
more useful, since it could not otherwise be achieved.  But I think this
would require additional code in log on top of whatever additional code
is in sha1_name.  In other words, we would not get it for free just by
adjusting sha1_name.

Are there other relevant commands that I'm missing?  

If not, I think we should reconsider the original thought of just
supporting cat-file.  The nice thing about just supporting cat-file is
that for out-of-repo links we can add a special form to the output, that
does not contain a sha (since there is no corresponding sha in the
repo).  In other words, something like your solution 3, quoted above.


[1] See page 11 of http://inform7.com/learn/documents/WhitePaper.pdf
("Has the president ever been ill?") for a similar case.
