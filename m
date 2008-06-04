From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Wed, 4 Jun 2008 16:03:48 +0200
Message-ID: <200806041603.49555.jnareb@gmail.com>
References: <940824.46903.qm@web31808.mail.mud.yahoo.com> <200806032331.44514.jnareb@gmail.com> <7v3ant213k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 16:05:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3tbe-0004J1-Ho
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 16:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYFDOD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 10:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbYFDOD4
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 10:03:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:61052 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbYFDODz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 10:03:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so59073fgg.17
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TaAwDLkpR5FfE1Ak/IH90HxGPf+IDAnK1Vw0De9223A=;
        b=TgNdD5K9jnuldWZiw91GNsnFbSl+YJFS0LQjfeRneHYiA3bVgxndHyg+EfKEcDt2qc
         3xJVCF/URyHjhXQq9Ps9pEJAlh/7EYeSD1/t61GbTUs/mmDVUami6JGYdt1XupdCgmFa
         Q5vvdW3ARz9fGYSbm3MpIvFWFH6ZUq1p3ZlDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Z5TVcY/IYi+/vYbBIG7B/qNHLkdJr1CxdZfsX4XDR9V/PK4zSiGwrBPNAiJoO8miPb
         vnZpnxDBVW8t3oroxV1g3Vp6F6sNHThLH/Wm7gZ9pqhyFv/fJ6NvnoAeiWJnrRhkB1S1
         2MqSEXn+x6RauuRlTn+oaP+YNSDXaVLtl36W8=
Received: by 10.86.80.5 with SMTP id d5mr163268fgb.11.1212588233701;
        Wed, 04 Jun 2008 07:03:53 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.210.131])
        by mx.google.com with ESMTPS id l19sm1764109fgb.7.2008.06.04.07.03.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 07:03:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v3ant213k.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83780>

On Wed, 4 Jun 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Tue, 3 Jan 2008, Luben Tuikov wrote:
>>>
>>> The intention was that it shouldn't necessarily be the (strict) parent
>>> of the change (changed segment), since it may or may not have changed
>>> in the strict parent commit.  The intention was that it
>>> "starts"/"opens" the parent commit so that "git" would start from
>>> there and find the actual change/commit where that line/segment has
>>> changed.  And it has worked pretty fine for me when data-mining
>>> (something I do quite often) code evolution.
> 
> Yes, but the current scheme breaks down in another way.  When $full_rev
> added many lines to the file, and you are adding the link to for a line
> near the end of the file and such a line may not exist.  This cannot be
> cheaply done even inside blame itself.

I think the scheme could be fixed by proposed belo git-blame porcelain
format output extension.  Can it be done cheaply?  I don't know,
generating extended info as described below should be cheap if we
have equivalent of textual (patch) diff between commit blamed for
given line, and its parent; actually what we need is more of 'context'
diff than of default 'unified' diff.

> Another breakage is even though $full_rev^ _may_ exist (iow, $full_rev
> might not be the root commit), the file being blamed may not exist there
> (iow $full_rev might have introduced the file).  Instead of running
> "rev-parse $full_rev^", you would at least need to ask "rev-list -1
> $full_rev^ -- $path" or something from the Porcelain layer, but
> unfortunately this is rather expensive.

Doesn't blame know revision graph for history of a given file already?

But even without it (i.e. ony 'parents' header showing true, not
rewritten parents) what we need is some info about pre-image for blamed
line.  We would need line number of the line in pre-image (or NUL
if the page was added in blamed commit), and pre-image filename.

I don't know if it could be done cheaply, and if it could be done
simply; currently git-diff doesn't have "context diff" format output,
and what I though about by pre-image line number requires finding if
a line was added in a commit, or was modified in a commit.  (If it
was removed, it wouldn't be in final image and hence wouldn't be
blamed; if it was moved, it wouldn't be blamed, as blame follows
code movement).

> Because blame already almost knows if the commit the final blame lies on
> has a parent, it would be reasonably cheap to add that "parent or nothing"
> information to its --porcelain (and its --incremental) format if we wanted
> to.

It would be easy to add 'parents' header, perhaps empty if we blame
root commit, or a boundary commit (do we say 'boundary' then?) when
doing revision limited blaming.

>From what you write it wouldn't be easy to add "history of a given
line begins here", or even "history of a given file begins there"...

-- 
Jakub Narebski
Poland
