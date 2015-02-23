From: David Turner <dturner@twopensource.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a
 large repo?
Date: Mon, 23 Feb 2015 15:23:16 -0500
Organization: Twitter
Message-ID: <1424722996.27803.29.camel@leckie>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
	 <CACsJy8Dortn4fHwF8xSgJ=KoJ9o1qzmc_UyaVq003D2sxFZEuQ@mail.gmail.com>
	 <1424392969.30029.15.camel@leckie>
	 <xmqqegpkz4cf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 21:23:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPzXJ-0007ID-M1
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 21:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbbBWUXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 15:23:21 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:43961 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbBWUXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 15:23:20 -0500
Received: by qcxr5 with SMTP id r5so13129881qcx.10
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 12:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=XMkbEQXJ4hh0Pk0w5mldB1mp0kv9bsOkPKLVZImhS4s=;
        b=NzL12c6bxI6AU32EnqIeiqBxExyc+2g1PQ8tZ+d6NVARE6/mHySIB3uf9skdfdnuKl
         2WPh7ug8MniIUK50yR4k88H7uEUCDTpAMELPOzpBJ3+05t/dImUk5UHUYSjt7Db2oLrv
         lW7qMP2/Qn7VgA1ByD2tjfMHc/SYxm6rZ7+lPLC+g78+7JXHuYFzsoE5xRlBmLW97ycj
         IuGsT+JZg/redv5gYQeom2bleXH7EU+VeDXxKOFuBUrz2dUXQZa6ca2r0RU9F3eHMdtq
         p/k5pMpSYIXfpI/Q+8EX2ipbGIXBFsEIGhuQAMYBnwktcwa1UgtU74QGiO5CdNr2tMq0
         PozQ==
X-Gm-Message-State: ALoCoQkYVycbRKTnE2zcePdNSUr2f5olSX17BA8rIozzCQ6yTZ5g8w37dwdL1/T9g7hpkIr6RE5k
X-Received: by 10.140.236.73 with SMTP id h70mr28343561qhc.41.1424723000088;
        Mon, 23 Feb 2015 12:23:20 -0800 (PST)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id 70sm3657090qhe.29.2015.02.23.12.23.18
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2015 12:23:19 -0800 (PST)
In-Reply-To: <xmqqegpkz4cf.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264294>


On Fri, 2015-02-20 at 12:59 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > On Fri, 2015-02-20 at 06:38 +0700, Duy Nguyen wrote:
> >> >    * 'git push'?
> >> 
> >> This one is not affected by how deep your repo's history is, or how
> >> wide your tree is, so should be quick..
> >> 
> >> Ah the number of refs may affect both git-push and git-pull. I think
> >> Stefan knows better than I in this area.
> >
> > I can tell you that this is a bit of a problem for us at Twitter.  We
> > have over 100k refs, which adds ~20MiB of downstream traffic to every
> > push.
> >
> > I added a hack to improve this locally inside Twitter: The client sends
> > a bloom filter of shas that it believes that the server knows about; the
> > server sends only the sha of master and any refs that are not in the
> > bloom filter.  The client  uses its local version of the servers' refs
> > as if they had just been sent....
> 
> Interesting.
> 
> Care to extend the discussion to improve the protocol exchange,
> which starts at $gmane/263932 [*1*], where I list the known issues
> around the current protocol (and a possible way to correct them in
> footnotes)?

At Twitter, we changed to an entirely different clone strategy for our
largest repo: instead of using git clone, we use bittorrent (on a
tarball of the repo).  For git pull, we maintain a journal of all pushes
ever made to the server (data and ref updates); each client keeps track
of their location in that journal.  So now pull does not require any
computation on the server; the client just requests the segment of the
journal that they don't have.  Then the client replays the journal.
This scheme isn't perfect: clients end up with data about even
transitory and long-dead branches, and there is presently no way to
redact data (although that would be possible to add).  And of course
shallow and sparse clones are impossible.  But it works quite well for
Twitter's needs.  As I understand it, the hope is to implement redaction
and then submit patches upstream.

I say "we", but I personally did not do any of the above work.  Because
I haven't looked into most of these issues personally, I'm reluctant to
say too much on protocol improvements.  I would want to better
understand the constraints.  I do think there is value in having a
diversity of possible protocols to handle different use cases.  As
repositories grow, traditional full-repo clones become less viable.
Network transfer and client-side performance both suffer.  In a repo the
size of (say) WebKit, the traditional model works.  In a repo the size
of Facebook's monorepo, it starts to break down.  So Facebook does
entirely shallow clones (using hg, but the problems are similar in git).
Commands like log and blame instead call out to a server to gather
history data.  At Google, whose repo is I think two or three orders of
magnitude larger than WebKit, all local copies are both shallow and
sparse; there is also support for "sparse commits" -- so that a commit
that affects (say) ten thousand files across the entire tree can be kept
to a reasonable size. 

<end digression>

Twitter's journal scheme explains why I implemented bloom filter pushes
-- the number of refs does not significantly affect pull performance,
but pushes still go through the normal git machinery, so we wanted an
optimization to reduce latency there.
