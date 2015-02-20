From: David Turner <dturner@twopensource.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a
 large repo?
Date: Fri, 20 Feb 2015 13:29:12 -0500
Organization: Twitter
Message-ID: <1424456952.31528.6.camel@leckie>
References: <20150220065801.7CDC7140BE4@smtp.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Stephen Morton <stephen.c.morton@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 19:29:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOsKL-0003tV-PL
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 19:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbbBTS3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 13:29:18 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:44681 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701AbbBTS3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 13:29:16 -0500
Received: by mail-qg0-f42.google.com with SMTP id z107so15484910qgd.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 10:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=VD226OkvRQrEWswpWEJ6O2ecBOjKQ/1nIvL89xUakqM=;
        b=L8TyanEHRPJ2k2BvITVzPLDr/xUTQ2xKPIiLN+L0WNN+7HP4oTH8QEC3ClXH+kCxRU
         D0O8ZRAYjYR4xfj0RorU9hD66vG7MeQfJg9Kwe5kRj+l6aVWDnZ3MxYtLumWf83sJ8jB
         poFdtIMSpT7DTHpvbR3JaHQqnUH0FNgoATpIWAOgfW7EIJiMM+HJPHO8TudHSP7RRXgP
         LcyxDP59gyTDZZSBBnU2egvc6qxYSthGy9L0twrJqJp71hNh+DdXZGQ+eNNhfeClA67P
         BzesO9dx0WMHJaTyEop4yp4MVCjm4W97lN7AKqoweob7LlK4okkDGdDXVSLYnT9fzCv8
         yhIg==
X-Gm-Message-State: ALoCoQlaR66vcln6sOkz7xpqcE/JFLuKNzNp70i2YYw0SUQD7AvfrKpz8IE/oX6GtiuL2Ik1BaKX
X-Received: by 10.140.149.130 with SMTP id 124mr26806439qhv.40.1424456955353;
        Fri, 20 Feb 2015 10:29:15 -0800 (PST)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id e5sm22442196qaq.16.2015.02.20.10.29.13
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Feb 2015 10:29:14 -0800 (PST)
In-Reply-To: <20150220065801.7CDC7140BE4@smtp.codeaurora.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264175>

On Thu, 2015-02-19 at 23:57 -0700, Martin Fick wrote:
> On Feb 19, 2015 5:42 PM, David Turner <dturner@twopensource.com> wrote:
> >
> > On Fri, 2015-02-20 at 06:38 +0700, Duy Nguyen wrote: 
> > > >    * 'git push'? 
> > > 
> > > This one is not affected by how deep your repo's history is, or how 
> > > wide your tree is, so should be quick.. 
> > > 
> > > Ah the number of refs may affect both git-push and git-pull. I think 
> > > Stefan knows better than I in this area. 
> >
> > I can tell you that this is a bit of a problem for us at Twitter.  We 
> > have over 100k refs, which adds ~20MiB of downstream traffic to every 
> > push. 
> >
> > I added a hack to improve this locally inside Twitter: The client sends 
> > a bloom filter of shas that it believes that the server knows about; the 
> > server sends only the sha of master and any refs that are not in the 
> > bloom filter.  The client  uses its local version of the servers' refs 
> > as if they had just been sent.  This means that some packs will be 
> > suboptimal, due to false positives in the bloom filter leading some new 
> > refs to not be sent.  Also, if there were a repack between the pull and 
> > the push, some refs might have been deleted on the server; we repack 
> > rarely enough and pull frequently enough that this is hopefully not an 
> > issue. 
> >
> > We're still testing to see if this works.  But due to the number of 
> > assumptions it makes, it's probably not that great an idea for general 
> > use. 
> 
> Good to hear that others are starting to experiment with solutions to this problem!  I hope to hear more updates on this.
> 
> I have a prototype of a simpler, and
> I believe more robust solution, but aimed at a smaller use case I think.  On connecting, the client sends a sha of all its refs/shas as defined by a refspec, which it also sends to the server, which it believes the server might have the same refs/shas values for.  The server can then calculate the value of its refs/shas which meet the same refspec, and then omit sending those refs if the "verification" sha matches, and instead send only a confirmation that they matched (along with any refs outside of the refspec).  On a match, the client can inject the local values of the refs which met the refspec and be guaranteed that they match the server's values.
> 
> This optimization is aimed at the worst case scenario (and is thus the potentially best case "compression"), when the client and server match for all refs (a refs/* refspec)  This is something that happens often on Gerrit server startup, when it verifies that its mirrors are up-to-date.  One reason I chose this as a starting optimization, is because I think it is one use case which will actually not benefit from "fixing" the git protocol to only send relevant refs since all the refs are in fact relevant here! So something like this will likely be needed in any future git protocol in order for it to be efficient for this use case.  And I believe this use case is likely to stick around.
> 
> With a minor tweak, this optimization should work when replicating actual expected updates also by excluding the expected updating refs from the verification so that the server always sends their values since they will likely not match and would wreck the optimization.  However, for this use case it is not clear whether it is actually even worth caring about the non updating refs?  In theory the knowledge of the non updating refs can potentially reduce the amount of data transmitted, but I suspect that as the ref count increases, this has diminishing returns and mostly ends up chewing up CPU and memory in a vain attempt to reduce network traffic.

For a more general solution, perhaps a log of ref updates could be used.
Every time a ref is updated on the server, that ref would be written
into an append-only log.  Every time a client pulls, their pull data
includes an index into that log.  Then on push, the client could say, "I
have refs as-of $index", and the server could read the log (or do
something more-optimized) and send only refs updated since that index.
